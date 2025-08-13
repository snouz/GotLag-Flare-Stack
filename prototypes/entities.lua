icons = "__Flare Stack__/graphics/icon/"
entity = "__Flare Stack__/graphics/entity/"

local ITEM_BURN_RATE_TOOLTIP = {}
if settings.startup["flare-stack-item-rate"].value == 1 then
  ITEM_BURN_RATE_TOOLTIP = {"flare-tooltips.item-burn-rate-single", tostring(settings.startup["flare-stack-item-rate"].value)}
else
  ITEM_BURN_RATE_TOOLTIP = {"flare-tooltips.item-burn-rate", tostring(settings.startup["flare-stack-item-rate"].value)}
end
local FLUID_BURN_RATE_TOOLTIP = {"flare-tooltips.fluid-burn-rate", tostring(settings.startup["flare-stack-fluid-rate"].value)}

data:extend(
{
  -- Flare Stack *************************************************************************
  {
    type = "furnace",
    name = "flare-stack",
    localised_description = FLUID_BURN_RATE_TOOLTIP,
    icon = icons .. "flare-stack.png",
    icon_size = 64,
    icon_draw_specification = {
      scale = 0.7,
      shift = {0, -0.2},
    },
    flags = {"placeable-neutral","player-creation"},
    minable = {mining_time = 0.2, result = "flare-stack"},
    fast_replaceable_group = "fluid-incinerator",
    max_health = 250,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    crafting_categories = {"flaring"},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = {pollution = 8}
    },
    energy_usage = "1kW",
    source_inventory_size = 0,
    result_inventory_size = 0,
    match_animation_speed_to_activity = false,
    graphics_set = {
      animation =
      {
        layers = {
          {
            filename = entity .. "flare-stack.png",
            priority = "high",
            width = 320,
            height = 320,
            scale = 0.5,
            frame_count = 1,
            shift = {1.5, -1.59375}
          },
          {
            filename = entity .. "flare-stack-shadow.png",
            priority = "high",
            width = 320,
            height = 320,
            scale = 0.5,
            frame_count = 1,
            shift = {1.5, -1.59375},
            draw_as_shadow = true
          },
        }
      },
      working_visualisations = {
        {
          animation =
          {
            layers = {
              {
                filename = entity .. "flare-stack-fire.png",
                priority = "high",
                frame_count = 29,
                width = 48,
                height = 105,
                scale = 0.5,
                shift = {0, -4.3},
                draw_as_glow = true,
                run_mode = "backward"
              },
              {
                filename = entity .. "flare-stack-glow-top.png",
                priority = "high",
                repeat_count = 29,
                width = 320,
                height = 320,
                scale = 0.5,
                shift = {1.5, -1.59375},
                draw_as_light = true,
              },
            }
          },
          --light = {intensity = 0.1, size = 5},
          constant_speed = true,
          burns_as_liquid = true,
          fadeout = true,
        },
        {
          animation =
          {
            layers = {
              {
                filename = entity .. "smoke.png",
                priority = "high",
                frame_count = 29,
                width = 48,
                height = 105,
                shift = {0, -4.3},
                animation_speed = 0.8,
                scale = 0.5,
                run_mode = "backward",
              },
            }
          },
          --light = {intensity = 0.1, size = 5},
          constant_speed = true,
          burns_as_gas = true,
          fadeout = true,
        }
      }
    },
    working_sound =
    {
      sound = { filename = "__base__/sound/oil-refinery.ogg" },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 2.5,
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        volume = settings.startup["flare-stack-fluid-rate"].value * 2,
        pipe_connections =
        {
          { flow_direction = "input", direction = defines.direction.south, position = {0, 0} }
        }
      }
    },
	module_slots = 1,
	allowed_effects = { "consumption", "speed", "pollution", "quality" },
  },

  -- Incinerator smoke
  {
    type = "trivial-smoke",
    name = "incinerator-smoke",
    duration = 150,
    fade_in_duration = 0,
    fade_away_duration = 100,
    spread_duration = 100,
    start_scale = 0.4,
    end_scale = 1.5,
    color = {r = 0.3, g = 0.3, b = 0.3, a = 0.3},
    cyclic = true,
    affected_by_wind = true,
    animation =
    {
      width = 152,
      height = 120,
      line_length = 5,
      frame_count = 60,
      shift = {-0.53125, -0.4375},
      priority = "high",
      animation_speed = 0.25,
      filename = "__base__/graphics/entity/smoke/smoke.png",
      flags = { "smoke" }
    }
  }
})

-- Electric Incinerator ******************************************************************
local eincinerator = (util.table.deepcopy(data.raw["furnace"]["flare-stack"]))
eincinerator.name = "electric-incinerator"
eincinerator.localised_description = ITEM_BURN_RATE_TOOLTIP
eincinerator.icon = icons .. "electric-incinerator.png"
eincinerator.minable = {mining_time = 0.2, result = "electric-incinerator"}
eincinerator.fast_replaceable_group = "item-incinerator"
eincinerator.crafting_categories = {"incineration", "fuel-incineration"}
eincinerator.crafting_speed = settings.startup["flare-stack-item-rate"].value
eincinerator.energy_usage = "320kW"
eincinerator.graphics_set.animation.layers[1].filename = entity .. "incinerator-electric.png"
eincinerator.graphics_set.working_visualisations[1].animation.layers =
{
  {
    filename = entity .. "smoke.png",
    priority = "high",
    frame_count = 29,
    width = 48,
    height = 105,
    shift = {0, -4.3},
    animation_speed = 0.8,
    scale = 0.5,
    run_mode = "backward",
  },
}

eincinerator.source_inventory_size = 1
eincinerator.fluid_boxes = nil

-- Incinerator ***************************************************************************
local incinerator = (util.table.deepcopy(eincinerator))
incinerator.name = "incinerator"
-- incinerator.localised_description = ITEM_BURN_RATE_TOOLTIP
incinerator.icon = icons .. "incinerator.png"
incinerator.minable.result = "incinerator"
-- incinerator.fast_replaceable_group = "item-incinerator"
incinerator.crafting_categories = {"incineration"}
-- incinerator.crafting_speed = settings.startup["flare-stack-item-rate"].value
-- incinerator.energy_usage = "320kW"
--incinerator.graphics_set.animation.layers[1].filename = entity .. "incinerator.png"

incinerator.graphics_set = {
      animation =
      {
        layers = {
          {
            filename = entity .. "incinerator.png",
            priority = "high",
            width = 320,
            height = 320,
            scale = 0.5,
            frame_count = 1,
            shift = {1.5, -1.59375}
          },
          {
            filename = entity .. "flare-stack-shadow.png",
            priority = "high",
            width = 320,
            height = 320,
            scale = 0.5,
            frame_count = 1,
            shift = {1.5, -1.59375},
            draw_as_shadow = true
          },
        }
      },
      working_visualisations = {
        {
          animation =
          {
            layers = {
              {
                filename = entity .. "flare-stack-glow-furnace.png",
                priority = "extra-high",
                repeat_count = 29,
                width = 320,
                height = 320,
                scale = 0.5,
                shift = {1.5, -1.59375},
                draw_as_glow = true,
              }
            }
          },
          --light = {intensity = 0.1, size = 5},
          constant_speed = true
        }
      }
    }

incinerator.energy_source =
{
  type = "burner",
  effectivity = 1,
  fuel_inventory_size = 1,
  emissions_per_minute = {pollution = 8},
  light_flicker =
  {
    minimum_intensity = 0,
    maximum_intensity = 0
  },
  smoke =
  {
    {
      name = "incinerator-smoke",
      deviation = {0.1, 0.1},
      frequency = 15,
      north_position = {0.0, -4},
      south_position = {0.0, -4},
      east_position = {0.0, -4},
      west_position = {0.0, -4},
      starting_vertical_speed = 0.08,
      starting_frame_deviation = 60
    }
  }
}
-- incinerator.source_inventory_size = 1
-- incinerator.fluid_boxes = nil



-- Vent Stack ****************************************************************************
--local ventstack = (util.table.deepcopy(data.raw["furnace"]["flare-stack"]))
--ventstack.name = "vent-stack"
--  ventstack.localised_description = FLUID_BURN_RATE_TOOLTIP
--ventstack.icon = icons .. "vent-stack.png"
--ventstack.minable = {mining_time = 0.2, result = "vent-stack"}
-- ventstack.fast_replaceable_group = "fluid-incinerator"
-- ventstack.crafting_categories = {"flaring"}
-- ventstack.crafting_speed = 1
-- ventstack.energy_source.emissions_per_minute = {pollution = 8}
--[[
ventstack.graphics_set.working_visualisations[1].animation.layers =
{
  -{
    filename = entity .. "smoke.png",
    priority = "low",
    frame_count = 29,
    width = 48,
    height = 105,
    shift = {0, -4.3},
    animation_speed = 0.8,
    scale = 0.5,
    run_mode = "backward",
  },
}
ventstack.stateless_visualisation[1].animation.layers[1].filename = entity .. "vent-stack.png"
]]--

data:extend(
{
  incinerator,
  eincinerator,
  --ventstack
})

if mods["space-age"] then

  local gravity = 
  {
    {
      property = "gravity",
      min = 0.1
    }
  }
  data.raw["furnace"]["flare-stack"].surface_conditions = gravity
  data.raw["furnace"]["incinerator"].surface_conditions = gravity
  data.raw["furnace"]["electric-incinerator"].surface_conditions = gravity
  
end

  --  if settings.startup["train-battery-pack-energy-density-setting"].value == "80 MJ" then