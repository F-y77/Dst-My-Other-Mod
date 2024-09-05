-- 文件: scripts/states/SGchicken.lua

local State = require("stategraph/state")

local states = {
    State{
        name = "idle",
        tags = {"idle"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle", true)
            inst.components.locomotor:Stop()
        end,
    },

    State{
        name = "run",
        tags = {"moving"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("run", true)
            inst.components.locomotor:RunForward()
        end,
        timeline = {
            TimeEvent(0, function(inst) inst.SoundEmitter:PlaySound("dontstarve/rabbit/hop") end),
        },
    },

    State{
        name = "death",
        tags = {"busy"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("death")
            inst.components.lootdropper:DropLoot()
            inst:Remove()
        end,
    },
}

return StateGraph("SGchicken", states, {}, "idle")

