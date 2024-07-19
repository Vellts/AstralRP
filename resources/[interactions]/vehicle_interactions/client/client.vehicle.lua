local dgs = exports.dgs
local vdrive = nil
local vsit0 = nil
local sW, sH = dgs:dgsGetScreenSize()
local w, h = sW * 0.005, sH * 0.003

function handleVehicleDummy(vehicle, delete)
    -- setTimer(function)
    -- iprint(":D")
    if (not delete) then
        local ldx, ldy, ldz = getVehicleComponentPosition(vehicle, "door_lf_dummy")
        local rdx, rdy, rdz = getVehicleComponentPosition(vehicle, "door_rf_dummy")
        vdrive = drawDriveBadge(ldx, ldy, ldz)
        dgs:dgs3DImageAttachToElement(vdrive, vehicle, ldx, ldy - 0.5, ldz)
        vsit0 = drawSitBadge(rdx, rdy, rdz)
        dgs:dgs3DImageAttachToElement(vsit0, vehicle, rdx, rdy - 0.5, rdz)
    else
        if (isElement(vdrive)) then
            destroyElement(vdrive)
            vdrive = nil
        end
        if (isElement(vsit0)) then
            destroyElement(vsit0)
            vsit0 = nil
        end
    end
end
addEvent("vehicle_interaction::handleVehicleDummy", true)
addEventHandler("vehicle_interaction::handleVehicleDummy", resourceRoot, handleVehicleDummy)

function drawDriveBadge(x, y, z)
    local driveTexture = dxCreateTexture("assets/drive.png")
    local image = dgs:dgsCreate3DImage(x, y, z, driveTexture)
    dgs:dgsSetProperty(image,"fadeDistance",5)
    dgs:dgs3DImageSetSize(image, w, h)
    -- destroyElement(driveTexture)
    return image
end

function drawSitBadge(x, y, z)
    local driveTexture = dxCreateTexture("assets/sit.png")
    local image = dgs:dgsCreate3DImage(x, y, z, driveTexture)
    dgs:dgsSetProperty(image,"fadeDistance",5)
    dgs:dgs3DImageSetSize(image, w, h)
    -- destroyElement(driveTexture)
    return image
end