function dynamicweather()
  local variable = math.random(0,18)
  --   if variable == 8 then
  --   variable = 18
  -- end
  variable = 8
  setWeatherBlended ( variable )
  setRainLevel(math.random(1, 2))
  setTimer( dynamicweather, math.random( 10000, 10000 ), 1 )
  iprint("changed weather to "..variable)
end

setTimer( dynamicweather, 3000, 1 )