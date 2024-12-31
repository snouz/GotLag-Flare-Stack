local techicons = "__Flare Stack__/graphics/technology/"

--[[
if data.raw["technology"]["oil-processing"] then
  table.insert(
    data.raw["technology"]["oil-processing"].effects,
    {type = "unlock-recipe",recipe = "flare-stack"})
  --table.insert(
  --  data.raw["technology"]["oil-processing"].effects,
  --  {type = "unlock-recipe",recipe = "vent-stack"})
end
if data.raw["technology"]["angels-oil-processing"] then
  table.insert(
    data.raw["technology"]["angels-oil-processing"].effects,
    {type = "unlock-recipe",recipe = "flare-stack"})
  --table.insert(
  --  data.raw["technology"]["angels-oil-processing"].effects,
  --  {type = "unlock-recipe",recipe = "vent-stack"})
end
if data.raw["technology"]["advanced-material-processing"] then
  table.insert(
    data.raw["technology"]["advanced-material-processing"].effects,
    {type = "unlock-recipe",recipe = "electric-incinerator"})
end
]]

data:extend({
  {
    type = "technology",
    name = "flare-stack-item-venting-tech",
    icon = techicons .. "flare-stack-item-venting-tech.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "incinerator"
      },
    },
    prerequisites = {"automation-science-pack"},
    unit =
    {
      count = 50,
      ingredients = {{"automation-science-pack", 1}},
      time = 5
    }
  },
  {
    type = "technology",
    name = "flare-stack-item-venting-electric-tech",
    icon = techicons .. "flare-stack-item-venting-electric-tech.png",
    icon_size = 256,
    prerequisites = {"advanced-material-processing", "flare-stack-item-venting-tech"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "electric-incinerator"
      },
    }
  },
  {
    type = "technology",
    name = "flare-stack-fluid-venting-tech",
    icon = techicons .. "flare-stack-fluid-venting-tech.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "flare-stack"
      }
    },
    prerequisites = {"oil-processing"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    }
  },
})