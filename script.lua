--========================================================--
--                 MIRACLE AUTO SYSTEM
--          AUTO CLICK + AUTO LOOT + MOBILE
--========================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--========================================================--
-- SETTINGS
--========================================================--

local AutoClick = false
local AutoLoot = true

local AutoLootLoopRunning = false
local SelectingPosition = false
local SelectingInput = nil

local ClickX = 0
local ClickY = 0
local ClickInterval = 1

local LOOT_SCAN_DELAY = 0.15

--========================================================--
-- REMOVE OLD GUI
--========================================================--

pcall(function()
    local Old = CoreGui:FindFirstChild("MIRACLE_AUTO_CLICKER")
    if Old then
        Old:Destroy()
    end
end)

--========================================================--
-- COLORS
--========================================================--

local BG = Color3.fromRGB(10, 18, 30)
local CARD = Color3.fromRGB(15, 29, 44)
local HEADER = Color3.fromRGB(16, 39, 62)

local BLUE = Color3.fromRGB(25, 135, 210)
local BLUE_LIGHT = Color3.fromRGB(55, 175, 240)

local TEXT = Color3.fromRGB(235, 248, 255)
local SUBTEXT = Color3.fromRGB(135, 190, 220)

local OFF = Color3.fromRGB(30, 55, 72)

--========================================================--
-- SCREEN GUI
--========================================================--

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MIRACLE_AUTO_CLICKER"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

--========================================================--
-- SHADOW
--========================================================--

local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(0, 360, 0, 360)
Shadow.Position = UDim2.new(0.5, -176, 0.5, -174)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.65
Shadow.BorderSizePixel = 0
Shadow.ZIndex = 1
Shadow.Parent = ScreenGui

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 18)
ShadowCorner.Parent = Shadow

--========================================================--
-- MAIN
--========================================================--

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 360, 0, 360)
Main.Position = UDim2.new(0.5, -180, 0.5, -180)
Main.BackgroundColor3 = BG
Main.BorderSizePixel = 0
Main.ZIndex = 2
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = BLUE_LIGHT
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.2
MainStroke.Parent = Main

--========================================================--
-- HEADER
--========================================================--

local Header = Instance.new("Frame")
Header.Name = "DragHandle"
Header.Size = UDim2.new(1, 0, 0, 76)
Header.BackgroundColor3 = HEADER
Header.BorderSizePixel = 0
Header.ZIndex = 3
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 44, 0, 44)
Logo.Position = UDim2.new(0, 16, 0, 16)
Logo.BackgroundColor3 = BLUE
Logo.BorderSizePixel = 0
Logo.Text = "M"
Logo.TextColor3 = TEXT
Logo.TextSize = 22
Logo.Font = Enum.Font.GothamBold
Logo.ZIndex = 4
Logo.Parent = Header

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 12)
LogoCorner.Parent = Logo

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -120, 0, 28)
Title.Position = UDim2.new(0, 70, 0, 14)
Title.BackgroundTransparency = 1
Title.Text = "MIRACLE AUTO"
Title.TextColor3 = TEXT
Title.TextSize = 19
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 4
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -120, 0, 20)
Subtitle.Position = UDim2.new(0, 70, 0, 40)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "AUTO CLICK  •  AUTO LOOT"
Subtitle.TextColor3 = SUBTEXT
Subtitle.TextSize = 10
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.ZIndex = 4
Subtitle.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 34, 0, 34)
CloseButton.Position = UDim2.new(1, -48, 0, 20)
CloseButton.BackgroundColor3 = Color3.fromRGB(24, 60, 82)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = TEXT
CloseButton.TextSize = 23
CloseButton.Font = Enum.Font.GothamBold
CloseButton.AutoButtonColor = false
CloseButton.ZIndex = 5
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 9)
CloseCorner.Parent = CloseButton

--========================================================--
-- STATUS
--========================================================--

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -36, 0, 46)
Status.Position = UDim2.new(0, 18, 0, 88)
Status.BackgroundColor3 = CARD
Status.BorderSizePixel = 0
Status.Text = "🧲 กำลังตรวจสอบ Loot..."
Status.TextColor3 = TEXT
Status.TextSize = 12
Status.Font = Enum.Font.GothamMedium
Status.ZIndex = 3
Status.Parent = Main

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 11)
StatusCorner.Parent = Status

local StatusStroke = Instance.new("UIStroke")
StatusStroke.Color = BLUE
StatusStroke.Transparency = 0.55
StatusStroke.Parent = Status

--========================================================--
-- POSITION CARD
--========================================================--

local PositionCard = Instance.new("Frame")
PositionCard.Size = UDim2.new(1, -36, 0, 58)
PositionCard.Position = UDim2.new(0, 18, 0, 144)
PositionCard.BackgroundColor3 = CARD
PositionCard.BorderSizePixel = 0
PositionCard.ZIndex = 3
PositionCard.Parent = Main

local PositionCorner = Instance.new("UICorner")
PositionCorner.CornerRadius = UDim.new(0, 11)
PositionCorner.Parent = PositionCard

local PositionTitle = Instance.new("TextLabel")
PositionTitle.Size = UDim2.new(0, 100, 1, 0)
PositionTitle.Position = UDim2.new(0, 12, 0, 0)
PositionTitle.BackgroundTransparency = 1
PositionTitle.Text = "CLICK POINT"
PositionTitle.TextColor3 = SUBTEXT
PositionTitle.TextSize = 10
PositionTitle.Font = Enum.Font.GothamBold
PositionTitle.TextXAlignment = Enum.TextXAlignment.Left
PositionTitle.ZIndex = 4
PositionTitle.Parent = PositionCard

local PositionText = Instance.new("TextLabel")
PositionText.Size = UDim2.new(0, 130, 1, 0)
PositionText.Position = UDim2.new(0, 105, 0, 0)
PositionText.BackgroundTransparency = 1
PositionText.Text = "X: 0    Y: 0"
PositionText.TextColor3 = TEXT
PositionText.TextSize = 11
PositionText.Font = Enum.Font.GothamMedium
PositionText.ZIndex = 4
PositionText.Parent = PositionCard

local SelectButton = Instance.new("TextButton")
SelectButton.Size = UDim2.new(0, 82, 0, 36)
SelectButton.Position = UDim2.new(1, -94, 0, 11)
SelectButton.BackgroundColor3 = BLUE
SelectButton.BorderSizePixel = 0
SelectButton.Text = "SELECT"
SelectButton.TextColor3 = TEXT
SelectButton.TextSize = 10
SelectButton.Font = Enum.Font.GothamBold
SelectButton.AutoButtonColor = false
SelectButton.ZIndex = 5
SelectButton.Parent = PositionCard

local SelectCorner = Instance.new("UICorner")
SelectCorner.CornerRadius = UDim.new(0, 9)
SelectCorner.Parent = SelectButton

--========================================================--
-- INTERVAL
--========================================================--

local IntervalLabel = Instance.new("TextLabel")
IntervalLabel.Size = UDim2.new(0, 140, 0, 38)
IntervalLabel.Position = UDim2.new(0, 18, 0, 216)
IntervalLabel.BackgroundTransparency = 1
IntervalLabel.Text = "CLICK INTERVAL"
IntervalLabel.TextColor3 = SUBTEXT
IntervalLabel.TextSize = 10
IntervalLabel.Font = Enum.Font.GothamBold
IntervalLabel.TextXAlignment = Enum.TextXAlignment.Left
IntervalLabel.ZIndex = 3
IntervalLabel.Parent = Main

local IntervalBox = Instance.new("TextBox")
IntervalBox.Size = UDim2.new(0, 100, 0, 36)
IntervalBox.Position = UDim2.new(1, -118, 0, 217)
IntervalBox.BackgroundColor3 = CARD
IntervalBox.BorderSizePixel = 0
IntervalBox.Text = "1"
IntervalBox.PlaceholderText = "0.1"
IntervalBox.TextColor3 = TEXT
IntervalBox.PlaceholderColor3 = SUBTEXT
IntervalBox.TextSize = 12
IntervalBox.Font = Enum.Font.GothamMedium
IntervalBox.ClearTextOnFocus = false
IntervalBox.ZIndex = 4
IntervalBox.Parent = Main

local IntervalCorner = Instance.new("UICorner")
IntervalCorner.CornerRadius = UDim.new(0, 9)
IntervalCorner.Parent = IntervalBox

local IntervalStroke = Instance.new("UIStroke")
IntervalStroke.Color = BLUE
IntervalStroke.Transparency = 0.55
IntervalStroke.Parent = IntervalBox

--========================================================--
-- AUTO CLICK BUTTON
--========================================================--

local AutoClickButton = Instance.new("TextButton")
AutoClickButton.Size = UDim2.new(1, -36, 0, 42)
AutoClickButton.Position = UDim2.new(0, 18, 0, 264)
AutoClickButton.BackgroundColor3 = OFF
AutoClickButton.BorderSizePixel = 0
AutoClickButton.Text = "🔴  AUTO CLICK : OFF"
AutoClickButton.TextColor3 = TEXT
AutoClickButton.TextSize = 12
AutoClickButton.Font = Enum.Font.GothamBold
AutoClickButton.AutoButtonColor = false
AutoClickButton.ZIndex = 4
AutoClickButton.Parent = Main

local AutoClickCorner = Instance.new("UICorner")
AutoClickCorner.CornerRadius = UDim.new(0, 10)
AutoClickCorner.Parent = AutoClickButton

--========================================================--
-- AUTO LOOT BUTTON
--========================================================--

local AutoLootButton = Instance.new("TextButton")
AutoLootButton.Size = UDim2.new(1, -36, 0, 42)
AutoLootButton.Position = UDim2.new(0, 18, 0, 312)
AutoLootButton.BackgroundColor3 = BLUE
AutoLootButton.BorderSizePixel = 0
AutoLootButton.Text = "🟢  AUTO LOOT : ON"
AutoLootButton.TextColor3 = TEXT
AutoLootButton.TextSize = 12
AutoLootButton.Font = Enum.Font.GothamBold
AutoLootButton.AutoButtonColor = false
AutoLootButton.ZIndex = 4
AutoLootButton.Parent = Main

local AutoLootCorner = Instance.new("UICorner")
AutoLootCorner.CornerRadius = UDim.new(0, 10)
AutoLootCorner.Parent = AutoLootButton

--========================================================--
-- OPEN BUTTON
--========================================================--

local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.new(0, 58, 0, 58)
OpenButton.Position = UDim2.new(0.5, -29, 0.5, -29)
OpenButton.BackgroundColor3 = BLUE
OpenButton.BorderSizePixel = 0
OpenButton.Text = "M"
OpenButton.TextSize = 23
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextColor3 = TEXT
OpenButton.Visible = false
OpenButton.ZIndex = 10
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = BLUE_LIGHT
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenButton

--========================================================--
-- POSITION MARKER
--========================================================--

local PositionMarker = Instance.new("Frame")
PositionMarker.Name = "ClickMarker"
PositionMarker.Size = UDim2.new(0, 24, 0, 24)
PositionMarker.AnchorPoint = Vector2.new(0.5, 0.5)
PositionMarker.BackgroundTransparency = 1
PositionMarker.Visible = false
PositionMarker.ZIndex = 999
PositionMarker.Parent = ScreenGui

local MarkerStroke = Instance.new("UIStroke")
MarkerStroke.Color = BLUE_LIGHT
MarkerStroke.Thickness = 3
MarkerStroke.Parent = PositionMarker

local MarkerCorner = Instance.new("UICorner")
MarkerCorner.CornerRadius = UDim.new(1, 0)
MarkerCorner.Parent = PositionMarker

local MarkerCenter = Instance.new("Frame")
MarkerCenter.Size = UDim2.new(0, 6, 0, 6)
MarkerCenter.AnchorPoint = Vector2.new(0.5, 0.5)
MarkerCenter.Position = UDim2.fromScale(0.5, 0.5)
MarkerCenter.BackgroundColor3 = BLUE_LIGHT
MarkerCenter.BorderSizePixel = 0
MarkerCenter.ZIndex = 1000
MarkerCenter.Parent = PositionMarker

local MarkerCenterCorner = Instance.new("UICorner")
MarkerCenterCorner.CornerRadius = UDim.new(1, 0)
MarkerCenterCorner.Parent = MarkerCenter

--========================================================--
-- AUTO LOOT
--========================================================--

local function GetLootObjects()

    local Loots = {}
    local Seen = {}

    for _, Object in ipairs(workspace:GetDescendants()) do

        if Object:IsA("Model")
            and Object.Name == "Loot"
            and not Seen[Object]
            and Object:FindFirstChild("CollectLoot")
        then

            Seen[Object] = true
            table.insert(Loots, Object)

        end
    end

    return Loots
end

local function CollectLoot(Loot)

    if not Loot or not Loot.Parent then
        return false
    end

    local Remote = Loot:FindFirstChild("CollectLoot")

    if Remote and Remote:IsA("RemoteEvent") then

        local Success = pcall(function()
            Remote:FireServer(Loot)
        end)

        return Success
    end

    return false
end

local function StartAutoLootLoop()

    if AutoLootLoopRunning then
        return
    end

    AutoLootLoopRunning = true

    task.spawn(function()

        while AutoLoot and ScreenGui.Parent do

            local Loots = GetLootObjects()

            if #Loots == 0 then

                Status.Text = "⏳ รอ Loot เกิด..."

            else

                local Collected = 0

                for Index, Loot in ipairs(Loots) do

                    if not AutoLoot then
                        break
                    end

                    if Loot and Loot.Parent then

                        Status.Text =
                            "🧲 ดูด Loot " ..
                            Index ..
                            "/" ..
                            #Loots

                        if CollectLoot(Loot) then
                            Collected += 1
                        end
                    end

                    task.wait(LOOT_SCAN_DELAY)
                end

                if AutoLoot then

                    Status.Text =
                        "🧲 ดูด Loot แล้ว " ..
                        Collected ..
                        "/" ..
                        #Loots

                end
            end

            task.wait(0.05)
        end

        AutoLootLoopRunning = false

    end)
end

--========================================================--
-- AUTO LOOT TOGGLE
--========================================================--

AutoLootButton.Activated:Connect(function()

    AutoLoot = not AutoLoot

    if AutoLoot then

        AutoLootButton.Text = "🟢  AUTO LOOT : ON"
        AutoLootButton.BackgroundColor3 = BLUE

        StartAutoLootLoop()

    else

        AutoLootButton.Text = "🔴  AUTO LOOT : OFF"
        AutoLootButton.BackgroundColor3 = OFF

        Status.Text = "⛔ ปิด AUTO LOOT"

    end
end)

--========================================================--
-- INTERVAL
--========================================================--

IntervalBox.FocusLost:Connect(function()

    local Number = tonumber(IntervalBox.Text)

    if not Number then
        Number = 1
    end

    Number = math.max(0.1, Number)

    ClickInterval = Number
    IntervalBox.Text = tostring(Number)

end)

--========================================================--
-- SELECT POSITION
--========================================================--

local function FinishSelecting()

    SelectingPosition = false
    SelectingInput = nil

    SelectButton.Text = "SELECT"
    SelectButton.BackgroundColor3 = BLUE

    Main.Visible = true
    Shadow.Visible = true

end

local function SaveClickPosition(Position)

    if not SelectingPosition then
        return
    end

    --------------------------------------------------------
    -- รับตำแหน่งจาก Touch / Mouse โดยตรง
    --------------------------------------------------------

    local X = Position.X
    local Y = Position.Y

    --------------------------------------------------------
    -- ใช้ขนาดหน้าจอจริง
    --------------------------------------------------------

    local Camera = workspace.CurrentCamera

    if Camera then

        local ViewportSize = Camera.ViewportSize

        -- ป้องกันค่าหลุดขอบ
        X = math.clamp(X, 0, ViewportSize.X)
        Y = math.clamp(Y, 0, ViewportSize.Y)

    end

    ClickX = math.floor(X + 0.5)
    ClickY = math.floor(Y + 0.5)

    --------------------------------------------------------
    -- แสดง Marker ตรงตำแหน่งที่เลือก
    --------------------------------------------------------

    PositionMarker.Position =
        UDim2.fromOffset(ClickX, ClickY)

    PositionMarker.Visible = true

    --------------------------------------------------------
    -- แสดงค่า
    --------------------------------------------------------

    PositionText.Text =
        "X: " ..
        ClickX ..
        "    Y: " ..
        ClickY

    Status.Text =
        "📍 เลือกแล้ว  X:" ..
        ClickX ..
        " Y:" ..
        ClickY

    FinishSelecting()

end

SelectButton.Activated:Connect(function()

    if SelectingPosition then
        return
    end

    SelectingPosition = true
    SelectingInput = nil

    SelectButton.Text = "TAP / CLICK"
    SelectButton.BackgroundColor3 =
        Color3.fromRGB(35, 165, 225)

    Status.Text =
        "🎯 แตะตำแหน่งที่ต้องการบนหน้าจอ"

    --------------------------------------------------------
    -- ซ่อน UI
    --------------------------------------------------------

    Main.Visible = false
    Shadow.Visible = false
    OpenButton.Visible = false

end)

--========================================================--
-- TOUCH / MOUSE SELECT
--========================================================--

UserInputService.InputBegan:Connect(function(Input, GameProcessed)

    if not SelectingPosition then
        return
    end

    local InputType = Input.UserInputType

    if InputType ~= Enum.UserInputType.MouseButton1
        and InputType ~= Enum.UserInputType.Touch then
        return
    end

    if SelectingInput then
        return
    end

    SelectingInput = Input

    SaveClickPosition(Input.Position)

end)

--========================================================--
-- AUTO CLICK
--========================================================--

local function DoClick()

    if ClickX <= 0 or ClickY <= 0 then
        return
    end

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
end

--========================================================--
-- AUTO CLICK TOGGLE
--========================================================--

AutoClickButton.Activated:Connect(function()

    if ClickX <= 0 or ClickY <= 0 then

        Status.Text =
            "⚠ กรุณากด SELECT ก่อน"

        return
    end

    AutoClick = not AutoClick

    if AutoClick then

        AutoClickButton.Text =
            "🟢  AUTO CLICK : ON"

        AutoClickButton.BackgroundColor3 =
            BLUE

        Status.Text =
            "🖱️ Auto Click ON • " ..
            tostring(ClickInterval) ..
            "s"

    else

        AutoClickButton.Text =
            "🔴  AUTO CLICK : OFF"

        AutoClickButton.BackgroundColor3 =
            OFF

        Status.Text =
            "⛔ ปิด AUTO CLICK"

    end

end)

--========================================================--
-- AUTO CLICK LOOP
--========================================================--

task.spawn(function()

    while ScreenGui.Parent do

        if AutoClick then

            DoClick()

            local StartTime = os.clock()

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

--========================================================--
-- DRAG SYSTEM PC + MOBILE
--========================================================--

local function MakeDraggable(Object, DragHandle)

    local Dragging = false
    local DragStart = nil
    local StartPosition = nil
    local ActiveInput = nil

    DragHandle.InputBegan:Connect(function(Input)

        local Type = Input.UserInputType

        if Type == Enum.UserInputType.MouseButton1
            or Type == Enum.UserInputType.Touch then

            if Dragging then
                return
            end

            Dragging = true
            ActiveInput = Input

            DragStart = Input.Position
            StartPosition = Object.Position

        end

    end)

    DragHandle.InputEnded:Connect(function(Input)

        if Input == ActiveInput then

            Dragging = false
            ActiveInput = nil

        end

    end)

    UserInputService.InputChanged:Connect(function(Input)

        if not Dragging then
            return
        end

        local Type = Input.UserInputType

        if Type ~= Enum.UserInputType.MouseMovement
            and Type ~= Enum.UserInputType.Touch then
            return
        end

        local Delta =
            Input.Position - DragStart

        Object.Position = UDim2.new(

            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,

            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y

        )

        if Object == Main then

            Shadow.Position = UDim2.new(

                Object.Position.X.Scale,
                Object.Position.X.Offset + 4,

                Object.Position.Y.Scale,
                Object.Position.Y.Offset + 6

            )

        end

    end)

end

MakeDraggable(Main, Header)
MakeDraggable(OpenButton, OpenButton)

--========================================================--
-- CLOSE
--========================================================--

CloseButton.Activated:Connect(function()

    Main.Visible = false
    Shadow.Visible = false
    OpenButton.Visible = true

end)

--========================================================--
-- OPEN
--========================================================--

OpenButton.Activated:Connect(function()

    Main.Visible = true
    Shadow.Visible = true
    OpenButton.Visible = false

end)

--========================================================--
-- INITIALIZE
--========================================================--

AutoLoot = true
AutoClick = false

AutoLootButton.Text =
    "🟢  AUTO LOOT : ON"

AutoLootButton.BackgroundColor3 =
    BLUE

AutoClickButton.Text =
    "🔴  AUTO CLICK : OFF"

AutoClickButton.BackgroundColor3 =
    OFF

local InitialLoots = GetLootObjects()

Status.Text =
    "🧲 Loot ทั้งแมพ: " ..
    #InitialLoots

print("================================")
print("       MIRACLE AUTO SYSTEM")
print("================================")
print("Loot:", #InitialLoots)
print("Auto Loot: ON")
print("Auto Click: OFF")
print("Mobile Touch: ENABLED")
print("Position Marker: ENABLED")
print("================================")

StartAutoLootLoop()
