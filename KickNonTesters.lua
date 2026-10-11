-- Script no ServerScriptService
-- Faz kick de quem não é Tester ou Admin

local Players = game:GetService("Players")

-- Lista de Admins (10)
local adminNames = {
    "Admin1", "Admin2", "Admin3", "Admin4", "Admin5",
    "Admin6", "Admin7", "Admin8", "Admin9", "Admin10"
}

-- Lista de Testers (20)
local testerNames = {
    "Tester1", "Tester2", "Tester3", "Tester4", "Tester5",
    "Tester6", "Tester7", "Tester8", "Tester9", "Tester10",
    "Tester11", "Tester12", "Tester13", "Tester14", "Tester15",
    "Tester16", "Tester17", "Tester18", "Tester19", "Tester20"
}

-- Função para verificar se é admin ou tester
local function isAuthorized(playerName)
    -- Verifica se está na lista de admins
    for _, adminName in ipairs(adminNames) do
        if playerName == adminName then
            return true, "Admin"
        end
    end

    -- Verifica se está na lista de testers
    for _, testerName in ipairs(testerNames) do
        if playerName == testerName then
            return true, "Tester"
        end
    end

    return false, "Player"
end

-- Função quando jogador entra
local function onPlayerAdded(player)
    local authorized, rank = isAuthorized(player.Name)

    if authorized then
        -- Jogador é autorizado (Admin ou Tester)
        player:SetAttribute("Rank", rank)
        print(player.Name .. " entrou como " .. rank .. " ✓")

        -- Mensagem de boas-vindas
        player:SendNotification({
            Title = "✓ Acesso Concedido",
            Text = "Bem-vindo, " .. rank .. "!",
            Duration = 5
        })
    else
        -- Jogador NÃO está autorizado
        print(player.Name .. " não é Tester ou Admin. Fazendo kick...")

        -- Aguarda um pouco para garantir que o jogador carregou
        wait(0.5)

        -- Mensagem de kick
        player:Kick("❌ Você não é Tester!\n\nEste servidor é apenas para Admins e Testers.")
    end
end

-- Quando jogadores já estão no servidor
for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

-- Quando novo jogador entra
Players.PlayerAdded:Connect(onPlayerAdded)

print("═══════════════════════════════════════")
print("Sistema de Kickback Ativo!")
print("Admins: 10")
print("Testers: 20")
print("Outros: KICK com mensagem")
print("═══════════════════════════════════════")
