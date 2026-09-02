local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Stellar = {}
Stellar.__index = Stellar

local ICON_ASSET_ID = "rbxassetid://71984635708160"
local HEADER_HEIGHT = 56
local SIDEBAR_WIDTH = 60
local TAB_STRIP_TOP_PADDING = 18
local CONTENT_PADDING = 14
local ROW_HEIGHT = 56
local ROW_SPACING = 0
local ROW_TEXT_PADDING = 4
local ROW_NAME_SIZE = 14
local ROW_DESCRIPTION_SIZE = 11
local ROW_DIVIDER_COLOR = Color3.fromRGB(40, 40, 44)

local TOGGLE_TRACK_SIZE = UDim2.fromOffset(34, 18)
local TOGGLE_KNOB_SIZE = UDim2.fromOffset(10, 10)
local TOGGLE_KNOB_PADDING = 4

local BUTTON_ICON = "rbxassetid://73793633589587"
local BUTTON_SIZE = UDim2.fromOffset(24, 24)
local BUTTON_PULSE_SCALE = 1.15
local BUTTON_PULSE_TIME = 0.1

local DROPDOWN_ICON = "rbxassetid://5279719038"
local DROPDOWN_BOX_SIZE = UDim2.fromOffset(30, 26)
local DROPDOWN_OPTION_HEIGHT = 32
local DROPDOWN_PANEL_PADDING = 6

local SLIDER_TRACK_WIDTH = 85
local SLIDER_BUTTON_SIZE = UDim2.fromOffset(18, 18)
local SLIDER_VALUE_WIDTH = 24
local SLIDER_GAP = 5

local SECTION_HEADER_HEIGHT = 48
local SECTION_ICON_SIZE = UDim2.fromOffset(20, 20)
local SECTION_CHEVRON_SIZE = UDim2.fromOffset(14, 14)

local INPUT_BOX_SIZE = UDim2.fromOffset(100, 28)

local COLORPICKER_SWATCH_SIZE = UDim2.fromOffset(28, 28)
local COLORPICKER_PANEL_WIDTH = 220
local COLORPICKER_SV_SIZE = UDim2.fromOffset(150, 150)
local COLORPICKER_HUE_WIDTH = 22
local COLORPICKER_PANEL_PADDING = 12

local NOTIFICATION_WIDTH = 280
local NOTIFICATION_HEIGHT = 64
local NOTIFICATION_SPACING = 10
local NOTIFICATION_SCREEN_PADDING = 16

local Themes = {
	Crimson = {
		Accent = Color3.fromRGB(200, 0, 50),
		FrameColor = Color3.fromRGB(18, 18, 20),
		ContentColor = Color3.fromRGB(22, 22, 25),
		TextColor = Color3.fromRGB(255, 255, 255),
		SubTextColor = Color3.fromRGB(150, 150, 155),
		DividerColor = Color3.fromRGB(45, 45, 50),
		RowDivider = Color3.fromRGB(40, 40, 44),
		TabActive = Color3.fromRGB(200, 0, 50),
		TabIdle = Color3.fromRGB(255, 255, 255),
		ButtonColor = Color3.fromRGB(255, 255, 255),
		BoxColor = Color3.fromRGB(30, 30, 34),
		BoxHover = Color3.fromRGB(42, 42, 48),
		BorderColor = Color3.fromRGB(55, 55, 62),
		Placeholder = Color3.fromRGB(120, 120, 125),
		SliderTrack = Color3.fromRGB(50, 50, 55),
		SliderFill = Color3.fromRGB(200, 0, 50),
	},
	Blue = {
		Accent = Color3.fromRGB(0, 100, 255),
		FrameColor = Color3.fromRGB(15, 15, 20),
		ContentColor = Color3.fromRGB(20, 20, 25),
		TextColor = Color3.fromRGB(255, 255, 255),
		SubTextColor = Color3.fromRGB(150, 150, 155),
		DividerColor = Color3.fromRGB(40, 40, 50),
		RowDivider = Color3.fromRGB(35, 35, 42),
		TabActive = Color3.fromRGB(0, 100, 255),
		TabIdle = Color3.fromRGB(255, 255, 255),
		ButtonColor = Color3.fromRGB(255, 255, 255),
		BoxColor = Color3.fromRGB(25, 25, 30),
		BoxHover = Color3.fromRGB(38, 38, 45),
		BorderColor = Color3.fromRGB(50, 50, 58),
		Placeholder = Color3.fromRGB(110, 110, 120),
		SliderTrack = Color3.fromRGB(45, 45, 50),
		SliderFill = Color3.fromRGB(0, 100, 255),
	},
	Green = {
		Accent = Color3.fromRGB(0, 200, 100),
		FrameColor = Color3.fromRGB(12, 18, 12),
		ContentColor = Color3.fromRGB(16, 24, 16),
		TextColor = Color3.fromRGB(255, 255, 255),
		SubTextColor = Color3.fromRGB(150, 155, 150),
		DividerColor = Color3.fromRGB(40, 50, 40),
		RowDivider = Color3.fromRGB(35, 42, 35),
		TabActive = Color3.fromRGB(0, 200, 100),
		TabIdle = Color3.fromRGB(255, 255, 255),
		ButtonColor = Color3.fromRGB(255, 255, 255),
		BoxColor = Color3.fromRGB(20, 30, 20),
		BoxHover = Color3.fromRGB(30, 42, 30),
		BorderColor = Color3.fromRGB(45, 55, 45),
		Placeholder = Color3.fromRGB(110, 120, 110),
		SliderTrack = Color3.fromRGB(40, 50, 40),
		SliderFill = Color3.fromRGB(0, 200, 100),
	},
}

local ConfigFolderName = "Stellar_Config"
local ConfigEnabled = true
local ConfigAutoLoad = true

local function tween(instance, time, props, style, direction)
	local info = TweenInfo.new(time, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out)
	local t = TweenService:Create(instance, info, props)
	t:Play()
	return t
end

local function createCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = radius
	corner.Parent = parent
	return corner
end

local function createStroke(parent, color, thickness, transparency)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color
	stroke.Thickness = thickness
	stroke.Transparency = transparency or 0
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = parent
	return stroke
end

local function getConfigFolder()
	if not ConfigEnabled then return nil end
	local folder = workspace:FindFirstChild(ConfigFolderName)
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = ConfigFolderName
		folder.Parent = workspace
	end
	return folder
end

local function saveConfig(key, value)
	local folder = getConfigFolder()
	if not folder then return end
	local existing = folder:FindFirstChild(key)
	if existing then
		existing:Destroy()
	end
	local val = Instance.new("StringValue")
	val.Name = key
	val.Value = HttpService:JSONEncode(value)
	val.Parent = folder
end

local function loadConfig(key)
	local folder = getConfigFolder()
	if not folder then return nil end
	local existing = folder:FindFirstChild(key)
	if existing then
		local success, decoded = pcall(function()
			return HttpService:JSONDecode(existing.Value)
		end)
		if success then
			return decoded
		end
	end
	return nil
end

local Window = {}
Window.__index = Window

function Window.new(config)
	local self = setmetatable({}, Window)
	self.Config = config or {}
	self.Theme = Themes[self.Config.Theme or "Crimson"] or Themes.Crimson
	self.Tabs = {}
	self.CurrentTab = nil
	self.NotificationContainer = nil
	self.NotifyFunc = nil
	self.ScreenGui = nil
	self.MainFrame = nil
	self.Header = nil
	self.TabStrip = nil
	self.Content = nil
	self.Pages = {}
	self.Dragging = false
	self.DragStart = nil
	self.StartPos = nil
	self.Resizing = false
	self.ResizeStart = nil
	self.ResizeStartSize = nil
	self.Minimized = false
	self.PreMinSize = nil
	self.ConfigFolder = nil
	self.ConfigValues = {}

	ConfigEnabled = self.Config.Config and self.Config.Config.Enabled ~= false or false
	ConfigFolderName = self.Config.Config and self.Config.Config.Folder or "Stellar_Config"
	ConfigAutoLoad = self.Config.Config and self.Config.Config.AutoLoad ~= false or true
	if ConfigEnabled then
		self.ConfigFolder = getConfigFolder()
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "StellarUI"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 999
	screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	self.ScreenGui = screenGui

	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.Position = UDim2.fromScale(0.5, 0.5)
	mainFrame.Size = self.Config.Size or UDim2.fromOffset(580, 520)
	mainFrame.BackgroundColor3 = self.Theme.FrameColor
	mainFrame.BorderSizePixel = 0
	mainFrame.ClipsDescendants = true
	mainFrame.ZIndex = 2
	mainFrame.Parent = screenGui
	self.MainFrame = mainFrame
	createCorner(mainFrame, UDim.new(0, 12))

	if self.Config.Center then
		mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		mainFrame.Position = UDim2.fromScale(0.5, 0.5)
	else
		mainFrame.AnchorPoint = Vector2.new(0, 0)
		mainFrame.Position = UDim2.fromOffset(100, 100)
	end

	local header = Instance.new("Frame")
	header.Name = "Header"
	header.Size = UDim2.new(1, 0, 0, HEADER_HEIGHT)
	header.BackgroundColor3 = self.Theme.FrameColor
	header.BackgroundTransparency = 0
	header.ZIndex = 3
	header.Parent = mainFrame
	self.Header = header

	local headerLayout = Instance.new("UIListLayout")
	headerLayout.FillDirection = Enum.FillDirection.Horizontal
	headerLayout.SortOrder = Enum.SortOrder.LayoutOrder
	headerLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	headerLayout.Padding = UDim.new(0, 10)
	headerLayout.Parent = header

	local logo = Instance.new("ImageLabel")
	logo.Name = "Logo"
	logo.Size = UDim2.fromOffset(28, 28)
	logo.BackgroundTransparency = 1
	logo.Image = ICON_ASSET_ID
	logo.ScaleType = Enum.ScaleType.Fit
	logo.LayoutOrder = 1
	logo.ZIndex = 4
	logo.Parent = header

	local titleText = Instance.new("TextLabel")
	titleText.Name = "Title"
	titleText.Size = UDim2.new(0, 0, 1, 0)
	titleText.AutomaticSize = Enum.AutomaticSize.X
	titleText.BackgroundTransparency = 1
	titleText.Text = self.Config.Title or "Stellar"
	titleText.Font = Enum.Font.GothamBold
	titleText.TextSize = 16
	titleText.TextColor3 = self.Theme.TextColor
	titleText.TextXAlignment = Enum.TextXAlignment.Left
	titleText.LayoutOrder = 2
	titleText.ZIndex = 4
	titleText.Parent = header

	local badgeHolder = Instance.new("Frame")
	badgeHolder.Name = "Badges"
	badgeHolder.Size = UDim2.new(0, 0, 1, 0)
	badgeHolder.AutomaticSize = Enum.AutomaticSize.X
	badgeHolder.BackgroundTransparency = 1
	badgeHolder.LayoutOrder = 3
	badgeHolder.ZIndex = 4
	badgeHolder.Parent = header
	local badgeLayout = Instance.new("UIListLayout")
	badgeLayout.FillDirection = Enum.FillDirection.Horizontal
	badgeLayout.SortOrder = Enum.SortOrder.LayoutOrder
	badgeLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	badgeLayout.Padding = UDim.new(0, 6)
	badgeLayout.Parent = badgeHolder
	if self.Config.Badges then
		for i, badge in ipairs(self.Config.Badges) do
			local b = Instance.new("TextLabel")
			b.Name = "Badge" .. i
			b.Size = UDim2.fromOffset(0, 20)
			b.AutomaticSize = Enum.AutomaticSize.X
			b.BackgroundColor3 = self.Theme.Accent
			b.BackgroundTransparency = 0.2
			b.Text = badge
			b.Font = Enum.Font.GothamBold
			b.TextSize = 10
			b.TextColor3 = self.Theme.TextColor
			b.LayoutOrder = i
			b.ZIndex = 5
			createCorner(b, UDim.new(0, 4))
			b.Parent = badgeHolder
		end
	end

	local spacer = Instance.new("Frame")
	spacer.Name = "Spacer"
	spacer.Size = UDim2.new(1, 0, 1, 0)
	spacer.BackgroundTransparency = 1
	spacer.LayoutOrder = 4
	spacer.ZIndex = 3
	spacer.Parent = header

	local minimizeBtn = nil
	if self.Config.MinimizeButton then
		local btn = Instance.new("ImageButton")
		btn.Name = "Minimize"
		btn.Size = UDim2.fromOffset(28, 28)
		btn.BackgroundTransparency = 1
		btn.Image = self.Config.MinimizeButton_Image or "rbxassetid://82235228007110"
		btn.ImageColor3 = self.Theme.ButtonColor
		btn.ImageTransparency = 0.3
		btn.ScaleType = Enum.ScaleType.Fit
		btn.LayoutOrder = 5
		btn.ZIndex = 5
		btn.Parent = header
		btn.MouseEnter:Connect(function()
			tween(btn, 0.12, { ImageTransparency = 0 })
		end)
		btn.MouseLeave:Connect(function()
			tween(btn, 0.12, { ImageTransparency = 0.3 })
		end)
		btn.MouseButton1Click:Connect(function()
			self:ToggleMinimize()
		end)
		minimizeBtn = btn
	end

	local closeBtn = Instance.new("ImageButton")
	closeBtn.Name = "Close"
	closeBtn.Size = UDim2.fromOffset(28, 28)
	closeBtn.BackgroundTransparency = 1
	closeBtn.Image = "rbxassetid://82994774214203"
	closeBtn.ImageColor3 = self.Theme.ButtonColor
	closeBtn.ImageTransparency = 0.3
	closeBtn.ScaleType = Enum.ScaleType.Fit
	closeBtn.LayoutOrder = 6
	closeBtn.ZIndex = 5
	closeBtn.Parent = header
	closeBtn.MouseEnter:Connect(function()
		tween(closeBtn, 0.12, { ImageTransparency = 0 })
	end)
	closeBtn.MouseLeave:Connect(function()
		tween(closeBtn, 0.12, { ImageTransparency = 0.3 })
	end)
	closeBtn.MouseButton1Click:Connect(function()
		screenGui:Destroy()
	end)

	local topDivider = Instance.new("Frame")
	topDivider.Name = "TopDivider"
	topDivider.AnchorPoint = Vector2.new(0, 1)
	topDivider.Position = UDim2.new(0, 0, 1, 0)
	topDivider.Size = UDim2.new(1, 0, 0, 1)
	topDivider.BackgroundColor3 = self.Theme.DividerColor
	topDivider.BorderSizePixel = 0
	topDivider.ZIndex = 4
	topDivider.Parent = header

	local verticalDivider = Instance.new("Frame")
	verticalDivider.Name = "VerticalDivider"
	verticalDivider.AnchorPoint = Vector2.new(0, 0)
	verticalDivider.Position = UDim2.new(0, SIDEBAR_WIDTH, 0, HEADER_HEIGHT)
	verticalDivider.Size = UDim2.new(0, 1, 1, -HEADER_HEIGHT)
	verticalDivider.BackgroundColor3 = self.Theme.DividerColor
	verticalDivider.BorderSizePixel = 0
	verticalDivider.ZIndex = 3
	verticalDivider.Parent = mainFrame

	local tabStrip = Instance.new("Frame")
	tabStrip.Name = "TabStrip"
	tabStrip.AnchorPoint = Vector2.new(0, 0)
	tabStrip.Position = UDim2.new(0, 0, 0, HEADER_HEIGHT + TAB_STRIP_TOP_PADDING)
	tabStrip.Size = UDim2.new(0, SIDEBAR_WIDTH, 1, -(HEADER_HEIGHT + TAB_STRIP_TOP_PADDING))
	tabStrip.BackgroundTransparency = 1
	tabStrip.ZIndex = 3
	tabStrip.Parent = mainFrame
	self.TabStrip = tabStrip

	local tabList = Instance.new("UIListLayout")
	tabList.FillDirection = Enum.FillDirection.Vertical
	tabList.SortOrder = Enum.SortOrder.LayoutOrder
	tabList.Padding = UDim.new(0, 4)
	tabList.Parent = tabStrip

	local content = Instance.new("Frame")
	content.Name = "Content"
	content.AnchorPoint = Vector2.new(0, 0)
	content.Position = UDim2.new(0, SIDEBAR_WIDTH + 1 + CONTENT_PADDING, 0, HEADER_HEIGHT + CONTENT_PADDING)
	content.Size = UDim2.new(1, -(SIDEBAR_WIDTH + 1 + CONTENT_PADDING * 2), 1, -(HEADER_HEIGHT + CONTENT_PADDING * 2))
	content.BackgroundColor3 = self.Theme.ContentColor
	content.BackgroundTransparency = 0
	content.BorderSizePixel = 0
	content.ClipsDescendants = true
	content.ZIndex = 3
	content.Parent = mainFrame
	self.Content = content
	createCorner(content, UDim.new(0, 12))

	local notificationContainer = Instance.new("Frame")
	notificationContainer.Name = "NotificationContainer"
	notificationContainer.AnchorPoint = Vector2.new(1, 1)
	notificationContainer.Position = UDim2.new(1, -NOTIFICATION_SCREEN_PADDING, 1, -NOTIFICATION_SCREEN_PADDING)
	notificationContainer.Size = UDim2.fromOffset(NOTIFICATION_WIDTH, 0)
	notificationContainer.AutomaticSize = Enum.AutomaticSize.Y
	notificationContainer.BackgroundTransparency = 1
	notificationContainer.ZIndex = 200
	notificationContainer.Parent = screenGui
	self.NotificationContainer = notificationContainer
	local notificationList = Instance.new("UIListLayout")
	notificationList.FillDirection = Enum.FillDirection.Vertical
	notificationList.HorizontalAlignment = Enum.HorizontalAlignment.Right
	notificationList.VerticalAlignment = Enum.VerticalAlignment.Bottom
	notificationList.SortOrder = Enum.SortOrder.LayoutOrder
	notificationList.Padding = UDim.new(0, NOTIFICATION_SPACING)
	notificationList.Parent = notificationContainer

	self.NotifyFunc = function(data)
		self:Notify(data)
	end

	if self.Config.Draggable then
		self:EnableDragging()
	end
	if self.Config.Resize then
		self:EnableResizing()
	end

	if self.Config.MinimizeKey then
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.KeyCode == self.Config.MinimizeKey then
				self:ToggleMinimize()
			end
		end)
	end

	self:CreateTab("Home", ICON_ASSET_ID)
	if #self.Tabs > 0 then
		self:SelectTab(self.Tabs[1])
	end

	return self
end

function Window:EnableDragging()
	local frame = self.MainFrame
	local header = self.Header
	local dragging = false
	local dragStart = nil
	local startPos = nil

	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

function Window:EnableResizing()
	local frame = self.MainFrame
	local resizer = Instance.new("TextButton")
	resizer.Name = "Resizer"
	resizer.AnchorPoint = Vector2.new(1, 1)
	resizer.Position = UDim2.new(1, 0, 1, 0)
	resizer.Size = UDim2.fromOffset(20, 20)
	resizer.BackgroundTransparency = 1
	resizer.Text = ""
	resizer.ZIndex = 10
	resizer.Parent = frame
	local resizing = false
	local resizeStart = nil
	local startSize = nil

	resizer.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizing = true
			resizeStart = input.Position
			startSize = frame.Size
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					resizing = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - resizeStart
			local newWidth = math.max(300, startSize.X.Offset + delta.X)
			local newHeight = math.max(200, startSize.Y.Offset + delta.Y)
			frame.Size = UDim2.fromOffset(newWidth, newHeight)
		end
	end)
end

function Window:ToggleMinimize()
	if self.Minimized then
		self.Minimized = false
		tween(self.MainFrame, 0.25, { Size = self.PreMinSize or self.Config.Size or UDim2.fromOffset(580, 520) })
		self.Content.Visible = true
		self.TabStrip.Visible = true
	else
		self.Minimized = true
		self.PreMinSize = self.MainFrame.Size
		tween(self.MainFrame, 0.25, { Size = UDim2.fromOffset(self.MainFrame.Size.X.Offset, HEADER_HEIGHT) })
		self.Content.Visible = false
		self.TabStrip.Visible = false
	end
end

function Window:CreateTab(name, icon)
	local tab = {
		Name = name,
		Icon = icon or ICON_ASSET_ID,
		Button = nil,
		Page = nil,
		Layout = nil,
	}
	table.insert(self.Tabs, tab)

	local button = Instance.new("TextButton")
	button.Name = name .. "Tab"
	button.AnchorPoint = Vector2.new(0.5, 0)
	button.Position = UDim2.new(0, SIDEBAR_WIDTH / 2, 0, (#self.Tabs - 1) * 40)
	button.Size = UDim2.fromOffset(36, 36)
	button.BackgroundColor3 = self.Theme.TabActive
	button.BackgroundTransparency = 1
	button.AutoButtonColor = false
	button.Text = ""
	button.ZIndex = 4
	button.Parent = self.TabStrip
	createCorner(button, UDim.new(0, 8))
	tab.Button = button

	local indicator = Instance.new("Frame")
	indicator.Name = "ActiveIndicator"
	indicator.AnchorPoint = Vector2.new(0, 0.5)
	indicator.Position = UDim2.new(0, -6, 0.5, 0)
	indicator.Size = UDim2.fromOffset(3, 20)
	indicator.BackgroundColor3 = self.Theme.TabActive
	indicator.BackgroundTransparency = 1
	indicator.BorderSizePixel = 0
	indicator.ZIndex = 4
	indicator.Parent = button
	createCorner(indicator, UDim.new(1, 0))

	local iconLabel = Instance.new("ImageLabel")
	iconLabel.Name = "Icon"
	iconLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	iconLabel.Position = UDim2.fromScale(0.5, 0.5)
	iconLabel.Size = UDim2.fromOffset(20, 20)
	iconLabel.BackgroundTransparency = 1
	iconLabel.Image = icon or ICON_ASSET_ID
	iconLabel.ImageColor3 = self.Theme.TabIdle
	iconLabel.ImageTransparency = 0.35
	iconLabel.ScaleType = Enum.ScaleType.Fit
	iconLabel.ZIndex = 5
	iconLabel.Parent = button

	local tooltip = Instance.new("Frame")
	tooltip.Name = "Tooltip"
	tooltip.AnchorPoint = Vector2.new(0, 0.5)
	tooltip.Position = UDim2.new(1, 10, 0.5, 0)
	tooltip.AutomaticSize = Enum.AutomaticSize.X
	tooltip.Size = UDim2.fromOffset(0, 28)
	tooltip.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
	tooltip.BackgroundTransparency = 1
	tooltip.BorderSizePixel = 0
	tooltip.ZIndex = 6
	tooltip.Visible = false
	tooltip.Parent = button
	createCorner(tooltip, UDim.new(0, 6))
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
	tooltipText.Text = name
	tooltipText.Font = Enum.Font.GothamMedium
	tooltipText.TextSize = 13
	tooltipText.TextColor3 = self.Theme.TextColor
	tooltipText.TextTransparency = 1
	tooltipText.ZIndex = 7
	tooltipText.Parent = tooltip

	button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			tooltip.Visible = true
			tween(tooltip, 0.15, { BackgroundTransparency = 0.05 })
			tween(tooltipText, 0.15, { TextTransparency = 0 })
			tween(button, 0.15, { BackgroundTransparency = 0.9 })
		end
	end)
	local function release()
		tooltip.Visible = false
		tween(tooltip, 0.15, { BackgroundTransparency = 1 })
		tween(tooltipText, 0.15, { TextTransparency = 1 })
		tween(button, 0.15, { BackgroundTransparency = 1 })
	end
	button.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			release()
		end
	end)
	button.MouseLeave:Connect(function()
		if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
			release()
		end
	end)

	button.MouseButton1Click:Connect(function()
		self:SelectTab(tab)
	end)

	local page = Instance.new("ScrollingFrame")
	page.Name = name .. "Page"
	page.Size = UDim2.fromScale(1, 1)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ZIndex = 3
	page.Visible = false
	page.ScrollBarThickness = 3
	page.ScrollBarImageColor3 = self.Theme.TextColor
	page.ScrollBarImageTransparency = 0.7
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.Parent = self.Content
	tab.Page = page
	local pageList = Instance.new("UIListLayout")
	pageList.FillDirection = Enum.FillDirection.Vertical
	pageList.SortOrder = Enum.SortOrder.LayoutOrder
	pageList.Padding = UDim.new(0, ROW_SPACING)
	pageList.Parent = page
	tab.Layout = pageList

	return tab
end

function Window:SelectTab(tab)
	for _, t in ipairs(self.Tabs) do
		local active = t == tab
		t.Page.Visible = active
		tween(t.Button, 0.2, { BackgroundTransparency = active and 0.9 or 1 })
		tween(t.Button:FindFirstChild("ActiveIndicator"), 0.2, { BackgroundTransparency = active and 0 or 1 })
		tween(t.Button:FindFirstChild("Icon"), 0.2, { ImageTransparency = active and 0 or 0.35, ImageColor3 = active and self.Theme.TabActive or self.Theme.TabIdle })
	end
	self.CurrentTab = tab
end

function Window:GetConfigValue(key, default)
	if ConfigAutoLoad and ConfigEnabled then
		local val = loadConfig(key)
		if val ~= nil then
			return val
		end
	end
	return default
end

function Window:SaveConfigValue(key, value)
	if ConfigEnabled then
		saveConfig(key, value)
	end
end

local function createRowBase(parent, name, description, layoutOrder)
	local row = Instance.new("Frame")
	row.Name = name .. "Row"
	row.Size = UDim2.new(1, 0, 0, ROW_HEIGHT)
	row.BackgroundTransparency = 1
	row.LayoutOrder = layoutOrder
	row.ZIndex = 4
	row.Parent = parent

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
	nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
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
	descLabel.TextColor3 = Color3.fromRGB(140, 140, 145)
	descLabel.TextXAlignment = Enum.TextXAlignment.Left
	descLabel.TextWrapped = true
	descLabel.ZIndex = 5
	descLabel.Parent = row

	return row
end

function Window:AddParagraph(tab, title, description)
	local paragraph = Instance.new("Frame")
	paragraph.Name = "Paragraph"
	paragraph.Size = UDim2.new(1, 0, 0, 50)
	paragraph.BackgroundTransparency = 1
	paragraph.LayoutOrder = #tab.Layout:GetChildren()
	paragraph.ZIndex = 4
	paragraph.Parent = tab.Page

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.AnchorPoint = Vector2.new(0, 0)
	titleLabel.Position = UDim2.new(0, ROW_TEXT_PADDING, 0, 4)
	titleLabel.Size = UDim2.new(1, -ROW_TEXT_PADDING*2, 0, 20)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 15
	titleLabel.TextColor3 = self.Theme.TextColor
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.ZIndex = 5
	titleLabel.Parent = paragraph

	local descLabel = Instance.new("TextLabel")
	descLabel.Name = "Description"
	descLabel.AnchorPoint = Vector2.new(0, 0)
	descLabel.Position = UDim2.new(0, ROW_TEXT_PADDING, 0, 26)
	descLabel.Size = UDim2.new(1, -ROW_TEXT_PADDING*2, 0, 16)
	descLabel.BackgroundTransparency = 1
	descLabel.Text = description or ""
	descLabel.Font = Enum.Font.Gotham
	descLabel.TextSize = 12
	descLabel.TextColor3 = self.Theme.SubTextColor
	descLabel.TextXAlignment = Enum.TextXAlignment.Left
	descLabel.TextWrapped = true
	descLabel.ZIndex = 5
	descLabel.Parent = paragraph

	return paragraph
end

function Window:AddButton(tab, name, description, icon, callback)
	local row = createRowBase(tab.Page, name, description, #tab.Layout:GetChildren()+1)
	local button = Instance.new("ImageButton")
	button.Name = "Button"
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, -ROW_TEXT_PADDING, 0.5, 0)
	button.Size = BUTTON_SIZE
	button.BackgroundTransparency = 1
	button.Image = icon or BUTTON_ICON
	button.ImageColor3 = self.Theme.ButtonColor
	button.ZIndex = 5
	button.Parent = row

	local function pulse(instance)
		if not instance:GetAttribute("BaseSizeX") then
			instance:SetAttribute("BaseSizeX", instance.Size.X.Offset)
			instance:SetAttribute("BaseSizeY", instance.Size.Y.Offset)
		end
		local baseX = instance:GetAttribute("BaseSizeX")
		local baseY = instance:GetAttribute("BaseSizeY")
		local baseSize = UDim2.fromOffset(baseX, baseY)
		local peakSize = UDim2.fromOffset(baseX * BUTTON_PULSE_SCALE, baseY * BUTTON_PULSE_SCALE)
		local grow = tween(instance, BUTTON_PULSE_TIME, { Size = peakSize }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		grow.Completed:Connect(function()
			tween(instance, BUTTON_PULSE_TIME, { Size = baseSize }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		end)
	end

	button.MouseButton1Click:Connect(function()
		pulse(button)
		if callback then callback() end
	end)

	return button
end

function Window:AddToggle(tab, name, description, default, callback, configKey)
	local configVal = default or false
	if configKey and ConfigAutoLoad then
		local saved = self:GetConfigValue(configKey)
		if saved ~= nil then configVal = saved end
	end
	local row = createRowBase(tab.Page, name, description, #tab.Layout:GetChildren()+1)
	local isOn = configVal
	local track = Instance.new("TextButton")
	track.Name = "Toggle"
	track.AnchorPoint = Vector2.new(1, 0.5)
	track.Position = UDim2.new(1, -ROW_TEXT_PADDING-4, 0.5, 0)
	track.Size = TOGGLE_TRACK_SIZE
	track.BackgroundTransparency = 1
	track.AutoButtonColor = false
	track.Text = ""
	track.ZIndex = 5
	track.Parent = row
	createCorner(track, UDim.new(1, 0))
	createStroke(track, Color3.fromRGB(220,220,225), 2)

	local knob = Instance.new("Frame")
	knob.Name = "Knob"
	knob.AnchorPoint = Vector2.new(0, 0.5)
	knob.Size = TOGGLE_KNOB_SIZE
	knob.Position = UDim2.new(isOn and 1 or 0, isOn and -(TOGGLE_KNOB_SIZE.X.Offset + TOGGLE_KNOB_PADDING) or TOGGLE_KNOB_PADDING, 0.5, 0)
	knob.BackgroundColor3 = Color3.fromRGB(220,220,225)
	knob.BorderSizePixel = 0
	knob.ZIndex = 6
	knob.Parent = track
	createCorner(knob, UDim.new(1, 0))

	local function updateVisual()
		local targetX = isOn and (TOGGLE_TRACK_SIZE.X.Offset - TOGGLE_KNOB_SIZE.X.Offset - TOGGLE_KNOB_PADDING) or TOGGLE_KNOB_PADDING
		tween(knob, 0.18, { Position = UDim2.new(0, targetX, 0.5, 0) })
	end

	track.MouseButton1Click:Connect(function()
		isOn = not isOn
		updateVisual()
		if callback then callback(isOn) end
		if configKey then self:SaveConfigValue(configKey, isOn) end
	end)

	return track
end

function Window:AddInput(tab, name, description, default, callback, configKey)
	local configVal = default or ""
	if configKey and ConfigAutoLoad then
		local saved = self:GetConfigValue(configKey)
		if saved ~= nil then configVal = saved end
	end
	local row = createRowBase(tab.Page, name, description, #tab.Layout:GetChildren()+1)
	local box = Instance.new("Frame")
	box.Name = "InputBox"
	box.AnchorPoint = Vector2.new(1, 0.5)
	box.Position = UDim2.new(1, -ROW_TEXT_PADDING, 0.5, 0)
	box.Size = INPUT_BOX_SIZE
	box.BackgroundColor3 = self.Theme.BoxColor
	box.ZIndex = 5
	box.Parent = row
	createCorner(box, UDim.new(0, 8))
	local stroke = createStroke(box, self.Theme.BorderColor, 1)

	local textBox = Instance.new("TextBox")
	textBox.Name = "TextBox"
	textBox.AnchorPoint = Vector2.new(0, 0.5)
	textBox.Position = UDim2.new(0, 10, 0.5, 0)
	textBox.Size = UDim2.new(1, -20, 1, 0)
	textBox.BackgroundTransparency = 1
	textBox.Text = configVal
	textBox.PlaceholderText = ""
	textBox.Font = Enum.Font.Gotham
	textBox.TextSize = 13
	textBox.TextColor3 = self.Theme.TextColor
	textBox.TextXAlignment = Enum.TextXAlignment.Left
	textBox.ClearTextOnFocus = false
	textBox.ZIndex = 6
	textBox.Parent = box

	textBox.Focused:Connect(function()
		tween(stroke, 0.12, { Color = self.Theme.Accent })
	end)
	textBox.FocusLost:Connect(function(enterPressed)
		tween(stroke, 0.12, { Color = self.Theme.BorderColor })
		if callback then callback(textBox.Text, enterPressed) end
		if configKey then self:SaveConfigValue(configKey, textBox.Text) end
	end)

	return textBox
end

function Window:AddDropdown(tab, name, description, options, multi, default, callback, configKey)
	local configVal = default
	if configKey and ConfigAutoLoad then
		local saved = self:GetConfigValue(configKey)
		if saved ~= nil then configVal = saved end
	end
	local row = createRowBase(tab.Page, name, description, #tab.Layout:GetChildren()+1)
	local selectedOption = configVal or options[1]
	local isOpen = false
	local bar = Instance.new("Frame")
	bar.Name = "Bar"
	bar.AnchorPoint = Vector2.new(1, 0.5)
	bar.Position = UDim2.new(1, -ROW_TEXT_PADDING, 0.5, 0)
	bar.Size = UDim2.new(0, 110, 0, 28)
	bar.BackgroundColor3 = self.Theme.BoxColor
	bar.ZIndex = 5
	bar.Parent = row
	createCorner(bar, UDim.new(0, 8))

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Name = "Value"
	valueLabel.AnchorPoint = Vector2.new(0, 0.5)
	valueLabel.Position = UDim2.new(0, 12, 0.5, 0)
	valueLabel.Size = UDim2.new(1, -50, 1, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(selectedOption)
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.TextSize = 13
	valueLabel.TextColor3 = self.Theme.TextColor
	valueLabel.TextXAlignment = Enum.TextXAlignment.Left
	valueLabel.TextTruncate = Enum.TextTruncate.AtEnd
	valueLabel.ZIndex = 6
	valueLabel.Parent = bar

	local barDivider = Instance.new("Frame")
	barDivider.Name = "Divider"
	barDivider.AnchorPoint = Vector2.new(1, 0.5)
	barDivider.Position = UDim2.new(1, -DROPDOWN_BOX_SIZE.X.Offset-6, 0.5, 0)
	barDivider.Size = UDim2.new(0, 1, 1, -10)
	barDivider.BackgroundColor3 = self.Theme.RowDivider
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
	chevron.ImageColor3 = self.Theme.ButtonColor
	chevron.Rotation = 0
	chevron.ZIndex = 7
	chevron.Parent = box

	box.MouseEnter:Connect(function()
		tween(chevron, 0.12, { ImageTransparency = 0.3 })
	end)
	box.MouseLeave:Connect(function()
		tween(chevron, 0.12, { ImageTransparency = 0 })
	end)

	local gui = self.ScreenGui
	local panel = Instance.new("Frame")
	panel.Name = "DropdownPanel"
	panel.BackgroundColor3 = self.Theme.BoxColor
	panel.BorderSizePixel = 0
	panel.ClipsDescendants = true
	panel.Visible = false
	panel.ZIndex = 100
	panel.Parent = gui
	createCorner(panel, UDim.new(0, 8))
	createStroke(panel, self.Theme.BorderColor, 1)
	local panelList = Instance.new("UIListLayout")
	panelList.FillDirection = Enum.FillDirection.Vertical
	panelList.SortOrder = Enum.SortOrder.LayoutOrder
	panelList.Parent = panel

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
		tween(chevron, 0.18, { Rotation = 0 })
		local shrink = tween(panel, 0.18, { Size = UDim2.fromOffset(panelWidth, 0) })
		shrink.Completed:Connect(function()
			if not isOpen then panel.Visible = false end
		end)
	end
	local function openPanel()
		positionPanel()
		isOpen = true
		panel.Visible = true
		tween(chevron, 0.18, { Rotation = 180 })
		tween(panel, 0.18, { Size = UDim2.fromOffset(panelWidth, fullPanelHeight) })
	end
	box.MouseButton1Click:Connect(function()
		if isOpen then closePanel() else openPanel() end
	end)
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not isOpen then return end
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local mousePos = UserInputService:GetMouseLocation()
		local panelPos = panel.AbsolutePosition
		local panelSize = panel.AbsoluteSize
		local boxPos = box.AbsolutePosition
		local boxSize = box.AbsoluteSize
		local insidePanel = mousePos.X >= panelPos.X and mousePos.X <= panelPos.X + panelSize.X and mousePos.Y >= panelPos.Y and mousePos.Y <= panelPos.Y + panelSize.Y
		local insideBox = mousePos.X >= boxPos.X and mousePos.X <= boxPos.X + boxSize.X and mousePos.Y >= boxPos.Y and mousePos.Y <= boxPos.Y + boxSize.Y
		if not insidePanel and not insideBox then closePanel() end
	end)

	if options then
		for i, optionText in ipairs(options) do
			local optionButton = Instance.new("TextButton")
			optionButton.Name = "Option"..i
			optionButton.Size = UDim2.new(1,0,0,DROPDOWN_OPTION_HEIGHT)
			optionButton.BackgroundColor3 = self.Theme.BoxColor
			optionButton.AutoButtonColor = false
			optionButton.Text = optionText
			optionButton.Font = Enum.Font.Gotham
			optionButton.TextSize = 12
			optionButton.TextColor3 = self.Theme.TextColor
			optionButton.LayoutOrder = i
			optionButton.ZIndex = 101
			optionButton.Parent = panel

			optionButton.MouseEnter:Connect(function()
				tween(optionButton, 0.1, { BackgroundColor3 = self.Theme.BoxHover })
			end)
			optionButton.MouseLeave:Connect(function()
				tween(optionButton, 0.1, { BackgroundColor3 = self.Theme.BoxColor })
			end)
			optionButton.MouseButton1Click:Connect(function()
				selectedOption = optionText
				valueLabel.Text = optionText
				closePanel()
				if callback then callback(optionText) end
				if configKey then self:SaveConfigValue(configKey, optionText) end
			end)
		end
	end

	tab.Page:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		if isOpen then positionPanel() end
	end)

	return bar
end

function Window:AddMultiDropdown(tab, name, description, options, defaultSelected, callback, configKey)
	local configVal = defaultSelected
	if configKey and ConfigAutoLoad then
		local saved = self:GetConfigValue(configKey)
		if saved ~= nil then configVal = saved end
	end
	local row = createRowBase(tab.Page, name, description, #tab.Layout:GetChildren()+1)
	local selected = {}
	if configVal then for _, v in ipairs(configVal) do selected[v] = true end end
	local isOpen = false

	local function summaryText()
		local count = 0
		local first = nil
		for opt in pairs(selected) do count += 1; first = first or opt end
		if count == 0 then return "None" elseif count == 1 then return first else return count.." selected" end
	end

	local bar = Instance.new("Frame")
	bar.Name = "Bar"
	bar.AnchorPoint = Vector2.new(1, 0.5)
	bar.Position = UDim2.new(1, -ROW_TEXT_PADDING, 0.5, 0)
	bar.Size = UDim2.new(0, 110, 0, 28)
	bar.BackgroundColor3 = self.Theme.BoxColor
	bar.ZIndex = 5
	bar.Parent = row
	createCorner(bar, UDim.new(0,8))

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Name = "Value"
	valueLabel.AnchorPoint = Vector2.new(0,0.5)
	valueLabel.Position = UDim2.new(0,12,0.5,0)
	valueLabel.Size = UDim2.new(1,-50,1,0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = summaryText()
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.TextSize = 13
	valueLabel.TextColor3 = self.Theme.TextColor
	valueLabel.TextXAlignment = Enum.TextXAlignment.Left
	valueLabel.TextTruncate = Enum.TextTruncate.AtEnd
	valueLabel.ZIndex = 6
	valueLabel.Parent = bar

	local barDivider = Instance.new("Frame")
	barDivider.Name = "Divider"
	barDivider.AnchorPoint = Vector2.new(1,0.5)
	barDivider.Position = UDim2.new(1,-DROPDOWN_BOX_SIZE.X.Offset-6,0.5,0)
	barDivider.Size = UDim2.new(0,1,1,-10)
	barDivider.BackgroundColor3 = self.Theme.RowDivider
	barDivider.BorderSizePixel = 0
	barDivider.ZIndex = 6
	barDivider.Parent = bar

	local box = Instance.new("TextButton")
	box.Name = "DropdownBox"
	box.AnchorPoint = Vector2.new(1,0.5)
	box.Position = UDim2.new(1,-4,0.5,0)
	box.Size = DROPDOWN_BOX_SIZE
	box.BackgroundTransparency = 1
	box.AutoButtonColor = false
	box.Text = ""
	box.ZIndex = 6
	box.Parent = bar

	local chevron = Instance.new("ImageLabel")
	chevron.Name = "Icon"
	chevron.AnchorPoint = Vector2.new(0.5,0.5)
	chevron.Position = UDim2.fromScale(0.5,0.5)
	chevron.Size = DROPDOWN_ICON_SIZE
	chevron.BackgroundTransparency = 1
	chevron.Image = DROPDOWN_ICON
	chevron.ImageColor3 = self.Theme.ButtonColor
	chevron.Rotation = 0
	chevron.ZIndex = 7
	chevron.Parent = box

	box.MouseEnter:Connect(function() tween(chevron,0.12,{ImageTransparency=0.3}) end)
	box.MouseLeave:Connect(function() tween(chevron,0.12,{ImageTransparency=0}) end)

	local gui = self.ScreenGui
	local panel = Instance.new("Frame")
	panel.Name = "MultiDropdownPanel"
	panel.BackgroundColor3 = self.Theme.BoxColor
	panel.BorderSizePixel = 0
	panel.ClipsDescendants = true
	panel.Visible = false
	panel.ZIndex = 100
	panel.Parent = gui
	createCorner(panel, UDim.new(0,8))
	createStroke(panel, self.Theme.BorderColor, 1)
	local panelList = Instance.new("UIListLayout")
	panelList.FillDirection = Enum.FillDirection.Vertical
	panelList.SortOrder = Enum.SortOrder.LayoutOrder
	panelList.Parent = panel

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
		tween(chevron,0.18,{Rotation=0})
		local shrink = tween(panel,0.18,{Size=UDim2.fromOffset(panelWidth,0)})
		shrink.Completed:Connect(function()
			if not isOpen then panel.Visible = false end
		end)
	end
	local function openPanel()
		positionPanel()
		isOpen = true
		panel.Visible = true
		tween(chevron,0.18,{Rotation=180})
		tween(panel,0.18,{Size=UDim2.fromOffset(panelWidth, fullPanelHeight)})
	end
	box.MouseButton1Click:Connect(function() if isOpen then closePanel() else openPanel() end end)
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not isOpen then return end
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local inputPos = input.UserInputType == Enum.UserInputType.Touch and Vector2.new(input.Position.X, input.Position.Y) or UserInputService:GetMouseLocation()
		local panelPos = panel.AbsolutePosition
		local panelSize = panel.AbsoluteSize
		local boxPos = box.AbsolutePosition
		local boxSize = box.AbsoluteSize
		local insidePanel = inputPos.X >= panelPos.X and inputPos.X <= panelPos.X + panelSize.X and inputPos.Y >= panelPos.Y and inputPos.Y <= panelPos.Y + panelSize.Y
		local insideBox = inputPos.X >= boxPos.X and inputPos.X <= boxPos.X + boxSize.X and inputPos.Y >= boxPos.Y and inputPos.Y <= boxPos.Y + boxSize.Y
		if not insidePanel and not insideBox then closePanel() end
	end)

	if options then
		for i, optionText in ipairs(options) do
			local optionButton = Instance.new("TextButton")
			optionButton.Name = "Option"..i
			optionButton.Size = UDim2.new(1,0,0,DROPDOWN_OPTION_HEIGHT)
			optionButton.BackgroundColor3 = self.Theme.BoxColor
			optionButton.AutoButtonColor = false
			optionButton.Text = ""
			optionButton.LayoutOrder = i
			optionButton.ZIndex = 101
			optionButton.Parent = panel

			local checkbox = Instance.new("Frame")
			checkbox.Name = "Checkbox"
			checkbox.AnchorPoint = Vector2.new(0,0.5)
			checkbox.Position = UDim2.new(0,10,0.5,0)
			checkbox.Size = UDim2.fromOffset(16,16)
			checkbox.BackgroundColor3 = self.Theme.BoxColor
			checkbox.ZIndex = 102
			checkbox.Parent = optionButton
			createCorner(checkbox, UDim.new(0,4))
			createStroke(checkbox, Color3.fromRGB(90,90,98), 1.5)

			local checkFill = Instance.new("Frame")
			checkFill.Name = "Fill"
			checkFill.AnchorPoint = Vector2.new(0.5,0.5)
			checkFill.Position = UDim2.fromScale(0.5,0.5)
			checkFill.Size = UDim2.new(1,-6,1,-6)
			checkFill.BackgroundColor3 = self.Theme.Accent
			checkFill.BackgroundTransparency = selected[optionText] and 0 or 1
			checkFill.ZIndex = 103
			checkFill.Parent = checkbox
			createCorner(checkFill, UDim.new(0,2))

			local optionLabel = Instance.new("TextLabel")
			optionLabel.Name = "Label"
			optionLabel.AnchorPoint = Vector2.new(0,0.5)
			optionLabel.Position = UDim2.new(0,10+16+8,0.5,0)
			optionLabel.Size = UDim2.new(1,-(10+16+18),1,0)
			optionLabel.BackgroundTransparency = 1
			optionLabel.Text = optionText
			optionLabel.Font = Enum.Font.Gotham
			optionLabel.TextSize = 12
			optionLabel.TextColor3 = self.Theme.TextColor
			optionLabel.TextXAlignment = Enum.TextXAlignment.Left
			optionLabel.TextTruncate = Enum.TextTruncate.AtEnd
			optionLabel.ZIndex = 102
			optionLabel.Parent = optionButton

			optionButton.MouseEnter:Connect(function() tween(optionButton,0.1,{BackgroundColor3=self.Theme.BoxHover}) end)
			optionButton.MouseLeave:Connect(function() tween(optionButton,0.1,{BackgroundColor3=self.Theme.BoxColor}) end)
			optionButton.MouseButton1Click:Connect(function()
				selected[optionText] = not selected[optionText] or nil
				tween(checkFill,0.12,{BackgroundTransparency = selected[optionText] and 0 or 1})
				valueLabel.Text = summaryText()
				if callback then
					local list = {}
					for opt in pairs(selected) do table.insert(list, opt) end
					callback(list)
				end
				if configKey then
					local list = {}
					for opt in pairs(selected) do table.insert(list, opt) end
					self:SaveConfigValue(configKey, list)
				end
			end)
		end
	end

	tab.Page:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		if isOpen then positionPanel() end
	end)

	return bar
end

function Window:AddSlider(tab, name, description, min, max, default, callback, configKey)
	local configVal = default or min
	if configKey and ConfigAutoLoad then
		local saved = self:GetConfigValue(configKey)
		if saved ~= nil then configVal = saved end
	end
	local row = createRowBase(tab.Page, name, description, #tab.Layout:GetChildren()+1)
	local value = configVal
	min = min or 0
	max = max or 100
	local step = 1

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Name = "ValueLabel"
	valueLabel.AnchorPoint = Vector2.new(1,0.5)
	valueLabel.Position = UDim2.new(1,-ROW_TEXT_PADDING,0.5,0)
	valueLabel.Size = UDim2.fromOffset(SLIDER_VALUE_WIDTH,18)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(value)
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.TextSize = 12
	valueLabel.TextColor3 = self.Theme.SubTextColor
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.ZIndex = 5
	valueLabel.Parent = row

	local plusButton = Instance.new("TextButton")
	plusButton.Name = "Plus"
	plusButton.AnchorPoint = Vector2.new(1,0.5)
	plusButton.Position = UDim2.new(1,-ROW_TEXT_PADDING-SLIDER_VALUE_WIDTH-SLIDER_GAP,0.5,0)
	plusButton.Size = SLIDER_BUTTON_SIZE
	plusButton.BackgroundColor3 = self.Theme.BoxColor
	plusButton.AutoButtonColor = false
	plusButton.Text = "+"
	plusButton.Font = Enum.Font.GothamBold
	plusButton.TextSize = 14
	plusButton.TextColor3 = self.Theme.TextColor
	plusButton.ZIndex = 5
	plusButton.Parent = row
	createCorner(plusButton, UDim.new(0,6))

	local track = Instance.new("Frame")
	track.Name = "Track"
	track.AnchorPoint = Vector2.new(1,0.5)
	track.Position = UDim2.new(1,-ROW_TEXT_PADDING-SLIDER_VALUE_WIDTH-SLIDER_GAP-SLIDER_BUTTON_SIZE.X.Offset-SLIDER_GAP,0.5,0)
	track.Size = UDim2.fromOffset(SLIDER_TRACK_WIDTH,3)
	track.BackgroundColor3 = self.Theme.SliderTrack
	track.BorderSizePixel = 0
	track.ZIndex = 5
	track.Parent = row
	createCorner(track, UDim.new(1,0))

	local minusButton = Instance.new("TextButton")
	minusButton.Name = "Minus"
	minusButton.AnchorPoint = Vector2.new(1,0.5)
	minusButton.Position = UDim2.new(0,-SLIDER_GAP,0.5,0)
	minusButton.Size = SLIDER_BUTTON_SIZE
	minusButton.BackgroundColor3 = self.Theme.BoxColor
	minusButton.AutoButtonColor = false
	minusButton.Text = "-"
	minusButton.Font = Enum.Font.GothamBold
	minusButton.TextSize = 14
	minusButton.TextColor3 = self.Theme.TextColor
	minusButton.ZIndex = 5
	minusButton.Parent = track
	createCorner(minusButton, UDim.new(0,6))

	for _, btn in ipairs({minusButton, plusButton}) do
		btn.MouseEnter:Connect(function() tween(btn,0.1,{BackgroundColor3=self.Theme.BoxHover}) end)
		btn.MouseLeave:Connect(function() tween(btn,0.1,{BackgroundColor3=self.Theme.BoxColor}) end)
	end

	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.AnchorPoint = Vector2.new(0,0.5)
	fill.Position = UDim2.new(0,0,0.5,0)
	fill.Size = UDim2.new(0,0,1,0)
	fill.BackgroundColor3 = self.Theme.SliderFill
	fill.BorderSizePixel = 0
	fill.ZIndex = 6
	fill.Parent = track
	createCorner(fill, UDim.new(1,0))

	local hitArea = Instance.new("TextButton")
	hitArea.Name = "HitArea"
	hitArea.AnchorPoint = Vector2.new(0.5,0.5)
	hitArea.Position = UDim2.fromScale(0.5,0.5)
	hitArea.Size = UDim2.new(1,0,0,24)
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
		fill.Size = UDim2.new(alpha,0,1,0)
		valueLabel.Text = tostring(value)
		if fire and callback then callback(value) end
		if fire and configKey then self:SaveConfigValue(configKey, value) end
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

	return track
end

function Window:AddImageBox(tab, name, description, imageId, size, callback)
	local row = createRowBase(tab.Page, name, description, #tab.Layout:GetChildren()+1)
	local button = Instance.new("ImageButton")
	button.Name = "ImageBox"
	button.AnchorPoint = Vector2.new(1,0.5)
	button.Position = UDim2.new(1,-ROW_TEXT_PADDING,0.5,0)
	button.Size = size or UDim2.fromOffset(40,40)
	button.BackgroundTransparency = 1
	button.Image = imageId
	button.ScaleType = Enum.ScaleType.Fit
	button.ZIndex = 5
	button.Parent = row
	button.MouseButton1Click:Connect(function()
		if callback then callback(imageId) end
	end)
	return button
end

function Window:AddColorPicker(tab, name, description, defaultColor, callback, configKey)
	local configVal = defaultColor or Color3.fromRGB(0,0,255)
	if configKey and ConfigAutoLoad then
		local saved = self:GetConfigValue(configKey)
		if saved ~= nil and type(saved) == "table" then
			configVal = Color3.new(saved[1], saved[2], saved[3])
		end
	end
	local row = createRowBase(tab.Page, name, description, #tab.Layout:GetChildren()+1)
	local currentColor = configVal
	local h, s, v = Color3.toHSV(currentColor)
	local isOpen = false

	local swatch = Instance.new("TextButton")
	swatch.Name = "Swatch"
	swatch.AnchorPoint = Vector2.new(1,0.5)
	swatch.Position = UDim2.new(1,-ROW_TEXT_PADDING,0.5,0)
	swatch.Size = COLORPICKER_SWATCH_SIZE
	swatch.BackgroundColor3 = currentColor
	swatch.AutoButtonColor = false
	swatch.Text = ""
	swatch.ZIndex = 5
	swatch.Parent = row
	createCorner(swatch, UDim.new(0,8))
	createStroke(swatch, self.Theme.BorderColor, 1)

	local gui = self.ScreenGui
	local panel = Instance.new("Frame")
	panel.Name = "ColorPickerPanel"
	panel.Size = UDim2.fromOffset(COLORPICKER_PANEL_WIDTH, 0)
	panel.BackgroundColor3 = self.Theme.ContentColor
	panel.BorderSizePixel = 0
	panel.ClipsDescendants = true
	panel.Visible = false
	panel.ZIndex = 100
	panel.Parent = gui
	createCorner(panel, UDim.new(0,12))
	createStroke(panel, self.Theme.BorderColor, 1)

	local panelPadding = Instance.new("UIPadding")
	panelPadding.PaddingLeft = UDim.new(0, COLORPICKER_PANEL_PADDING)
	panelPadding.PaddingRight = UDim.new(0, COLORPICKER_PANEL_PADDING)
	panelPadding.PaddingTop = UDim.new(0, COLORPICKER_PANEL_PADDING)
	panelPadding.PaddingBottom = UDim.new(0, COLORPICKER_PANEL_PADDING)
	panelPadding.Parent = panel

	local pickerRow = Instance.new("Frame")
	pickerRow.Name = "PickerRow"
	pickerRow.Size = UDim2.new(1,0,0,COLORPICKER_SV_SIZE.Y.Offset)
	pickerRow.BackgroundTransparency = 1
	pickerRow.ZIndex = 101
	pickerRow.Parent = panel

	local svSquare = Instance.new("ImageButton")
	svSquare.Name = "SVSquare"
	svSquare.AnchorPoint = Vector2.new(0,0)
	svSquare.Position = UDim2.fromOffset(0,0)
	svSquare.Size = COLORPICKER_SV_SIZE
	svSquare.AutoButtonColor = false
	svSquare.Image = ""
	svSquare.BackgroundColor3 = Color3.fromHSV(h,1,1)
	svSquare.ZIndex = 101
	svSquare.Parent = pickerRow
	createCorner(svSquare, UDim.new(0,8))

	local svWhiteGradient = Instance.new("Frame")
	svWhiteGradient.Name = "WhiteGradient"
	svWhiteGradient.Size = UDim2.fromScale(1,1)
	svWhiteGradient.BackgroundColor3 = Color3.new(1,1,1)
	svWhiteGradient.BorderSizePixel = 0
	svWhiteGradient.ZIndex = 101
	svWhiteGradient.Parent = svSquare
	createCorner(svWhiteGradient, UDim.new(0,8))

	local svWhiteGradientUI = Instance.new("UIGradient")
	svWhiteGradientUI.Color = ColorSequence.new(Color3.new(1,1,1), Color3.new(1,1,1))
	svWhiteGradientUI.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0), NumberSequenceKeypoint.new(1,1)})
	svWhiteGradientUI.Parent = svWhiteGradient

	local svBlackGradient = Instance.new("Frame")
	svBlackGradient.Name = "BlackGradient"
	svBlackGradient.Size = UDim2.fromScale(1,1)
	svBlackGradient.BackgroundColor3 = Color3.new(0,0,0)
	svBlackGradient.BorderSizePixel = 0
	svBlackGradient.ZIndex = 102
	svBlackGradient.Parent = svSquare
	createCorner(svBlackGradient, UDim.new(0,8))

	local svBlackGradientUI = Instance.new("UIGradient")
	svBlackGradientUI.Rotation = 90
	svBlackGradientUI.Color = ColorSequence.new(Color3.new(0,0,0), Color3.new(0,0,0))
	svBlackGradientUI.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1), NumberSequenceKeypoint.new(1,0)})
	svBlackGradientUI.Parent = svBlackGradient

	local svCursor = Instance.new("Frame")
	svCursor.Name = "Cursor"
	svCursor.AnchorPoint = Vector2.new(0.5,0.5)
	svCursor.Size = UDim2.fromOffset(14,14)
	svCursor.BackgroundTransparency = 1
	svCursor.ZIndex = 103
	svCursor.Parent = svSquare
	createCorner(svCursor, UDim.new(1,0))
	createStroke(svCursor, Color3.new(1,1,1), 2)

	local hueStrip = Instance.new("ImageButton")
	hueStrip.Name = "HueStrip"
	hueStrip.AnchorPoint = Vector2.new(1,0)
	hueStrip.Position = UDim2.new(1,0,0,0)
	hueStrip.Size = UDim2.fromOffset(COLORPICKER_HUE_WIDTH, COLORPICKER_SV_SIZE.Y.Offset)
	hueStrip.AutoButtonColor = false
	hueStrip.Image = ""
	hueStrip.BackgroundColor3 = Color3.new(1,1,1)
	hueStrip.ZIndex = 101
	hueStrip.Parent = pickerRow
	createCorner(hueStrip, UDim.new(0,6))

	local hueGradient = Instance.new("UIGradient")
	hueGradient.Rotation = 90
	hueGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.000, Color3.fromHSV(0.000,1,1)),
		ColorSequenceKeypoint.new(0.167, Color3.fromHSV(0.167,1,1)),
		ColorSequenceKeypoint.new(0.333, Color3.fromHSV(0.333,1,1)),
		ColorSequenceKeypoint.new(0.500, Color3.fromHSV(0.500,1,1)),
		ColorSequenceKeypoint.new(0.667, Color3.fromHSV(0.667,1,1)),
		ColorSequenceKeypoint.new(0.833, Color3.fromHSV(0.833,1,1)),
		ColorSequenceKeypoint.new(1.000, Color3.fromHSV(1.000,1,1)),
	})
	hueGradient.Parent = hueStrip

	local hueCursor = Instance.new("Frame")
	hueCursor.Name = "Cursor"
	hueCursor.AnchorPoint = Vector2.new(0.5,0.5)
	hueCursor.Size = UDim2.new(1,4,0,4)
	hueCursor.BackgroundColor3 = Color3.new(1,1,1)
	hueCursor.BorderSizePixel = 0
	hueCursor.ZIndex = 103
	hueCursor.Parent = hueStrip
	createCorner(hueCursor, UDim.new(1,0))

	local rgbRow = Instance.new("Frame")
	rgbRow.Name = "RGBRow"
	rgbRow.Size = UDim2.new(1,0,0,24)
	rgbRow.Position = UDim2.new(0,0,0,COLORPICKER_SV_SIZE.Y.Offset+10)
	rgbRow.BackgroundTransparency = 1
	rgbRow.ZIndex = 101
	rgbRow.Parent = panel

	local previewSwatch = Instance.new("Frame")
	previewSwatch.Name = "Preview"
	previewSwatch.AnchorPoint = Vector2.new(0,0.5)
	previewSwatch.Position = UDim2.new(0,0,0.5,0)
	previewSwatch.Size = UDim2.fromOffset(24,24)
	previewSwatch.BackgroundColor3 = currentColor
	previewSwatch.ZIndex = 101
	previewSwatch.Parent = rgbRow
	createCorner(previewSwatch, UDim.new(0,6))

	local rgbLabel = Instance.new("TextLabel")
	rgbLabel.Name = "RGBLabel"
	rgbLabel.AnchorPoint = Vector2.new(0,0.5)
	rgbLabel.Position = UDim2.new(0,32,0.5,0)
	rgbLabel.Size = UDim2.new(1,-32,1,0)
	rgbLabel.BackgroundTransparency = 1
	rgbLabel.Text = string.format("%d, %d, %d", math.floor(currentColor.R*255+0.5), math.floor(currentColor.G*255+0.5), math.floor(currentColor.B*255+0.5))
	rgbLabel.Font = Enum.Font.Gotham
	rgbLabel.TextSize = 12
	rgbLabel.TextColor3 = self.Theme.SubTextColor
	rgbLabel.TextXAlignment = Enum.TextXAlignment.Left
	rgbLabel.ZIndex = 101
	rgbLabel.Parent = rgbRow

	local panelWidth = COLORPICKER_PANEL_WIDTH
	local fullPanelHeight = COLORPICKER_PANEL_PADDING*2 + COLORPICKER_SV_SIZE.Y.Offset + 10 + 24

	local function updateCursors()
		svCursor.Position = UDim2.new(s,0,1-v,0)
		hueCursor.Position = UDim2.new(0.5,0,h,0)
		svSquare.BackgroundColor3 = Color3.fromHSV(h,1,1)
	end
	local function applyColor(fire)
		currentColor = Color3.fromHSV(h,s,v)
		swatch.BackgroundColor3 = currentColor
		previewSwatch.BackgroundColor3 = currentColor
		rgbLabel.Text = string.format("%d, %d, %d", math.floor(currentColor.R*255+0.5), math.floor(currentColor.G*255+0.5), math.floor(currentColor.B*255+0.5))
		if fire and callback then callback(currentColor) end
		if fire and configKey then self:SaveConfigValue(configKey, {currentColor.R, currentColor.G, currentColor.B}) end
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
		local shrink = tween(panel, 0.18, { Size = UDim2.fromOffset(panelWidth, 0) })
		shrink.Completed:Connect(function()
			if not isOpen then panel.Visible = false end
		end)
	end
	local function openPanel()
		positionPanel()
		isOpen = true
		panel.Visible = true
		tween(panel, 0.18, { Size = UDim2.fromOffset(panelWidth, fullPanelHeight) })
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
	local draggingHue = false
	local function updateSVFromInput(inputPos)
		local absPos = svSquare.AbsolutePosition
		local absSize = svSquare.AbsoluteSize
		local relX = math.clamp((inputPos.X - absPos.X)/absSize.X, 0, 1)
		local relY = math.clamp((inputPos.Y - absPos.Y)/absSize.Y, 0, 1)
		s = relX
		v = 1 - relY
		svCursor.Position = UDim2.new(s,0,1-v,0)
		applyColor(true)
	end
	local function updateHueFromInput(inputPos)
		local absPos = hueStrip.AbsolutePosition
		local absSize = hueStrip.AbsoluteSize
		local relY = math.clamp((inputPos.Y - absPos.Y)/absSize.Y, 0, 1)
		h = relY
		hueCursor.Position = UDim2.new(0.5,0,h,0)
		svSquare.BackgroundColor3 = Color3.fromHSV(h,1,1)
		applyColor(true)
	end
	svSquare.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSV = true
			updateSVFromInput(Vector2.new(input.Position.X, input.Position.Y))
		end
	end)
	svSquare.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSV = false
		end
	end)
	hueStrip.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingHue = true
			updateHueFromInput(Vector2.new(input.Position.X, input.Position.Y))
		end
	end)
	hueStrip.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingHue = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local inputPos = Vector2.new(input.Position.X, input.Position.Y)
		if draggingSV then updateSVFromInput(inputPos) elseif draggingHue then updateHueFromInput(inputPos) end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSV = false
			draggingHue = false
		end
	end)

	tab.Page:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		if isOpen then positionPanel() end
	end)

	return swatch
end

function Window:AddKeybind(tab, name, description, defaultKey, callback, configKey)
	local configVal = defaultKey or Enum.KeyCode.E
	if configKey and ConfigAutoLoad then
		local saved = self:GetConfigValue(configKey)
		if saved ~= nil and Enum.KeyCode[saved] then
			configVal = Enum.KeyCode[saved]
		end
	end
	local row = createRowBase(tab.Page, name, description, #tab.Layout:GetChildren()+1)
	local currentKey = configVal
	local box = Instance.new("TextButton")
	box.Name = "KeybindBox"
	box.AnchorPoint = Vector2.new(1,0.5)
	box.Position = UDim2.new(1,-ROW_TEXT_PADDING,0.5,0)
	box.Size = UDim2.fromOffset(90,32)
	box.BackgroundColor3 = self.Theme.BoxColor
	box.AutoButtonColor = false
	box.Text = ""
	box.ZIndex = 5
	box.Parent = row
	createCorner(box, UDim.new(0,8))
	createStroke(box, self.Theme.BorderColor, 1)

	local keyLabel = Instance.new("TextLabel")
	keyLabel.Name = "KeyLabel"
	keyLabel.AnchorPoint = Vector2.new(0.5,0.5)
	keyLabel.Position = UDim2.fromScale(0.5,0.5)
	keyLabel.Size = UDim2.new(1,-8,1,0)
	keyLabel.BackgroundTransparency = 1
	keyLabel.Text = currentKey.Name
	keyLabel.Font = Enum.Font.Gotham
	keyLabel.TextSize = 13
	keyLabel.TextColor3 = self.Theme.TextColor
	keyLabel.ZIndex = 6
	keyLabel.Parent = box

	local listening = false
	local inputConnection
	local function stopListening()
		listening = false
		box.BackgroundColor3 = self.Theme.BoxColor
		keyLabel.Text = currentKey.Name
		if inputConnection then inputConnection:Disconnect(); inputConnection = nil end
	end
	local function startListening()
		listening = true
		box.BackgroundColor3 = Color3.fromRGB(45,45,90)
		keyLabel.Text = "..."
		inputConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if input.UserInputType == Enum.UserInputType.Keyboard then
				currentKey = input.KeyCode
				stopListening()
				if callback then callback(currentKey) end
				if configKey then self:SaveConfigValue(configKey, currentKey.Name) end
			end
		end)
	end
	box.MouseButton1Click:Connect(function()
		if listening then stopListening() else startListening() end
	end)

	return box
end

function Window:Notify(data)
	local title = data.Title or "Stellar"
	local description = data.Description or ""
	local content = data.Content or ""
	local color = data.Color or self.Theme.Accent
	local delay = data.Delay or 3

	local container = self.NotificationContainer
	local slot = Instance.new("Frame")
	slot.Name = "NotificationSlot"
	slot.Size = UDim2.fromOffset(NOTIFICATION_WIDTH, NOTIFICATION_HEIGHT)
	slot.BackgroundTransparency = 1
	slot.ClipsDescendants = false
	slot.ZIndex = 200
	slot.Parent = container

	local card = Instance.new("Frame")
	card.Name = "Notification"
	card.AnchorPoint = Vector2.new(0,0)
	card.Position = UDim2.fromOffset(NOTIFICATION_WIDTH + 20, 0)
	card.Size = UDim2.fromOffset(NOTIFICATION_WIDTH, NOTIFICATION_HEIGHT)
	card.BackgroundColor3 = self.Theme.FrameColor
	card.BackgroundTransparency = 1
	card.ClipsDescendants = true
	card.ZIndex = 200
	card.Parent = slot
	createCorner(card, UDim.new(0,12))
	local stroke = createStroke(card, self.Theme.BorderColor, 1, 1)

	local icon = Instance.new("Frame")
	icon.Name = "Icon"
	icon.AnchorPoint = Vector2.new(0,0.5)
	icon.Position = UDim2.new(0,14,0.5,0)
	icon.Size = UDim2.fromOffset(3,28)
	icon.BackgroundColor3 = color
	icon.BorderSizePixel = 0
	icon.ZIndex = 201
	icon.Parent = card
	createCorner(icon, UDim.new(1,0))

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.AnchorPoint = Vector2.new(0,0)
	titleLabel.Position = UDim2.new(0, 30, 0, 12)
	titleLabel.Size = UDim2.new(1, -40, 0, 18)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 14
	titleLabel.TextColor3 = self.Theme.TextColor
	titleLabel.TextTransparency = 1
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
	titleLabel.ZIndex = 201
	titleLabel.Parent = card

	local descLabel = Instance.new("TextLabel")
	descLabel.Name = "Description"
	descLabel.AnchorPoint = Vector2.new(0,0)
	descLabel.Position = UDim2.new(0, 30, 0, 32)
	descLabel.Size = UDim2.new(1, -40, 0, 26)
	descLabel.BackgroundTransparency = 1
	descLabel.Text = (description ~= "" and description.." - "..content or content)
	descLabel.Font = Enum.Font.Gotham
	descLabel.TextSize = 12
	descLabel.TextColor3 = self.Theme.SubTextColor
	descLabel.TextTransparency = 1
	descLabel.TextXAlignment = Enum.TextXAlignment.Left
	descLabel.TextYAlignment = Enum.TextYAlignment.Top
	descLabel.TextWrapped = true
	descLabel.ZIndex = 201
	descLabel.Parent = card

	local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	TweenService:Create(card, tweenInfo, { Position = UDim2.fromOffset(0,0), BackgroundTransparency = 0 }):Play()
	TweenService:Create(stroke, tweenInfo, { Transparency = 0 }):Play()
	TweenService:Create(icon, tweenInfo, { BackgroundTransparency = 0 }):Play()
	TweenService:Create(titleLabel, tweenInfo, { TextTransparency = 0 }):Play()
	TweenService:Create(descLabel, tweenInfo, { TextTransparency = 0 }):Play()

	task.delay(delay, function()
		local outInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
		local outTween = TweenService:Create(card, outInfo, { Position = UDim2.fromOffset(NOTIFICATION_WIDTH + 20, 0), BackgroundTransparency = 1 })
		TweenService:Create(stroke, outInfo, { Transparency = 1 }):Play()
		TweenService:Create(icon, outInfo, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(titleLabel, outInfo, { TextTransparency = 1 }):Play()
		TweenService:Create(descLabel, outInfo, { TextTransparency = 1 }):Play()
		outTween:Play()
		outTween.Completed:Connect(function()
			slot:Destroy()
		end)
	end)
end

function Stellar:CreateWindow(config)
	return Window.new(config)
end

return Stellar
