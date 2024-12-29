-- generate flare recipe for every fluid
for ki, vi in pairs(data.raw.fluid) do 
  data:extend({
    {
      type = "recipe",
      name = vi.name.."-flaring",
      category = "flaring",
      enabled = true,
      hidden = true,
      energy_required = 0.5,
      ingredients =
      {
        {type="fluid", name=vi.name, amount=5}
      },
      results =
      {
        {type="fluid", name=vi.name, amount=0}
      },
      -- icon = "__Flare Stack__/graphics/icon/no.png",
      icons = vi.icons or {{icon = vi.icon}},
      subgroup = "fluid-recipes",
      order = "z[incineration]"
    }
  })
  table.insert(data.raw.recipe[vi.name.."-flaring"].icons, {icon = "__Flare Stack__/graphics/icon/no.png"})
end

-- returns true if string fuel1 represents a higher energy value than string fuel2, eg "8MJ" > "20kJ" is true
function fuelGreaterThan(fuel1, fuel2)
  local fuel_suffix_list =
  {
    ["J"] = 0,
    ["kJ"] = 1,
    ["MJ"] = 2,
    ["GJ"] = 3,
    ["TJ"] = 4,
  }
  local exp1 = fuel_suffix_list[string.sub(fuel1,string.find(fuel1, "%a+"))]
  local exp2 = fuel_suffix_list[string.sub(fuel2,string.find(fuel2, "%a+"))]
  if exp1 == exp2 then
    local num1 = tonumber(string.sub(fuel1,string.find(fuel1, "%d+")))
    local num2 = tonumber(string.sub(fuel2,string.find(fuel2, "%d+")))
    return num1 > num2
  else
    return exp1 > exp2
  end
end

function incinerateRecipe(item, category)
  data:extend({
    {
      type = "recipe",
      name = category.."-"..item.name.."-incineration",
      category = "incineration",
      enabled = true,
      hidden = true,
      energy_required = 0.5,
      ingredients =
      {
        {item.name, 1}
      },
      results =
      {
        {type="fluid", name="water", amount=0}
      },
      icons = item.icons or {{icon = item.icon}},
      -- icon = "__Flare Stack__/graphics/icon/no.png",
      subgroup = "fluid-recipes",
      order = "zz[incineration]"
    }
  })
  table.insert(data.raw.recipe[category.."-"..item.name.."-incineration"].icons, {icon = "__Flare Stack__/graphics/icon/no.png"})
end

-- Get fuel value for coal if it exists, else default to vanilla value
if data.raw.item["coal"] and data.raw.item["coal"].fuel_value then
  coal_value = data.raw.item["coal"].fuel_value
else
  coal_value = "8MJ"
end

for ki, vi in pairs(data.raw.item) do
  -- create incineration recipe for any item, and any chemical fuel with less energy than coal
  if not (vi.fuel_category and vi.fuel_category == "chemical" and not fuelGreaterThan(coal_value, vi.fuel_value)) then
    incinerateRecipe(vi, "item")
  end
end

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
    incinerateRecipe(i, c)
  end
end