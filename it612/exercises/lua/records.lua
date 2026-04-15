local records = {
    "alice=88",
    "bob=94",
    "carol=76"
}

local parsed = {}
for _, line in ipairs(records) do
    local name, score = string.match(line, "(%a+)=(%d+)")
    parsed[name] = tonumber(score)
end

for name, score in pairs(parsed) do
    print(name, score)
end
