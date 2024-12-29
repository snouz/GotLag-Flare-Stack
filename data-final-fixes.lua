-- list of non-flammable gases to be vented for minimal energy cost in vent stack
ventlist = {
  
  -- Bob's
  {name="liquid-air",energy=0.4,amount=0.4},
  {name="oxygen",energy=0.4,amount=0.4},
  {name="nitrogen",energy=0.4,amount=0.4},
  {name="chlorine",energy=0.4,amount=0.4},
  {name="hydrogen-chloride",energy=0.4,amount=0.4},
  {name="nitrogen-dioxide",energy=0.4,amount=0.4},
  {name="sulfur-dioxide",energy=0.4,amount=0.4},
  
  -- N.Tech Chemistry
  {name="carbon-dioxide",energy=0.4,amount=0.4},
  {name="ammonia",energy=0.4,amount=0.4},
  {name="sulfur-trioxide",energy=0.4,amount=0.4},
}

-- list of flammable fluids to be flared off for minimal energy cost in flare stack
flarelist = {
  {name="heavy-oil",energy=0.4,amount=0.2},
  {name="light-oil",energy=0.4,amount=0.3},
  {name="petroleum-gas",energy=0.4,amount=0.4},
  {name="crude-oil",energy=0.4,amount=0.1},
  {name="lubricant",energy=0.4,amount=0.1},
  
  -- Bob's
  {name="hydrogen",energy=0.4,amount=0.4},
  {name="liquid-fuel",energy=0.4,amount=0.3},
  
  -- N.Tech Chemistry
  {name="methanol",energy=0.4,amount=0.3},
  {name="methylamine",energy=0.4,amount=0.4},
  {name="dimethylamine",energy=0.4,amount=0.4},
  {name="methylhydrazine",energy=0.4,amount=0.4},
  {name="dimethylhydrazine",energy=0.4,amount=0.4},
}

-- list of non-flammable fluids that require fuel to be destroyed in incinerator
incineratelist = {
  {name="sulfuric-acid",energy=0.5,amount=0.5},
  {name="water",energy=0.5,amount=0.5},
  
  -- Bob's
  {name="lithia-water",energy=0.5,amount=0.5},
  {name="nitric-acid",energy=0.5,amount=0.5},
  {name="tungstic-acid",energy=0.5,amount=0.5},
  {name="ferric-chloride-solution",energy=0.5,amount=0.5},
  
  -- N.Tech Chemistry
  {name="disulfuric-acid",energy=0.5,amount=0.5},
  {name="seawater",energy=0.5,amount=0.5},
}

-- Creates a recipe to vent given fluid, if said fluid exists
-- "fluid" is a table of name, energy, amount
function createVentRecipe(fluid)
  if data.raw.fluid[fluid.name] then
    data:extend({
      {
        type = "recipe",
        name = fluid.name.."-venting",
        category = "gas-venting",
        enabled = true,
        hidden = true,
        energy_required = fluid.energy,
        ingredients =
        {
          {type="fluid", name=fluid.name, amount=fluid.amount}
        },
        results =
        {
          {type="fluid", name=fluid.name, amount=0}
        },
        icon = "__Flare Stack__/graphics/icon/no.png",
        subgroup = "fluid-recipes",
        order = "z[venting]"
      }
    })
  end
end

-- Creates a recipe to flare off given fluid, if said fluid exists
-- "fluid" is a table of name, energy, amount
function createFlareRecipe(fluid)
  if data.raw.fluid[fluid.name] then
    data:extend({
      {
        type = "recipe",
        name = fluid.name.."-flaring",
        category = "flaring",
        enabled = true,
        hidden = true,
        energy_required = fluid.energy,
        ingredients =
        {
          {type="fluid", name=fluid.name, amount=fluid.amount}
        },
        results =
        {
          {type="fluid", name=fluid.name, amount=0}
        },
        icon = "__Flare Stack__/graphics/icon/no.png",
        subgroup = "fluid-recipes",
        order = "z[flaring]"
      }
    })
  end
end

-- Creates a recipe to incinerate given fluid, if said fluid exists
-- "fluid" is a table of name, energy, amount
function createIncinerationRecipe(fluid)
  if data.raw.fluid[fluid.name] then
    data:extend({
      {
        type = "recipe",
        name = fluid.name.."-incineration",
        category = "incineration",
        enabled = true,
        hidden = true,
        energy_required = fluid.energy,
        ingredients =
        {
          {type="fluid", name=fluid.name, amount=fluid.amount}
        },
        results =
        {
          {type="fluid", name=fluid.name, amount=0}
        },
        icon = "__Flare Stack__/graphics/icon/no.png",
        subgroup = "fluid-recipes",
        order = "z[incineration]"
      }
    })
  end
end

-- generate fluid venting recipes
for i, fluid in pairs(ventlist) do
  createVentRecipe(fluid)
end

-- generate fluid flaring recipes
for i, fluid in pairs(flarelist) do
  createFlareRecipe(fluid)
end

-- generate fluid incineration recipes
for i, fluid in pairs(incineratelist) do
  createIncinerationRecipe(fluid)
end

-- generate incineration recipe for every non-fluid item
for ki, vi in pairs(data.raw.item) do 
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