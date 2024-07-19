-- DGS = exports.dgs
-- local progressBar = DGS:dgsCreateProgressBar(100,200,100,100,false)
-- local shader = DGS:dgsCreateRoundRect({
--     { 0.2, true },
--     { 0.2, true },
--     { 0.2, true },
--     { 0.2, true }
-- }, tocolor(30, 30, 30, 234))
-- local shader2 = DGS:dgsCreateRoundRect({
--     { 0.2, true },
--     { 0.2, true },
--     { 0.2, true },
--     { 0.2, true }
-- }, tocolor(255, 96, 96, 153))
-- DGS:dgsProgressBarSetProgress(progressBar, 90)
-- DGS:dgsProgressBarSetStyle(progressBar,"normal-vertical")
-- DGS:dgsSetProperties(progressBar, {
--     bgImage = shader,
--     indicatorImage = shader2,
-- })
-- DGS:dgsProgressBarSetStyle(pbRoundOptional,"ring-plain", {
--     rotation = 90,
--     antiAliased = 0.005,
--     radius = 0.1,
--     thickness = 0.1
-- })

addCommandHandler("devmodee", function()
    setElementData(localPlayer, "player::devmode", (not getElementData(localPlayer, "player::devmode")))
    triggerEvent("player::updateBadge", localPlayer, "devmode")
end)

addCommandHandler("testplayername", function()
    local x, y, z = getElementPosition(localPlayer)
    local ped = createPed(0, x, y, z)
    drawName(ped, _)
end)

-- DGS = exports.dgs

-- local x, y, z = getElementPosition(localPlayer)
-- local text = DGS:dgsCreate3DText(x, y, z,"Persona desconocida #1230")
-- DGS:dgsSetProperty(text,"fadeDistance",20)
-- DGS:dgsSetProperty(text,"textSize",{ 0.3, 0.3})
-- -- DGS:dgsSetProperty(text,"shadow",{1,1,tocolor(0,0,0,255),true})
-- -- DGS:dgsSetProperty(text,"outline",{"out",1,tocolor(255,255,255,255)})
-- DGS:dgs3DTextAttachToElement(text,localPlayer,0,0,0.9)