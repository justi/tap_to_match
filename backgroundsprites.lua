--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:1421df34bea7a6aab34c1b6a7bc2923a:1/1$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- game_page
            x=2,
            y=484,
            width=320,
            height=480,

        },
        {
            -- lead_page
            x=2,
            y=2,
            width=320,
            height=480,

        },
    },
    
    sheetContentWidth = 512,
    sheetContentHeight = 1024
}

SheetInfo.frameIndex =
{

    ["game_page"] = 1,
    ["lead_page"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
