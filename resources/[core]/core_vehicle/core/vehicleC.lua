local cancelTheseTypes = { 
    [4]=true, 
    [5]=true, 
    [6]=true, 
    [7]=true 
} 
  
addEventHandler("onClientExplosion",root, 
function (x,y,z,theType) 
    if cancelTheseTypes[theType] then
        iprint("cancelled")
        cancelEvent() 
        setElementHealth(source, 400)
    end 
end) 