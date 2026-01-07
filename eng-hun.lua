local szotar = {
    ["hello"] = "szia",
    ["apple"] = "alma",
    ["house"] = "ház",
    ["cat"] = "macska",
    ["water"] = "víz"
}

print("Angol-magyar szótár gyakorló. Írd be a fordítást!")

local pontszam = 0
local osszesSzo = 0

for angol, magyar in pairs(szotar) do
    osszesSzo = osszesSzo + 1
    io.write("Mi a magyar fordítása a(z) '" .. angol .. "' szónak? ")
    local valasz = io.read():lower():gsub("%s+", "")
    if valasz == magyar then
        print("✅ Helyes!")
        pontszam = pontszam + 1
    else
        print("❌ Nem helyes. A helyes válasz: " .. magyar)
    end
end

print(string.format("\nJáték vége! Eredményed: %d/%d", pontszam, osszesSzo))
