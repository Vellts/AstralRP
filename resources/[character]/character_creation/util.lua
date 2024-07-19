function table.size(t)
  local count = 0
  for _ in pairs(t) do count = count + 1 end
  return count
end

function table.filter(t, f)
  local out = {}
  for k, v in pairs(t) do
    if f(v) then
      out[k] = v
    end
  end
  return out
end