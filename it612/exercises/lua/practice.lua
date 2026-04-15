local practice = {}

function practice.sum(items)
    local total = 0
    for _, item in ipairs(items) do
        total = total + item
    end 
    return total
end

return practice