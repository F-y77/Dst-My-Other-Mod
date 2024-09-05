-- 文件: modmain.lua

-- 引入必要的API
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- 注册新的预设物文件
PrefabFiles = {
    "chicken"
}

-- 添加鸡的生成代码
local function AddSpawner()
    local function SpawnChicken(inst)
        local x, y, z = inst.Transform:GetWorldPosition()
        local chicken = GLOBAL.SpawnPrefab("chicken")
        if chicken then
            chicken.Transform:SetPosition(x, y, z)
        end
    end

    local function OnSpawnerWake(inst)
        if math.random() < 0.1 then
            SpawnChicken(inst)
        end
    end

    -- 确保在世界初始化后添加事件监听器
    AddPrefabPostInit("world", function(inst)
        inst:DoTaskInTime(0, function()
            inst:ListenForEvent("spawnerwake", OnSpawnerWake)
        end)
    end)
end

-- 执行初始化函数
AddSpawner()
