function table.hasValue(value, table)
    for _, v in ipairs(table) do
        -- iprint(v)
        if v == value then
            return true
        end
    end
    return false
end

function table.size(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end


function clientTransitionElements(elements)
    for _, element in ipairs(elements) do
        
    end
end