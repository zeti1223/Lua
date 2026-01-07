local szotar = {}
local file = io.open("szotar.txt", "r")
if not file then
    print("Hiba: Nem sikerült megnyitni a szotar.txt fájlt!")
    os.exit()
end

for line in file:lines() do
    local angol, magyar = line:match("([^=]+)=(.+)")
    if angol and magyar then
        szotar[angol:match("^%s*(.-)%s*$")] = magyar
    end
end
file:close()

print("Angol-magyar szótár gyakorló. Írd be a fordítást!")

local pontszam = 0
local osszesSzo = 0

for angol, magyar in pairs(szotar) do
    osszesSzo = osszesSzo + 1
    io.write("Mi a magyar fordítása a(z) '" .. angol .. "' szónak? ")
    local valasz = io.read():lower():gsub("%s+", "")

    local helyes = false
    for szo in magyar:gmatch("([^,]+)") do
        if valasz == szo:lower():gsub("%s+", "") then
            helyes = true
            break
        end
    end

    if helyes then
        print("✅ Helyes!")
        pontszam = pontszam + 1
    else
        print("❌ Nem helyes. A helyes válasz: " .. magyar)
    end
end

print(string.format("\nJáték vége! Eredményed: %d/%d", pontszam, osszesSzo))
