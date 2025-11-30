local json = require("json")
local leaderboard = {}

leaderboard = {
    maxEntries = 10,
    fileName = "leaderboard.json",
    entries = {}
}

function leaderboard.load()
    local file = io.open(leaderboard.fileName, "r")
    if file then
        local content = file:read("*a")
        leaderboard.entries = content ~= "" and json.decode(content) or {}
        file:close()
    else
        leaderboard.entries = {}
    end
end

function leaderboard.save()
    local file = io.open(leaderboard.fileName, "w")
    if file then
        file:write(json.encode(leaderboard.entries))
        file:close()
    end
end

function leaderboard.add(initials, score)
    table.insert(leaderboard.entries, {
        initials = initials, score = score
    })
    table.sort(leaderboard.entries, function(a, b) 
        return a.score > b.score 
    end)

    while #leaderboard.entries > leaderboard.maxEntries do
        table.remove(leaderboard.entries)
    end

    leaderboard.save()
end

function leaderboard.checkHighScore(score)
    if #leaderboard.entries < leaderboard.maxEntries or
        score > leaderboard.entries[#leaderboard.entries].score then
        
        print("New high score! Enter initials:")
        initialsEntry.start(score)
    else
        print("Score did not qualify for leaderboard.")
    end
end

initialsEntry = {
    letters = {"A","B","C","D","E","F","G","H","I","J","K","L","M",
               "N","O","P","Q","R","S","T","U","V","W","X","Y","Z"},
    index = {1,1,1},  -- position of letters (A,A,A)
    currentPos = 1,   -- 1–3
    score = 0
}

function initialsEntry.start(score)
    initialsEntry.score = score
    initialsEntry.index = {1,1,1}
    initialsEntry.currentPos = 1
    initialsEntry.active = true
end

-- Call this when player presses UP
function initialsEntry.increment()
    initialsEntry.index[initialsEntry.currentPos] =
        (initialsEntry.index[initialsEntry.currentPos] % 26) + 1
end

-- Call this when player presses DOWN
function initialsEntry.decrement()
    initialsEntry.index[initialsEntry.currentPos] =
        ((initialsEntry.index[initialsEntry.currentPos] - 2) % 26) + 1
end

-- Call this when player hits ENTER / A button
function initialsEntry.confirmLetter()
    if initialsEntry.currentPos < 3 then
        initialsEntry.currentPos = initialsEntry.currentPos + 1
    else
        -- finalize initials
        local initials =
            initialsEntry.letters[initialsEntry.index[1]] ..
            initialsEntry.letters[initialsEntry.index[2]] ..
            initialsEntry.letters[initialsEntry.index[3]]

        leaderboard.add(initials, initialsEntry.score)

        initialsEntry.active = false
        print("Saved score for:", initials)
    end
end

leaderboard.initialsEntry = initialsEntry
return leaderboard