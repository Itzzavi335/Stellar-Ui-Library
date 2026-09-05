local Stellar = {}

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ICON_ASSET_ID = "rbxassetid://71984635708160"
local ICON_SIZE = UDim2.fromOffset(64, 64)
local ICON_FADE_IN_TIME = 1.4
local SLIDE_TIME = 0.9
local TEXT_FADE_IN_TIME = 0.8
local HOLD_TIME = 2
local FADE_OUT_TIME = 0.8
local SLIDE_OFFSET = 70

local FRAME_SIZE = UDim2.fromOffset(500, 350)
local FRAME_COLOR = Color3.fromRGB(18, 18, 20)
local FRAME_CORNER_RADIUS = UDim.new(0, 24)
local FRAME_FADE_IN_TIME = 0.6

local HEADER_PADDING = 16
local LOGO_SIZE = UDim2.fromOffset(28, 28)
local TITLE_TEXT = "Title"
local TITLE_SIZE = 15
local SUBTITLE_TEXT = "Subtitle"
local SUBTITLE_SIZE = 11
local SUBTITLE_COLOR = Color3.fromRGB(150, 150, 155)
local HEADER_HEIGHT = 56
local DIVIDER_COLOR = Color3.fromRGB(45, 45, 50)
local SIDEBAR_WIDTH = 60

local TABS = {}
local TAB_BUTTON_SIZE = UDim2.fromOffset(36, 36)
local TAB_BUTTON_ICON_SIZE = UDim2.fromOffset(20, 20)
local TAB_BUTTON_SPACING = 4
local TAB_STRIP_TOP_PADDING = 18
local TAB_CORNER_RADIUS = UDim.new(0, 8)
local TAB_ACTIVE_COLOR = Color3.fromRGB(0, 0, 255)
local TAB_IDLE_ICON_COLOR = Color3.fromRGB(255, 255, 255)
local TAB_IDLE_ICON_TRANSPARENCY = 0.35
local TAB_HOVER_BG_TRANSPARENCY = 0.9
local TAB_TOOLTIP_COLOR = Color3.fromRGB(10, 10, 12)
local TAB_TOOLTIP_TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local TAB_TOOLTIP_FADE_TIME = 0.15
local TAB_INDICATOR_WIDTH = 3
local TAB_INDICATOR_HEIGHT = 20
local TAB_INDICATOR_FADE_TIME = 0.2

local CONTENT_PADDING = 14
local CONTENT_COLOR = FRAME_COLOR
local CONTENT_CORNER_RADIUS = UDim.new(0, 14)

local ROW_HEIGHT = 56
local ROW_SPACING = 0
local ROW_TEXT_PADDING = 4
local ROW_NAME_SIZE = 14
local ROW_NAME_COLOR = Color3.fromRGB(255, 255, 255)
local ROW_DESCRIPTION_SIZE = 11
local ROW_DESCRIPTION_COLOR = Color3.fromRGB(140, 140, 145)
local ROW_DIVIDER_COLOR = Color3.fromRGB(40, 40, 44)

local TOGGLE_TRACK_SIZE = UDim2.fromOffset(34, 18)
local TOGGLE_TRACK_BORDER_COLOR = Color3.fromRGB(220, 220, 225)
local TOGGLE_TRACK_BORDER_THICKNESS = 2
local TOGGLE_KNOB_SIZE = UDim2.fromOffset(10, 10)
local TOGGLE_KNOB_COLOR = Color3.fromRGB(220, 220, 225)
local TOGGLE_KNOB_PADDING = 4
local TOGGLE_SLIDE_TIME = 0.18

local BUTTON_ICON = "rbxassetid://73793633589587"
local BUTTON_COLOR = Color3.fromRGB(255, 255, 255)
local BUTTON_SIZE = UDim2.fromOffset(24, 24)
local BUTTON_PULSE_SCALE = 1.15
local BUTTON_PULSE_TIME = 0.1

local DROPDOWN_ICON = "rbxassetid://5279719038"
local DROPDOWN_ICON_COLOR = Color3.fromRGB(255, 255, 255)
local DROPDOWN_ICON_SIZE = UDim2.fromOffset(14, 14)
local DROPDOWN_BOX_SIZE = UDim2.fromOffset(30, 26)
local DROPDOWN_BOX_COLOR = Color3.fromRGB(30, 30, 34)
local DROPDOWN_BOX_HOVER_COLOR = Color3.fromRGB(42, 42, 48)
local DROPDOWN_BOX_CORNER = UDim.new(0, 8)
local DROPDOWN_BOX_BORDER_COLOR = Color3.fromRGB(55, 55, 62)
local DROPDOWN_BOX_BORDER_THICKNESS = 1
local DROPDOWN_ROTATE_TIME = 0.18
local DROPDOWN_OPEN_ROTATION = 180
local DROPDOWN_OPTION_HEIGHT = 34
local DROPDOWN_OPTION_COLOR = Color3.fromRGB(28, 28, 32)
local DROPDOWN_OPTION_HOVER_COLOR = Color3.fromRGB(40, 40, 46)
local DROPDOWN_OPTION_TEXT_COLOR = Color3.fromRGB(220, 220, 225)
local DROPDOWN_OPTION_TEXT_SIZE = 13
local DROPDOWN_OPTION_DIVIDER_COLOR = Color3.fromRGB(45, 45, 50)
local DROPDOWN_PANEL_CORNER = UDim.new(0, 12)
local DROPDOWN_PANEL_BG_COLOR = Color3.fromRGB(24, 24, 27)
local DROPDOWN_PANEL_PADDING = 6

local MULTI_DROPDOWN_CHECK_SIZE = UDim2.fromOffset(16, 16)
local MULTI_DROPDOWN_CHECK_COLOR = Color3.fromRGB(0, 0, 255)
local MULTI_DROPDOWN_CHECK_BORDER_COLOR = Color3.fromRGB(90, 90, 98)
local MULTI_DROPDOWN_CHECKMARK_ICON = "rbxassetid://5279719038"

local SLIDER_TRACK_HEIGHT = 3
local SLIDER_TRACK_COLOR = Color3.fromRGB(50, 50, 55)
local SLIDER_FILL_COLOR = Color3.fromRGB(0, 0, 255)
local SLIDER_TRACK_WIDTH = 85
local SLIDER_BUTTON_SIZE = UDim2.fromOffset(18, 18)
local SLIDER_BUTTON_COLOR = Color3.fromRGB(30, 30, 34)
local SLIDER_BUTTON_HOVER_COLOR = Color3.fromRGB(42, 42, 48)
local SLIDER_BUTTON_TEXT_COLOR = Color3.fromRGB(220, 220, 225)
local SLIDER_BUTTON_CORNER = UDim.new(0, 6)
local SLIDER_VALUE_TEXT_SIZE = 12
local SLIDER_VALUE_TEXT_COLOR = Color3.fromRGB(160, 160, 165)
local SLIDER_VALUE_WIDTH = 24
local SLIDER_GAP = 5

local SECTION_HEADER_HEIGHT = 48
local SECTION_ICON_SIZE = UDim2.fromOffset(20, 20)
local SECTION_TITLE_SIZE = 15
local SECTION_TITLE_COLOR = Color3.fromRGB(255, 255, 255)
local SECTION_CHEVRON_ICON = "rbxassetid://5279719038"
local SECTION_CHEVRON_SIZE = UDim2.fromOffset(14, 14)
local SECTION_CHEVRON_COLOR = Color3.fromRGB(200, 200, 205)
local SECTION_ROTATE_TIME = 0.2
local SECTION_OPEN_ROTATION = 180
local SECTION_BODY_COLOR = Color3.fromRGB(22, 22, 25)
local SECTION_CORNER = UDim.new(0, 12)
local SECTION_BODY_PADDING = 8
local SECTION_DIVIDER_COLOR = Color3.fromRGB(40, 40, 44)

local INPUT_BOX_SIZE = UDim2.fromOffset(100, 28)
local INPUT_BOX_COLOR = Color3.fromRGB(30, 30, 34)
local INPUT_BOX_CORNER = UDim.new(0, 8)
local INPUT_BOX_BORDER_COLOR = Color3.fromRGB(55, 55, 62)
local INPUT_BOX_FOCUSED_BORDER_COLOR = Color3.fromRGB(0, 0, 255)
local INPUT_TEXT_COLOR = Color3.fromRGB(220, 220, 225)
local INPUT_PLACEHOLDER_COLOR = Color3.fromRGB(120, 120, 125)
local INPUT_TEXT_SIZE = 13

local COLORPICKER_SWATCH_SIZE = UDim2.fromOffset(28, 28)
local COLORPICKER_SWATCH_CORNER = UDim.new(0, 8)
local COLORPICKER_SWATCH_BORDER_COLOR = Color3.fromRGB(55, 55, 62)
local COLORPICKER_PANEL_WIDTH = 220
local COLORPICKER_PANEL_HEIGHT = 220
local COLORPICKER_PANEL_COLOR = Color3.fromRGB(24, 24, 27)
local COLORPICKER_PANEL_CORNER = UDim.new(0, 12)
local COLORPICKER_PANEL_BORDER_COLOR = Color3.fromRGB(55, 55, 62)
local COLORPICKER_SV_SIZE = UDim2.fromOffset(150, 150)
local COLORPICKER_HUE_WIDTH = 22
local COLORPICKER_PANEL_PADDING = 12
local COLORPICKER_CURSOR_SIZE = UDim2.fromOffset(14, 14)

local NOTIFICATION_WIDTH = 280
local NOTIFICATION_HEIGHT = 64
local NOTIFICATION_COLOR = Color3.fromRGB(18, 18, 20)
local NOTIFICATION_CORNER = UDim.new(0, 12)
local NOTIFICATION_BORDER_COLOR = Color3.fromRGB(45, 45, 50)
local NOTIFICATION_ICON_SIZE = UDim2.fromOffset(28, 28)
local NOTIFICATION_TITLE_COLOR = Color3.fromRGB(255, 255, 255)
local NOTIFICATION_TITLE_SIZE = 14
local NOTIFICATION_MESSAGE_COLOR = Color3.fromRGB(170, 170, 175)
local NOTIFICATION_MESSAGE_SIZE = 12
local NOTIFICATION_DURATION = 4
local NOTIFICATION_SLIDE_TIME = 0.35
local NOTIFICATION_SPACING = 10
local NOTIFICATION_SCREEN_PADDING = 16

local WINDOW_BUTTON_SIZE = UDim2.fromOffset(28, 28)
local WINDOW_BUTTON_ICON_SIZE = UDim2.fromOffset(13, 13)
local WINDOW_BUTTON_SPACING = 6
local WINDOW_BUTTON_COLOR = Color3.fromRGB(255, 255, 255)
local WINDOW_BUTTON_IDLE_TRANSPARENCY = 0.35
local WINDOW_BUTTON_HOVER_TRANSPARENCY = 0
local CLOSE_ICON = "rbxassetid://82994774214203"
local MINIMIZE_ICON = "rbxassetid://82235228007110"
local WINDOW_CONTROLS_PADDING = 14

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StellarUI"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.Parent = playerGui

local notificationContainer = Instance.new("Frame")
notificationContainer.Name = "NotificationContainer"
notificationContainer.AnchorPoint = Vector2.new(1, 1)
notificationContainer.Position = UDim2.new(1, -NOTIFICATION_SCREEN_PADDING, 1, -NOTIFICATION_SCREEN_PADDING)
notificationContainer.Size = UDim2.fromOffset(NOTIFICATION_WIDTH, 0)
notificationContainer.AutomaticSize = Enum.AutomaticSize.Y
notificationContainer.BackgroundTransparency = 1
notificationContainer.ZIndex = 200
notificationContainer.Parent = screenGui

local notificationList = Instance.new("UIListLayout")
notificationList.FillDirection = Enum.FillDirection.Vertical
notificationList.HorizontalAlignment = Enum.HorizontalAlignment.Right
notificationList.VerticalAlignment = Enum.VerticalAlignment.Bottom
notificationList.SortOrder = Enum.SortOrder.LayoutOrder
notificationList.Padding = UDim.new(0, NOTIFICATION_SPACING)
notificationList.Parent = notificationContainer

local function tween(instance, time, props, style, direction)
	local info = TweenInfo.new(time, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out)
	local t = TweenService:Create(instance, info, props)
	t:Play()
	return t
end

local function notify(title, message, duration)
	duration = duration or NOTIFICATION_DURATION
	local slot = Instance.new("Frame")
	slot.Name = "NotificationSlot"
	slot.Size = UDim2.fromOffset(NOTIFICATION_WIDTH, NOTIFICATION_HEIGHT)
	slot.BackgroundTransparency = 1
	slot.ClipsDescendants = false
	slot.ZIndex = 200
	slot.Parent = notificationContainer

	local card = Instance.new("Frame")
	card.Name = "Notification"
	card.AnchorPoint = Vector2.new(0, 0)
	card.Position = UDim2.fromOffset(NOTIFICATION_WIDTH + 20, 0)
	card.Size = UDim2.fromOffset(NOTIFICATION_WIDTH, NOTIFICATION_HEIGHT)
	card.BackgroundColor3 = NOTIFICATION_COLOR
	card.BackgroundTransparency = 1
	card.ClipsDescendants = true
	card.ZIndex = 200
	card.Parent = slot

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = NOTIFICATION_CORNER
	cardCorner.Parent = card

	local cardStroke = Instance.new("UIStroke")
	cardStroke.Color = NOTIFICATION_BORDER_COLOR
	cardStroke.Thickness = 1
	cardStroke.Transparency = 1
	cardStroke.Parent = card

	local logo = Instance.new("ImageLabel")
	logo.Name = "Logo"
	logo.AnchorPoint = Vector2.new(0, 0.5)
	logo.Position = UDim2.new(0, 14, 0.5, 0)
	logo.Size = NOTIFICATION_ICON_SIZE
	logo.BackgroundTransparency = 1
	logo.Image = ICON_ASSET_ID
	logo.ImageTransparency = 1
	logo.ScaleType = Enum.ScaleType.Fit
	logo.ZIndex = 201
	logo.Parent = card

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.AnchorPoint = Vector2.new(0, 0)
	titleLabel.Position = UDim2.new(0, 14 + NOTIFICATION_ICON_SIZE.X.Offset + 10, 0, 12)
	titleLabel.Size = UDim2.new(1, -(14 + NOTIFICATION_ICON_SIZE.X.Offset + 24), 0, 18)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title or ""
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = NOTIFICATION_TITLE_SIZE
	titleLabel.TextColor3 = NOTIFICATION_TITLE_COLOR
	titleLabel.TextTransparency = 1
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
	titleLabel.ZIndex = 201
	titleLabel.Parent = card

	local messageLabel = Instance.new("TextLabel")
	messageLabel.Name = "Message"
	messageLabel.AnchorPoint = Vector2.new(0, 0)
	messageLabel.Position = UDim2.new(0, 14 + NOTIFICATION_ICON_SIZE.X.Offset + 10, 0, 32)
	messageLabel.Size = UDim2.new(1, -(14 + NOTIFICATION_ICON_SIZE.X.Offset + 24), 0, 26)
	messageLabel.BackgroundTransparency = 1
	messageLabel.Text = message or ""
	messageLabel.Font = Enum.Font.Gotham
	messageLabel.TextSize = NOTIFICATION_MESSAGE_SIZE
	messageLabel.TextColor3 = NOTIFICATION_MESSAGE_COLOR
	messageLabel.TextTransparency = 1
	messageLabel.TextXAlignment = Enum.TextXAlignment.Left
	messageLabel.TextYAlignment = Enum.TextYAlignment.Top
	messageLabel.TextWrapped = true
	messageLabel.ZIndex = 201
	messageLabel.Parent = card

	local tweenInfo = TweenInfo.new(NOTIFICATION_SLIDE_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	TweenService:Create(card, tweenInfo, { Position = UDim2.fromOffset(0, 0), BackgroundTransparency = 0 }):Play()
	TweenService:Create(cardStroke, tweenInfo, { Transparency = 0 }):Play()
	TweenService:Create(logo, tweenInfo, { ImageTransparency = 0 }):Play()
	TweenService:Create(titleLabel, tweenInfo, { TextTransparency = 0 }):Play()
	TweenService:Create(messageLabel, tweenInfo, { TextTransparency = 0 }):Play()

	task.delay(duration, function()
		local outInfo = TweenInfo.new(NOTIFICATION_SLIDE_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
		local outTween = TweenService:Create(card, outInfo, {
			Position = UDim2.fromOffset(NOTIFICATION_WIDTH + 20, 0),
			BackgroundTransparency = 1,
		})
		TweenService:Create(cardStroke, outInfo, { Transparency = 1 }):Play()
		TweenService:Create(logo, outInfo, { ImageTransparency = 1 }):Play()
		TweenService:Create(titleLabel, outInfo, { TextTransparency = 1 }):Play()
		TweenService:Create(messageLabel, outInfo, { TextTransparency = 1 }):Play()
		outTween:Play()
		outTween.Completed:Connect(function()
			slot:Destroy()
		end)
	end)
end

Stellar.Notify = function(config)
	notify(config.Title, config.Content, config.Duration)
end

local function pulse(instance, peakScale, time)
	if not instance:GetAttribute("BaseSizeX") then
		instance:SetAttribute("BaseSizeX", instance.Size.X.Offset)
		instance:SetAttribute("BaseSizeY", instance.Size.Y.Offset)
	end
	local baseX = instance:GetAttribute("BaseSizeX")
	local baseY = instance:GetAttribute("BaseSizeY")
	local baseSize = UDim2.fromOffset(baseX, baseY)
	local peakSize = UDim2.fromOffset(baseX * peakScale, baseY * peakScale)
	local grow = tween(instance, time, { Size = peakSize }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	grow.Completed:Connect(function()
		tween(instance, time, { Size = baseSize }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	end)
end

local function applyEdgeRounding(button, radius, side, bgColor)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = radius
	corner.Parent = button
	local patchHeight = radius.Offset
	if patchHeight <= 0 then return end
	local function patch(anchorX)
		local square = Instance.new("Frame")
		square.Name = "CornerSquarePatch"
		local patchSide = (side == "top") and 1 or 0
		square.AnchorPoint = Vector2.new(anchorX, patchSide)
		square.Position = UDim2.new(anchorX, 0, patchSide, 0)
		square.Size = UDim2.new(0, patchHeight, 0, patchHeight)
		square.BackgroundColor3 = bgColor
		square.BorderSizePixel = 0
		square.ZIndex = button.ZIndex
		square.Parent = button
	end
	patch(0)
	patch(1)
end

local function createRowBase(name, description, layoutOrder, parentFrame)
	local row = Instance.new("Frame")
	row.Name = name .. "Row"
	row.Size = UDim2.new(1, 0, 0, ROW_HEIGHT)
	row.BackgroundTransparency = 1
	row.LayoutOrder = layoutOrder
	row.ZIndex = 4
	row.Parent = parentFrame

	local divider = Instance.new("Frame")
	divider.Name = "Divider"
	divider.AnchorPoint = Vector2.new(0, 1)
	divider.Position = UDim2.new(0, 0, 1, 0)
	divider.Size = UDim2.new(1, 0, 0, 1)
	divider.BackgroundColor3 = ROW_DIVIDER_COLOR
	divider.BorderSizePixel = 0
	divider.ZIndex = 4
	divider.Parent = row

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "Name"
	nameLabel.AnchorPoint = Vector2.new(0, 0)
	nameLabel.Position = UDim2.new(0, ROW_TEXT_PADDING, 0, 8)
	nameLabel.Size = UDim2.new(1, -90, 0, 18)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = name
	nameLabel.Font = Enum.Font.GothamMedium
	nameLabel.TextSize = ROW_NAME_SIZE
	nameLabel.TextColor3 = ROW_NAME_COLOR
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.ZIndex = 5
	nameLabel.Parent = row

	local descLabel = Instance.new("TextLabel")
	descLabel.Name = "Description"
	descLabel.AnchorPoint = Vector2.new(0, 0)
	descLabel.Position = UDim2.new(0, ROW_TEXT_PADDING, 0, 28)
	descLabel.Size = UDim2.new(1, -90, 0, 16)
	descLabel.BackgroundTransparency = 1
	descLabel.Text = description
	descLabel.Font = Enum.Font.Gotham
	descLabel.TextSize = ROW_DESCRIPTION_SIZE
	descLabel.TextColor3 = ROW_DESCRIPTION_COLOR
	descLabel.TextXAlignment = Enum.TextXAlignment.Left
	descLabel.TextWrapped = true
	descLabel.ZIndex = 5
	descLabel.Parent = row

	return row
end

local function createToggleRow(name, description, layoutOrder, defaultOn, onChanged, parentFrame)
	local row = createRowBase(name, description, layoutOrder, parentFrame)
	local isOn = defaultOn or false

	local track = Instance.new("TextButton")
	track.Name = "Toggle"
	track.AnchorPoint = Vector2.new(1, 0.5)
	track.Position = UDim2.new(1, -ROW_TEXT_PADDING - 4, 0.5, 0)
	track.Size = TOGGLE_TRACK_SIZE
	track.BackgroundTransparency = 1
	track.AutoButtonColor = false
	track.Text = ""
	track.ZIndex = 5
	track.Parent = row

	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(1, 0)
	trackCorner.Parent = track

	local trackStroke = Instance.new("UIStroke")
	trackStroke.Color = TOGGLE_TRACK_BORDER_COLOR
	trackStroke.Thickness = TOGGLE_TRACK_BORDER_THICKNESS
	trackStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	trackStroke.Parent = track

	local knob = Instance.new("Frame")
	knob.Name = "Knob"
	knob.AnchorPoint = Vector2.new(0, 0.5)
	knob.Size = TOGGLE_KNOB_SIZE
	knob.Position = UDim2.new(isOn and 1 or 0, isOn and -(TOGGLE_KNOB_SIZE.X.Offset + TOGGLE_KNOB_PADDING) or TOGGLE_KNOB_PADDING, 0.5, 0)
	knob.BackgroundColor3 = TOGGLE_KNOB_COLOR
	knob.BorderSizePixel = 0
	knob.ZIndex = 6
	knob.Parent = track

	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = knob

	local function updateVisual()
		local targetX = isOn and (TOGGLE_TRACK_SIZE.X.Offset - TOGGLE_KNOB_SIZE.X.Offset - TOGGLE_KNOB_PADDING) or TOGGLE_KNOB_PADDING
		tween(knob, TOGGLE_SLIDE_TIME, { Position = UDim2.new(0, targetX, 0.5, 0) }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	end

	track.MouseButton1Click:Connect(function()
		isOn = not isOn
		updateVisual()
		if onChanged then onChanged(isOn) end
	end)

	return row, track
end

local function createButtonRow(name, description, layoutOrder, onPressed, parentFrame)
	local row = createRowBase(name, description, layoutOrder, parentFrame)

	local button = Instance.new("ImageButton")
	button.Name = "Button"
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, -ROW_TEXT_PADDING, 0.5, 0)
	button.Size = BUTTON_SIZE
	button.BackgroundTransparency = 1
	button.Image = BUTTON_ICON
	button.ImageColor3 = BUTTON_COLOR
	button.ZIndex = 5
	button.Parent = row

	button.MouseButton1Click:Connect(function()
		pulse(button, BUTTON_PULSE_SCALE, BUTTON_PULSE_TIME)
		if onPressed then onPressed() end
	end)

	return row, button
end

local function createLabelRow(text, layoutOrder, parentFrame)
	local row = Instance.new("Frame")
	row.Name = "LabelRow"
	row.Size = UDim2.new(1, 0, 0, 32)
	row.BackgroundTransparency = 1
	row.LayoutOrder = layoutOrder
	row.ZIndex = 4
	row.Parent = parentFrame

	local divider = Instance.new("Frame")
	divider.Name = "Divider"
	divider.AnchorPoint = Vector2.new(0, 1)
	divider.Position = UDim2.new(0, 0, 1, 0)
	divider.Size = UDim2.new(1, 0, 0, 1)
	divider.BackgroundColor3 = ROW_DIVIDER_COLOR
	divider.BorderSizePixel = 0
	divider.ZIndex = 4
	divider.Parent = row

	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.AnchorPoint = Vector2.new(0, 0.5)
	label.Position = UDim2.new(0, ROW_TEXT_PADDING, 0.5, 0)
	label.Size = UDim2.new(1, -ROW_TEXT_PADDING * 2, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.Font = Enum.Font.GothamBold
	label.TextSize = ROW_NAME_SIZE
	label.TextColor3 = ROW_NAME_COLOR
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.ZIndex = 5
	label.Parent = row

	return row, label
end

local function createDropdownRow(name, description, layoutOrder, options, defaultOption, onSelected, parentFrame)
	local row = createRowBase(name, description, layoutOrder, parentFrame)
	local isOpen = false
	local selectedOption = defaultOption or (options and options[1])

	local bar = Instance.new("Frame")
	bar.Name = "Bar"
	bar.AnchorPoint = Vector2.new(1, 0.5)
	bar.Position = UDim2.new(1, -ROW_TEXT_PADDING, 0.5, 0)
	bar.Size = UDim2.new(0, 110, 0, 28)
	bar.BackgroundColor3 = DROPDOWN_OPTION_COLOR
	bar.ZIndex = 5
	bar.Parent = row

	local barCorner = Instance.new("UICorner")
	barCorner.CornerRadius = DROPDOWN_PANEL_CORNER
	barCorner.Parent = bar

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Name = "Value"
	valueLabel.AnchorPoint = Vector2.new(0, 0.5)
	valueLabel.Position = UDim2.new(0, 12, 0.5, 0)
	valueLabel.Size = UDim2.new(1, -50, 1, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = selectedOption or ""
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.TextSize = 13
	valueLabel.TextColor3 = Color3.fromRGB(160, 160, 165)
	valueLabel.TextXAlignment = Enum.TextXAlignment.Left
	valueLabel.TextTruncate = Enum.TextTruncate.AtEnd
	valueLabel.ZIndex = 6
	valueLabel.Parent = bar

	local barDivider = Instance.new("Frame")
	barDivider.Name = "Divider"
	barDivider.AnchorPoint = Vector2.new(1, 0.5)
	barDivider.Position = UDim2.new(1, -DROPDOWN_BOX_SIZE.X.Offset - 6, 0.5, 0)
	barDivider.Size = UDim2.new(0, 1, 1, -10)
	barDivider.BackgroundColor3 = ROW_DIVIDER_COLOR
	barDivider.BorderSizePixel = 0
	barDivider.ZIndex = 6
	barDivider.Parent = bar

	local box = Instance.new("TextButton")
	box.Name = "DropdownBox"
	box.AnchorPoint = Vector2.new(1, 0.5)
	box.Position = UDim2.new(1, -4, 0.5, 0)
	box.Size = DROPDOWN_BOX_SIZE
	box.BackgroundTransparency = 1
	box.AutoButtonColor = false
	box.Text = ""
	box.ZIndex = 6
	box.Parent = bar

	local chevron = Instance.new("ImageLabel")
	chevron.Name = "Icon"
	chevron.AnchorPoint = Vector2.new(0.5, 0.5)
	chevron.Position = UDim2.fromScale(0.5, 0.5)
	chevron.Size = DROPDOWN_ICON_SIZE
	chevron.BackgroundTransparency = 1
	chevron.Image = DROPDOWN_ICON
	chevron.ImageColor3 = DROPDOWN_ICON_COLOR
	chevron.Rotation = 0
	chevron.ZIndex = 7
	chevron.Parent = box

	box.MouseEnter:Connect(function() tween(chevron, 0.12, { ImageTransparency = 0.3 }) end)
	box.MouseLeave:Connect(function() tween(chevron, 0.12, { ImageTransparency = 0 }) end)

	local backdrop = Instance.new("TextButton")
	backdrop.Name = "DropdownBackdrop"
	backdrop.Size = UDim2.fromScale(1, 1)
	backdrop.BackgroundTransparency = 1
	backdrop.AutoButtonColor = false
	backdrop.Text = ""
	backdrop.Visible = false
	backdrop.ZIndex = 99
	backdrop.Parent = screenGui

	local panel = Instance.new("Frame")
	panel.Name = "DropdownPanel"
	panel.BackgroundColor3 = DROPDOWN_PANEL_BG_COLOR
	panel.BorderSizePixel = 0
	panel.ClipsDescendants = true
	panel.Visible = false
	panel.ZIndex = 100
	panel.Parent = screenGui

	local panelCorner = Instance.new("UICorner")
	panelCorner.CornerRadius = DROPDOWN_PANEL_CORNER
	panelCorner.Parent = panel

	local panelStroke = Instance.new("UIStroke")
	panelStroke.Color = DROPDOWN_BOX_BORDER_COLOR
	panelStroke.Thickness = 1
	panelStroke.Parent = panel

	local panelInner = Instance.new("Frame")
	panelInner.Name = "Inner"
	panelInner.Position = UDim2.fromOffset(1, 1)
	panelInner.Size = UDim2.new(1, -2, 1, -2)
	panelInner.BackgroundTransparency = 1
	panelInner.ClipsDescendants = true
	panelInner.ZIndex = 100
	panelInner.Parent = panel

	local panelInnerCorner = Instance.new("UICorner")
	panelInnerCorner.CornerRadius = UDim.new(0, DROPDOWN_PANEL_CORNER.Offset - 1)
	panelInnerCorner.Parent = panelInner

	local panelList = Instance.new("UIListLayout")
	panelList.FillDirection = Enum.FillDirection.Vertical
	panelList.SortOrder = Enum.SortOrder.LayoutOrder
	panelList.Parent = panelInner

	local fullPanelHeight = (options and #options or 0) * DROPDOWN_OPTION_HEIGHT
	local panelWidth = 130

	local function positionPanel()
		local boxAbsPos = box.AbsolutePosition
		local boxAbsSize = box.AbsoluteSize
		local barAbsSize = bar.AbsoluteSize
		panel.Position = UDim2.fromOffset(boxAbsPos.X + boxAbsSize.X - barAbsSize.X, boxAbsPos.Y + boxAbsSize.Y + DROPDOWN_PANEL_PADDING)
		panel.Size = UDim2.fromOffset(barAbsSize.X, 0)
		panelWidth = barAbsSize.X
	end

	local function closePanel()
		isOpen = false
		backdrop.Visible = false
		tween(chevron, DROPDOWN_ROTATE_TIME, { Rotation = 0 })
		local shrink = tween(panel, DROPDOWN_ROTATE_TIME, { Size = UDim2.fromOffset(panelWidth, 0) })
		shrink.Completed:Connect(function()
			if not isOpen then panel.Visible = false end
		end)
	end

	local function openPanel()
		positionPanel()
		isOpen = true
		backdrop.Visible = true
		panel.Visible = true
		tween(chevron, DROPDOWN_ROTATE_TIME, { Rotation = DROPDOWN_OPEN_ROTATION })
		tween(panel, DROPDOWN_ROTATE_TIME, { Size = UDim2.fromOffset(panelWidth, fullPanelHeight) })
	end

	box.MouseButton1Click:Connect(function()
		if isOpen then closePanel() else openPanel() end
	end)
	backdrop.MouseButton1Click:Connect(closePanel)

	if options then
		for i, optionText in ipairs(options) do
			local optionButton = Instance.new("TextButton")
			optionButton.Name = "Option" .. i
			optionButton.Size = UDim2.new(1, 0, 0, DROPDOWN_OPTION_HEIGHT)
			optionButton.BackgroundColor3 = DROPDOWN_OPTION_COLOR
			optionButton.AutoButtonColor = false
			optionButton.SelectionImageObject = nil
			optionButton.Text = optionText
			optionButton.Font = Enum.Font.Gotham
			optionButton.TextSize = DROPDOWN_OPTION_TEXT_SIZE
			optionButton.TextColor3 = DROPDOWN_OPTION_TEXT_COLOR
			optionButton.LayoutOrder = i
			optionButton.ZIndex = 101
			optionButton.Parent = panelInner

			local cornerPatches = {}
			if i == 1 then applyEdgeRounding(optionButton, panelInnerCorner.CornerRadius, "top", DROPDOWN_OPTION_COLOR) end
			if i == #options then applyEdgeRounding(optionButton, panelInnerCorner.CornerRadius, "bottom", DROPDOWN_OPTION_COLOR) end
			for _, child in ipairs(optionButton:GetChildren()) do
				if child.Name == "CornerSquarePatch" then table.insert(cornerPatches, child) end
			end

			if i < #options then
				local optionDivider = Instance.new("Frame")
				optionDivider.Name = "Divider"
				optionDivider.AnchorPoint = Vector2.new(0, 1)
				optionDivider.Position = UDim2.new(0, 0, 1, 0)
				optionDivider.Size = UDim2.new(1, 0, 0, 1)
				optionDivider.BackgroundColor3 = DROPDOWN_OPTION_DIVIDER_COLOR
				optionDivider.BorderSizePixel = 0
				optionDivider.ZIndex = 102
				optionDivider.Parent = optionButton
			end

			optionButton.MouseEnter:Connect(function()
				tween(optionButton, 0.1, { BackgroundColor3 = DROPDOWN_OPTION_HOVER_COLOR })
				for _, patch in ipairs(cornerPatches) do tween(patch, 0.1, { BackgroundColor3 = DROPDOWN_OPTION_HOVER_COLOR }) end
			end)
			optionButton.MouseLeave:Connect(function()
				tween(optionButton, 0.1, { BackgroundColor3 = DROPDOWN_OPTION_COLOR })
				for _, patch in ipairs(cornerPatches) do tween(patch, 0.1, { BackgroundColor3 = DROPDOWN_OPTION_COLOR }) end
			end)
			optionButton.MouseButton1Click:Connect(function()
				selectedOption = optionText
				valueLabel.Text = optionText
				closePanel()
				if onSelected then onSelected(optionText) end
			end)
		end
	end

	if currentFrame then
		currentFrame:GetPropertyChangedSignal("Position"):Connect(function()
			if isOpen then positionPanel() end
		end)
	end

	return row, bar
end

local function createMultiDropdownRow(name, description, layoutOrder, options, defaultSelected, onChanged, parentFrame)
	local row = createRowBase(name, description, layoutOrder, parentFrame)
	local isOpen = false
	local selected = {}
	if defaultSelected then
		for _, opt in ipairs(defaultSelected) do selected[opt] = true end
	end

	local function summaryText()
		local count = 0
		local firstSelected = nil
		for opt in pairs(selected) do
			count = count + 1
			firstSelected = firstSelected or opt
		end
		if count == 0 then return "None"
		elseif count == 1 then return firstSelected
		else return count .. " selected" end
	end

	local bar = Instance.new("Frame")
	bar.Name = "Bar"
	bar.AnchorPoint = Vector2.new(1, 0.5)
	bar.Position = UDim2.new(1, -ROW_TEXT_PADDING, 0.5, 0)
	bar.Size = UDim2.new(0, 110, 0, 28)
	bar.BackgroundColor3 = DROPDOWN_OPTION_COLOR
	bar.ZIndex = 5
	bar.Parent = row

	local barCorner = Instance.new("UICorner")
	barCorner.CornerRadius = DROPDOWN_PANEL_CORNER
	barCorner.Parent = bar

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Name = "Value"
	valueLabel.AnchorPoint = Vector2.new(0, 0.5)
	valueLabel.Position = UDim2.new(0, 12, 0.5, 0)
	valueLabel.Size = UDim2.new(1, -50, 1, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = summaryText()
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.TextSize = 13
	valueLabel.TextColor3 = Color3.fromRGB(160, 160, 165)
	valueLabel.TextXAlignment = Enum.TextXAlignment.Left
	valueLabel.TextTruncate = Enum.TextTruncate.AtEnd
	valueLabel.ZIndex = 6
	valueLabel.Parent = bar

	local barDivider = Instance.new("Frame")
	barDivider.Name = "Divider"
	barDivider.AnchorPoint = Vector2.new(1, 0.5)
	barDivider.Position = UDim2.new(1, -DROPDOWN_BOX_SIZE.X.Offset - 6, 0.5, 0)
	barDivider.Size = UDim2.new(0, 1, 1, -10)
	barDivider.BackgroundColor3 = ROW_DIVIDER_COLOR
	barDivider.BorderSizePixel = 0
	barDivider.ZIndex = 6
	barDivider.Parent = bar

	local box = Instance.new("TextButton")
	box.Name = "DropdownBox"
	box.AnchorPoint = Vector2.new(1, 0.5)
	box.Position = UDim2.new(1, -4, 0.5, 0)
	box.Size = DROPDOWN_BOX_SIZE
	box.BackgroundTransparency = 1
	box.AutoButtonColor = false
	box.Text = ""
	box.ZIndex = 6
	box.Parent = bar

	local chevron = Instance.new("ImageLabel")
	chevron.Name = "Icon"
	chevron.AnchorPoint = Vector2.new(0.5, 0.5)
	chevron.Position = UDim2.fromScale(0.5, 0.5)
	chevron.Size = DROPDOWN_ICON_SIZE
	chevron.BackgroundTransparency = 1
	chevron.Image = DROPDOWN_ICON
	chevron.ImageColor3 = DROPDOWN_ICON_COLOR
	chevron.Rotation = 0
	chevron.ZIndex = 7
	chevron.Parent = box

	box.MouseEnter:Connect(function() tween(chevron, 0.12, { ImageTransparency = 0.3 }) end)
	box.MouseLeave:Connect(function() tween(chevron, 0.12, { ImageTransparency = 0 }) end)

	local backdrop = Instance.new("TextButton")
	backdrop.Name = "MultiDropdownBackdrop"
	backdrop.Size = UDim2.fromScale(1, 1)
	backdrop.BackgroundTransparency = 1
	backdrop.AutoButtonColor = false
	backdrop.Text = ""
	backdrop.Visible = false
	backdrop.ZIndex = 99
	backdrop.Parent = screenGui

	local panel = Instance.new("Frame")
	panel.Name = "MultiDropdownPanel"
	panel.BackgroundColor3 = DROPDOWN_PANEL_BG_COLOR
	panel.BorderSizePixel = 0
	panel.ClipsDescendants = true
	panel.Visible = false
	panel.ZIndex = 100
	panel.Parent = screenGui

	local panelCorner = Instance.new("UICorner")
	panelCorner.CornerRadius = DROPDOWN_PANEL_CORNER
	panelCorner.Parent = panel

	local panelStroke = Instance.new("UIStroke")
	panelStroke.Color = DROPDOWN_BOX_BORDER_COLOR
	panelStroke.Thickness = 1
	panelStroke.Parent = panel

	local panelInner = Instance.new("Frame")
	panelInner.Name = "Inner"
	panelInner.Position = UDim2.fromOffset(1, 1)
	panelInner.Size = UDim2.new(1, -2, 1, -2)
	panelInner.BackgroundTransparency = 1
	panelInner.ClipsDescendants = true
	panelInner.ZIndex = 100
	panelInner.Parent = panel

	local panelInnerCorner = Instance.new("UICorner")
	panelInnerCorner.CornerRadius = UDim.new(0, DROPDOWN_PANEL_CORNER.Offset - 1)
	panelInnerCorner.Parent = panelInner

	local panelList = Instance.new("UIListLayout")
	panelList.FillDirection = Enum.FillDirection.Vertical
	panelList.SortOrder = Enum.SortOrder.LayoutOrder
	panelList.Parent = panelInner

	local fullPanelHeight = (options and #options or 0) * DROPDOWN_OPTION_HEIGHT
	local panelWidth = 130

	local function positionPanel()
		local boxAbsPos = box.AbsolutePosition
		local boxAbsSize = box.AbsoluteSize
		local barAbsSize = bar.AbsoluteSize
		panel.Position = UDim2.fromOffset(boxAbsPos.X + boxAbsSize.X - barAbsSize.X, boxAbsPos.Y + boxAbsSize.Y + DROPDOWN_PANEL_PADDING)
		panel.Size = UDim2.fromOffset(barAbsSize.X, 0)
		panelWidth = barAbsSize.X
	end

	local function closePanel()
		isOpen = false
		backdrop.Visible = false
		tween(chevron, DROPDOWN_ROTATE_TIME, { Rotation = 0 })
		local shrink = tween(panel, DROPDOWN_ROTATE_TIME, { Size = UDim2.fromOffset(panelWidth, 0) })
		shrink.Completed:Connect(function()
			if not isOpen then panel.Visible = false end
		end)
	end

	local function openPanel()
		positionPanel()
		isOpen = true
		backdrop.Visible = true
		panel.Visible = true
		tween(chevron, DROPDOWN_ROTATE_TIME, { Rotation = DROPDOWN_OPEN_ROTATION })
		tween(panel, DROPDOWN_ROTATE_TIME, { Size = UDim2.fromOffset(panelWidth, fullPanelHeight) })
	end

	box.MouseButton1Click:Connect(function()
		if isOpen then closePanel() else openPanel() end
	end)
	backdrop.MouseButton1Click:Connect(closePanel)

	if options then
		for i, optionText in ipairs(options) do
			local optionButton = Instance.new("TextButton")
			optionButton.Name = "Option" .. i
			optionButton.Size = UDim2.new(1, 0, 0, DROPDOWN_OPTION_HEIGHT)
			optionButton.BackgroundColor3 = DROPDOWN_OPTION_COLOR
			optionButton.AutoButtonColor = false
			optionButton.SelectionImageObject = nil
			optionButton.Text = ""
			optionButton.LayoutOrder = i
			optionButton.ZIndex = 101
			optionButton.Parent = panelInner

			local cornerPatches = {}
			if i == 1 then applyEdgeRounding(optionButton, panelInnerCorner.CornerRadius, "top", DROPDOWN_OPTION_COLOR) end
			if i == #options then applyEdgeRounding(optionButton, panelInnerCorner.CornerRadius, "bottom", DROPDOWN_OPTION_COLOR) end
			for _, child in ipairs(optionButton:GetChildren()) do
				if child.Name == "CornerSquarePatch" then table.insert(cornerPatches, child) end
			end

			if i < #options then
				local optionDivider = Instance.new("Frame")
				optionDivider.Name = "Divider"
				optionDivider.AnchorPoint = Vector2.new(0, 1)
				optionDivider.Position = UDim2.new(0, 0, 1, 0)
				optionDivider.Size = UDim2.new(1, 0, 0, 1)
				optionDivider.BackgroundColor3 = DROPDOWN_OPTION_DIVIDER_COLOR
				optionDivider.BorderSizePixel = 0
				optionDivider.ZIndex = 102
				optionDivider.Parent = optionButton
			end

			local checkbox = Instance.new("Frame")
			checkbox.Name = "Checkbox"
			checkbox.AnchorPoint = Vector2.new(0, 0.5)
			checkbox.Position = UDim2.new(0, 10, 0.5, 0)
			checkbox.Size = MULTI_DROPDOWN_CHECK_SIZE
			checkbox.BackgroundColor3 = DROPDOWN_OPTION_COLOR
			checkbox.ZIndex = 102
			checkbox.Parent = optionButton

			local checkboxCorner = Instance.new("UICorner")
			checkboxCorner.CornerRadius = UDim.new(0, 4)
			checkboxCorner.Parent = checkbox

			local checkboxStroke = Instance.new("UIStroke")
			checkboxStroke.Color = MULTI_DROPDOWN_CHECK_BORDER_COLOR
			checkboxStroke.Thickness = 1.5
			checkboxStroke.Parent = checkbox

			local checkFill = Instance.new("Frame")
			checkFill.Name = "Fill"
			checkFill.AnchorPoint = Vector2.new(0.5, 0.5)
			checkFill.Position = UDim2.fromScale(0.5, 0.5)
			checkFill.Size = UDim2.new(1, -6, 1, -6)
			checkFill.BackgroundColor3 = MULTI_DROPDOWN_CHECK_COLOR
			checkFill.BackgroundTransparency = selected[optionText] and 0 or 1
			checkFill.ZIndex = 103
			checkFill.Parent = checkbox

			local checkFillCorner = Instance.new("UICorner")
			checkFillCorner.CornerRadius = UDim.new(0, 2)
			checkFillCorner.Parent = checkFill

			local optionLabel = Instance.new("TextLabel")
			optionLabel.Name = "Label"
			optionLabel.AnchorPoint = Vector2.new(0, 0.5)
			optionLabel.Position = UDim2.new(0, 10 + MULTI_DROPDOWN_CHECK_SIZE.X.Offset + 8, 0.5, 0)
			optionLabel.Size = UDim2.new(1, -(10 + MULTI_DROPDOWN_CHECK_SIZE.X.Offset + 18), 1, 0)
			optionLabel.BackgroundTransparency = 1
			optionLabel.Text = optionText
			optionLabel.Font = Enum.Font.Gotham
			optionLabel.TextSize = DROPDOWN_OPTION_TEXT_SIZE
			optionLabel.TextColor3 = DROPDOWN_OPTION_TEXT_COLOR
			optionLabel.TextXAlignment = Enum.TextXAlignment.Left
			optionLabel.TextTruncate = Enum.TextTruncate.AtEnd
			optionLabel.ZIndex = 102
			optionLabel.Parent = optionButton

			optionButton.MouseEnter:Connect(function()
				tween(optionButton, 0.1, { BackgroundColor3 = DROPDOWN_OPTION_HOVER_COLOR })
				for _, patch in ipairs(cornerPatches) do tween(patch, 0.1, { BackgroundColor3 = DROPDOWN_OPTION_HOVER_COLOR }) end
			end)
			optionButton.MouseLeave:Connect(function()
				tween(optionButton, 0.1, { BackgroundColor3 = DROPDOWN_OPTION_COLOR })
				for _, patch in ipairs(cornerPatches) do tween(patch, 0.1, { BackgroundColor3 = DROPDOWN_OPTION_COLOR }) end
			end)

			optionButton.MouseButton1Click:Connect(function()
				selected[optionText] = not selected[optionText] or nil
				tween(checkFill, 0.12, { BackgroundTransparency = selected[optionText] and 0 or 1 })
				valueLabel.Text = summaryText()
				if onChanged then
					local list = {}
					for opt in pairs(selected) do table.insert(list, opt) end
					onChanged(list)
				end
			end)
		end
	end

	if currentFrame then
		currentFrame:GetPropertyChangedSignal("Position"):Connect(function()
			if isOpen then positionPanel() end
		end)
	end

	return row, bar
end

local function createSliderRow(name, description, layoutOrder, min, max, default, step, onChanged, parentFrame)
	min = min or 0
	max = max or 100
	step = step or 1
	local value = default or min

	local row = createRowBase(name, description, layoutOrder, parentFrame)

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Name = "ValueLabel"
	valueLabel.AnchorPoint = Vector2.new(1, 0.5)
	valueLabel.Position = UDim2.new(1, -ROW_TEXT_PADDING, 0.5, 0)
	valueLabel.Size = UDim2.fromOffset(SLIDER_VALUE_WIDTH, 18)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(value)
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.TextSize = SLIDER_VALUE_TEXT_SIZE
	valueLabel.TextColor3 = SLIDER_VALUE_TEXT_COLOR
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.ZIndex = 5
	valueLabel.Parent = row

	local plusButton = Instance.new("TextButton")
	plusButton.Name = "Plus"
	plusButton.AnchorPoint = Vector2.new(1, 0.5)
	plusButton.Position = UDim2.new(1, -ROW_TEXT_PADDING - SLIDER_VALUE_WIDTH - SLIDER_GAP, 0.5, 0)
	plusButton.Size = SLIDER_BUTTON_SIZE
	plusButton.BackgroundColor3 = SLIDER_BUTTON_COLOR
	plusButton.AutoButtonColor = false
	plusButton.Text = "+"
	plusButton.Font = Enum.Font.GothamBold
	plusButton.TextSize = 14
	plusButton.TextColor3 = SLIDER_BUTTON_TEXT_COLOR
	plusButton.ZIndex = 5
	plusButton.Parent = row

	local plusCorner = Instance.new("UICorner")
	plusCorner.CornerRadius = SLIDER_BUTTON_CORNER
	plusCorner.Parent = plusButton

	local track = Instance.new("Frame")
	track.Name = "Track"
	track.AnchorPoint = Vector2.new(1, 0.5)
	track.Position = UDim2.new(1, -ROW_TEXT_PADDING - SLIDER_VALUE_WIDTH - SLIDER_GAP - SLIDER_BUTTON_SIZE.X.Offset - SLIDER_GAP, 0.5, 0)
	track.Size = UDim2.fromOffset(SLIDER_TRACK_WIDTH, SLIDER_TRACK_HEIGHT)
	track.BackgroundColor3 = SLIDER_TRACK_COLOR
	track.BorderSizePixel = 0
	track.ZIndex = 5
	track.Parent = row

	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(1, 0)
	trackCorner.Parent = track

	local minusButton = Instance.new("TextButton")
	minusButton.Name = "Minus"
	minusButton.AnchorPoint = Vector2.new(1, 0.5)
	minusButton.Position = UDim2.new(0, -SLIDER_GAP, 0.5, 0)
	minusButton.Size = SLIDER_BUTTON_SIZE
	minusButton.BackgroundColor3 = SLIDER_BUTTON_COLOR
	minusButton.AutoButtonColor = false
	minusButton.Text = "-"
	minusButton.Font = Enum.Font.GothamBold
	minusButton.TextSize = 14
	minusButton.TextColor3 = SLIDER_BUTTON_TEXT_COLOR
	minusButton.ZIndex = 5
	minusButton.Parent = track

	local minusCorner = Instance.new("UICorner")
	minusCorner.CornerRadius = SLIDER_BUTTON_CORNER
	minusCorner.Parent = minusButton

	for _, btn in ipairs({ minusButton, plusButton }) do
		btn.MouseEnter:Connect(function() tween(btn, 0.1, { BackgroundColor3 = SLIDER_BUTTON_HOVER_COLOR }) end)
		btn.MouseLeave:Connect(function() tween(btn, 0.1, { BackgroundColor3 = SLIDER_BUTTON_COLOR }) end)
	end

	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.AnchorPoint = Vector2.new(0, 0.5)
	fill.Position = UDim2.new(0, 0, 0.5, 0)
	fill.Size = UDim2.new(0, 0, 1, 0)
	fill.BackgroundColor3 = SLIDER_FILL_COLOR
	fill.BorderSizePixel = 0
	fill.ZIndex = 6
	fill.Parent = track

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = fill

	local hitArea = Instance.new("TextButton")
	hitArea.Name = "HitArea"
	hitArea.AnchorPoint = Vector2.new(0.5, 0.5)
	hitArea.Position = UDim2.fromScale(0.5, 0.5)
	hitArea.Size = UDim2.new(1, 0, 0, 24)
	hitArea.BackgroundTransparency = 1
	hitArea.AutoButtonColor = false
	hitArea.Text = ""
	hitArea.ZIndex = 7
	hitArea.Parent = track

	local function setValue(newValue, fire)
		newValue = math.clamp(newValue, min, max)
		newValue = min + math.round((newValue - min) / step) * step
		newValue = math.clamp(newValue, min, max)
		value = newValue
		local alpha = (max > min) and ((value - min) / (max - min)) or 0
		fill.Size = UDim2.new(alpha, 0, 1, 0)
		valueLabel.Text = tostring(value)
		if fire and onChanged then onChanged(value) end
	end

	setValue(value, false)

	minusButton.MouseButton1Click:Connect(function() setValue(value - step, true) end)
	plusButton.MouseButton1Click:Connect(function() setValue(value + step, true) end)

	local draggingSlider = false

	local function updateFromInputPosition(inputPos)
		local trackAbsPos = track.AbsolutePosition
		local trackAbsSize = track.AbsoluteSize
		local relativeX = (inputPos.X - trackAbsPos.X) / trackAbsSize.X
		relativeX = math.clamp(relativeX, 0, 1)
		local newValue = min + relativeX * (max - min)
		setValue(newValue, true)
	end

	hitArea.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSlider = true
			updateFromInputPosition(input.Position)
		end
	end)

	hitArea.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSlider = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not draggingSlider then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			updateFromInputPosition(input.Position)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSlider = false
		end
	end)

	return row, track
end

local function createInputRow(name, description, layoutOrder, placeholder, default, onChanged, parentFrame)
	local row = createRowBase(name, description, layoutOrder, parentFrame)

	local box = Instance.new("Frame")
	box.Name = "InputBox"
	box.AnchorPoint = Vector2.new(1, 0.5)
	box.Position = UDim2.new(1, -ROW_TEXT_PADDING, 0.5, 0)
	box.Size = INPUT_BOX_SIZE
	box.BackgroundColor3 = INPUT_BOX_COLOR
	box.ZIndex = 5
	box.Parent = row

	local boxCorner = Instance.new("UICorner")
	boxCorner.CornerRadius = INPUT_BOX_CORNER
	boxCorner.Parent = box

	local boxStroke = Instance.new("UIStroke")
	boxStroke.Color = INPUT_BOX_BORDER_COLOR
	boxStroke.Thickness = 1
	boxStroke.Parent = box

	local penIcon = Instance.new("ImageLabel")
	penIcon.Name = "PenIcon"
	penIcon.AnchorPoint = Vector2.new(1, 0.5)
	penIcon.Position = UDim2.new(1, -8, 0.5, 0)
	penIcon.Size = UDim2.fromOffset(12, 12)
	penIcon.BackgroundTransparency = 1
	penIcon.Image = "rbxassetid://119122808711052"
	penIcon.ImageColor3 = INPUT_PLACEHOLDER_COLOR
	penIcon.ScaleType = Enum.ScaleType.Fit
	penIcon.ZIndex = 6
	penIcon.Parent = box

	local textBox = Instance.new("TextBox")
	textBox.Name = "TextBox"
	textBox.AnchorPoint = Vector2.new(0, 0.5)
	textBox.Position = UDim2.new(0, 10, 0.5, 0)
	textBox.Size = UDim2.new(1, -30, 1, 0)
	textBox.BackgroundTransparency = 1
	textBox.Text = default or ""
	textBox.PlaceholderText = placeholder or ""
	textBox.PlaceholderColor3 = INPUT_PLACEHOLDER_COLOR
	textBox.Font = Enum.Font.Gotham
	textBox.TextSize = INPUT_TEXT_SIZE
	textBox.TextColor3 = INPUT_TEXT_COLOR
	textBox.TextXAlignment = Enum.TextXAlignment.Left
	textBox.ClearTextOnFocus = false
	textBox.ZIndex = 6
	textBox.Parent = box

	textBox.Focused:Connect(function() tween(boxStroke, 0.12, { Color = INPUT_BOX_FOCUSED_BORDER_COLOR }) end)
	textBox.FocusLost:Connect(function(enterPressed)
		tween(boxStroke, 0.12, { Color = INPUT_BOX_BORDER_COLOR })
		if onChanged then onChanged(textBox.Text, enterPressed) end
	end)

	return row, textBox
end

local function createColorPickerRow(name, description, layoutOrder, defaultColor, onChanged, parentFrame)
	local row = createRowBase(name, description, layoutOrder, parentFrame)
	local currentColor = defaultColor or Color3.fromRGB(0, 0, 255)
	local h, s, v = Color3.toHSV(currentColor)
	local isOpen = false

	local swatch = Instance.new("TextButton")
	swatch.Name = "Swatch"
	swatch.AnchorPoint = Vector2.new(1, 0.5)
	swatch.Position = UDim2.new(1, -ROW_TEXT_PADDING, 0.5, 0)
	swatch.Size = COLORPICKER_SWATCH_SIZE
	swatch.BackgroundColor3 = currentColor
	swatch.AutoButtonColor = false
	swatch.Text = ""
	swatch.ZIndex = 5
	swatch.Parent = row

	local swatchCorner = Instance.new("UICorner")
	swatchCorner.CornerRadius = COLORPICKER_SWATCH_CORNER
	swatchCorner.Parent = swatch

	local swatchStroke = Instance.new("UIStroke")
	swatchStroke.Color = COLORPICKER_SWATCH_BORDER_COLOR
	swatchStroke.Thickness = 1
	swatchStroke.Parent = swatch

	local panel = Instance.new("Frame")
	panel.Name = "ColorPickerPanel"
	panel.Size = UDim2.fromOffset(COLORPICKER_PANEL_WIDTH, 0)
	panel.BackgroundColor3 = COLORPICKER_PANEL_COLOR
	panel.BorderSizePixel = 0
	panel.ClipsDescendants = true
	panel.Visible = false
	panel.ZIndex = 100
	panel.Parent = screenGui

	local panelCorner = Instance.new("UICorner")
	panelCorner.CornerRadius = COLORPICKER_PANEL_CORNER
	panelCorner.Parent = panel

	local panelStroke = Instance.new("UIStroke")
	panelStroke.Color = COLORPICKER_PANEL_BORDER_COLOR
	panelStroke.Thickness = 1
	panelStroke.Parent = panel

	local panelPadding = Instance.new("UIPadding")
	panelPadding.PaddingLeft = UDim.new(0, COLORPICKER_PANEL_PADDING)
	panelPadding.PaddingRight = UDim.new(0, COLORPICKER_PANEL_PADDING)
	panelPadding.PaddingTop = UDim.new(0, COLORPICKER_PANEL_PADDING)
	panelPadding.PaddingBottom = UDim.new(0, COLORPICKER_PANEL_PADDING)
	panelPadding.Parent = panel

	local pickerRow = Instance.new("Frame")
	pickerRow.Name = "PickerRow"
	pickerRow.Size = UDim2.new(1, 0, 0, COLORPICKER_SV_SIZE.Y.Offset)
	pickerRow.BackgroundTransparency = 1
	pickerRow.ZIndex = 101
	pickerRow.Parent = panel

	local svSquare = Instance.new("ImageButton")
	svSquare.Name = "SVSquare"
	svSquare.AnchorPoint = Vector2.new(0, 0)
	svSquare.Position = UDim2.fromOffset(0, 0)
	svSquare.Size = COLORPICKER_SV_SIZE
	svSquare.AutoButtonColor = false
	svSquare.Image = ""
	svSquare.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
	svSquare.ZIndex = 101
	svSquare.Parent = pickerRow

	local svCorner = Instance.new("UICorner")
	svCorner.CornerRadius = UDim.new(0, 8)
	svCorner.Parent = svSquare

	local svWhiteGradient = Instance.new("Frame")
	svWhiteGradient.Name = "WhiteGradient"
	svWhiteGradient.Size = UDim2.fromScale(1, 1)
	svWhiteGradient.BackgroundColor3 = Color3.new(1, 1, 1)
	svWhiteGradient.BorderSizePixel = 0
	svWhiteGradient.ZIndex = 101
	svWhiteGradient.Parent = svSquare

	local svWhiteGradientUI = Instance.new("UIGradient")
	svWhiteGradientUI.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(1, 1, 1))
	svWhiteGradientUI.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
	svWhiteGradientUI.Parent = svWhiteGradient

	local svWhiteCorner = Instance.new("UICorner")
	svWhiteCorner.CornerRadius = UDim.new(0, 8)
	svWhiteCorner.Parent = svWhiteGradient

	local svBlackGradient = Instance.new("Frame")
	svBlackGradient.Name = "BlackGradient"
	svBlackGradient.Size = UDim2.fromScale(1, 1)
	svBlackGradient.BackgroundColor3 = Color3.new(0, 0, 0)
	svBlackGradient.BorderSizePixel = 0
	svBlackGradient.ZIndex = 102
	svBlackGradient.Parent = svSquare

	local svBlackGradientUI = Instance.new("UIGradient")
	svBlackGradientUI.Rotation = 90
	svBlackGradientUI.Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(0, 0, 0))
	svBlackGradientUI.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
	svBlackGradientUI.Parent = svBlackGradient

	local svBlackCorner = Instance.new("UICorner")
	svBlackCorner.CornerRadius = UDim.new(0, 8)
	svBlackCorner.Parent = svBlackGradient

	local svCursor = Instance.new("Frame")
	svCursor.Name = "Cursor"
	svCursor.AnchorPoint = Vector2.new(0.5, 0.5)
	svCursor.Size = COLORPICKER_CURSOR_SIZE
	svCursor.BackgroundTransparency = 1
	svCursor.ZIndex = 103
	svCursor.Parent = svSquare

	local svCursorCorner = Instance.new("UICorner")
	svCursorCorner.CornerRadius = UDim.new(1, 0)
	svCursorCorner.Parent = svCursor

	local svCursorStroke = Instance.new("UIStroke")
	svCursorStroke.Color = Color3.new(1, 1, 1)
	svCursorStroke.Thickness = 2
	svCursorStroke.Parent = svCursor

	local hueStrip = Instance.new("ImageButton")
	hueStrip.Name = "HueStrip"
	hueStrip.AnchorPoint = Vector2.new(1, 0)
	hueStrip.Position = UDim2.new(1, 0, 0, 0)
	hueStrip.Size = UDim2.fromOffset(COLORPICKER_HUE_WIDTH, COLORPICKER_SV_SIZE.Y.Offset)
	hueStrip.AutoButtonColor = false
	hueStrip.Image = ""
	hueStrip.BackgroundColor3 = Color3.new(1, 1, 1)
	hueStrip.ZIndex = 101
	hueStrip.Parent = pickerRow

	local hueCorner = Instance.new("UICorner")
	hueCorner.CornerRadius = UDim.new(0, 6)
	hueCorner.Parent = hueStrip

	local hueGradient = Instance.new("UIGradient")
	hueGradient.Rotation = 90
	hueGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.000, Color3.fromHSV(0.000, 1, 1)),
		ColorSequenceKeypoint.new(0.167, Color3.fromHSV(0.167, 1, 1)),
		ColorSequenceKeypoint.new(0.333, Color3.fromHSV(0.333, 1, 1)),
		ColorSequenceKeypoint.new(0.500, Color3.fromHSV(0.500, 1, 1)),
		ColorSequenceKeypoint.new(0.667, Color3.fromHSV(0.667, 1, 1)),
		ColorSequenceKeypoint.new(0.833, Color3.fromHSV(0.833, 1, 1)),
		ColorSequenceKeypoint.new(1.000, Color3.fromHSV(1.000, 1, 1)),
	})
	hueGradient.Parent = hueStrip

	local hueCursor = Instance.new("Frame")
	hueCursor.Name = "Cursor"
	hueCursor.AnchorPoint = Vector2.new(0.5, 0.5)
	hueCursor.Size = UDim2.new(1, 4, 0, 4)
	hueCursor.BackgroundColor3 = Color3.new(1, 1, 1)
	hueCursor.BorderSizePixel = 0
	hueCursor.ZIndex = 103
	hueCursor.Parent = hueStrip

	local hueCursorCorner = Instance.new("UICorner")
	hueCursorCorner.CornerRadius = UDim.new(1, 0)
	hueCursorCorner.Parent = hueCursor

	local rgbRow = Instance.new("Frame")
	rgbRow.Name = "RGBRow"
	rgbRow.Size = UDim2.new(1, 0, 0, 24)
	rgbRow.Position = UDim2.new(0, 0, 0, COLORPICKER_SV_SIZE.Y.Offset + 10)
	rgbRow.BackgroundTransparency = 1
	rgbRow.ZIndex = 101
	rgbRow.Parent = panel

	local previewSwatch = Instance.new("Frame")
	previewSwatch.Name = "Preview"
	previewSwatch.AnchorPoint = Vector2.new(0, 0.5)
	previewSwatch.Position = UDim2.new(0, 0, 0.5, 0)
	previewSwatch.Size = UDim2.fromOffset(24, 24)
	previewSwatch.BackgroundColor3 = currentColor
	previewSwatch.ZIndex = 101
	previewSwatch.Parent = rgbRow

	local previewCorner = Instance.new("UICorner")
	previewCorner.CornerRadius = UDim.new(0, 6)
	previewCorner.Parent = previewSwatch

	local rgbLabel = Instance.new("TextLabel")
	rgbLabel.Name = "RGBLabel"
	rgbLabel.AnchorPoint = Vector2.new(0, 0.5)
	rgbLabel.Position = UDim2.new(0, 32, 0.5, 0)
	rgbLabel.Size = UDim2.new(1, -32, 1, 0)
	rgbLabel.BackgroundTransparency = 1
	rgbLabel.Text = string.format("%d, %d, %d", math.floor(currentColor.R * 255 + 0.5), math.floor(currentColor.G * 255 + 0.5), math.floor(currentColor.B * 255 + 0.5))
	rgbLabel.Font = Enum.Font.Gotham
	rgbLabel.TextSize = 12
	rgbLabel.TextColor3 = Color3.fromRGB(200, 200, 205)
	rgbLabel.TextXAlignment = Enum.TextXAlignment.Left
	rgbLabel.ZIndex = 101
	rgbLabel.Parent = rgbRow

	local panelWidth = COLORPICKER_PANEL_WIDTH
	local fullPanelHeight = COLORPICKER_PANEL_PADDING * 2 + COLORPICKER_SV_SIZE.Y.Offset + 10 + 24

	local function updateCursors()
		svCursor.Position = UDim2.new(s, 0, 1 - v, 0)
		hueCursor.Position = UDim2.new(0.5, 0, h, 0)
		svSquare.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
	end

	local function applyColor(fire)
		currentColor = Color3.fromHSV(h, s, v)
		swatch.BackgroundColor3 = currentColor
		previewSwatch.BackgroundColor3 = currentColor
		rgbLabel.Text = string.format("%d, %d, %d", math.floor(currentColor.R * 255 + 0.5), math.floor(currentColor.G * 255 + 0.5), math.floor(currentColor.B * 255 + 0.5))
		if fire and onChanged then onChanged(currentColor) end
	end

	updateCursors()

	local function positionPanel()
		local swatchAbsPos = swatch.AbsolutePosition
		local swatchAbsSize = swatch.AbsoluteSize
		panel.Position = UDim2.fromOffset(swatchAbsPos.X + swatchAbsSize.X - panelWidth, swatchAbsPos.Y + swatchAbsSize.Y + DROPDOWN_PANEL_PADDING)
		panel.Size = UDim2.fromOffset(panelWidth, 0)
	end

	local function closePanel()
		isOpen = false
		local shrink = tween(panel, DROPDOWN_ROTATE_TIME, { Size = UDim2.fromOffset(panelWidth, 0) })
		shrink.Completed:Connect(function()
			if not isOpen then panel.Visible = false end
		end)
	end

	local function openPanel()
		positionPanel()
		isOpen = true
		panel.Visible = true
		tween(panel, DROPDOWN_ROTATE_TIME, { Size = UDim2.fromOffset(panelWidth, fullPanelHeight) })
	end

	swatch.MouseButton1Click:Connect(function()
		if isOpen then closePanel() else openPanel() end
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not isOpen then return end
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local inputPos = Vector2.new(input.Position.X, input.Position.Y)
		local panelPos = panel.AbsolutePosition
		local panelSize = panel.AbsoluteSize
		local swatchPos = swatch.AbsolutePosition
		local swatchSize = swatch.AbsoluteSize
		local insidePanel = inputPos.X >= panelPos.X and inputPos.X <= panelPos.X + panelSize.X and inputPos.Y >= panelPos.Y and inputPos.Y <= panelPos.Y + panelSize.Y
		local insideSwatch = inputPos.X >= swatchPos.X and inputPos.X <= swatchPos.X + swatchSize.X and inputPos.Y >= swatchPos.Y and inputPos.Y <= swatchPos.Y + swatchSize.Y
		if not insidePanel and not insideSwatch then closePanel() end
	end)

	local draggingSV = false
	local function updateSVFromInput(inputPos)
		local absPos = svSquare.AbsolutePosition
		local absSize = svSquare.AbsoluteSize
		local relX = math.clamp((inputPos.X - absPos.X) / absSize.X, 0, 1)
		local relY = math.clamp((inputPos.Y - absPos.Y) / absSize.Y, 0, 1)
		s = relX
		v = 1 - relY
		svCursor.Position = UDim2.new(s, 0, 1 - v, 0)
		applyColor(true)
	end

	svSquare.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSV = true
			updateSVFromInput(Vector2.new(input.Position.X, input.Position.Y))
		end
	end)

	svSquare.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSV = false end
	end)

	local draggingHue = false
	local function updateHueFromInput(inputPos)
		local absPos = hueStrip.AbsolutePosition
		local absSize = hueStrip.AbsoluteSize
		local relY = math.clamp((inputPos.Y - absPos.Y) / absSize.Y, 0, 1)
		h = relY
		hueCursor.Position = UDim2.new(0.5, 0, h, 0)
		svSquare.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
		applyColor(true)
	end

	hueStrip.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingHue = true
			updateHueFromInput(Vector2.new(input.Position.X, input.Position.Y))
		end
	end)

	hueStrip.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingHue = false end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local inputPos = Vector2.new(input.Position.X, input.Position.Y)
		if draggingSV then updateSVFromInput(inputPos)
		elseif draggingHue then updateHueFromInput(inputPos) end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSV = false
			draggingHue = false
		end
	end)

	if currentFrame then
		currentFrame:GetPropertyChangedSignal("Position"):Connect(function()
			if isOpen then positionPanel() end
		end)
	end

	return row, swatch
end

local function createSection(title, icon, layoutOrder, startOpen, parentFrame)
	local isOpen = startOpen ~= false

	local section = Instance.new("Frame")
	section.Name = title .. "Section"
	section.Size = UDim2.new(1, 0, 0, 0)
	section.AutomaticSize = Enum.AutomaticSize.Y
	section.BackgroundTransparency = 1
	section.LayoutOrder = layoutOrder
	section.ZIndex = 4
	section.Parent = parentFrame

	local panel = Instance.new("Frame")
	panel.Name = "Panel"
	panel.Size = UDim2.new(1, 0, 0, 0)
	panel.AutomaticSize = Enum.AutomaticSize.Y
	panel.BackgroundTransparency = 1
	panel.ClipsDescendants = true
	panel.ZIndex = 4
	panel.Parent = section

	local panelCorner = Instance.new("UICorner")
	panelCorner.CornerRadius = SECTION_CORNER
	panelCorner.Parent = panel

	local panelLayout = Instance.new("UIListLayout")
	panelLayout.FillDirection = Enum.FillDirection.Vertical
	panelLayout.SortOrder = Enum.SortOrder.LayoutOrder
	panelLayout.Parent = panel

	local header = Instance.new("TextButton")
	header.Name = "Header"
	header.Size = UDim2.new(1, 0, 0, SECTION_HEADER_HEIGHT)
	header.BackgroundTransparency = 1
	header.AutoButtonColor = false
	header.Text = ""
	header.LayoutOrder = 1
	header.ZIndex = 5
	header.Parent = panel

	local headerIcon = Instance.new("ImageLabel")
	headerIcon.Name = "Icon"
	headerIcon.AnchorPoint = Vector2.new(0, 0.5)
	headerIcon.Position = UDim2.new(0, ROW_TEXT_PADDING, 0.5, 0)
	headerIcon.Size = SECTION_ICON_SIZE
	headerIcon.BackgroundTransparency = 1
	headerIcon.Image = icon or ""
	headerIcon.ImageColor3 = SECTION_TITLE_COLOR
	headerIcon.ScaleType = Enum.ScaleType.Fit
	headerIcon.ZIndex = 6
	headerIcon.Parent = header

	local headerTitle = Instance.new("TextLabel")
	headerTitle.Name = "Title"
	headerTitle.AnchorPoint = Vector2.new(0, 0.5)
	headerTitle.Position = UDim2.new(0, ROW_TEXT_PADDING + SECTION_ICON_SIZE.X.Offset + 10, 0.5, 0)
	headerTitle.Size = UDim2.new(1, -100, 1, 0)
	headerTitle.BackgroundTransparency = 1
	headerTitle.Text = title
	headerTitle.Font = Enum.Font.GothamBold
	headerTitle.TextSize = SECTION_TITLE_SIZE
	headerTitle.TextColor3 = SECTION_TITLE_COLOR
	headerTitle.TextXAlignment = Enum.TextXAlignment.Left
	headerTitle.ZIndex = 6
	headerTitle.Parent = header

	local chevron = Instance.new("ImageLabel")
	chevron.Name = "Chevron"
	chevron.AnchorPoint = Vector2.new(1, 0.5)
	chevron.Position = UDim2.new(1, -ROW_TEXT_PADDING, 0.5, 0)
	chevron.Size = SECTION_CHEVRON_SIZE
	chevron.BackgroundTransparency = 1
	chevron.Image = SECTION_CHEVRON_ICON
	chevron.ImageColor3 = SECTION_CHEVRON_COLOR
	chevron.Rotation = isOpen and SECTION_OPEN_ROTATION or 0
	chevron.ZIndex = 6
	chevron.Parent = header

	local clipper = Instance.new("Frame")
	clipper.Name = "Clipper"
	clipper.Size = UDim2.new(1, 0, 0, 0)
	clipper.BackgroundTransparency = 1
	clipper.ClipsDescendants = true
	clipper.LayoutOrder = 3
	clipper.ZIndex = 5
	clipper.Parent = panel

	local body = Instance.new("Frame")
	body.Name = "Body"
	body.Size = UDim2.new(1, 0, 0, 0)
	body.AutomaticSize = Enum.AutomaticSize.Y
	body.BackgroundTransparency = 1
	body.ZIndex = 5
	body.Parent = clipper

	local bodyPadding = Instance.new("UIPadding")
	bodyPadding.PaddingLeft = UDim.new(0, SECTION_BODY_PADDING)
	bodyPadding.PaddingRight = UDim.new(0, SECTION_BODY_PADDING)
	bodyPadding.PaddingBottom = UDim.new(0, SECTION_BODY_PADDING)
	bodyPadding.Parent = body

	local bodyLayout = Instance.new("UIListLayout")
	bodyLayout.FillDirection = Enum.FillDirection.Vertical
	bodyLayout.SortOrder = Enum.SortOrder.LayoutOrder
	bodyLayout.Parent = body

	body:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if isOpen then clipper.Size = UDim2.new(1, 0, 0, body.AbsoluteSize.Y) end
	end)

	clipper.Size = UDim2.new(1, 0, 0, isOpen and body.AbsoluteSize.Y or 0)

	local function toggle()
		isOpen = not isOpen
		tween(chevron, SECTION_ROTATE_TIME, { Rotation = isOpen and SECTION_OPEN_ROTATION or 0 })
		tween(clipper, SECTION_ROTATE_TIME, { Size = UDim2.new(1, 0, 0, isOpen and body.AbsoluteSize.Y or 0) }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	end

	header.MouseButton1Click:Connect(toggle)

	return section, body
end

local currentFrame = nil

Stellar.CreateWindow = function(config)
	local iconAsset = config.Icon or ICON_ASSET_ID
	local frameSize = config.Size or FRAME_SIZE
	local titleText = config.Title or "Title"
	local subtitleText = config.Subtitle or "Subtitle"

	local icon = Instance.new("ImageLabel")
	icon.Name = "SplashIcon"
	icon.AnchorPoint = Vector2.new(0.5, 0.5)
	icon.Position = UDim2.fromScale(0.5, 0.5)
	icon.Size = ICON_SIZE
	icon.BackgroundTransparency = 1
	icon.Image = iconAsset
	icon.ImageTransparency = 1
	icon.ZIndex = 3
	icon.Parent = screenGui

	local text = Instance.new("TextLabel")
	text.Name = "SplashText"
	text.AnchorPoint = Vector2.new(0.5, 0.5)
	text.Position = UDim2.fromScale(0.5, 0.5)
	text.Size = UDim2.fromOffset(220, 50)
	text.BackgroundTransparency = 1
	text.Text = "Stellar"
	text.Font = Enum.Font.GothamBold
	text.TextSize = 32
	text.TextColor3 = Color3.fromRGB(255, 255, 255)
	text.TextTransparency = 1
	text.ZIndex = 3
	text.Parent = screenGui

	local splashDone = false

	task.spawn(function()
		local fadeInTween = tween(icon, ICON_FADE_IN_TIME, { ImageTransparency = 0 })
		fadeInTween.Completed:Wait()
		task.wait(0.3)
		local slideTween = tween(icon, SLIDE_TIME, { Position = UDim2.new(0.5, -SLIDE_OFFSET, 0.5, 0) }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		slideTween.Completed:Wait()
		local textFadeIn = tween(text, TEXT_FADE_IN_TIME, { TextTransparency = 0 })
		textFadeIn.Completed:Wait()
		task.wait(HOLD_TIME)
		local iconFadeOut = tween(icon, FADE_OUT_TIME, { ImageTransparency = 1 })
		local textFadeOut = tween(text, FADE_OUT_TIME, { TextTransparency = 1 })
		iconFadeOut.Completed:Wait()
		icon:Destroy()
		text:Destroy()
		splashDone = true
	end)

	while not splashDone do task.wait() end

	local frame = Instance.new("Frame")
	frame.Name = "MainFrame"
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.fromScale(0.5, 0.5)
	frame.Size = frameSize
	frame.BackgroundColor3 = FRAME_COLOR
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.ClipsDescendants = true
	frame.ZIndex = 2
	frame.Parent = screenGui

	currentFrame = frame

	local frameCorner = Instance.new("UICorner")
	frameCorner.CornerRadius = FRAME_CORNER_RADIUS
	frameCorner.Parent = frame

	tween(frame, FRAME_FADE_IN_TIME, { BackgroundTransparency = 0 })
	notify("Stellar", "Interface loaded successfully.", 3)

	local header = Instance.new("Frame")
	header.Name = "Header"
	header.AnchorPoint = Vector2.new(0, 0)
	header.Position = UDim2.fromOffset(0, 0)
	header.Size = UDim2.new(1, 0, 0, HEADER_HEIGHT)
	header.BackgroundTransparency = 1
	header.ZIndex = 3
	header.Parent = frame

	local topDivider = Instance.new("Frame")
	topDivider.Name = "TopDivider"
	topDivider.AnchorPoint = Vector2.new(0, 1)
	topDivider.Position = UDim2.new(0, 0, 1, 0)
	topDivider.Size = UDim2.new(1, 0, 0, 1)
	topDivider.BackgroundColor3 = DIVIDER_COLOR
	topDivider.BorderSizePixel = 0
	topDivider.ZIndex = 4
	topDivider.Parent = header

	local logo = Instance.new("ImageLabel")
	logo.Name = "Logo"
	logo.AnchorPoint = Vector2.new(0.5, 0.5)
	logo.Position = UDim2.new(0, SIDEBAR_WIDTH / 2, 0.5, 0)
	logo.Size = LOGO_SIZE
	logo.BackgroundTransparency = 1
	logo.Image = iconAsset
	logo.ScaleType = Enum.ScaleType.Fit
	logo.ZIndex = 4
	logo.Parent = header

	local verticalDivider = Instance.new("Frame")
	verticalDivider.Name = "VerticalDivider"
	verticalDivider.AnchorPoint = Vector2.new(0, 0)
	verticalDivider.Position = UDim2.new(0, SIDEBAR_WIDTH, 0, 0)
	verticalDivider.Size = UDim2.new(0, 1, 1, 0)
	verticalDivider.BackgroundColor3 = DIVIDER_COLOR
	verticalDivider.BorderSizePixel = 0
	verticalDivider.ZIndex = 4
	verticalDivider.Parent = frame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.AnchorPoint = Vector2.new(0, 0)
	titleLabel.Position = UDim2.new(0, SIDEBAR_WIDTH + 14, 0, HEADER_PADDING - 4)
	titleLabel.Size = UDim2.fromOffset(280, 18)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = titleText
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = TITLE_SIZE
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.ZIndex = 4
	titleLabel.Parent = header

	local subtitleLabel = Instance.new("TextLabel")
	subtitleLabel.Name = "Subtitle"
	subtitleLabel.AnchorPoint = Vector2.new(0, 0)
	subtitleLabel.Position = UDim2.new(0, SIDEBAR_WIDTH + 14, 0, HEADER_PADDING + 14)
	subtitleLabel.Size = UDim2.fromOffset(280, 16)
	subtitleLabel.BackgroundTransparency = 1
	subtitleLabel.Text = subtitleText
	subtitleLabel.Font = Enum.Font.Gotham
	subtitleLabel.TextSize = SUBTITLE_SIZE
	subtitleLabel.TextColor3 = SUBTITLE_COLOR
	subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	subtitleLabel.ZIndex = 4
	subtitleLabel.Parent = header

	local windowControls = Instance.new("Frame")
	windowControls.Name = "WindowControls"
	windowControls.AnchorPoint = Vector2.new(1, 0.5)
	windowControls.Position = UDim2.new(1, -WINDOW_CONTROLS_PADDING, 0.5, 0)
	windowControls.Size = UDim2.fromOffset(WINDOW_BUTTON_SIZE.X.Offset * 2 + WINDOW_BUTTON_SPACING, WINDOW_BUTTON_SIZE.Y.Offset)
	windowControls.BackgroundTransparency = 1
	windowControls.ZIndex = 4
	windowControls.Parent = header

	local windowControlsList = Instance.new("UIListLayout")
	windowControlsList.FillDirection = Enum.FillDirection.Horizontal
	windowControlsList.SortOrder = Enum.SortOrder.LayoutOrder
	windowControlsList.Padding = UDim.new(0, WINDOW_BUTTON_SPACING)
	windowControlsList.VerticalAlignment = Enum.VerticalAlignment.Center
	windowControlsList.Parent = windowControls

	local function createWindowButton(iconId, layoutOrder)
		local btn = Instance.new("ImageButton")
		btn.Name = "WindowButton"
		btn.Size = WINDOW_BUTTON_SIZE
		btn.BackgroundTransparency = 1
		btn.LayoutOrder = layoutOrder
		btn.ZIndex = 5
		btn.Parent = windowControls

		local icon = Instance.new("ImageLabel")
		icon.Name = "Icon"
		icon.AnchorPoint = Vector2.new(0.5, 0.5)
		icon.Position = UDim2.fromScale(0.5, 0.5)
		icon.Size = WINDOW_BUTTON_ICON_SIZE
		icon.BackgroundTransparency = 1
		icon.Image = iconId
		icon.ImageColor3 = WINDOW_BUTTON_COLOR
		icon.ImageTransparency = WINDOW_BUTTON_IDLE_TRANSPARENCY
		icon.ScaleType = Enum.ScaleType.Fit
		icon.ZIndex = 6
		icon.Parent = btn

		btn.MouseEnter:Connect(function() tween(icon, 0.12, { ImageTransparency = WINDOW_BUTTON_HOVER_TRANSPARENCY }) end)
		btn.MouseLeave:Connect(function() tween(icon, 0.12, { ImageTransparency = WINDOW_BUTTON_IDLE_TRANSPARENCY }) end)

		return btn
	end

	local minimizeButton = createWindowButton(MINIMIZE_ICON, 1)
	local closeButton = createWindowButton(CLOSE_ICON, 2)

	local isMinimized = false
	local frameSizeBeforeMinimize = frameSize

	minimizeButton.MouseButton1Click:Connect(function()
		isMinimized = not isMinimized
		if isMinimized then
			frameSizeBeforeMinimize = frame.Size
			tween(topDivider, 0.15, { BackgroundTransparency = 1 })
			tween(frame, 0.25, { Size = UDim2.fromOffset(frame.Size.X.Offset, HEADER_HEIGHT) }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		else
			local restoreTween = tween(frame, 0.25, { Size = frameSizeBeforeMinimize }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			restoreTween.Completed:Connect(function()
				if not isMinimized then tween(topDivider, 0.15, { BackgroundTransparency = 0 }) end
			end)
		end
	end)

	closeButton.MouseButton1Click:Connect(function()
		local closeTween = tween(frame, 0.25, { BackgroundTransparency = 1 })
		tween(verticalDivider, 0.25, { BackgroundTransparency = 1 })
		closeTween.Completed:Connect(function()
			screenGui:Destroy()
		end)
	end)

	local content = Instance.new("Frame")
	content.Name = "Content"
	content.AnchorPoint = Vector2.new(0, 0)
	content.Position = UDim2.new(0, SIDEBAR_WIDTH + 1 + CONTENT_PADDING, 0, HEADER_HEIGHT + CONTENT_PADDING)
	content.Size = UDim2.new(1, -(SIDEBAR_WIDTH + 1 + CONTENT_PADDING * 2), 1, -(HEADER_HEIGHT + CONTENT_PADDING * 2))
	content.BackgroundColor3 = CONTENT_COLOR
	content.BackgroundTransparency = 1
	content.BorderSizePixel = 0
	content.ZIndex = 3
	content.Parent = frame

	local contentCorner = Instance.new("UICorner")
	contentCorner.CornerRadius = CONTENT_CORNER_RADIUS
	contentCorner.Parent = content

	tween(content, FRAME_FADE_IN_TIME, { BackgroundTransparency = 0 })

	local pages = {}
	local tabButtons = {}
	local tabStrip = Instance.new("Frame")
	tabStrip.Name = "TabStrip"
	tabStrip.AnchorPoint = Vector2.new(0, 0)
	tabStrip.Position = UDim2.new(0, 0, 0, HEADER_HEIGHT + TAB_STRIP_TOP_PADDING)
	tabStrip.Size = UDim2.new(0, SIDEBAR_WIDTH, 1, -(HEADER_HEIGHT + TAB_STRIP_TOP_PADDING))
	tabStrip.BackgroundTransparency = 1
	tabStrip.ZIndex = 3
	tabStrip.Parent = frame

	local function createPage(tabName, visible)
		local page = Instance.new("ScrollingFrame")
		page.Name = tabName .. "Page"
		page.Size = UDim2.fromScale(1, 1)
		page.BackgroundTransparency = 1
		page.BorderSizePixel = 0
		page.ZIndex = 3
		page.Visible = visible
		page.ScrollBarThickness = 3
		page.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
		page.ScrollBarImageTransparency = 1
		page.AutomaticCanvasSize = Enum.AutomaticSize.Y
		page.CanvasSize = UDim2.new(0, 0, 0, 0)
		page.Parent = content

		local pageList = Instance.new("UIListLayout")
		pageList.FillDirection = Enum.FillDirection.Vertical
		pageList.SortOrder = Enum.SortOrder.LayoutOrder
		pageList.Padding = UDim.new(0, ROW_SPACING)
		pageList.Parent = page

		pages[tabName] = page
		return page
	end

	local window = {}
	window.Config = config
	window.Frame = frame
	window.Content = content
	window.Pages = pages
	window.TabButtons = tabButtons

	function window:CreateTab(tabConfig)
		local tabName = tabConfig.Name or "Tab"
		local tabIcon = tabConfig.Icon or ICON_ASSET_ID
		local iconScale = tabConfig.IconScale or 1

		local page = createPage(tabName, #tabButtons == 0)

		local yPos = (#tabButtons) * (TAB_BUTTON_SIZE.Y.Offset + TAB_BUTTON_SPACING)

		local button = Instance.new("TextButton")
		button.Name = tabName .. "Tab"
		button.AnchorPoint = Vector2.new(0.5, 0)
		button.Position = UDim2.new(0, SIDEBAR_WIDTH / 2, 0, yPos)
		button.Size = TAB_BUTTON_SIZE
		button.BackgroundColor3 = TAB_ACTIVE_COLOR
		button.BackgroundTransparency = 1
		button.AutoButtonColor = false
		button.Text = ""
		button.ZIndex = 4
		button.Parent = tabStrip

		local buttonCorner = Instance.new("UICorner")
		buttonCorner.CornerRadius = TAB_CORNER_RADIUS
		buttonCorner.Parent = button

		local indicator = Instance.new("Frame")
		indicator.Name = "ActiveIndicator"
		indicator.AnchorPoint = Vector2.new(0, 0.5)
		indicator.Position = UDim2.new(0, -8, 0.5, 0)
		indicator.Size = UDim2.fromOffset(TAB_INDICATOR_WIDTH, TAB_INDICATOR_HEIGHT)
		indicator.BackgroundColor3 = TAB_ACTIVE_COLOR
		indicator.BackgroundTransparency = 1
		indicator.BorderSizePixel = 0
		indicator.ZIndex = 4
		indicator.Parent = button

		local indicatorCorner = Instance.new("UICorner")
		indicatorCorner.CornerRadius = UDim.new(1, 0)
		indicatorCorner.Parent = indicator

		local buttonIcon = Instance.new("ImageLabel")
		buttonIcon.Name = "Icon"
		buttonIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		buttonIcon.Position = UDim2.fromScale(0.5, 0.5)
		buttonIcon.Size = UDim2.fromOffset(TAB_BUTTON_ICON_SIZE.X.Offset * iconScale, TAB_BUTTON_ICON_SIZE.Y.Offset * iconScale)
		buttonIcon.BackgroundTransparency = 1
		buttonIcon.Image = tabIcon
		buttonIcon.ImageColor3 = TAB_IDLE_ICON_COLOR
		buttonIcon.ImageTransparency = TAB_IDLE_ICON_TRANSPARENCY
		buttonIcon.ScaleType = Enum.ScaleType.Fit
		buttonIcon.ZIndex = 5
		buttonIcon.Parent = button

		local tooltip = Instance.new("Frame")
		tooltip.Name = "Tooltip"
		tooltip.AnchorPoint = Vector2.new(0, 0.5)
		tooltip.Position = UDim2.new(1, 10, 0.5, 0)
		tooltip.AutomaticSize = Enum.AutomaticSize.X
		tooltip.Size = UDim2.fromOffset(0, 28)
		tooltip.BackgroundColor3 = TAB_TOOLTIP_COLOR
		tooltip.BackgroundTransparency = 1
		tooltip.BorderSizePixel = 0
		tooltip.ZIndex = 6
		tooltip.Visible = false
		tooltip.Parent = button

		local tooltipCorner = Instance.new("UICorner")
		tooltipCorner.CornerRadius = UDim.new(0, 6)
		tooltipCorner.Parent = tooltip

		local tooltipPadding = Instance.new("UIPadding")
		tooltipPadding.PaddingLeft = UDim.new(0, 12)
		tooltipPadding.PaddingRight = UDim.new(0, 12)
		tooltipPadding.Parent = tooltip

		local tooltipText = Instance.new("TextLabel")
		tooltipText.Name = "Label"
		tooltipText.AnchorPoint = Vector2.new(0, 0.5)
		tooltipText.Position = UDim2.fromScale(0, 0.5)
		tooltipText.AutomaticSize = Enum.AutomaticSize.X
		tooltipText.Size = UDim2.fromOffset(0, 28)
		tooltipText.BackgroundTransparency = 1
		tooltipText.Text = tabName
		tooltipText.Font = Enum.Font.GothamMedium
		tooltipText.TextSize = 13
		tooltipText.TextColor3 = TAB_TOOLTIP_TEXT_COLOR
		tooltipText.TextTransparency = 1
		tooltipText.ZIndex = 7
		tooltipText.Parent = tooltip

		local tabEntry = {
			button = button,
			indicator = indicator,
			icon = buttonIcon,
			active = false,
			page = page,
		}
		table.insert(tabButtons, tabEntry)

		local function setActive()
			for _, entry in ipairs(tabButtons) do
				local isThisOne = (entry == tabEntry)
				entry.active = isThisOne
				tween(entry.indicator, TAB_INDICATOR_FADE_TIME, { BackgroundTransparency = isThisOne and 0 or 1 })
				tween(entry.icon, TAB_INDICATOR_FADE_TIME, { ImageTransparency = isThisOne and 0 or TAB_IDLE_ICON_TRANSPARENCY, ImageColor3 = isThisOne and TAB_ACTIVE_COLOR or TAB_IDLE_ICON_COLOR })
				entry.page.Visible = isThisOne
			end
		end

		if #tabButtons == 1 then setActive() end

		local isHeld = false
		button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				isHeld = true
				tooltip.Visible = true
				tween(tooltip, TAB_TOOLTIP_FADE_TIME, { BackgroundTransparency = 0.05 })
				tween(tooltipText, TAB_TOOLTIP_FADE_TIME, { TextTransparency = 0 })
				tween(button, 0.15, { BackgroundTransparency = TAB_HOVER_BG_TRANSPARENCY })
			end
		end)

		local function release()
			if not isHeld then return end
			isHeld = false
			local fadeOut = tween(tooltip, TAB_TOOLTIP_FADE_TIME, { BackgroundTransparency = 1 })
			tween(tooltipText, TAB_TOOLTIP_FADE_TIME, { TextTransparency = 1 })
			tween(button, 0.15, { BackgroundTransparency = 1 })
			fadeOut.Completed:Wait()
			if not isHeld then tooltip.Visible = false end
		end

		button.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then task.spawn(release) end
		end)

		button.MouseLeave:Connect(function()
			if isHeld and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then task.spawn(release) end
		end)

		button.MouseButton1Click:Connect(setActive)

		local tab = {}
		tab.Name = tabName
		tab.Page = page
		tab.Button = button
		tab.LayoutOrder = 0

		function tab:CreateSection(sectionConfig)
			local sectionTitle = sectionConfig.Name or "Section"
			local sectionIcon = sectionConfig.Icon or ""
			local layoutOrder = self.LayoutOrder + 1
			self.LayoutOrder = layoutOrder
			local section = createSection(sectionTitle, sectionIcon, layoutOrder, sectionConfig.Open, page)
			return section
		end

		function tab:CreateLabel(labelConfig)
			local layoutOrder = self.LayoutOrder + 1
			self.LayoutOrder = layoutOrder
			createLabelRow(labelConfig.Text, layoutOrder, page)
		end

		function tab:CreateButton(buttonConfig)
			local layoutOrder = self.LayoutOrder + 1
			self.LayoutOrder = layoutOrder
			createButtonRow(buttonConfig.Name, buttonConfig.Description or "", layoutOrder, buttonConfig.Callback, page)
		end

		function tab:CreateToggle(toggleConfig)
			local layoutOrder = self.LayoutOrder + 1
			self.LayoutOrder = layoutOrder
			createToggleRow(toggleConfig.Name, toggleConfig.Description or "", layoutOrder, toggleConfig.Default or false, toggleConfig.Callback, page)
		end

		function tab:CreateDropdown(dropdownConfig)
			local layoutOrder = self.LayoutOrder + 1
			self.LayoutOrder = layoutOrder
			createDropdownRow(dropdownConfig.Name, dropdownConfig.Description or "", layoutOrder, dropdownConfig.Options, dropdownConfig.Default, dropdownConfig.Callback, page)
		end

		function tab:CreateMultiDropdown(multiConfig)
			local layoutOrder = self.LayoutOrder + 1
			self.LayoutOrder = layoutOrder
			createMultiDropdownRow(multiConfig.Name, multiConfig.Description or "", layoutOrder, multiConfig.Options, multiConfig.Default, multiConfig.Callback, page)
		end

		function tab:CreateSlider(sliderConfig)
			local layoutOrder = self.LayoutOrder + 1
			self.LayoutOrder = layoutOrder
			createSliderRow(sliderConfig.Name, sliderConfig.Description or "", layoutOrder, sliderConfig.Min or 0, sliderConfig.Max or 100, sliderConfig.Default or sliderConfig.Min, sliderConfig.Increment or 1, sliderConfig.Callback, page)
		end

		function tab:CreateColorPicker(colorConfig)
			local layoutOrder = self.LayoutOrder + 1
			self.LayoutOrder = layoutOrder
			createColorPickerRow(colorConfig.Name, colorConfig.Description or "", layoutOrder, colorConfig.Default or Color3.fromRGB(0, 0, 255), colorConfig.Callback, page)
		end

		function tab:CreateInput(inputConfig)
			local layoutOrder = self.LayoutOrder + 1
			self.LayoutOrder = layoutOrder
			createInputRow(inputConfig.Name, inputConfig.Description or "", layoutOrder, inputConfig.Placeholder or "", inputConfig.Default or "", inputConfig.Callback, page)
		end

		return tab
	end

	local dragging = false
	local dragInput
	local dragStart
	local startPos
	local DRAG_TWEEN_TIME = 0.08

	local function updateDrag(input)
		local delta = input.Position - dragStart
		local targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		tween(frame, DRAG_TWEEN_TIME, { Position = targetPos }, Enum.EasingStyle.Linear)
	end

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then updateDrag(input) end
	end)

	return window
end

return Stellar
