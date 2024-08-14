--DESENVOLVIDO POR disc: farpax

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")



vINV = {}
Tunnel.bindInterface("ver_inv", vINV)

function vINV.Mochila(target_id)
    local nuser_id = target_id
    local nplayer = vRP.getUserSource(nuser_id)
    if nplayer then
        local data = vRP.getUserDataTable(nuser_id)
        local weapons = vRPclient.getWeapons(nplayer)
        local money = vRP.getMoney(nuser_id)
        local inventario = {}
        local inventario2 = {}

        if data and data.inventory then
            for k, v in pairs(data.inventory) do
                if vRP.itemBodyList(k) then
                    table.insert(inventario, { amount = parseInt(v.amount), name = vRP.itemNameList(k) })
                end
            end
            if money > 0 then
                table.insert(inventario, { amount = vRP.format(parseInt(money)), name = vRP.itemNameList("carteira") })
            end
            for k, v in pairs(weapons) do
                if v.ammo < 1 then
                    table.insert(inventario2, { amount = 1, name = vRP.itemNameList("wbody|" .. k) })
                else
                    table.insert(inventario2, { amount = 1, name = vRP.itemNameList("wbody|" .. k) })
                    table.insert(inventario2, { amount = v.ammo, name = vRP.itemNameList("wammo|" .. k) })
                end
            end
            return inventario, inventario2
        end
    end
end

function vINV.showInventory(target_id, source)
    local inventario, inventario2 = vINV.Mochila(target_id)
    if inventario then
        local textItems = "Itens do Jogador:\n"
        for _, item in ipairs(inventario) do
            -- Verificação para garantir que o item e suas propriedades não sejam nil
            if item and item.amount and item.name then
                textItems = textItems .. item.amount .. "x " .. item.name .. "\n"
            else
                -- Registrar informações sobre o item que está causando o problema
                print("Erro ao concatenar item do inventário: ", item and item.name or "nome desconhecido", item and item.amount or "quantidade desconhecida")
            end
        end
        for _, item in ipairs(inventario2) do
            -- Verificação para garantir que o item e suas propriedades não sejam nil
            if item and item.amount and item.name then
                textItems = textItems .. item.amount .. "x " .. item.name .. "\n"
            else
                -- Registrar informações sobre o item que está causando o problema
                print("Erro ao concatenar item do inventário: ", item and item.name or "nome desconhecido", item and item.amount or "quantidade desconhecida")
            end
        end
        TriggerClientEvent("showInventoryNotification", source, textItems)
    else
        TriggerClientEvent("Notify", source, "negado", "Jogador não encontrado ou sem inventário.")
    end
end


RegisterCommand('veinv', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local target_id = tonumber(args[1])
	if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "suporte.permissao") then
    if target_id then
        vINV.showInventory(targeSst_id, source)
    else
        TriggerClientEvent("Notify", source, "negado", "Você precisa especificar o ID do jogador para visualizar o inventário.")
    end
else
	TriggerClientEvent("Notify", source, "negado", "Você não é STAFF atualmente.")
end
end)
