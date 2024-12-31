local icons = "__Flare Stack__/graphics/icon/"

data:extend(
{
  --[[
  {
    type = "item",
    name = "vent-stack",
    icon = icons .. "vent-stack.png",
    icon_size = 64,
    subgroup = "production-machine",
    order = "e[chemical-plant]a",
    place_result = "vent-stack",
    stack_size = 50
  },]]--
  {
    type = "item",
    name = "flare-stack",
    icon = icons .. "flare-stack.png",
    icon_size = 64,
    subgroup = "production-machine",
    order = "e[chemical-plant]b",
    place_result = "flare-stack",
    stack_size = 20,
    weight = 100000,
  },
  {
    type = "item",
    name = "incinerator",
    icon = icons .. "incinerator.png",
    icon_size = 64,
    subgroup = "production-machine",
    order = "e[chemical-plant]c",
    place_result = "incinerator",
    stack_size = 20,
    weight = 100000,
  },
  {
    type = "item",
    name = "electric-incinerator",
    icon = icons .. "electric-incinerator.png",
    icon_size = 64,
    subgroup = "production-machine",
    order = "e[chemical-plant]d",
    place_result = "electric-incinerator",
    stack_size = 20,
    weight = 100000,
  }
})