--================================================--
--              MIRACLE AUTO SYSTEM
--       CAMERA ZOOM + AUTO LOOT + AUTO CLICK
--                PC + MOBILE
--================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

--================================================--
-- SETTINGS
--================================================--

-- CAMERA ZOOM
local MIN_ZOOM = 5
local MAX_ZOOM = 2000
local ZoomDistance = 100

-- AUTO LOOT
local AutoLoot = true
local AutoLootLoopRunning = false

-- ตรวจ Loot ทุกครั้ง
local LOOT_SCAN_DELAY = 0.15

-- เวลารอก่อนตรวจรอบใหม่
local LOOT_RESCAN_DELAY = 0.05

-- AUTO CLICK
local AutoClick = false
local ClickInterval = 1

local ClickX = 0
local ClickY = 0


--================================================--
-- REMOVE OLD UI
--================================================--

pcall(function()

    local Old =
        CoreGui:FindFirstChild("MIRACLE_AUTO_SYSTEM")

    if Old then
        Old:Destroy()
    end

end)


--================================================--
-- SCREEN GUI
--================================================--

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MIRACLE_AUTO_SYSTEM"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui


--================================================--
-- MAIN
--================================================--

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 390, 0, 470)
Main.Position = UDim2.new(0.5, -195, 0.5, -235)
Main.BackgroundColor3 = Color3.fromRGB(10, 15, 28)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(35, 100, 190)
MainStroke.Thickness = 1.5
MainStroke.Parent = Main


--================================================--
-- HEADER
--================================================--

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(13, 25, 48)
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 14)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 15)
HeaderFix.Position = UDim2.new(0, 0, 1, -15)
HeaderFix.BackgroundColor3 = Header.BackgroundColor3
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header


--================================================--
-- TITLE
--================================================--

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MIRACLE AUTO"
Title.TextColor3 = Color3.fromRGB(100, 180, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -100, 0, 18)
Subtitle.Position = UDim2.new(0, 21, 0, 34)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "AUTO SYSTEM • PC + MOBILE"
Subtitle.TextColor3 = Color3.fromRGB(130, 145, 170)
Subtitle.TextSize = 10
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header


--================================================--
-- MINIMIZE
--================================================--

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0, 38, 0, 38)
Minimize.Position = UDim2.new(1, -49, 0, 11)
Minimize.BackgroundColor3 = Color3.fromRGB(25, 55, 95)
Minimize.BorderSizePixel = 0
Minimize.Text = "−"
Minimize.TextColor3 = Color3.fromRGB(220, 235, 255)
Minimize.TextSize = 24
Minimize.Font = Enum.Font.GothamBold
Minimize.AutoButtonColor = false
Minimize.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 10)
MinCorner.Parent = Minimize


--================================================--
-- CONTENT
--================================================--

local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -20, 1, -70)
Content.Position = UDim2.new(0, 10, 0, 68)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Color3.fromRGB(50, 110, 190)
Content.CanvasSize = UDim2.new(0, 0, 0, 470)
Content.Parent = Main


--================================================--
-- SECTION FUNCTION
--================================================--

local function CreateSection(Parent, Y, Height)

    local Frame = Instance.new("Frame")

    Frame.Size =
        UDim2.new(1, -5, 0, Height)

    Frame.Position =
        UDim2.new(0, 2, 0, Y)

    Frame.BackgroundColor3 =
        Color3.fromRGB(15, 23, 40)

    Frame.BorderSizePixel = 0
    Frame.Parent = Parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 11)
    Corner.Parent = Frame

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(30, 55, 90)
    Stroke.Thickness = 1
    Stroke.Parent = Frame

    return Frame

end


--================================================--
-- CAMERA SECTION
--================================================--

local CameraSection =
    CreateSection(Content, 0, 145)

local CameraTitle = Instance.new("TextLabel")
CameraTitle.Size = UDim2.new(1, -30, 0, 28)
CameraTitle.Position = UDim2.new(0, 15, 0, 10)
CameraTitle.BackgroundTransparency = 1
CameraTitle.Text = "🔭  CAMERA ZOOM"
CameraTitle.TextColor3 = Color3.fromRGB(100, 180, 255)
CameraTitle.TextSize = 16
CameraTitle.Font = Enum.Font.GothamBold
CameraTitle.TextXAlignment = Enum.TextXAlignment.Left
CameraTitle.Parent = CameraSection


local ZoomValue = Instance.new("TextLabel")
ZoomValue.Size = UDim2.new(0, 100, 0, 28)
ZoomValue.Position = UDim2.new(1, -115, 0, 10)
ZoomValue.BackgroundColor3 = Color3.fromRGB(20, 50, 85)
ZoomValue.BorderSizePixel = 0
ZoomValue.Text = tostring(ZoomDistance)
ZoomValue.TextColor3 = Color3.fromRGB(180, 220, 255)
ZoomValue.TextSize = 13
ZoomValue.Font = Enum.Font.GothamBold
ZoomValue.Parent = CameraSection

local ZoomCorner = Instance.new("UICorner")
ZoomCorner.CornerRadius = UDim.new(0, 7)
ZoomCorner.Parent = ZoomValue


--================================================--
-- ZOOM SLIDER
--================================================--

local SliderBack = Instance.new("Frame")
SliderBack.Size = UDim2.new(1, -30, 0, 8)
SliderBack.Position = UDim2.new(0, 15, 0, 57)
SliderBack.BackgroundColor3 = Color3.fromRGB(35, 45, 65)
SliderBack.BorderSizePixel = 0
SliderBack.Parent = CameraSection

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(1, 0)
SliderCorner.Parent = SliderBack


local SliderFill = Instance.new("Frame")
SliderFill.BackgroundColor3 = Color3.fromRGB(50, 135, 235)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBack

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(1, 0)
FillCorner.Parent = SliderFill


local SliderButton = Instance.new("TextButton")
SliderButton.Size = UDim2.new(0, 20, 0, 20)
SliderButton.AnchorPoint = Vector2.new(0.5, 0.5)
SliderButton.BackgroundColor3 = Color3.fromRGB(120, 195, 255)
SliderButton.BorderSizePixel = 0
SliderButton.Text = ""
SliderButton.Parent = SliderBack

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(1, 0)
ButtonCorner.Parent = SliderButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Color = Color3.fromRGB(220, 240, 255)
ButtonStroke.Thickness = 2
ButtonStroke.Parent = SliderButton


--================================================--
-- SET ZOOM
--================================================--

local function SetZoom(Value)

    ZoomDistance =
        math.clamp(
            math.floor(Value + 0.5),
            MIN_ZOOM,
            MAX_ZOOM
        )

    pcall(function()

        Player.CameraMinZoomDistance =
            ZoomDistance

        Player.CameraMaxZoomDistance =
            ZoomDistance

    end)

    ZoomValue.Text =
        tostring(ZoomDistance)

    local Percent =
        (ZoomDistance - MIN_ZOOM) /
        (MAX_ZOOM - MIN_ZOOM)

    SliderFill.Size =
        UDim2.new(
            Percent,
            0,
            1,
            0
        )

    SliderButton.Position =
        UDim2.new(
            Percent,
            0,
            0.5,
            0
        )

end


local function SetZoomFromInput(Input)

    local X =
        Input.Position.X

    local StartX =
        SliderBack.AbsolutePosition.X

    local Width =
        SliderBack.AbsoluteSize.X

    local Percent =
        math.clamp(
            (X - StartX) / Width,
            0,
            1
        )

    local Value =
        MIN_ZOOM +
        ((MAX_ZOOM - MIN_ZOOM) * Percent)

    SetZoom(Value)

end


local DraggingSlider = false


SliderButton.InputBegan:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch
    then

        DraggingSlider = true

        SetZoomFromInput(Input)

    end

end)


SliderBack.InputBegan:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch
    then

        DraggingSlider = true

        SetZoomFromInput(Input)

    end

end)


UserInputService.InputChanged:Connect(function(Input)

    if not DraggingSlider then
        return
    end

    if Input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch
    then

        SetZoomFromInput(Input)

    end

end)


UserInputService.InputEnded:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch
    then

        DraggingSlider = false

    end

end)


SetZoom(ZoomDistance)


--================================================--
-- ZOOM TEXT
--================================================--

local ZoomMinText = Instance.new("TextLabel")
ZoomMinText.Size = UDim2.new(0, 50, 0, 20)
ZoomMinText.Position = UDim2.new(0, 15, 0, 72)
ZoomMinText.BackgroundTransparency = 1
ZoomMinText.Text = "5"
ZoomMinText.TextColor3 = Color3.fromRGB(120, 135, 160)
ZoomMinText.TextSize = 11
ZoomMinText.Font = Enum.Font.Gotham
ZoomMinText.TextXAlignment = Enum.TextXAlignment.Left
ZoomMinText.Parent = CameraSection


local ZoomMaxText = Instance.new("TextLabel")
ZoomMaxText.Size = UDim2.new(0, 60, 0, 20)
ZoomMaxText.Position = UDim2.new(1, -75, 0, 72)
ZoomMaxText.BackgroundTransparency = 1
ZoomMaxText.Text = "2000"
ZoomMaxText.TextColor3 = Color3.fromRGB(120, 135, 160)
ZoomMaxText.TextSize = 11
ZoomMaxText.Font = Enum.Font.Gotham
ZoomMaxText.TextXAlignment = Enum.TextXAlignment.Right
ZoomMaxText.Parent = CameraSection


local ZoomInfo = Instance.new("TextLabel")
ZoomInfo.Size = UDim2.new(1, -30, 0, 25)
ZoomInfo.Position = UDim2.new(0, 15, 0, 102)
ZoomInfo.BackgroundTransparency = 1
ZoomInfo.Text = "ลากแถบเพื่อปรับระยะกล้อง • 5 - 2000"
ZoomInfo.TextColor3 = Color3.fromRGB(110, 125, 150)
ZoomInfo.TextSize = 11
ZoomInfo.Font = Enum.Font.Gotham
ZoomInfo.TextXAlignment = Enum.TextXAlignment.Left
ZoomInfo.Parent = CameraSection


--================================================--
-- AUTO LOOT SECTION
--================================================--

local LootSection =
    CreateSection(Content, 155, 105)


local LootTitle = Instance.new("TextLabel")
LootTitle.Size = UDim2.new(1, -110, 0, 30)
LootTitle.Position = UDim2.new(0, 15, 0, 12)
LootTitle.BackgroundTransparency = 1
LootTitle.Text = "🧲  AUTO LOOT"
LootTitle.TextColor3 = Color3.fromRGB(100, 180, 255)
LootTitle.TextSize = 16
LootTitle.Font = Enum.Font.GothamBold
LootTitle.TextXAlignment = Enum.TextXAlignment.Left
LootTitle.Parent = LootSection


local LootStatus = Instance.new("TextLabel")
LootStatus.Size = UDim2.new(1, -30, 0, 20)
LootStatus.Position = UDim2.new(0, 15, 0, 43)
LootStatus.BackgroundTransparency = 1
LootStatus.Text = "กำลังเริ่มระบบ..."
LootStatus.TextColor3 = Color3.fromRGB(120, 190, 150)
LootStatus.TextSize = 11
LootStatus.Font = Enum.Font.Gotham
LootStatus.TextXAlignment = Enum.TextXAlignment.Left
LootStatus.Parent = LootSection


local LootToggle = Instance.new("TextButton")
LootToggle.Size = UDim2.new(0, 70, 0, 32)
LootToggle.Position = UDim2.new(1, -85, 0, 15)
LootToggle.BackgroundColor3 = Color3.fromRGB(35, 150, 100)
LootToggle.BorderSizePixel = 0
LootToggle.Text = "ON"
LootToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
LootToggle.TextSize = 13
LootToggle.Font = Enum.Font.GothamBold
LootToggle.AutoButtonColor = false
LootToggle.Parent = LootSection

local LootCorner = Instance.new("UICorner")
LootCorner.CornerRadius = UDim.new(0, 8)
LootCorner.Parent = LootToggle


--================================================--
-- AUTO CLICK SECTION
--================================================--

local ClickSection =
    CreateSection(Content, 270, 180)


local ClickTitle = Instance.new("TextLabel")
ClickTitle.Size = UDim2.new(1, -110, 0, 30)
ClickTitle.Position = UDim2.new(0, 15, 0, 12)
ClickTitle.BackgroundTransparency = 1
ClickTitle.Text = "🖱️  AUTO CLICK"
ClickTitle.TextColor3 = Color3.fromRGB(100, 180, 255)
ClickTitle.TextSize = 16
ClickTitle.Font = Enum.Font.GothamBold
ClickTitle.TextXAlignment = Enum.TextXAlignment.Left
ClickTitle.Parent = ClickSection


local ClickToggle = Instance.new("TextButton")
ClickToggle.Size = UDim2.new(0, 70, 0, 32)
ClickToggle.Position = UDim2.new(1, -85, 0, 15)
ClickToggle.BackgroundColor3 = Color3.fromRGB(65, 70, 85)
ClickToggle.BorderSizePixel = 0
ClickToggle.Text = "OFF"
ClickToggle.TextColor3 = Color3.fromRGB(220, 225, 235)
ClickToggle.TextSize = 13
ClickToggle.Font = Enum.Font.GothamBold
ClickToggle.AutoButtonColor = false
ClickToggle.Parent = ClickSection

local ClickCorner = Instance.new("UICorner")
ClickCorner.CornerRadius = UDim.new(0, 8)
ClickCorner.Parent = ClickToggle


--================================================--
-- CLICK POSITION
--================================================--

local PositionText = Instance.new("TextLabel")
PositionText.Size = UDim2.new(1, -30, 0, 25)
PositionText.Position = UDim2.new(0, 15, 0, 55)
PositionText.BackgroundTransparency = 1
PositionText.Text = "Position: ยังไม่ได้เลือก"
PositionText.TextColor3 = Color3.fromRGB(150, 160, 180)
PositionText.TextSize = 11
PositionText.Font = Enum.Font.Gotham
PositionText.TextXAlignment = Enum.TextXAlignment.Left
PositionText.Parent = ClickSection


local SelectPosition = Instance.new("TextButton")
SelectPosition.Size = UDim2.new(1, -30, 0, 32)
SelectPosition.Position = UDim2.new(0, 15, 0, 82)
SelectPosition.BackgroundColor3 = Color3.fromRGB(25, 65, 105)
SelectPosition.BorderSizePixel = 0
SelectPosition.Text = "SELECT CLICK POSITION"
SelectPosition.TextColor3 = Color3.fromRGB(190, 225, 255)
SelectPosition.TextSize = 12
SelectPosition.Font = Enum.Font.GothamBold
SelectPosition.AutoButtonColor = false
SelectPosition.Parent = ClickSection

local SelectCorner = Instance.new("UICorner")
SelectCorner.CornerRadius = UDim.new(0, 8)
SelectCorner.Parent = SelectPosition


--================================================--
-- CLICK INTERVAL
--================================================--

local IntervalLabel = Instance.new("TextLabel")
IntervalLabel.Size = UDim2.new(0, 130, 0, 22)
IntervalLabel.Position = UDim2.new(0, 15, 0, 125)
IntervalLabel.BackgroundTransparency = 1
IntervalLabel.Text = "Click Interval"
IntervalLabel.TextColor3 = Color3.fromRGB(145, 160, 180)
IntervalLabel.TextSize = 11
IntervalLabel.Font = Enum.Font.Gotham
IntervalLabel.TextXAlignment = Enum.TextXAlignment.Left
IntervalLabel.Parent = ClickSection


local IntervalBox = Instance.new("TextBox")
IntervalBox.Size = UDim2.new(0, 100, 0, 28)
IntervalBox.Position = UDim2.new(1, -115, 0, 122)
IntervalBox.BackgroundColor3 = Color3.fromRGB(25, 35, 55)
IntervalBox.BorderSizePixel = 0
IntervalBox.Text = "1"
IntervalBox.PlaceholderText = "0.1"
IntervalBox.TextColor3 = Color3.fromRGB(220, 230, 245)
IntervalBox.TextSize = 12
IntervalBox.Font = Enum.Font.GothamBold
IntervalBox.ClearTextOnFocus = false
IntervalBox.Parent = ClickSection

local IntervalCorner = Instance.new("UICorner")
IntervalCorner.CornerRadius = UDim.new(0, 7)
IntervalCorner.Parent = IntervalBox


--================================================--
-- DRAG MAIN UI
--================================================--

local DraggingMain = false
local DragStart = nil
local StartPosition = nil


Header.InputBegan:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch
    then

        DraggingMain = true
        DragStart = Input.Position
        StartPosition = Main.Position

    end

end)


UserInputService.InputChanged:Connect(function(Input)

    if not DraggingMain then
        return
    end

    if Input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch
    then

        local Delta =
            Input.Position - DragStart

        Main.Position =
            UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )

    end

end)


UserInputService.InputEnded:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch
    then

        DraggingMain = false

    end

end)


--================================================--
-- OPEN BUTTON
--================================================--

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 58, 0, 58)
OpenButton.Position = UDim2.new(0, 20, 0.5, -29)
OpenButton.BackgroundColor3 = Color3.fromRGB(15, 55, 100)
OpenButton.BorderSizePixel = 0
OpenButton.Text = "M"
OpenButton.TextColor3 = Color3.fromRGB(150, 215, 255)
OpenButton.TextSize = 25
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Visible = false
OpenButton.AutoButtonColor = false
OpenButton.Parent = ScreenGui


local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton


local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(60, 150, 235)
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenButton


Minimize.Activated:Connect(function()

    Main.Visible = false
    OpenButton.Visible = true

end)


OpenButton.Activated:Connect(function()

    Main.Visible = true
    OpenButton.Visible = false

end)


--================================================--
-- DRAG OPEN BUTTON
--================================================--

local DraggingOpen = false
local OpenDragStart = nil
local OpenStartPosition = nil


OpenButton.InputBegan:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch
    then

        DraggingOpen = true
        OpenDragStart = Input.Position
        OpenStartPosition = OpenButton.Position

    end

end)


UserInputService.InputChanged:Connect(function(Input)

    if not DraggingOpen then
        return
    end

    if Input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch
    then

        local Delta =
            Input.Position - OpenDragStart

        OpenButton.Position =
            UDim2.new(
                OpenStartPosition.X.Scale,
                OpenStartPosition.X.Offset + Delta.X,
                OpenStartPosition.Y.Scale,
                OpenStartPosition.Y.Offset + Delta.Y
            )

    end

end)


UserInputService.InputEnded:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch
    then

        DraggingOpen = false

    end

end)


--================================================--
-- AUTO LOOT BUTTON
--================================================--

local function UpdateLootButton()

    if AutoLoot then

        LootToggle.Text = "ON"

        LootToggle.BackgroundColor3 =
            Color3.fromRGB(35, 150, 100)

        LootStatus.Text =
            "🧲 กำลังตรวจหา Loot..."

        LootStatus.TextColor3 =
            Color3.fromRGB(100, 210, 145)

    else

        LootToggle.Text = "OFF"

        LootToggle.BackgroundColor3 =
            Color3.fromRGB(65, 70, 85)

        LootStatus.Text =
            "Auto Loot หยุดแล้ว"

        LootStatus.TextColor3 =
            Color3.fromRGB(140, 150, 165)

    end

end


LootToggle.Activated:Connect(function()

    AutoLoot = not AutoLoot

    UpdateLootButton()

    if AutoLoot then

        -- ถ้าเปิดใหม่ ให้สร้าง loop ใหม่ทันที
        StartAutoLootLoop()

    end

end)


--================================================--
-- AUTO CLICK BUTTON
--================================================--

local function UpdateClickButton()

    if AutoClick then

        ClickToggle.Text = "ON"

        ClickToggle.BackgroundColor3 =
            Color3.fromRGB(35, 150, 100)

    else

        ClickToggle.Text = "OFF"

        ClickToggle.BackgroundColor3 =
            Color3.fromRGB(65, 70, 85)

    end

end


ClickToggle.Activated:Connect(function()

    AutoClick = not AutoClick

    UpdateClickButton()

end)


--================================================--
-- CLICK INTERVAL
--================================================--

IntervalBox.FocusLost:Connect(function()

    local Value =
        tonumber(IntervalBox.Text)

    if not Value then

        IntervalBox.Text =
            tostring(ClickInterval)

        return

    end

    ClickInterval =
        math.max(
            0.1,
            Value
        )

    IntervalBox.Text =
        tostring(ClickInterval)

end)


--================================================--
-- SELECT CLICK POSITION
--================================================--

local SelectingPosition = false


SelectPosition.Activated:Connect(function()

    SelectingPosition = true

    Main.Visible = false
    OpenButton.Visible = false

    PositionText.Text =
        "Position: กำลังเลือก..."

end)


UserInputService.InputBegan:Connect(function(Input, GameProcessed)

    if not SelectingPosition then
        return
    end

    if GameProcessed then
        return
    end

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch
    then

        ClickX =
            Input.Position.X

        ClickY =
            Input.Position.Y

        SelectingPosition = false

        PositionText.Text =
            string.format(
                "Position: %.0f, %.0f",
                ClickX,
                ClickY
            )

        Main.Visible = true

    end

end)


--================================================--
-- AUTO CLICK LOOP
--================================================--

task.spawn(function()

    while ScreenGui.Parent do

        if AutoClick
            and ClickX > 0
            and ClickY > 0
        then

            pcall(function()

                VirtualInputManager:SendMouseButtonEvent(
                    ClickX,
                    ClickY,
                    0,
                    true,
                    game,
                    0
                )

                task.wait(0.02)

                VirtualInputManager:SendMouseButtonEvent(
                    ClickX,
                    ClickY,
                    0,
                    false,
                    game,
                    0
                )

            end)


            local StartTime =
                os.clock()

            while AutoClick
                and os.clock() - StartTime < ClickInterval
            do

                task.wait(0.01)

            end

        else

            task.wait(0.05)

        end

    end

end)


--================================================--
-- GET LOOT
--================================================--

local function GetLootObjects()

    local Loots = {}
    local Seen = {}

    -- ใช้ GetDescendants ทุกครั้ง
    -- เพื่อให้เจอ Loot ที่เพิ่งเกิด

    for _, Object in ipairs(
        workspace:GetDescendants()
    ) do

        if Object:IsA("Model")
            and Object.Name == "Loot"
        then

            local CollectLoot =
                Object:FindFirstChild(
                    "CollectLoot"
                )

            if CollectLoot
                and not Seen[Object]
            then

                Seen[Object] = true

                table.insert(
                    Loots,
                    Object
                )

            end

        end

    end

    return Loots

end


--================================================--
-- COLLECT LOOT
--================================================--

local function CollectLoot(Loot)

    if not Loot
        or not Loot.Parent
    then

        return false

    end


    local Remote =
        Loot:FindFirstChild(
            "CollectLoot"
        )


    if not Remote then
        return false
    end


    if Remote:IsA("RemoteEvent") then

        local Success =
            pcall(function()

                Remote:FireServer(Loot)

            end)

        return Success

    end


    return false

end


--================================================--
-- AUTO LOOT LOOP
--================================================--

function StartAutoLootLoop()

    -- ป้องกัน loop ซ้ำ
    if AutoLootLoopRunning then
        return
    end

    AutoLootLoopRunning = true


    task.spawn(function()

        while AutoLoot do

            -- หา Loot ใหม่ทุกครั้ง
            local Loots =
                GetLootObjects()


            if #Loots == 0 then

                LootStatus.Text =
                    "⏳ รอ Loot เกิด..."

            else

                LootStatus.Text =
                    "🧲 พบ Loot " ..
                    #Loots ..
                    " ชิ้น"


                for Index, Loot in ipairs(Loots) do

                    if not AutoLoot then
                        break
                    end


                    if Loot
                        and Loot.Parent
                    then

                        CollectLoot(Loot)

                    end


                    task.wait(
                        LOOT_SCAN_DELAY
                    )

                end


                if AutoLoot then

                    LootStatus.Text =
                        "🧲 ตรวจแล้ว " ..
                        #Loots ..
                        " ชิ้น"

                end

            end


            -- สำคัญ:
            -- ไม่หยุด loop เมื่อไม่เจอ Loot
            -- จะวนกลับไปหาใหม่ตลอด

            task.wait(
                LOOT_RESCAN_DELAY
            )

        end


        AutoLootLoopRunning = false

    end)

end


--================================================--
-- KEEP CAMERA ZOOM
--================================================--

RunService.RenderStepped:Connect(function()

    if Player.CameraMinZoomDistance
        ~= ZoomDistance
    then

        pcall(function()

            Player.CameraMinZoomDistance =
                ZoomDistance

        end)

    end


    if Player.CameraMaxZoomDistance
        ~= ZoomDistance
    then

        pcall(function()

            Player.CameraMaxZoomDistance =
                ZoomDistance

        end)

    end

end)


--================================================--
-- RESPAWN
--================================================--

Player.CharacterAdded:Connect(function()

    task.wait(0.5)

    SetZoom(ZoomDistance)

    -- ตรวจให้แน่ใจว่า Auto Loot ยังทำงาน
    if AutoLoot then
        StartAutoLootLoop()
    end

end)


--================================================--
-- INITIALIZE
--================================================--

SetZoom(ZoomDistance)

UpdateLootButton()
UpdateClickButton()

-- เริ่ม Auto Loot หลัง UI ถูกสร้างเสร็จทั้งหมด
task.spawn(function()

    -- รอให้แมพเริ่มโหลด
    task.wait(0.5)

    if AutoLoot then
        StartAutoLootLoop()
    end

end)


--================================================--
-- DEBUG
--================================================--

print("========================================")
print("         MIRACLE AUTO SYSTEM")
print("========================================")
print("Camera Zoom : 5 - 2000")
print("Current Zoom:", ZoomDistance)
print("Auto Loot   :", AutoLoot)
print("Auto Click  :", AutoClick)
print("Click Speed :", ClickInterval)
print("----------------------------------------")
print("Auto Loot จะตรวจหา Loot ใหม่ตลอดเวลา")
print("========================================")
