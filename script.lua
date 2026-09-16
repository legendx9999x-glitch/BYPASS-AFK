--==================================================
-- MIRACLE SYSTEM
-- AUTO LOOT + AFK PROTECTION
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local AutoLoot = true
local AutoLootLoopRunning = false

-- AFK เปิดตลอด ไม่มีปุ่มเปิด/ปิด
local AFK_PROTECTION = true
local AFK_INTERVAL = 60

local LOOT_SCAN_DELAY = 0.15

--==================================================
-- COLORS
--==================================================

local BLACK = Color3.fromRGB(3, 7, 14)
local PANEL = Color3.fromRGB(6, 12, 22)
local PANEL2 = Color3.fromRGB(10, 19, 32)

local BLUE = Color3.fromRGB(0, 155, 255)
local BLUE2 = Color3.fromRGB(0, 210, 255)
local BLUE_DARK = Color3.fromRGB(0, 70, 120)

local WHITE = Color3.fromRGB(245, 250, 255)
local GRAY = Color3.fromRGB(115, 140, 165)

local GREEN = Color3.fromRGB(45, 235, 140)

--==================================================
-- REMOVE OLD UI
--==================================================

local OldGui = CoreGui:FindFirstChild("MIRACLE_SYSTEM")

if OldGui then
    OldGui:Destroy()
end

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "MIRACLE_SYSTEM"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ScreenGui.Parent = CoreGui

--==================================================
-- SHADOW
--==================================================

local Shadow = Instance.new("Frame")

Shadow.Name = "Shadow"

Shadow.Size = UDim2.new(0, 364, 0, 304)

Shadow.Position = UDim2.new(
    0.5,
    -182,
    0.5,
    -152
)

Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.55
Shadow.BorderSizePixel = 0
Shadow.ZIndex = 0

Shadow.Parent = ScreenGui

local ShadowCorner = Instance.new("UICorner")

ShadowCorner.CornerRadius = UDim.new(0, 22)
ShadowCorner.Parent = Shadow

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")

Main.Name = "Main"

Main.Size = UDim2.new(0, 360, 0, 300)

Main.Position = UDim2.new(
    0.5,
    -180,
    0.5,
    -150
)

Main.BackgroundColor3 = BLACK
Main.BorderSizePixel = 0
Main.ZIndex = 1

Main.Parent = ScreenGui

--==================================================
-- MAIN CORNER
--==================================================

local MainCorner = Instance.new("UICorner")

MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = Main

--==================================================
-- MAIN STROKE
--==================================================

local MainStroke = Instance.new("UIStroke")

MainStroke.Color = BLUE
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.1

MainStroke.Parent = Main

--==================================================
-- INNER
--==================================================

local Inner = Instance.new("Frame")

Inner.Name = "Inner"

Inner.Size = UDim2.new(
    1,
    -4,
    1,
    -4
)

Inner.Position = UDim2.new(
    0,
    2,
    0,
    2
)

Inner.BackgroundColor3 = PANEL
Inner.BorderSizePixel = 0
Inner.ZIndex = 2

Inner.Parent = Main

local InnerCorner = Instance.new("UICorner")

InnerCorner.CornerRadius = UDim.new(0, 18)
InnerCorner.Parent = Inner

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")

Header.Name = "Header"

Header.Size = UDim2.new(
    1,
    -2,
    0,
    62
)

Header.Position = UDim2.new(
    0,
    1,
    0,
    1
)

Header.BackgroundColor3 = PANEL2
Header.BorderSizePixel = 0
Header.ZIndex = 3

Header.Parent = Inner

local HeaderCorner = Instance.new("UICorner")

HeaderCorner.CornerRadius = UDim.new(0, 17)
HeaderCorner.Parent = Header

--==================================================
-- HEADER BOTTOM
--==================================================

local HeaderBottom = Instance.new("Frame")

HeaderBottom.Size = UDim2.new(
    1,
    0,
    0,
    18
)

HeaderBottom.Position = UDim2.new(
    0,
    0,
    1,
    -18
)

HeaderBottom.BackgroundColor3 = PANEL2
HeaderBottom.BorderSizePixel = 0
HeaderBottom.ZIndex = 3

HeaderBottom.Parent = Header

--==================================================
-- LOGO
--==================================================

local Logo = Instance.new("Frame")

Logo.Size = UDim2.new(
    0,
    40,
    0,
    40
)

Logo.Position = UDim2.new(
    0,
    16,
    0,
    11
)

Logo.BackgroundColor3 = BLUE_DARK
Logo.BorderSizePixel = 0
Logo.ZIndex = 6

Logo.Parent = Header

local LogoCorner = Instance.new("UICorner")

LogoCorner.CornerRadius = UDim.new(0, 11)
LogoCorner.Parent = Logo

local LogoStroke = Instance.new("UIStroke")

LogoStroke.Color = BLUE2
LogoStroke.Thickness = 1
LogoStroke.Transparency = 0.15

LogoStroke.Parent = Logo

local LogoText = Instance.new("TextLabel")

LogoText.Size = UDim2.new(1, 0, 1, 0)

LogoText.BackgroundTransparency = 1

LogoText.Text = "M"

LogoText.TextColor3 = BLUE2
LogoText.TextSize = 21
LogoText.Font = Enum.Font.GothamBlack

LogoText.ZIndex = 7

LogoText.Parent = Logo

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")

Title.Size = UDim2.new(
    1,
    -125,
    0,
    24
)

Title.Position = UDim2.new(
    0,
    68,
    0,
    10
)

Title.BackgroundTransparency = 1

Title.Text = "MIRACLE SYSTEM"

Title.TextColor3 = WHITE
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold

Title.TextXAlignment = Enum.TextXAlignment.Left

Title.ZIndex = 6

Title.Parent = Header

--==================================================
-- SUBTITLE
--==================================================

local Subtitle = Instance.new("TextLabel")

Subtitle.Size = UDim2.new(
    1,
    -125,
    0,
    17
)

Subtitle.Position = UDim2.new(
    0,
    68,
    0,
    34
)

Subtitle.BackgroundTransparency = 1

Subtitle.Text = "AUTO LOOT  •  AFK PROTECTION"

Subtitle.TextColor3 = BLUE2
Subtitle.TextSize = 9
Subtitle.Font = Enum.Font.GothamBold

Subtitle.TextXAlignment = Enum.TextXAlignment.Left

Subtitle.ZIndex = 6

Subtitle.Parent = Header

--==================================================
-- MINIMIZE BUTTON
--==================================================

local Minimize = Instance.new("TextButton")

Minimize.Size = UDim2.new(
    0,
    36,
    0,
    36
)

Minimize.Position = UDim2.new(
    1,
    -49,
    0,
    12
)

Minimize.BackgroundColor3 =
    Color3.fromRGB(14, 26, 43)

Minimize.BorderSizePixel = 0

Minimize.Text = "−"

Minimize.TextColor3 = GRAY
Minimize.TextSize = 20
Minimize.Font = Enum.Font.GothamBold

Minimize.AutoButtonColor = false

Minimize.ZIndex = 8

Minimize.Parent = Header

local MinCorner = Instance.new("UICorner")

MinCorner.CornerRadius = UDim.new(0, 10)
MinCorner.Parent = Minimize

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")

Content.Name = "Content"

Content.Size = UDim2.new(
    1,
    -30,
    1,
    -76
)

Content.Position = UDim2.new(
    0,
    15,
    0,
    70
)

Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ZIndex = 4

Content.Parent = Inner

--==================================================
-- AUTO LOOT STATUS CARD
--==================================================

local LootStatus = Instance.new("Frame")

LootStatus.Size = UDim2.new(
    1,
    0,
    0,
    55
)

LootStatus.Position = UDim2.new(
    0,
    0,
    0,
    0
)

LootStatus.BackgroundColor3 =
    Color3.fromRGB(7, 17, 29)

LootStatus.BorderSizePixel = 0
LootStatus.ZIndex = 5

LootStatus.Parent = Content

local LootStatusCorner = Instance.new("UICorner")

LootStatusCorner.CornerRadius = UDim.new(0, 13)
LootStatusCorner.Parent = LootStatus

local LootStatusStroke = Instance.new("UIStroke")

LootStatusStroke.Color = BLUE
LootStatusStroke.Thickness = 1
LootStatusStroke.Transparency = 0.65

LootStatusStroke.Parent = LootStatus

--==================================================
-- LOOT ICON
--==================================================

local LootIcon = Instance.new("Frame")

LootIcon.Size = UDim2.new(
    0,
    32,
    0,
    32
)

LootIcon.Position = UDim2.new(
    0,
    11,
    0.5,
    -16
)

LootIcon.BackgroundColor3 =
    Color3.fromRGB(8, 50, 75)

LootIcon.BorderSizePixel = 0
LootIcon.ZIndex = 6

LootIcon.Parent = LootStatus

local LootIconCorner = Instance.new("UICorner")

LootIconCorner.CornerRadius = UDim.new(0, 10)
LootIconCorner.Parent = LootIcon

local LootIconText = Instance.new("TextLabel")

LootIconText.Size = UDim2.new(1, 0, 1, 0)

LootIconText.BackgroundTransparency = 1

LootIconText.Text = "M"

LootIconText.TextColor3 = BLUE2
LootIconText.TextSize = 14
LootIconText.Font = Enum.Font.GothamBlack

LootIconText.ZIndex = 7

LootIconText.Parent = LootIcon

--==================================================
-- LOOT STATUS TEXT
--==================================================

local Status = Instance.new("TextLabel")

Status.Size = UDim2.new(
    1,
    -65,
    0,
    22
)

Status.Position = UDim2.new(
    0,
    55,
    0,
    8
)

Status.BackgroundTransparency = 1

Status.Text = "กำลังตรวจสอบ Loot..."

Status.TextColor3 = WHITE
Status.TextSize = 12
Status.Font = Enum.Font.GothamBold

Status.TextXAlignment = Enum.TextXAlignment.Left

Status.ZIndex = 6

Status.Parent = LootStatus

local LootSubStatus = Instance.new("TextLabel")

LootSubStatus.Size = UDim2.new(
    1,
    -65,
    0,
    17
)

LootSubStatus.Position = UDim2.new(
    0,
    55,
    0,
    31
)

LootSubStatus.BackgroundTransparency = 1

LootSubStatus.Text = "AUTO LOOT ACTIVE"

LootSubStatus.TextColor3 = GRAY
LootSubStatus.TextSize = 9
LootSubStatus.Font = Enum.Font.GothamMedium

LootSubStatus.TextXAlignment = Enum.TextXAlignment.Left

LootSubStatus.ZIndex = 6

LootSubStatus.Parent = LootStatus

--==================================================
-- AUTO LOOT BUTTON
--==================================================

local AutoLootButton = Instance.new("TextButton")

AutoLootButton.Name = "AutoLoot"

AutoLootButton.Size = UDim2.new(
    1,
    0,
    0,
    46
)

AutoLootButton.Position = UDim2.new(
    0,
    0,
    0,
    67
)

AutoLootButton.BackgroundColor3 = BLUE

AutoLootButton.BorderSizePixel = 0

AutoLootButton.Text = ""

AutoLootButton.AutoButtonColor = false

AutoLootButton.ZIndex = 5

AutoLootButton.Parent = Content

local AutoLootCorner = Instance.new("UICorner")

AutoLootCorner.CornerRadius = UDim.new(0, 13)
AutoLootCorner.Parent = AutoLootButton

local AutoLootStroke = Instance.new("UIStroke")

AutoLootStroke.Color = BLUE2
AutoLootStroke.Thickness = 1
AutoLootStroke.Transparency = 0.25

AutoLootStroke.Parent = AutoLootButton

local AutoLootText = Instance.new("TextLabel")

AutoLootText.Size = UDim2.new(
    1,
    -75,
    1,
    0
)

AutoLootText.Position = UDim2.new(
    0,
    16,
    0,
    0
)

AutoLootText.BackgroundTransparency = 1

AutoLootText.Text = "AUTO LOOT"

AutoLootText.TextColor3 = WHITE
AutoLootText.TextSize = 12
AutoLootText.Font = Enum.Font.GothamBold

AutoLootText.TextXAlignment = Enum.TextXAlignment.Left

AutoLootText.ZIndex = 6

AutoLootText.Parent = AutoLootButton

local AutoLootState = Instance.new("TextLabel")

AutoLootState.Size = UDim2.new(
    0,
    50,
    1,
    0
)

AutoLootState.Position = UDim2.new(
    1,
    -62,
    0,
    0
)

AutoLootState.BackgroundTransparency = 1

AutoLootState.Text = "ON"

AutoLootState.TextColor3 = WHITE
AutoLootState.TextSize = 11
AutoLootState.Font = Enum.Font.GothamBlack

AutoLootState.TextXAlignment = Enum.TextXAlignment.Right

AutoLootState.ZIndex = 6

AutoLootState.Parent = AutoLootButton

--==================================================
-- AFK STATUS
--==================================================

local AFKStatus = Instance.new("Frame")

AFKStatus.Size = UDim2.new(
    1,
    0,
    0,
    55
)

AFKStatus.Position = UDim2.new(
    0,
    0,
    0,
    124
)

AFKStatus.BackgroundColor3 =
    Color3.fromRGB(7, 22, 25)

AFKStatus.BorderSizePixel = 0
AFKStatus.ZIndex = 5

AFKStatus.Parent = Content

local AFKCorner = Instance.new("UICorner")

AFKCorner.CornerRadius = UDim.new(0, 13)
AFKCorner.Parent = AFKStatus

local AFKStroke = Instance.new("UIStroke")

AFKStroke.Color = GREEN
AFKStroke.Thickness = 1
AFKStroke.Transparency = 0.7

AFKStroke.Parent = AFKStatus

--==================================================
-- AFK ICON
--==================================================

local AFKIcon = Instance.new("Frame")

AFKIcon.Size = UDim2.new(
    0,
    30,
    0,
    30
)

AFKIcon.Position = UDim2.new(
    0,
    11,
    0.5,
    -15
)

AFKIcon.BackgroundColor3 =
    Color3.fromRGB(12, 65, 52)

AFKIcon.BorderSizePixel = 0

AFKIcon.ZIndex = 6

AFKIcon.Parent = AFKStatus

local AFKIconCorner = Instance.new("UICorner")

AFKIconCorner.CornerRadius = UDim.new(1, 0)
AFKIconCorner.Parent = AFKIcon

local AFKDot = Instance.new("Frame")

AFKDot.Size = UDim2.new(
    0,
    9,
    0,
    9
)

AFKDot.Position = UDim2.new(
    0.5,
    -4.5,
    0.5,
    -4.5
)

AFKDot.BackgroundColor3 = GREEN

AFKDot.BorderSizePixel = 0

AFKDot.ZIndex = 7

AFKDot.Parent = AFKIcon

local AFKDotCorner = Instance.new("UICorner")

AFKDotCorner.CornerRadius = UDim.new(1, 0)
AFKDotCorner.Parent = AFKDot

--==================================================
-- AFK TEXT
--==================================================

local AFKTitle = Instance.new("TextLabel")

AFKTitle.Size = UDim2.new(
    1,
    -65,
    0,
    20
)

AFKTitle.Position = UDim2.new(
    0,
    52,
    0,
    8
)

AFKTitle.BackgroundTransparency = 1

AFKTitle.Text = "AFK PROTECTION ACTIVE"

AFKTitle.TextColor3 = GREEN
AFKTitle.TextSize = 12
AFKTitle.Font = Enum.Font.GothamBold

AFKTitle.TextXAlignment = Enum.TextXAlignment.Left

AFKTitle.ZIndex = 6

AFKTitle.Parent = AFKStatus

local AFKActivity = Instance.new("TextLabel")

AFKActivity.Size = UDim2.new(
    1,
    -65,
    0,
    16
)

AFKActivity.Position = UDim2.new(
    0,
    52,
    0,
    29
)

AFKActivity.BackgroundTransparency = 1

AFKActivity.Text = "Activity protection • ON"

AFKActivity.TextColor3 = GRAY
AFKActivity.TextSize = 9
AFKActivity.Font = Enum.Font.GothamMedium

AFKActivity.TextXAlignment = Enum.TextXAlignment.Left

AFKActivity.ZIndex = 6

AFKActivity.Parent = AFKStatus

--==================================================
-- FOOTER
--==================================================

local Footer = Instance.new("TextLabel")

Footer.Size = UDim2.new(
    1,
    0,
    0,
    16
)

Footer.Position = UDim2.new(
    0,
    0,
    1,
    -17
)

Footer.BackgroundTransparency = 1

Footer.Text = "MIRACLE SYSTEM  •  LOOT + AFK"

Footer.TextColor3 =
    Color3.fromRGB(65, 90, 120)

Footer.TextSize = 9
Footer.Font = Enum.Font.GothamBold

Footer.TextXAlignment = Enum.TextXAlignment.Center

Footer.ZIndex = 5

Footer.Parent = Content

--==================================================
-- OPEN BUTTON
--==================================================

local OpenButton = Instance.new("TextButton")

OpenButton.Name = "OpenButton"

OpenButton.Size = UDim2.new(
    0,
    62,
    0,
    62
)

OpenButton.Position = UDim2.new(
    0.5,
    -31,
    0.5,
    -31
)

OpenButton.BackgroundColor3 = BLACK

OpenButton.BorderSizePixel = 0

OpenButton.Text = "M"

OpenButton.TextColor3 = BLUE2

OpenButton.TextSize = 18
OpenButton.Font = Enum.Font.GothamBlack

OpenButton.Visible = false

OpenButton.AutoButtonColor = false

OpenButton.ZIndex = 10

OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")

OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton

local OpenStroke = Instance.new("UIStroke")

OpenStroke.Color = BLUE
OpenStroke.Thickness = 2

OpenStroke.Parent = OpenButton

--==================================================
-- GET LOOT
--==================================================

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

            table.insert(
                Loots,
                Object
            )

        end

    end

    return Loots

end

--==================================================
-- COLLECT LOOT
--==================================================

local function CollectLoot(Loot)

    if not Loot or not Loot.Parent then
        return false
    end

    local Remote =
        Loot:FindFirstChild("CollectLoot")

    if Remote and Remote:IsA("RemoteEvent") then

        local Success = pcall(function()

            Remote:FireServer(Loot)

        end)

        return Success

    end

    return false

end

--==================================================
-- AUTO LOOT LOOP
--==================================================

local function StartAutoLootLoop()

    if AutoLootLoopRunning then
        return
    end

    AutoLootLoopRunning = true

    task.spawn(function()

        while AutoLoot and ScreenGui.Parent do

            local Loots =
                GetLootObjects()

            if #Loots == 0 then

                Status.Text =
                    "⏳ รอ Loot เกิด..."

                LootSubStatus.Text =
                    "AUTO LOOT ACTIVE"

            else

                local Collected = 0

                for Index, Loot in ipairs(Loots) do

                    if not AutoLoot then
                        break
                    end

                    if Loot and Loot.Parent then

                        Status.Text =
                            "🧲 ดูด Loot  "
                            .. Index
                            .. "/"
                            .. #Loots

                        LootSubStatus.Text =
                            "Scanning whole map..."

                        if CollectLoot(Loot) then
                            Collected += 1
                        end

                    end

                    task.wait(
                        LOOT_SCAN_DELAY
                    )

                end

                Status.Text =
                    "🧲 ดูด Loot แล้ว  "
                    .. Collected
                    .. "/"
                    .. #Loots

                LootSubStatus.Text =
                    "AUTO LOOT ACTIVE"

            end

            task.wait(0.05)

        end

        AutoLootLoopRunning = false

    end)

end

--==================================================
-- AUTO LOOT BUTTON
--==================================================

AutoLootButton.MouseButton1Click:Connect(function()

    AutoLoot = not AutoLoot

    if AutoLoot then

        AutoLootText.Text =
            "AUTO LOOT"

        AutoLootState.Text =
            "ON"

        AutoLootButton.BackgroundColor3 =
            BLUE

        LootSubStatus.Text =
            "AUTO LOOT ACTIVE"

        StartAutoLootLoop()

    else

        AutoLootText.Text =
            "AUTO LOOT"

        AutoLootState.Text =
            "OFF"

        AutoLootButton.BackgroundColor3 =
            Color3.fromRGB(45, 55, 70)

        Status.Text =
            "⛔ AUTO LOOT ปิดอยู่"

        LootSubStatus.Text =
            "AUTO LOOT DISABLED"

    end

end)

--==================================================
-- AFK PROTECTION
--==================================================

local function SendAFKActivity()

    if not AFK_PROTECTION then
        return
    end

    pcall(function()

        VirtualUser:CaptureController()

        VirtualUser:ClickButton2(
            Vector2.new(
                math.random(300, 700),
                math.random(200, 500)
            )
        )

    end)

    AFKActivity.Text =
        "Activity sent • Just Now"

    print(
        "[MIRACLE AFK] Activity sent"
    )

end

--==================================================
-- ROBLOX IDLE
--==================================================

LocalPlayer.Idled:Connect(function()

    SendAFKActivity()

end)

--==================================================
-- AFK LOOP
--==================================================

task.spawn(function()

    while ScreenGui.Parent do

        task.wait(
            AFK_INTERVAL
        )

        SendAFKActivity()

    end

end)

--==================================================
-- DRAG SYSTEM
--==================================================

local function MakeDraggable(Object, DragHandle)

    local Dragging = false
    local DragStart
    local StartPosition

    DragHandle.InputBegan:Connect(function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1

            or Input.UserInputType ==
            Enum.UserInputType.Touch
        then

            Dragging = true

            DragStart =
                Input.Position

            StartPosition =
                Object.Position

            Input.Changed:Connect(function()

                if Input.UserInputState ==
                    Enum.UserInputState.End
                then

                    Dragging = false

                end

            end)

        end

    end)

    UserInputService.InputChanged:Connect(function(Input)

        if not Dragging then
            return
        end

        if Input.UserInputType ~=
            Enum.UserInputType.MouseMovement

            and Input.UserInputType ~=
            Enum.UserInputType.Touch
        then
            return
        end

        local Delta =
            Input.Position - DragStart

        local NewPosition = UDim2.new(

            StartPosition.X.Scale,

            StartPosition.X.Offset
                + Delta.X,

            StartPosition.Y.Scale,

            StartPosition.Y.Offset
                + Delta.Y

        )

        -- ขยับตัว UI หลัก
        Object.Position = NewPosition

        -- ขยับ Shadow ตาม Main
        if Object == Main then

            Shadow.Position = UDim2.new(

                NewPosition.X.Scale,

                NewPosition.X.Offset - 2,

                NewPosition.Y.Scale,

                NewPosition.Y.Offset - 2

            )

        end

    end)

end

MakeDraggable(
    Main,
    Header
)

MakeDraggable(
    OpenButton,
    OpenButton
)

--==================================================
-- MINIMIZE
--==================================================

Minimize.MouseButton1Click:Connect(function()

    Main.Visible = false
    Shadow.Visible = false

    OpenButton.Visible = true

end)

--==================================================
-- OPEN
--==================================================

OpenButton.MouseButton1Click:Connect(function()

    OpenButton.Visible = false

    Main.Visible = true
    Shadow.Visible = true

    -- จัด Shadow ให้ตรงกับ Main
    Shadow.Position = UDim2.new(

        Main.Position.X.Scale,

        Main.Position.X.Offset - 2,

        Main.Position.Y.Scale,

        Main.Position.Y.Offset - 2

    )

end)

--==================================================
-- INITIALIZE
--==================================================

AutoLoot = true

AutoLootText.Text =
    "AUTO LOOT"

AutoLootState.Text =
    "ON"

AutoLootButton.BackgroundColor3 =
    BLUE

AFK_PROTECTION = true

AFKTitle.Text =
    "AFK PROTECTION ACTIVE"

AFKActivity.Text =
    "Activity protection • ON"

-- จัด Shadow ตอนเริ่ม
Shadow.Position = UDim2.new(

    Main.Position.X.Scale,

    Main.Position.X.Offset - 2,

    Main.Position.Y.Scale,

    Main.Position.Y.Offset - 2

)

local InitialLoots =
    GetLootObjects()

Status.Text =
    "🧲 Loot ทั้งแมพ: "
    .. #InitialLoots

LootSubStatus.Text =
    "AUTO LOOT ACTIVE"

print("================================")
print("        MIRACLE SYSTEM")
print("================================")
print(
    "Loot:",
    #InitialLoots
)
print(
    "Auto Loot: ON"
)
print(
    "AFK Protection: ALWAYS ON"
)
print("================================")

--==================================================
-- START
--==================================================

StartAutoLootLoop()

SendAFKActivity()
