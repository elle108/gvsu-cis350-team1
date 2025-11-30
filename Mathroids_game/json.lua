-- Minimal JSON encode/decode library (suitable for LÖVE)
local json = {}

----------------------------------------------------------------
-- ENCODE
----------------------------------------------------------------
local function escape_str(s)
    s = s:gsub("\\", "\\\\")
    s = s:gsub("\"", "\\\"")
    s = s:gsub("\b", "\\b")
    s = s:gsub("\f", "\\f")
    s = s:gsub("\n", "\\n")
    s = s:gsub("\r", "\\r")
    s = s:gsub("\t", "\\t")
    return s
end

local function encode_value(v)
    local t = type(v)

    if t == "nil" then
        return "null"

    elseif t == "boolean" then
        return tostring(v)

    elseif t == "number" then
        return tostring(v)

    elseif t == "string" then
        return "\"" .. escape_str(v) .. "\""

    elseif t == "table" then
        local isArray = true
        local max = 0

        for k, _ in pairs(v) do
            if type(k) ~= "number" then
                isArray = false
                break
            elseif k > max then
                max = k
            end
        end

        local items = {}

        if isArray then
            for i = 1, max do
                table.insert(items, encode_value(v[i]))
            end
            return "[" .. table.concat(items, ",") .. "]"
        else
            for k, vv in pairs(v) do
                table.insert(items,
                    "\"" .. tostring(k) .. "\":" .. encode_value(vv)
                )
            end
            return "{" .. table.concat(items, ",") .. "}"
        end
    end

    error("Unsupported JSON type: " .. t)
end

function json.encode(tbl)
    return encode_value(tbl)
end

----------------------------------------------------------------
-- DECODE (simple, supports your leaderboard use case)
----------------------------------------------------------------

function json.decode(str)
    return load("return " .. str:gsub("null", "nil"))()
end

return json
