math.randomseed(os.time())

local board = { " ", " ", " ", " ", " ", " ", " ", " ", " " }
local player = "X"
local bot = "O"
local current_turn = player

local function print_board(cursor_pos)
    os.execute("clear")
    print("\n")

    local function cell(i)
        local content = board[i]
        if i == cursor_pos then
            return "[" .. content .. "]"
        else
            return " " .. content .. " "
        end
    end

    print(" " .. cell(1) .. "|" .. cell(2) .. "|" .. cell(3))
    print(" ---+---+---")
    print(" " .. cell(4) .. "|" .. cell(5) .. "|" .. cell(6))
    print(" ---+---+---")
    print(" " .. cell(7) .. "|" .. cell(8) .. "|" .. cell(9))
    print("\n")
end

local function check_win(p)
    local wins = {
        { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 },
        { 1, 4, 7 }, { 2, 5, 8 }, { 3, 6, 9 },
        { 1, 5, 9 }, { 3, 5, 7 }
    }
    for _, w in ipairs(wins) do
        if board[w[1]] == p and board[w[2]] == p and board[w[3]] == p then
            return true
        end
    end
    return false
end

local function is_full()
    for i = 1, 9 do
        if board[i] == " " then return false end
    end
    return true
end

local function bot_move()
    local available = {}
    for i = 1, 9 do
        if board[i] == " " then table.insert(available, i) end
    end

    if #available > 0 then
        -- Véletlenszerű lépés a szabad helyek közül
        local choice = available[math.random(#available)]
        board[choice] = bot
    end
end

local function read_key()
    os.execute("stty raw -echo")
    local key = io.read(1)
    if key == "\27" then
        key = key .. io.read(1) .. io.read(1)
    end
    os.execute("stty -raw echo")
    return key
end

print("Üdvözöllek a Tic Tac Toe játékban!")
print("Te vagy az X, a gép az O.")
print("Nyomj egy gombot a kezdéshez...")
read_key()

while true do
    if current_turn == player then
        local cursor = 5
        local moved = false
        while not moved do
            print_board(cursor)
            print("Nyilak: mozgás, Enter: lerakás, q: kilépés")
            local key = read_key()

            if key == "\27[A" and cursor > 3 then
                cursor = cursor - 3
            elseif key == "\27[B" and cursor <= 6 then
                cursor = cursor + 3
            elseif key == "\27[C" and cursor % 3 ~= 0 then
                cursor = cursor + 1
            elseif key == "\27[D" and cursor % 3 ~= 1 then
                cursor = cursor - 1
            elseif key == "\13" or key == "\10" then
                if board[cursor] == " " then
                    board[cursor] = player
                    moved = true
                end
            elseif key == "q" then
                os.exit()
            end
        end

        if check_win(player) then
            print_board(cursor)
            print("Gratulálok, nyertél!")
            break
        elseif is_full() then
            print_board(cursor)
            print("Döntetlen!")
            break
        end
        current_turn = bot
    else
        print("A gép lép...")
        bot_move()
        if check_win(bot) then
            print_board()
            print("Sajnálom, a gép nyert!")
            break
        elseif is_full() then
            print_board()
            print("Döntetlen!")
            break
        end
        current_turn = player
    end
end
