--DESENVOLVIDO POR disc: farpax

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vINVserver = Tunnel.getInterface("ver_inv")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local invOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MOSTRAR TEXTO DO INVENTÁRIO ]---------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("showInventoryNotification")
AddEventHandler("showInventoryNotification", function(text)
    TriggerEvent("chat:addMessage", {
        color = { 255, 0, 0 },
        multiline = true,
        args = { "Inventário", text }
    })
end)
