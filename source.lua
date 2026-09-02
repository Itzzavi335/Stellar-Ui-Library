local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local UI = {}

local function tween(instance, time, props, style, direction)
	local info = TweenInfo.new(
		time,
		style or Enum.EasingStyle.Quad,
		direction or Enum.EasingDirection.Out
	)
	local t = TweenService:Create(instance, info, props)
	t:Play()
	return t
end

UI.tween = tween

local function createRowBase(name, description, layoutOrder, parentFrame)
	local row = Instance.new("Frame")
	row.Name = name .. "Row"
	row.Size = UDim2.new(1, 0, 0, 56)
	row.BackgroundTransparency = 1
	row.LayoutOrder = layoutOrder
	row.ZIndex = 4
	row.Parent = parentFrame

	local divider = Instance.new("Frame")
	divider.Name = "Divider"
	divider.AnchorPoint = Vector2.new(0, 1)
	divider.Position = UDim2.new(0, 0, 1, 0)
	divider.Size = UDim2.new(1, 0, 0, 1)
	divider.BackgroundColor3 = Color3.fromRGB(40, 40, 44)
	divider.BorderSizePixel = 0
	divider.ZIndex = 4
	divider.Parent = row

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "Name"
	nameLabel.AnchorPoint = Vector2.new(0, 0)
	nameLabel.Position = UDim2.new(0, 4, 0, 8)
	nameLabel.Size = UDim2.new(1, -90, 0, 18)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = name
	nameLabel.Font = Enum.Font.GothamMedium
	nameLabel.TextSize = 14
	nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.ZIndex = 5
	nameLabel.Parent = row

	local descLabel = Instance.new("TextLabel")
	descLabel.Name = "Description"
	descLabel.AnchorPoint = Vector2.new(0, 0)
	descLabel.Position = UDim2.new(0, 4, 0, 28)
	descLabel.Size = UDim2.new(1, -90, 0, 16)
	descLabel.BackgroundTransparency = 1
	descLabel.Text = description
	descLabel.Font = Enum.Font.Gotham
	descLabel.TextSize = 11
	descLabel.TextColor3 = Color3.fromRGB(140, 140, 145)
	descLabel.TextXAlignment = Enum.TextXAlignment.Left
	descLabel.TextWrapped = true
	descLabel.ZIndex = 5
	descLabel.Parent = row

	return row
end

UI.createRowBase = createRowBase

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

UI.createToggleRow = function(name, description, layoutOrder, defaultOn, onChanged, parentFrame)
	local row = createRowBase(name, description, layoutOrder, parentFrame)
	local isOn = defaultOn or false

	local track = Instance.new("TextButton")
	track.Name = "Toggle"
	track.AnchorPoint = Vector2.new(1, 0.5)
	track.Position = UDim2.new(1, -8, 0.5, 0)
	track.Size = UDim2.fromOffset(34, 18)
	track.BackgroundTransparency = 1
	track.AutoButtonColor = false
	track.Text = ""
	track.ZIndex = 5
	track.Parent = row

	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(1, 0)
	trackCorner.Parent = track

	local trackStroke = Instance.new("UIStroke")
	trackStroke.Color = Color3.fromRGB(220, 220, 225)
	trackStroke.Thickness = 2
	trackStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	trackStroke.Parent = track

	local knob = Instance.new("Frame")
	knob.Name = "Knob"
	knob.AnchorPoint = Vector2.new(0, 0.5)
	knob.Size = UDim2.fromOffset(10, 10)
	knob.Position = UDim2.new(
		isOn and 1 or 0,
		isOn and -14 or 4,
		0.5,
		0
	)
	knob.BackgroundColor3 = Color3.fromRGB(220, 220, 225)
	knob.BorderSizePixel = 0
	knob.ZIndex = 6
	knob.Parent = track

	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = knob

	local function updateVisual()
		local targetX = isOn and 20 or 4
		tween(knob, 0.18, {
			Position = UDim2.new(0, targetX, 0.5, 0),
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	end

	track.MouseButton1Click:Connect(function()
		isOn = not isOn
		updateVisual()
		if onChanged then
			onChanged(isOn)
		end
	end)

	return row, track
end

UI.createButtonRow = function(name, description, layoutOrder, onPressed, parentFrame)
	local row = createRowBase(name, description, layoutOrder, parentFrame)

	local button = Instance.new("ImageButton")
	button.Name = "Button"
	button.AnchorPoint = Vector2.new(1, 0.5)
	button.Position = UDim2.new(1, -4, 0.5, 0)
	button.Size = UDim2.fromOffset(24, 24)
	button.BackgroundTransparency = 1
	button.Image = "rbxassetid://73793633589587"
	button.ImageColor3 = Color3.fromRGB(255, 255, 255)
	button.ZIndex = 5
	button.Parent = row

	button.MouseButton1Click:Connect(function()
		pulse(button, 1.15, 0.1)
		if onPressed then
			onPressed()
		end
	end)

	return row, button
end

UI.createLabelRow = function(text, layoutOrder, parentFrame)
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
	divider.BackgroundColor3 = Color3.fromRGB(40, 40, 44)
	divider.BorderSizePixel = 0
	divider.ZIndex = 4
	divider.Parent = row

	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.AnchorPoint = Vector2.new(0, 0.5)
	label.Position = UDim2.new(0, 4, 0.5, 0)
	label.Size = UDim2.new(1, -8, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.Font = Enum.Font.GothamBold
	label.TextSize = 14
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.ZIndex = 5
	label.Parent = row

	return row, label
end

UI.createDropdownRow = function(name, description, layoutOrder, options, onSelected, parentFrame)
	local row = createRowBase(name, description, layoutOrder, parentFrame)
	local isOpen = false
	local selectedOption = options and options[1]

	local bar = Instance.new("Frame")
	bar.Name = "Bar"
	bar.AnchorPoint = Vector2.new(1, 0.5)
	bar.Position = UDim2.new(1, -4, 0.5, 0)
	bar.Size = UDim2.new(0, 110, 0, 28)
	bar.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
	bar.ZIndex = 5
	bar.Parent = row

	local barCorner = Instance.new("UICorner")
	barCorner.CornerRadius = UDim.new(0, 8)
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
	barDivider.Position = UDim2.new(1, -36, 0.5, 0)
	barDivider.Size = UDim2.new(0, 1, 1, -10)
	barDivider.BackgroundColor3 = Color3.fromRGB(40, 40, 44)
	barDivider.BorderSizePixel = 0
	barDivider.ZIndex = 6
	barDivider.Parent = bar

	local box = Instance.new("TextButton")
	box.Name = "DropdownBox"
	box.AnchorPoint = Vector2.new(1, 0.5)
	box.Position = UDim2.new(1, -4, 0.5, 0)
	box.Size = UDim2.fromOffset(30, 26)
	box.BackgroundTransparency = 1
	box.AutoButtonColor = false
	box.Text = ""
	box.ZIndex = 6
	box.Parent = bar

	local chevron = Instance.new("ImageLabel")
	chevron.Name = "Icon"
	chevron.AnchorPoint = Vector2.new(0.5, 0.5)
	chevron.Position = UDim2.fromScale(0.5, 0.5)
	chevron.Size = UDim2.fromOffset(14, 14)
	chevron.BackgroundTransparency = 1
	chevron.Image = "rbxassetid://5279719038"
	chevron.ImageColor3 = Color3.fromRGB(255, 255, 255)
	chevron.Rotation = 0
	chevron.ZIndex = 7
	chevron.Parent = box

	box.MouseEnter:Connect(function()
		tween(chevron, 0.12, { ImageTransparency = 0.3 })
	end)
	box.MouseLeave:Connect(function()
		tween(chevron, 0.12, { ImageTransparency = 0 })
	end)

	local gui = parentFrame:FindFirstAncestorOfClass("ScreenGui")
	local panel = Instance.new("Frame")
	panel.Name = "DropdownPanel"
	panel.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
	panel.BorderSizePixel = 0
	panel.ClipsDescendants = true
	panel.Visible = false
	panel.ZIndex = 100
	panel.Parent = gui

	local panelCorner = Instance.new("UICorner")
	panelCorner.CornerRadius = UDim.new(0, 8)
	panelCorner.Parent = panel

	local panelStroke = Instance.new("UIStroke")
	panelStroke.Color = Color3.fromRGB(55, 55, 62)
	panelStroke.Thickness = 1
	panelStroke.Parent = panel

	local panelList = Instance.new("UIListLayout")
	panelList.FillDirection = Enum.FillDirection.Vertical
	panelList.SortOrder = Enum.SortOrder.LayoutOrder
	panelList.Parent = panel

	local fullPanelHeight = (options and #options or 0) * 32
	local panelWidth = 130

	local function positionPanel()
		local boxAbsPos = box.AbsolutePosition
		local boxAbsSize = box.AbsoluteSize
		local barAbsSize = bar.AbsoluteSize
		panel.Position = UDim2.fromOffset(
			boxAbsPos.X + boxAbsSize.X - barAbsSize.X,
			boxAbsPos.Y + boxAbsSize.Y + 6
		)
		panel.Size = UDim2.fromOffset(barAbsSize.X, 0)
		panelWidth = barAbsSize.X
	end

	local function closePanel()
		isOpen = false
		tween(chevron, 0.18, { Rotation = 0 })
		local shrink = tween(panel, 0.18, { Size = UDim2.fromOffset(panelWidth, 0) })
		shrink.Completed:Connect(function()
			if not isOpen then
				panel.Visible = false
			end
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
			optionButton.Name = "Option" .. i
			optionButton.Size = UDim2.new(1, 0, 0, 32)
			optionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
			optionButton.AutoButtonColor = false
			optionButton.Text = optionText
			optionButton.Font = Enum.Font.Gotham
			optionButton.TextSize = 12
			optionButton.TextColor3 = Color3.fromRGB(220, 220, 225)
			optionButton.LayoutOrder = i
			optionButton.ZIndex = 101
			optionButton.Parent = panel

			optionButton.MouseEnter:Connect(function()
				tween(optionButton, 0.1, { BackgroundColor3 = Color3.fromRGB(45, 45, 52) })
			end)
			optionButton.MouseLeave:Connect(function()
				tween(optionButton, 0.1, { BackgroundColor3 = Color3.fromRGB(30, 30, 34) })
			end)
			optionButton.MouseButton1Click:Connect(function()
				selectedOption = optionText
				valueLabel.Text = optionText
				closePanel()
				if onSelected then onSelected(optionText) end
			end)
		end
	end

	parentFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		if isOpen then positionPanel() end
	end)

	return row, bar
end

UI.createMultiDropdownRow = function(name, description, layoutOrder, options, defaultSelected, onChanged, parentFrame)
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
			count += 1
			firstSelected = firstSelected or opt
		end
		if count == 0 then return "None" elseif count == 1 then return firstSelected else return count .. " selected" end
	end

	local bar = Instance.new("Frame")
	bar.Name = "Bar"
	bar.AnchorPoint = Vector2.new(1, 0.5)
	bar.Position = UDim2.new(1, -4, 0.5, 0)
	bar.Size = UDim2.new(0, 110, 0, 28)
	bar.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
	bar.ZIndex = 5
	bar.Parent = row

	local barCorner = Instance.new("UICorner")
	barCorner.CornerRadius = UDim.new(0, 8)
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
	barDivider.Position = UDim2.new(1, -36, 0.5, 0)
	barDivider.Size = UDim2.new(0, 1, 1, -10)
	barDivider.BackgroundColor3 = Color3.fromRGB(40, 40, 44)
	barDivider.BorderSizePixel = 0
	barDivider.ZIndex = 6
	barDivider.Parent = bar

	local box = Instance.new("TextButton")
	box.Name = "DropdownBox"
	box.AnchorPoint = Vector2.new(1, 0.5)
	box.Position = UDim2.new(1, -4, 0.5, 0)
	box.Size = UDim2.fromOffset(30, 26)
	box.BackgroundTransparency = 1
	box.AutoButtonColor = false
	box.Text = ""
	box.ZIndex = 6
	box.Parent = bar

	local chevron = Instance.new("ImageLabel")
	chevron.Name = "Icon"
	chevron.AnchorPoint = Vector2.new(0.5, 0.5)
	chevron.Position = UDim2.fromScale(0.5, 0.5)
	chevron.Size = UDim2.fromOffset(14, 14)
	chevron.BackgroundTransparency = 1
	chevron.Image = "rbxassetid://5279719038"
	chevron.ImageColor3 = Color3.fromRGB(255, 255, 255)
	chevron.Rotation = 0
	chevron.ZIndex = 7
	chevron.Parent = box

	box.MouseEnter:Connect(function()
		tween(chevron, 0.12, { ImageTransparency = 0.3 })
	end)
	box.MouseLeave:Connect(function()
		tween(chevron, 0.12, { ImageTransparency = 0 })
	end)

	local gui = parentFrame:FindFirstAncestorOfClass("ScreenGui")
	local panel = Instance.new("Frame")
	panel.Name = "MultiDropdownPanel"
	panel.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
	panel.BorderSizePixel = 0
	panel.ClipsDescendants = true
	panel.Visible = false
	panel.ZIndex = 100
	panel.Parent = gui

	local panelCorner = Instance.new("UICorner")
	panelCorner.CornerRadius = UDim.new(0, 8)
	panelCorner.Parent = panel

	local panelStroke = Instance.new("UIStroke")
	panelStroke.Color = Color3.fromRGB(55, 55, 62)
	panelStroke.Thickness = 1
	panelStroke.Parent = panel

	local panelList = Instance.new("UIListLayout")
	panelList.FillDirection = Enum.FillDirection.Vertical
	panelList.SortOrder = Enum.SortOrder.LayoutOrder
	panelList.Parent = panel

	local fullPanelHeight = (options and #options or 0) * 32
	local panelWidth = 130

	local function positionPanel()
		local boxAbsPos = box.AbsolutePosition
		local boxAbsSize = box.AbsoluteSize
		local barAbsSize = bar.AbsoluteSize
		panel.Position = UDim2.fromOffset(
			boxAbsPos.X + boxAbsSize.X - barAbsSize.X,
			boxAbsPos.Y + boxAbsSize.Y + 6
		)
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
			optionButton.Name = "Option" .. i
			optionButton.Size = UDim2.new(1, 0, 0, 32)
			optionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
			optionButton.AutoButtonColor = false
			optionButton.Text = ""
			optionButton.LayoutOrder = i
			optionButton.ZIndex = 101
			optionButton.Parent = panel

			local checkbox = Instance.new("Frame")
			checkbox.Name = "Checkbox"
			checkbox.AnchorPoint = Vector2.new(0, 0.5)
			checkbox.Position = UDim2.new(0, 10, 0.5, 0)
			checkbox.Size = UDim2.fromOffset(16, 16)
			checkbox.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
			checkbox.ZIndex = 102
			checkbox.Parent = optionButton

			local checkboxCorner = Instance.new("UICorner")
			checkboxCorner.CornerRadius = UDim.new(0, 4)
			checkboxCorner.Parent = checkbox

			local checkboxStroke = Instance.new("UIStroke")
			checkboxStroke.Color = Color3.fromRGB(90, 90, 98)
			checkboxStroke.Thickness = 1.5
			checkboxStroke.Parent = checkbox

			local checkFill = Instance.new("Frame")
			checkFill.Name = "Fill"
			checkFill.AnchorPoint = Vector2.new(0.5, 0.5)
			checkFill.Position = UDim2.fromScale(0.5, 0.5)
			checkFill.Size = UDim2.new(1, -6, 1, -6)
			checkFill.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
			checkFill.BackgroundTransparency = selected[optionText] and 0 or 1
			checkFill.ZIndex = 103
			checkFill.Parent = checkbox

			local checkFillCorner = Instance.new("UICorner")
			checkFillCorner.CornerRadius = UDim.new(0, 2)
			checkFillCorner.Parent = checkFill

			local optionLabel = Instance.new("TextLabel")
			optionLabel.Name = "Label"
			optionLabel.AnchorPoint = Vector2.new(0, 0.5)
			optionLabel.Position = UDim2.new(0, 34, 0.5, 0)
			optionLabel.Size = UDim2.new(1, -52, 1, 0)
			optionLabel.BackgroundTransparency = 1
			optionLabel.Text = optionText
			optionLabel.Font = Enum.Font.Gotham
			optionLabel.TextSize = 12
			optionLabel.TextColor3 = Color3.fromRGB(220, 220, 225)
			optionLabel.TextXAlignment = Enum.TextXAlignment.Left
			optionLabel.TextTruncate = Enum.TextTruncate.AtEnd
			optionLabel.ZIndex = 102
			optionLabel.Parent = optionButton

			optionButton.MouseEnter:Connect(function()
				tween(optionButton, 0.1, { BackgroundColor3 = Color3.fromRGB(45, 45, 52) })
			end)
			optionButton.MouseLeave:Connect(function()
				tween(optionButton, 0.1, { BackgroundColor3 = Color3.fromRGB(30, 30, 34) })
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

	parentFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		if isOpen then positionPanel() end
	end)

	return row, bar
end

UI.createSliderRow = function(name, description, layoutOrder, min, max, default, step, onChanged, parentFrame)
	min = min or 0
	max = max or 100
	step = step or 1
	local value = default or min

	local row = createRowBase(name, description, layoutOrder, parentFrame)

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Name = "ValueLabel"
	valueLabel.AnchorPoint = Vector2.new(1, 0.5)
	valueLabel.Position = UDim2.new(1, -4, 0.5, 0)
	valueLabel.Size = UDim2.fromOffset(24, 18)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(value)
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.TextSize = 12
	valueLabel.TextColor3 = Color3.fromRGB(160, 160, 165)
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.ZIndex = 5
	valueLabel.Parent = row

	local plusButton = Instance.new("TextButton")
	plusButton.Name = "Plus"
	plusButton.AnchorPoint = Vector2.new(1, 0.5)
	plusButton.Position = UDim2.new(1, -33, 0.5, 0)
	plusButton.Size = UDim2.fromOffset(18, 18)
	plusButton.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
	plusButton.AutoButtonColor = false
	plusButton.Text = "+"
	plusButton.Font = Enum.Font.GothamBold
	plusButton.TextSize = 14
	plusButton.TextColor3 = Color3.fromRGB(220, 220, 225)
	plusButton.ZIndex = 5
	plusButton.Parent = row

	local plusCorner = Instance.new("UICorner")
	plusCorner.CornerRadius = UDim.new(0, 6)
	plusCorner.Parent = plusButton

	local track = Instance.new("Frame")
	track.Name = "Track"
	track.AnchorPoint = Vector2.new(1, 0.5)
	track.Position = UDim2.new(1, -109, 0.5, 0)
	track.Size = UDim2.fromOffset(85, 3)
	track.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
	track.BorderSizePixel = 0
	track.ZIndex = 5
	track.Parent = row

	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(1, 0)
	trackCorner.Parent = track

	local minusButton = Instance.new("TextButton")
	minusButton.Name = "Minus"
	minusButton.AnchorPoint = Vector2.new(1, 0.5)
	minusButton.Position = UDim2.new(0, -5, 0.5, 0)
	minusButton.Size = UDim2.fromOffset(18, 18)
	minusButton.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
	minusButton.AutoButtonColor = false
	minusButton.Text = "-"
	minusButton.Font = Enum.Font.GothamBold
	minusButton.TextSize = 14
	minusButton.TextColor3 = Color3.fromRGB(220, 220, 225)
	minusButton.ZIndex = 5
	minusButton.Parent = track

	local minusCorner = Instance.new("UICorner")
	minusCorner.CornerRadius = UDim.new(0, 6)
	minusCorner.Parent = minusButton

	for _, btn in ipairs({ minusButton, plusButton }) do
		btn.MouseEnter:Connect(function()
			tween(btn, 0.1, { BackgroundColor3 = Color3.fromRGB(42, 42, 48) })
		end)
		btn.MouseLeave:Connect(function()
			tween(btn, 0.1, { BackgroundColor3 = Color3.fromRGB(30, 30, 34) })
		end)
	end

	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.AnchorPoint = Vector2.new(0, 0.5)
	fill.Position = UDim2.new(0, 0, 0.5, 0)
	fill.Size = UDim2.new(0, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
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

	minusButton.MouseButton1Click:Connect(function()
		setValue(value - step, true)
	end)
	plusButton.MouseButton1Click:Connect(function()
		setValue(value + step, true)
	end)

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

UI.createInputRow = function(name, description, layoutOrder, placeholder, default, onChanged, parentFrame)
	local row = createRowBase(name, description, layoutOrder, parentFrame)

	local box = Instance.new("Frame")
	box.Name = "InputBox"
	box.AnchorPoint = Vector2.new(1, 0.5)
	box.Position = UDim2.new(1, -4, 0.5, 0)
	box.Size = UDim2.fromOffset(100, 28)
	box.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
	box.ZIndex = 5
	box.Parent = row

	local boxCorner = Instance.new("UICorner")
	boxCorner.CornerRadius = UDim.new(0, 8)
	boxCorner.Parent = box

	local boxStroke = Instance.new("UIStroke")
	boxStroke.Color = Color3.fromRGB(55, 55, 62)
	boxStroke.Thickness = 1
	boxStroke.Parent = box

	local penIcon = Instance.new("ImageLabel")
	penIcon.Name = "PenIcon"
	penIcon.AnchorPoint = Vector2.new(1, 0.5)
	penIcon.Position = UDim2.new(1, -8, 0.5, 0)
	penIcon.Size = UDim2.fromOffset(12, 12)
	penIcon.BackgroundTransparency = 1
	penIcon.Image = "rbxassetid://119122808711052"
	penIcon.ImageColor3 = Color3.fromRGB(120, 120, 125)
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
	textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 125)
	textBox.Font = Enum.Font.Gotham
	textBox.TextSize = 13
	textBox.TextColor3 = Color3.fromRGB(220, 220, 225)
	textBox.TextXAlignment = Enum.TextXAlignment.Left
	textBox.ClearTextOnFocus = false
	textBox.ZIndex = 6
	textBox.Parent = box

	textBox.Focused:Connect(function()
		tween(boxStroke, 0.12, { Color = Color3.fromRGB(0, 0, 255) })
	end)

	textBox.FocusLost:Connect(function(enterPressed)
		tween(boxStroke, 0.12, { Color = Color3.fromRGB(55, 55, 62) })
		if onChanged then onChanged(textBox.Text, enterPressed) end
	end)

	return row, textBox
end

UI.createColorPickerRow = function(name, description, layoutOrder, defaultColor, onChanged, parentFrame)
	local row = createRowBase(name, description, layoutOrder, parentFrame)

	local currentColor = defaultColor or Color3.fromRGB(0, 0, 255)
	local h, s, v = Color3.toHSV(currentColor)
	local isOpen = false

	local swatch = Instance.new("TextButton")
	swatch.Name = "Swatch"
	swatch.AnchorPoint = Vector2.new(1, 0.5)
	swatch.Position = UDim2.new(1, -4, 0.5, 0)
	swatch.Size = UDim2.fromOffset(28, 28)
	swatch.BackgroundColor3 = currentColor
	swatch.AutoButtonColor = false
	swatch.Text = ""
	swatch.ZIndex = 5
	swatch.Parent = row

	local swatchCorner = Instance.new("UICorner")
	swatchCorner.CornerRadius = UDim.new(0, 8)
	swatchCorner.Parent = swatch

	local swatchStroke = Instance.new("UIStroke")
	swatchStroke.Color = Color3.fromRGB(55, 55, 62)
	swatchStroke.Thickness = 1
	swatchStroke.Parent = swatch

	local gui = parentFrame:FindFirstAncestorOfClass("ScreenGui")
	local panel = Instance.new("Frame")
	panel.Name = "ColorPickerPanel"
	panel.Size = UDim2.fromOffset(220, 0)
	panel.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
	panel.BorderSizePixel = 0
	panel.ClipsDescendants = true
	panel.Visible = false
	panel.ZIndex = 100
	panel.Parent = gui

	local panelCorner = Instance.new("UICorner")
	panelCorner.CornerRadius = UDim.new(0, 12)
	panelCorner.Parent = panel

	local panelStroke = Instance.new("UIStroke")
	panelStroke.Color = Color3.fromRGB(55, 55, 62)
	panelStroke.Thickness = 1
	panelStroke.Parent = panel

	local panelPadding = Instance.new("UIPadding")
	panelPadding.PaddingLeft = UDim.new(0, 12)
	panelPadding.PaddingRight = UDim.new(0, 12)
	panelPadding.PaddingTop = UDim.new(0, 12)
	panelPadding.PaddingBottom = UDim.new(0, 12)
	panelPadding.Parent = panel

	local pickerRow = Instance.new("Frame")
	pickerRow.Name = "PickerRow"
	pickerRow.Size = UDim2.new(1, 0, 0, 150)
	pickerRow.BackgroundTransparency = 1
	pickerRow.ZIndex = 101
	pickerRow.Parent = panel

	local svSquare = Instance.new("ImageButton")
	svSquare.Name = "SVSquare"
	svSquare.AnchorPoint = Vector2.new(0, 0)
	svSquare.Position = UDim2.fromOffset(0, 0)
	svSquare.Size = UDim2.fromOffset(150, 150)
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
	svWhiteGradientUI.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(1, 1),
	})
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
	svBlackGradientUI.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(1, 0),
	})
	svBlackGradientUI.Parent = svBlackGradient

	local svBlackCorner = Instance.new("UICorner")
	svBlackCorner.CornerRadius = UDim.new(0, 8)
	svBlackCorner.Parent = svBlackGradient

	local svCursor = Instance.new("Frame")
	svCursor.Name = "Cursor"
	svCursor.AnchorPoint = Vector2.new(0.5, 0.5)
	svCursor.Size = UDim2.fromOffset(14, 14)
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
	hueStrip.Size = UDim2.fromOffset(22, 150)
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
	rgbRow.Position = UDim2.new(0, 0, 0, 160)
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

	local panelWidth = 220
	local fullPanelHeight = 12 * 2 + 150 + 10 + 24

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
		panel.Position = UDim2.fromOffset(
			swatchAbsPos.X + swatchAbsSize.X - panelWidth,
			swatchAbsPos.Y + swatchAbsSize.Y + 6
		)
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
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingSV = false
		end
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

	parentFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		if isOpen then positionPanel() end
	end)

	return row, swatch
end

UI.createSection = function(title, icon, layoutOrder, startOpen, parentFrame)
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
	panelCorner.CornerRadius = UDim.new(0, 12)
	panelCorner.Parent = panel

	local panelLayout = Instance.new("UIListLayout")
	panelLayout.FillDirection = Enum.FillDirection.Vertical
	panelLayout.SortOrder = Enum.SortOrder.LayoutOrder
	panelLayout.Parent = panel

	local header = Instance.new("TextButton")
	header.Name = "Header"
	header.Size = UDim2.new(1, 0, 0, 48)
	header.BackgroundTransparency = 1
	header.AutoButtonColor = false
	header.Text = ""
	header.LayoutOrder = 1
	header.ZIndex = 5
	header.Parent = panel

	local headerIcon = Instance.new("ImageLabel")
	headerIcon.Name = "Icon"
	headerIcon.AnchorPoint = Vector2.new(0, 0.5)
	headerIcon.Position = UDim2.new(0, 4, 0.5, 0)
	headerIcon.Size = UDim2.fromOffset(20, 20)
	headerIcon.BackgroundTransparency = 1
	headerIcon.Image = icon or ""
	headerIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
	headerIcon.ScaleType = Enum.ScaleType.Fit
	headerIcon.ZIndex = 6
	headerIcon.Parent = header

	local headerTitle = Instance.new("TextLabel")
	headerTitle.Name = "Title"
	headerTitle.AnchorPoint = Vector2.new(0, 0.5)
	headerTitle.Position = UDim2.new(0, 34, 0.5, 0)
	headerTitle.Size = UDim2.new(1, -100, 1, 0)
	headerTitle.BackgroundTransparency = 1
	headerTitle.Text = title
	headerTitle.Font = Enum.Font.GothamBold
	headerTitle.TextSize = 15
	headerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	headerTitle.TextXAlignment = Enum.TextXAlignment.Left
	headerTitle.ZIndex = 6
	headerTitle.Parent = header

	local chevron = Instance.new("ImageLabel")
	chevron.Name = "Chevron"
	chevron.AnchorPoint = Vector2.new(1, 0.5)
	chevron.Position = UDim2.new(1, -4, 0.5, 0)
	chevron.Size = UDim2.fromOffset(14, 14)
	chevron.BackgroundTransparency = 1
	chevron.Image = "rbxassetid://5279719038"
	chevron.ImageColor3 = Color3.fromRGB(200, 200, 205)
	chevron.Rotation = isOpen and 180 or 0
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
	bodyPadding.PaddingLeft = UDim.new(0, 8)
	bodyPadding.PaddingRight = UDim.new(0, 8)
	bodyPadding.PaddingBottom = UDim.new(0, 8)
	bodyPadding.Parent = body

	local bodyLayout = Instance.new("UIListLayout")
	bodyLayout.FillDirection = Enum.FillDirection.Vertical
	bodyLayout.SortOrder = Enum.SortOrder.LayoutOrder
	bodyLayout.Parent = body

	body:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if isOpen then
			clipper.Size = UDim2.new(1, 0, 0, body.AbsoluteSize.Y)
		end
	end)

	clipper.Size = UDim2.new(1, 0, 0, isOpen and body.AbsoluteSize.Y or 0)

	local function toggle()
		isOpen = not isOpen
		tween(chevron, 0.2, { Rotation = isOpen and 180 or 0 })
		tween(clipper, 0.2, {
			Size = UDim2.new(1, 0, 0, isOpen and body.AbsoluteSize.Y or 0),
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	end

	header.MouseButton1Click:Connect(toggle)

	return section, body
end

UI.createNotificationSystem = function(parentGui)
	local notificationContainer = Instance.new("Frame")
	notificationContainer.Name = "NotificationContainer"
	notificationContainer.AnchorPoint = Vector2.new(1, 1)
	notificationContainer.Position = UDim2.new(1, -16, 1, -16)
	notificationContainer.Size = UDim2.fromOffset(280, 0)
	notificationContainer.AutomaticSize = Enum.AutomaticSize.Y
	notificationContainer.BackgroundTransparency = 1
	notificationContainer.ZIndex = 200
	notificationContainer.Parent = parentGui

	local notificationList = Instance.new("UIListLayout")
	notificationList.FillDirection = Enum.FillDirection.Vertical
	notificationList.HorizontalAlignment = Enum.HorizontalAlignment.Right
	notificationList.VerticalAlignment = Enum.VerticalAlignment.Bottom
	notificationList.SortOrder = Enum.SortOrder.LayoutOrder
	notificationList.Padding = UDim.new(0, 10)
	notificationList.Parent = notificationContainer

	local function notify(title, message)
		local slot = Instance.new("Frame")
		slot.Name = "NotificationSlot"
		slot.Size = UDim2.fromOffset(280, 64)
		slot.BackgroundTransparency = 1
		slot.ClipsDescendants = false
		slot.ZIndex = 200
		slot.Parent = notificationContainer

		local card = Instance.new("Frame")
		card.Name = "Notification"
		card.AnchorPoint = Vector2.new(0, 0)
		card.Position = UDim2.fromOffset(300, 0)
		card.Size = UDim2.fromOffset(280, 64)
		card.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
		card.BackgroundTransparency = 1
		card.ClipsDescendants = true
		card.ZIndex = 200
		card.Parent = slot

		local cardCorner = Instance.new("UICorner")
		cardCorner.CornerRadius = UDim.new(0, 12)
		cardCorner.Parent = card

		local cardStroke = Instance.new("UIStroke")
		cardStroke.Color = Color3.fromRGB(45, 45, 50)
		cardStroke.Thickness = 1
		cardStroke.Transparency = 1
		cardStroke.Parent = card

		local logo = Instance.new("ImageLabel")
		logo.Name = "Logo"
		logo.AnchorPoint = Vector2.new(0, 0.5)
		logo.Position = UDim2.new(0, 14, 0.5, 0)
		logo.Size = UDim2.fromOffset(28, 28)
		logo.BackgroundTransparency = 1
		logo.Image = "rbxassetid://71984635708160"
		logo.ImageTransparency = 1
		logo.ScaleType = Enum.ScaleType.Fit
		logo.ZIndex = 201
		logo.Parent = card

		local titleLabel = Instance.new("TextLabel")
		titleLabel.Name = "Title"
		titleLabel.AnchorPoint = Vector2.new(0, 0)
		titleLabel.Position = UDim2.new(0, 52, 0, 12)
		titleLabel.Size = UDim2.new(1, -62, 0, 18)
		titleLabel.BackgroundTransparency = 1
		titleLabel.Text = title or ""
		titleLabel.Font = Enum.Font.GothamBold
		titleLabel.TextSize = 14
		titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		titleLabel.TextTransparency = 1
		titleLabel.TextXAlignment = Enum.TextXAlignment.Left
		titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
		titleLabel.ZIndex = 201
		titleLabel.Parent = card

		local messageLabel = Instance.new("TextLabel")
		messageLabel.Name = "Message"
		messageLabel.AnchorPoint = Vector2.new(0, 0)
		messageLabel.Position = UDim2.new(0, 52, 0, 32)
		messageLabel.Size = UDim2.new(1, -62, 0, 26)
		messageLabel.BackgroundTransparency = 1
		messageLabel.Text = message or ""
		messageLabel.Font = Enum.Font.Gotham
		messageLabel.TextSize = 12
		messageLabel.TextColor3 = Color3.fromRGB(170, 170, 175)
		messageLabel.TextTransparency = 1
		messageLabel.TextXAlignment = Enum.TextXAlignment.Left
		messageLabel.TextYAlignment = Enum.TextYAlignment.Top
		messageLabel.TextWrapped = true
		messageLabel.ZIndex = 201
		messageLabel.Parent = card

		local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		TweenService:Create(card, tweenInfo, { Position = UDim2.fromOffset(0, 0), BackgroundTransparency = 0 }):Play()
		TweenService:Create(cardStroke, tweenInfo, { Transparency = 0 }):Play()
		TweenService:Create(logo, tweenInfo, { ImageTransparency = 0 }):Play()
		TweenService:Create(titleLabel, tweenInfo, { TextTransparency = 0 }):Play()
		TweenService:Create(messageLabel, tweenInfo, { TextTransparency = 0 }):Play()

		task.delay(4, function()
			local outInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
			local outTween = TweenService:Create(card, outInfo, {
				Position = UDim2.fromOffset(300, 0),
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

	return notify
end

return UI
