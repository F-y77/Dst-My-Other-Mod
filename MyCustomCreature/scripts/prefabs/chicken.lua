-- 文件: scripts/prefabs/chicken.lua

local Assets = {
    Asset("ANIM", "anim/chicken.zip"),
    Asset("ATLAS", "images/inventoryimages/chicken.xml"),
    Asset("IMAGE", "images/inventoryimages/chicken.tex"),
}

--local brain = require "prefab/chickenbrain"
--local SGChicken = require "states/SGchicken"

local function MakeChicken(name)
    local function fn()
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeCharacterPhysics(inst, 1, 0.5)

        inst.AnimState:SetBank("chicken")
        inst.AnimState:SetBuild("chicken")
        inst.AnimState:PlayAnimation("idle", true)

        inst:AddTag("animal")
        inst:AddTag("chicken")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("locomotor")
        inst.components.locomotor.walkspeed = 2
        inst.components.locomotor.runspeed = 4

        inst:AddComponent("health")
        inst.components.health:SetMaxHealth(50)

        inst:AddComponent("combat")
        inst.components.combat:SetDefaultDamage(5)
        inst.components.combat:SetAttackPeriod(2)

        inst:AddComponent("lootdropper")
        inst.components.lootdropper:SetLoot({"smallmeat", "feather"})

        inst:AddComponent("inspectable")

        inst:AddComponent("knownlocations")
        inst:AddComponent("eater")
        inst.components.eater:SetDiet({FOODTYPE.MEAT}, {FOODTYPE.MEAT})

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = "images/inventoryimages/chicken.xml"

        inst:AddComponent("tradable")

        -- 设置大脑和状态机
        --inst:SetBrain(brain)
        --inst:SetStateGraph("SGchicken")

        return inst
    end

    return Prefab(name, fn, Assets)
end

return MakeChicken("chicken")
