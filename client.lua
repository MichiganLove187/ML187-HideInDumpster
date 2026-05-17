local Framework = nil
if Config.Framework == "qbcore" then
    Framework = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "qbox" then
    Framework = exports['qbx-core']:GetCoreObject()
end

Main = {}
local inside = false
local oldcoords = nil

CreateThread(function()
    Main:Init()
end)

function Main:Init()
    if Config.Target == "qb-target" then
        exports['qb-target']:AddTargetModel(Config.TrashCans.Hash, {
            options = {
                {
                    event = 'ml187:hideindumpster:enter',
                    type = 'client',
                    icon = "fa-solid fa-trash-can",
                    label = Lang.Hide,
                },
                {
                    event = 'ml187:hideindumpster:exit',
                    type = 'client',
                    icon = "fa-solid fa-trash-can",
                    label = Lang.Exit,
                },
                {
                    event = 'ml187:hideindumpster:search',
                    type = 'client',
                    icon = "fa-solid fa-search",
                    label = "Search Trash Can",
                    job = "police",
                },
            },
            distance = Config.TrashCans.Distance,
        })
    elseif Config.Target == "ox_target" then
        exports.ox_target:addModel(Config.TrashCans.Hash, {
            {
                name = 'hide_in_trashcan',
                icon = "fa-solid fa-trash-can",
                label = Lang.Hide,
                onSelect = function()
                    TriggerEvent('ml187:hideindumpster:enter')
                end
            },
            {
                name = 'exit_trashcan',
                icon = "fa-solid fa-trash-can",
                label = Lang.Exit,
                onSelect = function()
                    TriggerEvent('ml187:hideindumpster:exit')
                end
            },
            {
                name = 'search_trashcan',
                icon = "fa-solid fa-search",
                label = "Search Trash Can",
                onSelect = function()
                    TriggerEvent('ml187:hideindumpster:search')
                end,
                groups = {['police'] = 0}
            }
        })
    end
end

RegisterNetEvent('ml187:hideindumpster:enter', function()
    Main:Enter()
end)

RegisterNetEvent('ml187:hideindumpster:exit', function()
    Main:Exit()
end)

RegisterNetEvent('ml187:hideindumpster:search', function()
    Main:SearchTrashCan()
end)

function Main:Enter()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    
    for k, v in pairs(Config.TrashCans.Hash) do
        local objectId = GetClosestObjectOfType(pedCoords, 1.0, Config.TrashCans.Hash[k], false)
        if DoesEntityExist(objectId) then
            inside = true
            local objectcoords = GetEntityCoords(objectId)
            oldcoords = GetEntityCoords(ped)
            SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z, 0.0, 0.0, 0.0)
            FreezeEntityPosition(ped, true)
            SetEntityVisible(ped, false)
            return
        end
    end
end

function Main:Exit()
    local ped = PlayerPedId()
    if not inside then 
        self:Notify(Lang.NotInside)
        return
    end
    
    inside = false
    SetEntityCoords(ped, oldcoords.x, oldcoords.y, oldcoords.z - 1)
    FreezeEntityPosition(ped, false)
    SetEntityVisible(ped, true)
end

function Main:Notify(msg)
    if msg == nil then return end
    
    if Config.Framework == "qbcore" then
        Framework.Functions.Notify(msg)
    elseif Config.Framework == "qbox" then
        Framework.Functions.Notify(msg)
    else
    
        local Notif = {
            text = msg,
            color = 130,
            flash = false,
            save = true 
        }
        
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(Notif.text)
        ThefeedSetNextPostBackgroundColor(Notif.color)
        EndTextCommandThefeedPostTicker(Notif.flash, Notif.save)
    end
end

function Main:SearchTrashCan()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    
    for k, v in pairs(Config.TrashCans.Hash) do
        local objectId = GetClosestObjectOfType(pedCoords, 1.0, Config.TrashCans.Hash[k], false)
        if DoesEntityExist(objectId) then
            local objectCoords = GetEntityCoords(objectId)
            local playerInside = false
            local players = GetActivePlayers()
            
            for i = 1, #players do
                local player = players[i]
                if player ~= PlayerId() then
                    local playerPed = GetPlayerPed(player)
                    local playerCoords = GetEntityCoords(playerPed)
                    if #(playerCoords - objectCoords) < 1.0 then
                        playerInside = true
                        break
                    end
                end
            end
            
            if playerInside then
                self:Notify(Lang.SearchFound)
            else
                self:Notify(Lang.SearchEmpty)
            end
            return
        end
    end
end
