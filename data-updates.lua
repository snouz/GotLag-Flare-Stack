require("prototypes.technology")

if settings.startup["flare-stack-disable-incinerators"].value then
  data.raw.technology["flare-stack-item-venting-tech"].hidden = true
  data.raw.technology["flare-stack-item-venting-electric-tech"].hidden = true
end