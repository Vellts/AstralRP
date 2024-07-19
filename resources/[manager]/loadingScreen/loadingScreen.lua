local dgs = exports.dgs

local data = {
    currentFile = "assets/fonts/Roboto-Regular.ttf",
    currentFileSize = 856,
    currentFileState = false,
    currentFileProgress = 0,
    dgsElem = nil,
    progressBar = nil,
    fileLabel = nil,
    fileDownloadedLabel = nil,
    tipsLabel = nil,
    artworksImage = nil,
    numberArtworks = 4,
    timerLabel = nil,
    timerArtwork = nil,
}

local function drawLoadingScreen()
    local screenX, screenY = dgs:dgsGetScreenSize()
    local font = dgs:dgsCreateFont("assets/fonts/Poppins-Bold.ttf", 20)

    setTransferBoxVisible (false)
    
    data.dgsElem = dgs:dgsCreateImage(0, 0, screenX, screenY, "assets/wallpaper.jpg", false)
    local shader1 = dgs:dgsCreateRoundRect(6, false, tocolor(35, 35, 35, 200))
    local shader2 = dgs:dgsCreateRoundRect(6, false, tocolor(106, 100, 169, 200))
    data.progressBar = dgs:dgsCreateProgressBar(0.05, 0.85, 0.2, 0.06, true, data.dgsElem)
    dgs:dgsSetProperties(data.progressBar, {
        bgImage = shader1,
        indicatorImage = shader2,
        progress = 60,
        padding = {
            10,
            10
        }
    })

    data.fileLabel = dgs:dgsCreateLabel(0.26, 0.85, 0.2, 0.06, "", true, data.dgsElem)
    dgs:dgsSetProperties(data.fileLabel, {
        font = font,
        textColor = tocolor(227, 224, 255, 120),
        alignment = {"left", "center"},
        textSize = {
            0.7,
            0.7
        }
    })

    data.fileDownloadedLabel = dgs:dgsCreateLabel(0.05, 0.8, 0.2, 0.06, "", true, data.dgsElem)
    dgs:dgsSetProperties(data.fileDownloadedLabel, {
        font = font,
        textColor = tocolor(227, 224, 255, 120),
        alignment = {"left", "center"},
        textSize = {
            0.8,
            0.8
        }
    })

    local logo = dgs:dgsCreateImage(0.47, 0.05, 0.055, 0.09, "assets/logo.png", true, data.dgsElem)

    local tipLabel = dgs:dgsCreateLabel(0.485, 0.3, 0.02, 0.02, "Tip:", true, data.dgsElem)
    dgs:dgsSetProperties(tipLabel, {
        font = font,
        textColor = tocolor(106, 100, 169, 200),
        alignment = {"center", "center"},
        textSize = {
            0.8,
            0.8
        }
    })
    local randomTip = math.random(1, #tips)
    data.tipsLabel = dgs:dgsCreateLabel(0.4, 0.35, 0.2, 0.06, tips[randomTip], true, data.dgsElem)
    dgs:dgsSetProperties(data.tipsLabel, {
        font = font,
        textColor = tocolor(227, 224, 255, 120),
        alignment = {"center", "center"},
        textSize = {
            0.8,
            0.8
        },
        wordBreak = true
    })

    -- artworks
    local randomArtwork = math.random(1,data.numberArtworks)
    data.artworksImage = dgs:dgsCreateImage(0.6, 0.5, 0.4, 0.5, "assets/artworks/"..randomArtwork..".png", true, data.dgsElem)

    data.timerArtwork = setTimer(changeArtwork, 10000, 0)
    data.timerLabel = setTimer(changeTip, 10000, 0)
    setTimer(checkTransferBox, 1000, 1)
end
addEventHandler("onClientResourceStart", resourceRoot, drawLoadingScreen)

function changeArtwork()
    dgs:dgsAlphaTo(data.artworksImage, 0, "OutQuad", 1000)
    setTimer(function()
        local randomArtwork = math.random(1, data.numberArtworks)
        dgs:dgsImageSetImage(data.artworksImage, "assets/artworks/"..randomArtwork..".png")
        dgs:dgsAlphaTo(data.artworksImage, 1, "OutQuad", 1000)
    end, 1000, 1)
end

function changeTip()
    dgs:dgsAlphaTo(data.tipsLabel, 0, "OutQuad", 1000)
    setTimer(function()
        local randomTip = math.random(1, #tips)
        dgs:dgsSetText(data.tipsLabel, tips[randomTip])
        dgs:dgsAlphaTo(data.tipsLabel, 1, "OutQuad", 1000)
    end, 1000, 1)
end

function checkTransferBox()
    if (isTransferBoxActive()) then
        setTimer (function()
            checkTransferBox()
        end, 1000, 1)
    else
        if (isElement(data.dgsElem)) then
            destroyElement(data.dgsElem)
        end
        if (isTimer(data.timerArtwork)) then
            killTimer(data.timerArtwork)
        end
        if (isTimer(data.timerLabel)) then
            killTimer(data.timerLabel)
        end
    end
end

addEventHandler ("onClientTransferBoxProgressChange", root, function (downloadedSize, totalSize)
    local percentage = math.min ((downloadedSize / totalSize) * 100, 100)
    dgs:dgsProgressBarSetProgress(data.progressBar, percentage)
    dgs:dgsSetText(data.fileDownloadedLabel, "Descargando archivos: "..math.floor(percentage).."%")
end)

function writeMsg (fileResource, fileName, fileSize, state)
    local text = fileName.." ("..fileSize.."KB)"
    dgs:dgsSetText(data.fileLabel, text)
end
addEventHandler ("onClientResourceFileDownload", root, writeMsg)