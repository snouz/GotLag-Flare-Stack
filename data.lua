local techicons = "__Flare Stack__/graphics/technology/"

require("prototypes.entities")
require("prototypes.items")
require("prototypes.recipes")

data:extend({
  {
    type = "item-group",
    name = "flare-incineration",
    order = "zflare-incineration",
    icon = techicons .. "flare-stack-item-venting-tech.png",
    icon_size = 256,
  },

  {
    type = "item-subgroup",
    name = "flare-incineration-fluid",
    group = "flare-incineration",
    order = "a",
  },
  {
    type = "item-subgroup",
    name = "flare-incineration-items",
    group = "flare-incineration",
    order = "b",
  },
})