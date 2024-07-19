-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/


-- Discord : https://discord.gg/DzgEcvy

local weap = {shot=false,timer=false}
addEventHandler("onClientPlayerWeaponFire", localPlayer, function()
    local rot = getPedCameraRotation(localPlayer)
    if (isTimer(weap.timer)) then killTimer(weap.timer); end
    if (not weap.shot) then
        setPedCameraRotation(localPlayer, -(rot-0.18))
        weap.shot = true
        weap.timer = setTimer(setPedCameraRotation, 50, 1, localPlayer, -(rot+0.30))
    else
        setPedCameraRotation(localPlayer, -(rot+0.18))
        weap.shot = false
        weap.timer = setTimer(setPedCameraRotation, 50, 1, localPlayer, -(rot-0.30))
    end
end)

-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/


-- Discord : https://discord.gg/DzgEcvy



--[[function rotateCameraRight()
        if getKeyState( "mouse1" ) == false then
            removeEventHandler("onClientPreRender", root, rotateCameraRight)
        else
            setTimer (function()
            setPedCameraRotation(localPlayer, -(getPedCameraRotation(localPlayer) + 0.08))
            setPedCameraRotation(localPlayer, -(getPedCameraRotation(localPlayer) - 0.08))
        end, 50, 1 )
            setCameraMatrix (x, y+0.8, z, lx, ly, lz)
            setCameraTarget ( localPlayer )
        if not isTimer(timer_right) then
            timer_left = setTimer ( timer_l, 850, 1 )
        end
    end
end

function timer_l()
    removeEventHandler("onClientPreRender", root, rotateCameraRight)
    addEventHandler("onClientPreRender", root, rotateCameraLeft)
end

function rotateCameraLeft()
        if getKeyState( "mouse1" ) == false then
            removeEventHandler("onClientPreRender", root, rotateCameraLeft)
        else
            setTimer ( function()
            setPedCameraRotation(localPlayer, -(getPedCameraRotation(localPlayer) - 0.08))
            setPedCameraRotation(localPlayer, -(getPedCameraRotation(localPlayer) + 0.08))
        end, 50, 1 )
            setCameraMatrix (x, y-0.8, z, lx, ly, lz)
            setCameraTarget ( localPlayer )
        if not isTimer(timer_left) then
            timer_right = setTimer ( timer_r, 900, 1 )
        end
    end
end
function timer_r()
    removeEventHandler("onClientPreRender", root, rotateCameraLeft)
    addEventHandler("onClientPreRender", root, rotateCameraRight)
end

function addEvent()
local weapon = getPedWeapon(localPlayer)
    if (weapon==34) or (weapon==31) or (weapon==30) or (weapon==6) then
        addEventHandler("onClientPreRender", root, rotateCameraRight)
    end
end
bindKey("mouse1", "down", addEvent)

bind = true]]


-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/


-- Discord : https://discord.gg/DzgEcvy