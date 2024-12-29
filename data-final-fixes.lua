-- returns icon/icons always in the form of a table of icons
function get_icons(prototype)
  if prototype.icons then
    return table.deepcopy(prototype.icons)
  else
    return {{
      icon = prototype.icon,
      icon_size = prototype.icon_size,
      icon_mipmaps = prototype.icon_mipmaps
    }}
  end
end
local no_icon = {
  icon = "__Flare Stack__/graphics/icon/no.png",
  icon_size = 32
}

-- generate flare recipe for every fluid
for ki, vi in pairs(data.raw.fluid) do
  local newicons = get_icons(vi)
  table.insert(newicons, no_icon)
  data:extend({
    {
      type = "recipe",
      name = vi.name.."-flaring",
      category = "flaring",
      enabled = true,
      hidden = true,
      energy_required = 1,
      ingredients =
      {
        {type="fluid", name=vi.name, amount=settings.startup["flare-stack-fluid-rate"].value}
      },
      results = { },
      icons = newicons,
      icon_size = 32,
      subgroup = "fluid-recipes",
      order = "z[incineration]"
    }
  })
end

-- generates a recipe to incinerate the specified non-fluid prototype
function incinerateRecipe(item, category, craft_category)
  local newicons = get_icons(item)
  table.insert(newicons, no_icon)
  data:extend({
    {
      type = "recipe",
      name = category.."-"..item.name.."-incineration",
      category = craft_category,
      enabled = true,
      hidden = true,
      -- energy_required = 0.5,
      energy_required = 1.0 / settings.startup["flare-stack-item-rate"].value,
      ingredients =
      {
        {item.name, 1}
      },
      results = { },
      icons = newicons,
      icon_size = 32,
      subgroup = "fluid-recipes",
      order = "zz[incineration]"
    }
  })
end

-- create incineration recipe for any item that isn't chemical fuel
for ki, vi in pairs(data.raw.item) do
  if not (vi.fuel_value and vi.fuel_category and vi.fuel_category == "chemical") then
    incinerateRecipe(vi, "item", "incineration")
  elseif vi.name ~= "wood" then
    incinerateRecipe(vi, "item", "fuel-incineration")
  end
end
-- wood is a chemical fuel but we want to incinerate it anyway
incinerateRecipe(data.raw["item"]["wood"], "item", "incineration")

-- non-item categories to incinerate too
category_list =
{
  "capsule",
  "ammo",
  "gun",
  "module",
  "armor",
  "mining-tool",
  "repair-tool"
}
for _, c in pairs(category_list) do
  for _, i in pairs(data.raw[c]) do
    incinerateRecipe(i, c, "incineration")
  end
end