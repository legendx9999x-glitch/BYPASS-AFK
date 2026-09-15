--==================================================
-- MAX AFK PROTECTION
-- PREMIUM BLUE UI
--==================================================

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local AFK_PROTECTION = true
local INTERVAL = 60

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
local RED = Color3.fromRGB(255, 75, 95)

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "MAX_AFk_UI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

--==================================================
-- SHADOW
--==================================================

local shadow = Instance.new("Frame")

shadow.Name = "Shadow"

shadow.Size = UDim2.new(0, 364, 0, 224)

shadow.Position = UDim2.new(
	0.5,
	-182,
	0.5,
	-112
)

shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

shadow.BackgroundTransparency = 0.55

shadow.BorderSizePixel = 0

shadow.ZIndex = 0

shadow.Parent = gui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 22)
shadowCorner.Parent = shadow

--==================================================
-- MAIN OUTER FRAME
--==================================================

local main = Instance.new("Frame")

main.Name = "Main"

main.Size = UDim2.new(0, 360, 0, 220)

main.Position = UDim2.new(
	0.5,
	-180,
	0.5,
	-110
)

main.BackgroundColor3 = BLACK

main.BorderSizePixel = 0

main.ZIndex = 1

main.Parent = gui

--==================================================
-- MAIN CORNER
--==================================================

local mainCorner = Instance.new("UICorner")

mainCorner.CornerRadius = UDim.new(0, 20)

mainCorner.Parent = main

--==================================================
-- MAIN BORDER
--==================================================

local mainStroke = Instance.new("UIStroke")

mainStroke.Color = BLUE

mainStroke.Thickness = 1.5

mainStroke.Transparency = 0.1

mainStroke.Parent = main

--==================================================
-- INNER PANEL
--==================================================

local inner = Instance.new("Frame")

inner.Name = "Inner"

inner.Size = UDim2.new(
	1,
	-4,
	1,
	-4
)

inner.Position = UDim2.new(
	0,
	2,
	0,
	2
)

inner.BackgroundColor3 = PANEL

inner.BorderSizePixel = 0

inner.ZIndex = 2

inner.Parent = main

local innerCorner = Instance.new("UICorner")

innerCorner.CornerRadius = UDim.new(0, 18)

innerCorner.Parent = inner

--==================================================
-- HEADER
--==================================================

local header = Instance.new("Frame")

header.Name = "Header"

header.Size = UDim2.new(
	1,
	-2,
	0,
	61
)

header.Position = UDim2.new(
	0,
	1,
	0,
	1
)

header.BackgroundColor3 = PANEL2

header.BorderSizePixel = 0

header.ZIndex = 3

header.Parent = inner

--==================================================
-- HEADER CORNER
--==================================================

local headerCorner = Instance.new("UICorner")

headerCorner.CornerRadius = UDim.new(0, 17)

headerCorner.Parent = header

--==================================================
-- HEADER BOTTOM COVER
--==================================================

local headerBottom = Instance.new("Frame")

headerBottom.Size = UDim2.new(
	1,
	0,
	0,
	18
)

headerBottom.Position = UDim2.new(
	0,
	0,
	1,
	-18
)

headerBottom.BackgroundColor3 = PANEL2

headerBottom.BorderSizePixel = 0

headerBottom.ZIndex = 3

headerBottom.Parent = header



--==================================================
-- LOGO
--==================================================

local logo = Instance.new("Frame")

logo.Size = UDim2.new(0, 40, 0, 40)

logo.Position = UDim2.new(
	0,
	16,
	0,
	11
)

logo.BackgroundColor3 = BLUE_DARK

logo.BorderSizePixel = 0

logo.ZIndex = 6

logo.Parent = header

local logoCorner = Instance.new("UICorner")

logoCorner.CornerRadius = UDim.new(0, 11)

logoCorner.Parent = logo

local logoStroke = Instance.new("UIStroke")

logoStroke.Color = BLUE2

logoStroke.Thickness = 1

logoStroke.Transparency = 0.15

logoStroke.Parent = logo

local logoGradient = Instance.new("UIGradient")

logoGradient.Color = ColorSequence.new({

	ColorSequenceKeypoint.new(
		0,
		Color3.fromRGB(0, 90, 155)
	),

	ColorSequenceKeypoint.new(
		1,
		Color3.fromRGB(0, 45, 85)
	)

})

logoGradient.Rotation = 45

logoGradient.Parent = logo

local logoText = Instance.new("TextLabel")

logoText.Size = UDim2.new(1, 0, 1, 0)

logoText.BackgroundTransparency = 1

logoText.Text = "M"

logoText.TextColor3 = BLUE2

logoText.TextSize = 21

logoText.Font = Enum.Font.GothamBlack

logoText.ZIndex = 7

logoText.Parent = logo

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")

title.Size = UDim2.new(
	1,
	-125,
	0,
	24
)

title.Position = UDim2.new(
	0,
	68,
	0,
	10
)

title.BackgroundTransparency = 1

title.Text = "MIRACLE BYPASS ANIT AFK"

title.TextColor3 = WHITE

title.TextSize = 16

title.Font = Enum.Font.GothamBold

title.TextXAlignment = Enum.TextXAlignment.Left

title.ZIndex = 6

title.Parent = header

--==================================================
-- SUBTITLE
--==================================================

local subtitle = Instance.new("TextLabel")

subtitle.Size = UDim2.new(
	1,
	-125,
	0,
	17
)

subtitle.Position = UDim2.new(
	0,
	68,
	0,
	34
)

subtitle.BackgroundTransparency = 1

subtitle.Text = "SESSION ACTIVE SYSTEM"

subtitle.TextColor3 = BLUE2

subtitle.TextSize = 9

subtitle.Font = Enum.Font.GothamBold

subtitle.TextXAlignment = Enum.TextXAlignment.Left

subtitle.ZIndex = 6

subtitle.Parent = header

--==================================================
-- MINIMIZE
--==================================================

local minimize = Instance.new("TextButton")

minimize.Size = UDim2.new(0, 36, 0, 36)

minimize.Position = UDim2.new(
	1,
	-49,
	0,
	12
)

minimize.BackgroundColor3 = Color3.fromRGB(14, 26, 43)

minimize.BorderSizePixel = 0

minimize.Text = "−"

minimize.TextColor3 = GRAY

minimize.TextSize = 20

minimize.Font = Enum.Font.GothamBold

minimize.AutoButtonColor = false

minimize.ZIndex = 8

minimize.Parent = header

local minCorner = Instance.new("UICorner")

minCorner.CornerRadius = UDim.new(0, 10)

minCorner.Parent = minimize

--==================================================
-- CONTENT
--==================================================

local content = Instance.new("Frame")

content.Name = "Content"

content.Size = UDim2.new(
	1,
	-30,
	1,
	-74
)

content.Position = UDim2.new(
	0,
	15,
	0,
	69
)

content.BackgroundTransparency = 1

content.BorderSizePixel = 0

content.ZIndex = 4

content.Parent = inner

--==================================================
-- STATUS CARD
--==================================================

local statusCard = Instance.new("Frame")

statusCard.Size = UDim2.new(
	1,
	0,
	0,
	53
)

statusCard.Position = UDim2.new(
	0,
	0,
	0,
	0
)

statusCard.BackgroundColor3 = Color3.fromRGB(7, 17, 29)

statusCard.BorderSizePixel = 0

statusCard.ZIndex = 5

statusCard.Parent = content

local statusCorner = Instance.new("UICorner")

statusCorner.CornerRadius = UDim.new(0, 13)

statusCorner.Parent = statusCard

local statusStroke = Instance.new("UIStroke")

statusStroke.Color = BLUE

statusStroke.Thickness = 1

statusStroke.Transparency = 0.65

statusStroke.Parent = statusCard

--==================================================
-- STATUS ICON
--==================================================

local statusIcon = Instance.new("Frame")

statusIcon.Size = UDim2.new(
	0,
	30,
	0,
	30
)

statusIcon.Position = UDim2.new(
	0,
	11,
	0.5,
	-15
)

statusIcon.BackgroundColor3 =
	Color3.fromRGB(12, 65, 52)

statusIcon.BorderSizePixel = 0

statusIcon.ZIndex = 6

statusIcon.Parent = statusCard

local statusIconCorner = Instance.new("UICorner")

statusIconCorner.CornerRadius = UDim.new(1, 0)

statusIconCorner.Parent = statusIcon

local statusDot = Instance.new("Frame")

statusDot.Size = UDim2.new(
	0,
	9,
	0,
	9
)

statusDot.Position = UDim2.new(
	0.5,
	-4.5,
	0.5,
	-4.5
)

statusDot.BackgroundColor3 = GREEN

statusDot.BorderSizePixel = 0

statusDot.ZIndex = 7

statusDot.Parent = statusIcon

local dotCorner = Instance.new("UICorner")

dotCorner.CornerRadius = UDim.new(1, 0)

dotCorner.Parent = statusDot

--==================================================
-- STATUS TEXT
--==================================================

local status = Instance.new("TextLabel")

status.Size = UDim2.new(
	1,
	-65,
	0,
	20
)

status.Position = UDim2.new(
	0,
	52,
	0,
	8
)

status.BackgroundTransparency = 1

status.Text = "PROTECTION ACTIVE"

status.TextColor3 = GREEN

status.TextSize = 12

status.Font = Enum.Font.GothamBold

status.TextXAlignment = Enum.TextXAlignment.Left

status.ZIndex = 6

status.Parent = statusCard

--==================================================
-- ACTIVITY
--==================================================

local activity = Instance.new("TextLabel")

activity.Size = UDim2.new(
	1,
	-65,
	0,
	16
)

activity.Position = UDim2.new(
	0,
	52,
	0,
	29
)

activity.BackgroundTransparency = 1

activity.Text = "Activity sent • Just Now"

activity.TextColor3 = GRAY

activity.TextSize = 9

activity.Font = Enum.Font.GothamMedium

activity.TextXAlignment = Enum.TextXAlignment.Left

activity.ZIndex = 6

activity.Parent = statusCard

--==================================================
-- TOGGLE BUTTON
--==================================================

local toggle = Instance.new("TextButton")

toggle.Size = UDim2.new(
	1,
	0,
	0,
	46
)

toggle.Position = UDim2.new(
	0,
	0,
	0,
	64
)

toggle.BackgroundColor3 = BLUE

toggle.BorderSizePixel = 0

toggle.Text = ""

toggle.AutoButtonColor = false

toggle.ZIndex = 5

toggle.Parent = content

local toggleCorner = Instance.new("UICorner")

toggleCorner.CornerRadius = UDim.new(0, 13)

toggleCorner.Parent = toggle

local toggleGradient = Instance.new("UIGradient")

toggleGradient.Color = ColorSequence.new({

	ColorSequenceKeypoint.new(
		0,
		Color3.fromRGB(0, 125, 225)
	),

	ColorSequenceKeypoint.new(
		0.5,
		Color3.fromRGB(0, 175, 255)
	),

	ColorSequenceKeypoint.new(
		1,
		Color3.fromRGB(0, 135, 235)
	)

})

toggleGradient.Rotation = 0

toggleGradient.Parent = toggle

local toggleStroke = Instance.new("UIStroke")

toggleStroke.Color = BLUE2

toggleStroke.Thickness = 1

toggleStroke.Transparency = 0.25

toggleStroke.Parent = toggle

--==================================================
-- TOGGLE TEXT
--==================================================

local toggleText = Instance.new("TextLabel")

toggleText.Size = UDim2.new(
	1,
	-70,
	1,
	0
)

toggleText.Position = UDim2.new(
	0,
	16,
	0,
	0
)

toggleText.BackgroundTransparency = 1

toggleText.Text = "AFK PROTECTION"

toggleText.TextColor3 = WHITE

toggleText.TextSize = 12

toggleText.Font = Enum.Font.GothamBold

toggleText.TextXAlignment = Enum.TextXAlignment.Left

toggleText.ZIndex = 6

toggleText.Parent = toggle

--==================================================
-- TOGGLE STATE
--==================================================

local toggleState = Instance.new("TextLabel")

toggleState.Size = UDim2.new(
	0,
	45,
	1,
	0
)

toggleState.Position = UDim2.new(
	1,
	-58,
	0,
	0
)

toggleState.BackgroundTransparency = 1

toggleState.Text = "ON"

toggleState.TextColor3 = WHITE

toggleState.TextSize = 11

toggleState.Font = Enum.Font.GothamBlack

toggleState.TextXAlignment = Enum.TextXAlignment.Right

toggleState.ZIndex = 6

toggleState.Parent = toggle

--==================================================
-- FOOTER
--==================================================

local footer = Instance.new("TextLabel")

footer.Size = UDim2.new(
	1,
	0,
	0,
	16
)

footer.Position = UDim2.new(
	0,
	0,
	1,
	-17
)

footer.BackgroundTransparency = 1

footer.Text = "MIRACLE  •  INTERVAL 60 SEC"

footer.TextColor3 =
	Color3.fromRGB(65, 90, 120)

footer.TextSize = 9

footer.Font = Enum.Font.GothamBold

footer.TextXAlignment = Enum.TextXAlignment.Center

footer.ZIndex = 5

footer.Parent = content

--==================================================
-- MINIMIZED BUTTON
--==================================================

local openButton = Instance.new("TextButton")

openButton.Name = "MAXButton"

openButton.Size = UDim2.new(
	0,
	62,
	0,
	62
)

openButton.Position = UDim2.new(
	0.5,
	-31,
	0.5,
	-31
)

openButton.BackgroundColor3 = BLACK

openButton.BorderSizePixel = 0

openButton.Text = ""

openButton.Visible = false

openButton.AutoButtonColor = false

openButton.ZIndex = 10

openButton.Parent = gui

local openCorner = Instance.new("UICorner")

openCorner.CornerRadius = UDim.new(1, 0)

openCorner.Parent = openButton

local openStroke = Instance.new("UIStroke")

openStroke.Color = BLUE

openStroke.Thickness = 2

openStroke.Parent = openButton

local openText = Instance.new("TextLabel")

openText.Size = UDim2.new(
	1,
	0,
	1,
	0
)

openText.BackgroundTransparency = 1

openText.Text = "MIRACLE"

openText.TextColor3 = BLUE2

openText.TextSize = 12

openText.Font = Enum.Font.GothamBlack

openText.ZIndex = 11

openText.Parent = openButton

--==================================================
-- UPDATE UI
--==================================================

local function updateUI()

	if AFK_PROTECTION then

		status.Text = "PROTECTION ACTIVE"
		status.TextColor3 = GREEN

		statusDot.BackgroundColor3 = GREEN

		statusIcon.BackgroundColor3 =
			Color3.fromRGB(12, 65, 52)

		toggleState.Text = "ON"

		toggleGradient.Color = ColorSequence.new({

			ColorSequenceKeypoint.new(
				0,
				Color3.fromRGB(0, 125, 225)
			),

			ColorSequenceKeypoint.new(
				0.5,
				Color3.fromRGB(0, 175, 255)
			),

			ColorSequenceKeypoint.new(
				1,
				Color3.fromRGB(0, 135, 235)
			)

		})

	else

		status.Text = "PROTECTION DISABLED"
		status.TextColor3 = RED

		statusDot.BackgroundColor3 = RED

		statusIcon.BackgroundColor3 =
			Color3.fromRGB(65, 20, 30)

		toggleState.Text = "OFF"

		toggleGradient.Color = ColorSequence.new({

			ColorSequenceKeypoint.new(
				0,
				Color3.fromRGB(90, 25, 40)
			),

			ColorSequenceKeypoint.new(
				1,
				Color3.fromRGB(135, 35, 55)
			)

		})

	end

end

--==================================================
-- TOGGLE
--==================================================

toggle.MouseButton1Click:Connect(function()

	AFK_PROTECTION = not AFK_PROTECTION

	updateUI()

	if AFK_PROTECTION then
		activity.Text = "Waiting for activity..."
	else
		activity.Text = "Protection is disabled"
	end

end)

--==================================================
-- MINIMIZE
--==================================================

minimize.MouseButton1Click:Connect(function()

	main.Visible = false
	shadow.Visible = false

	openButton.Visible = true

end)

--==================================================
-- OPEN
--==================================================

openButton.MouseButton1Click:Connect(function()

	openButton.Visible = false

	main.Visible = true
	shadow.Visible = true

end)

--==================================================
-- DRAG MAIN
--==================================================

local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1

		or input.UserInputType ==
		Enum.UserInputType.Touch then

		dragging = true

		dragStart = input.Position

		startPosition = main.Position

		input.Changed:Connect(function()

			if input.UserInputState ==
				Enum.UserInputState.End then

				dragging = false

			end

		end)

	end

end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType ==
		Enum.UserInputType.MouseMovement

		or input.UserInputType ==
		Enum.UserInputType.Touch then

		local delta =
			input.Position - dragStart

		main.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,

			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)

		shadow.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset - 2 + delta.X,

			startPosition.Y.Scale,
			startPosition.Y.Offset - 2 + delta.Y
		)

	end

end)

--==================================================
-- MINIMIZED DRAG
--==================================================

local miniDragging = false
local miniDragStart
local miniStartPosition

openButton.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1

		or input.UserInputType ==
		Enum.UserInputType.Touch then

		miniDragging = true

		miniDragStart = input.Position

		miniStartPosition =
			openButton.Position

		input.Changed:Connect(function()

			if input.UserInputState ==
				Enum.UserInputState.End then

				miniDragging = false

			end

		end)

	end

end)

UserInputService.InputChanged:Connect(function(input)

	if not miniDragging then
		return
	end

	if input.UserInputType ==
		Enum.UserInputType.MouseMovement

		or input.UserInputType ==
		Enum.UserInputType.Touch then

		local delta =
			input.Position - miniDragStart

		openButton.Position = UDim2.new(
			miniStartPosition.X.Scale,
			miniStartPosition.X.Offset + delta.X,

			miniStartPosition.Y.Scale,
			miniStartPosition.Y.Offset + delta.Y
		)

	end

end)

--==================================================
-- HOVER
--==================================================

toggle.MouseEnter:Connect(function()

	if not AFK_PROTECTION then
		return
	end

	TweenService:Create(
		toggle,
		TweenInfo.new(0.15),
		{
			BackgroundColor3 =
				Color3.fromRGB(0, 190, 255)
		}
	):Play()

end)

toggle.MouseLeave:Connect(function()

	if not AFK_PROTECTION then
		return
	end

	TweenService:Create(
		toggle,
		TweenInfo.new(0.15),
		{
			BackgroundColor3 = BLUE
		}
	):Play()

end)

--==================================================
-- SEND ACTIVITY
--==================================================

local function sendActivity()

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

	activity.Text = "Activity sent • Just Now"

	print("[MAX AFK] Activity sent")

end

--==================================================
-- ROBLOX IDLE
--==================================================

player.Idled:Connect(function()

	if not AFK_PROTECTION then
		return
	end

	sendActivity()

end)

--==================================================
-- PERIODIC ACTIVITY
--==================================================

task.spawn(function()

	while true do

		task.wait(INTERVAL)

		if AFK_PROTECTION then
			sendActivity()
		end

	end

end)

--==================================================
-- START
--==================================================

updateUI()

print("======================================")
print("       MIRACLE BYPASS ANIT AFK")
print("======================================")
print("Status:", AFK_PROTECTION)
print("Interval:", INTERVAL, "seconds")
print("======================================")
