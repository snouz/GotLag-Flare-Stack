-- generate flare recipe for every fluid
for ki, vi in pairs(data.raw.fluid) do 
  data:extend({
    {
      type = "recipe",
      name = vi.name.."-incineration",
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
      icon = "__Flare Stack__/graphics/icon/no.png",
      subgroup = "fluid-recipes",
      order = "z[incineration]"
    }
  })
end

-- generate incineration recipe for every non-fluid item
for ki, vi in pairs(data.raw.item) do
  if not (vi.fuel_category and vi.fuel_category == "chemical") then
    data:extend({
      {
        type = "recipe",
        name = vi.name.."-incineration",
        category = "incineration",
        enabled = true,
        hidden = true,
        energy_required = 0.5,
        ingredients =
        {
          {vi.name, 1}
        },
        results =
        {
          {type="fluid", name="water", amount=0}
        },
        icon = "__Flare Stack__/graphics/icon/no.png",
        subgroup = "fluid-recipes",
        order = "zz[incineration]"
      }
    })
  end
end