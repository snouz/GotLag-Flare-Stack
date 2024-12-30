data:extend(
{
  -- Vent Stack **************************************************************************
  {
    type = "recipe",
    name = "vent-stack",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {type = "item", name = "iron-plate", amount = 5},
      {type = "item", name = "iron-gear-wheel", amount = 5},
      {type = "item", name = "electronic-circuit", amount = 2},
      {type = "item", name = "pipe", amount = 5}
    },
    results = {{type = "item", name = "vent-stack", amount = 1}}
  },
  
  -- Venting recipes *********************************************************************
  -- see data-final-fixes for list of fluids to be flared
  {
    type = "recipe-category",
    name = "gas-venting"
  },
  
  -- Flare Stack *************************************************************************
  {
    type = "recipe",
    name = "flare-stack",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {type = "item", name = "steel-plate", amount = 5},
      {type = "item", name = "iron-gear-wheel", amount = 5},
      {type = "item", name = "electronic-circuit", amount = 2},
      {type = "item", name = "pipe", amount = 5}
    },
    results = {{type = "item", name = "flare-stack", amount = 1}}
  },
  
  -- Flaring recipes *********************************************************************
  -- see data-final-fixes for list of fluids to be flared
  {
    type = "recipe-category",
    name = "flaring"
  },
  
  -- Incinerator *************************************************************************
  {
    type = "recipe",
    name = "incinerator",
    energy_required = 2,
    enabled = true,
    ingredients =
    {
      {type = "item", name = "stone-furnace", amount = 1},
      {type = "item", name = "iron-gear-wheel", amount = 5},
      {type = "item", name = "electronic-circuit", amount = 2},
      {type = "item", name = "pipe", amount = 5}
    },
    results = {{type = "item", name = "incinerator", amount = 1}}
  },
})
  -- Electric Incinerator ****************************************************************
local eincinerator =
{
  type = "recipe",
  name = "electric-incinerator",
  energy_required = 2,
  enabled = false,
  ingredients =
  {
    {type = "item", name = "stone-furnace", amount = 1},
    {type = "item", name = "iron-gear-wheel", amount = 5},
    {type = "item", name = "electronic-circuit", amount = 5},
    {type = "item", name = "pipe", amount = 5}
  },
  results = {{type = "item", name = "electric-incinerator", amount = 1}}
}

if mods["Electric Furnaces"] then
  eincinerator.ingredients =
  {
    {type = "item", name = "electric-stone-furnace", amount = 1},
    {type = "item", name = "iron-gear-wheel", amount = 5},
    {type = "item", name = "electronic-circuit", amount = 2},
    {type = "item", name = "pipe", amount = 5}
  }
end

data:extend(
{
  eincinerator,
  -- Incineration recipes ****************************************************************
  -- see data-final-fixes.lua for list of fluids to be incinerated
  {
    type = "recipe-category",
    name = "incineration"
  },
  {
    type = "recipe-category",
    name = "fuel-incineration"
  }
})