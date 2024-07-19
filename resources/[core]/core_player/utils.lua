function table.size(tab)
    if not tab then return 0 end
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function capitalizeString(str)
    return (str:gsub("^%l", string.upper))
end