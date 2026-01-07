local alsoHatar = 1
local felsoHatar = 100
math.randomseed(os.time())
local gondoltSzam = math.random(alsoHatar, felsoHatar)
local tipp = nil
local probalkozasok = 0

print(string.format("Gondoltam egy számra %d és %d között. Találd ki!", alsoHatar, felsoHatar))

while tipp ~= gondoltSzam do
    io.write("Add meg a tipped: ")
    tipp = tonumber(io.read())
    probalkozasok = probalkozasok + 1

    if tipp < gondoltSzam then
        print("Nagyobbra gondoltam!")
    elseif tipp > gondoltSzam then
        print("Kisebbre gondoltam!")
    else
        print(string.format("Gratulálok! Eltaláltad %d próbálkozásból!", probalkozasok))
    end
end
