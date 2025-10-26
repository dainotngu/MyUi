-- Ui by OBIIDAI
repeat task.wait() until game:IsLoaded()

-- Services
local TweenService    = game:GetService("TweenService")
local UserInput       = game:GetService("UserInputService")
local CoreGui         = game:GetService("CoreGui")
local Lighting        = game:GetService("Lighting")
local Debris          = game:GetService("Debris")

-- ===== Helpers =====
local function safeNew(class,props)
	local obj = Instance.new(class)
	if props then
		for k,v in pairs(props) do
			pcall(function()
				if k=="Parent" then obj.Parent=v else obj[k]=v end
			end)
		end
	end
	return obj
end
local function safeDestroy(o) if o and o.Destroy then pcall(function() o:Destroy() end) end end
local function protectGui(g) if syn and syn.protect_gui then pcall(syn.protect_gui,g) end end
local function lerpColor(a,b,t) return Color3.new(a.R + (b.R-a.R)*t,a.G + (b.G-a.G)*t,a.B + (b.B-a.B)*t) end
local function tween(inst,props,time,style,dir)
	local info=TweenInfo.new(time or 0.25,style or Enum.EasingStyle.Quad,dir or Enum.EasingDirection.Out)
	local ok,tw = pcall(function() return TweenService:Create(inst,info,props) end)
	if ok and tw then pcall(function() tw:Play() end) end
	return tw
end

-- ===== Themes (50+) =====
local THEMES={
	Neon={bg=Color3.fromRGB(12,6,28),text=Color3.fromRGB(245,240,255),accent=Color3.fromRGB(200,40,255)},
	Ocean={bg=Color3.fromRGB(6,26,36),text=Color3.fromRGB(220,240,250),accent=Color3.fromRGB(24,160,220)},
	Midnight={bg=Color3.fromRGB(6,6,18),text=Color3.fromRGB(240,240,255),accent=Color3.fromRGB(160,120,255)},
	Cyber={bg=Color3.fromRGB(10,2,24),text=Color3.fromRGB(255,120,240),accent=Color3.fromRGB(255,60,140)},
	Aurora={bg=Color3.fromRGB(8,10,32),text=Color3.fromRGB(210,230,255),accent=Color3.fromRGB(120,220,200)},
	Gold={bg=Color3.fromRGB(40,32,12),text=Color3.fromRGB(255,230,180),accent=Color3.fromRGB(255,190,70)},
	Emerald={bg=Color3.fromRGB(8,36,22),text=Color3.fromRGB(180,255,200),accent=Color3.fromRGB(40,180,90)},
	Retro={bg=Color3.fromRGB(34,8,36),text=Color3.fromRGB(255,110,200),accent=Color3.fromRGB(255,48,140)},
	Steel={bg=Color3.fromRGB(40,44,50),text=Color3.fromRGB(220,220,230),accent=Color3.fromRGB(110,130,150)},
	Glass={bg=Color3.fromRGB(18,22,26),text=Color3.fromRGB(230,240,245),accent=Color3.fromRGB(80,200,240)},
	Candy={bg=Color3.fromRGB(48,12,40),text=Color3.fromRGB(255,200,230),accent=Color3.fromRGB(255,120,200)},
	Ice={bg=Color3.fromRGB(220,234,246),text=Color3.fromRGB(12,30,50),accent=Color3.fromRGB(30,140,220)},
	Flame={bg=Color3.fromRGB(44,8,6),text=Color3.fromRGB(255,160,140),accent=Color3.fromRGB(255,80,24)},
	Shadow={bg=Color3.fromRGB(22,22,26),text=Color3.fromRGB(210,210,220),accent=Color3.fromRGB(120,120,160)},
	Pearl={bg=Color3.fromRGB(250,248,246),text=Color3.fromRGB(18,20,22),accent=Color3.fromRGB(110,140,200)},
	Nova={bg=Color3.fromRGB(12,6,24),text=Color3.fromRGB(240,210,255),accent=Color3.fromRGB(200,80,255)},
	Sand={bg=Color3.fromRGB(245,230,210),text=Color3.fromRGB(32,28,18),accent=Color3.fromRGB(200,150,110)},
	Jade={bg=Color3.fromRGB(8,40,26),text=Color3.fromRGB(170,255,210),accent=Color3.fromRGB(40,200,120)},
	Chrome={bg=Color3.fromRGB(14,18,22),text=Color3.fromRGB(220,230,240),accent=Color3.fromRGB(160,200,255)},
	Plasma={bg=Color3.fromRGB(10,6,30),text=Color3.fromRGB(230,190,255),accent=Color3.fromRGB(255,90,200)},
	Rose={bg=Color3.fromRGB(28,10,18),text=Color3.fromRGB(255,200,230),accent=Color3.fromRGB(255,110,150)},
	Mint={bg=Color3.fromRGB(220,255,245),text=Color3.fromRGB(12,70,50),accent=Color3.fromRGB(70,200,140)},
	OceanDeep={bg=Color3.fromRGB(2,16,28),text=Color3.fromRGB(170,220,240),accent=Color3.fromRGB(10,120,180)},
	Violet={bg=Color3.fromRGB(18,4,40),text=Color3.fromRGB(220,180,255),accent=Color3.fromRGB(160,50,255)},
	Glacier={bg=Color3.fromRGB(200,225,240),text=Color3.fromRGB(12,24,42),accent=Color3.fromRGB(30,140,220)},
	Coral={bg=Color3.fromRGB(44,18,20),text=Color3.fromRGB(255,200,195),accent=Color3.fromRGB(255,120,110)},
	Forest={bg=Color3.fromRGB(8,40,12),text=Color3.fromRGB(160,255,140),accent=Color3.fromRGB(30,120,40)},
	NeonVoid={bg=Color3.fromRGB(10,0,20),text=Color3.fromRGB(255,90,255),accent=Color3.fromRGB(120,0,255)},
	Dream={bg=Color3.fromRGB(6,8,20),text=Color3.fromRGB(210,190,245),accent=Color3.fromRGB(140,110,230)},
	Lava={bg=Color3.fromRGB(35,4,0),text=Color3.fromRGB(255,180,100),accent=Color3.fromRGB(255,80,0)},
	Twilight={bg=Color3.fromRGB(10,6,18),text=Color3.fromRGB(220,190,255),accent=Color3.fromRGB(150,90,255)},
	Horizon={bg=Color3.fromRGB(12,20,32),text=Color3.fromRGB(200,220,255),accent=Color3.fromRGB(100,180,255)},
	Starlight={bg=Color3.fromRGB(2,4,12),text=Color3.fromRGB(180,200,255),accent=Color3.fromRGB(60,120,255)},
	Cosmic={bg=Color3.fromRGB(6,0,18),text=Color3.fromRGB(255,180,255),accent=Color3.fromRGB(200,50,255)},
	Sunset={bg=Color3.fromRGB(35,18,8),text=Color3.fromRGB(255,200,180),accent=Color3.fromRGB(255,100,50)},
	Eclipse={bg=Color3.fromRGB(8,8,8),text=Color3.fromRGB(220,220,255),accent=Color3.fromRGB(100,100,255)},
	Iridescent={bg=Color3.fromRGB(12,8,24),text=Color3.fromRGB(240,240,255),accent=Color3.fromRGB(255,100,255)}
}
local DEFAULT_THEME="Neon"

-- ===== FX VIP Engine =====
local FX={}
-- Basic fades
FX.FadeIn=function(obj,time) if not obj then return end; local orig=obj.BackgroundTransparency or 0; obj.BackgroundTransparency=1; tween(obj,{BackgroundTransparency=orig},time or 0.35) end
FX.FadeOut=function(obj,time) if not obj then return end; tween(obj,{BackgroundTransparency=1},time or 0.28); task.delay(time or 0.28,function() if obj then obj.Visible=false end end) end

-- Pulse
FX.Pulse=function(obj,scale,time)
	scale=scale or 1.06
	local orig=obj.Size
	tween(obj,{Size=UDim2.new(orig.X.Scale*scale,orig.X.Offset*scale,orig.Y.Scale*scale,orig.Y.Offset*scale)},time or 0.14)
	task.delay(time or 0.14,function() tween(obj,{Size=orig},time or 0.14) end)
end

-- Neon Stroke
FX.NeonStroke=function(obj,color,duration)
	if not obj then return end
	color=color or Color3.fromRGB(200,80,255)
	duration=duration or 3
	local stroke=safeNew("UIStroke",{Parent=obj,Color=color,Thickness=2,Transparency=0.9})
	task.spawn(function()
		local alive=true
		local remaining=duration
		while stroke and stroke.Parent and alive do
			for t=0.9,0.3,-0.04 do stroke.Transparency=t task.wait(0.02) end
			for t=0.3,0.9,0.04 do stroke.Transparency=t task.wait(0.02) end
			remaining=remaining-0.16
			if remaining<=0 then alive=false end
		end
	end)
	Debris:AddItem(stroke,duration)
end

-- Ripple
FX.Ripple=function(parent,origin,color,time)
	if not parent then return end
	time=time or 0.45
	color=color or Color3.new(1,1,1)
	origin=origin or UDim2.new(0.5,0,0.5,0)
	local r=safeNew("Frame",{Parent=parent,Size=UDim2.new(0,0,0,0),Position=origin,BackgroundColor3=color,BackgroundTransparency=0.6,ZIndex=999})
	safeNew("UICorner",{Parent=r,CornerRadius=UDim.new(1,0)})
	tween(r,{Size=UDim2.new(3,0,3,0),BackgroundTransparency=1},time)
	Debris:AddItem(r,time+0.05)
end

-- BorderPulse
FX.BorderPulse=function(obj,color,time)
	if not obj then return end
	color=color or Color3.fromRGB(255,255,255)
	time=time or 0.25
	local stroke=safeNew("UIStroke",{Parent=obj,Color=color,Thickness=2,Transparency=0.8})
	tween(stroke,{Transparency=0.2},time)
	task.delay(time,function() tween(stroke,{Transparency=0.8},time) end)
	Debris:AddItem(stroke,time*2)
end

-- Notification
local NOTIFY_GUI_NAME="DAI_UI_NOTIF"
local notifyRoot=CoreGui:FindFirstChild(NOTIFY_GUI_NAME) or safeNew("ScreenGui",{Name=NOTIFY_GUI_NAME,Parent=CoreGui,ResetOnSpawn=false})
protectGui(notifyRoot)
local function Notify(text,duration,color)
	color=color or Color3.fromRGB(255,180,0)
	duration=duration or 3
	local frame=safeNew("Frame",{Parent=notifyRoot,Size=UDim2.new(0,250,0,60),Position=UDim2.new(1,10,0.5,-30),BackgroundColor3=color,BackgroundTransparency=0,ZIndex=100})
	safeNew("UICorner",{Parent=frame,CornerRadius=UDim.new(0,12)})
	local lbl=safeNew("TextLabel",{Parent=frame,Text=text,TextSize=14,Font=Enum.Font.GothamSemibold,TextColor3=Color3.new(1,1,1),BackgroundTransparency=1,Size=UDim2.new(1,-12,1,-12),Position=UDim2.new(0,6,0,6),TextWrapped=true})
	tween(frame,{Position=UDim2.new(1,-260,0.5,-30)},0.4)
	task.delay(duration,function()
		tween(frame,{Position=UDim2.new(1,10,0.5,-30)},0.35)
		task.delay(0.36,function() safeDestroy(frame) end)
	end)
end

-- ===== UI Core =====
local UI={}
UI.Version="v200"
UI.Themes=THEMES
UI.FX=FX
UI.Notify=Notify

-- Root
local GUI_NAME="DAI_UI_V200"
if CoreGui:FindFirstChild(GUI_NAME) then safeDestroy(CoreGui[GUI_NAME]) end
local ROOT=safeNew("ScreenGui",{Name=GUI_NAME,Parent=CoreGui,ResetOnSpawn=false})
protectGui(ROOT)

-- State
local State={
	ThemeName=DEFAULT_THEME,
	Theme=THEMES[DEFAULT_THEME],
	Acrylic=true,
	BlurIntensity=8,
	LastWindow=nil,
	Visible=true
}

-- UI Init
function UI:Init(cfg)
	cfg=cfg or {}
	State.ThemeName=cfg.Theme or State.ThemeName
	State.Theme=THEMES[State.ThemeName] or State.Theme
	State.Acrylic=(cfg.Acrylic==nil) and State.Acrylic or cfg.Acrylic
	State.BlurIntensity=cfg.BlurIntensity or State.BlurIntensity
	if State.Acrylic then
		local b=Lighting:FindFirstChild("DAI_UI_v200_BLUR") or Instance.new("BlurEffect")
		b.Name="DAI_UI_v200_BLUR"; b.Parent=Lighting; b.Size=State.BlurIntensity
	end
	-- Toggle UI RightShift
	UserInput.InputBegan:Connect(function(input)
		if input.KeyCode==Enum.KeyCode.RightShift then
			State.Visible=not State.Visible
			ROOT.Enabled=State.Visible
		end
	end)
end

-- UI:CreateWindow
function UI:CreateWindow(opts)
	opts=opts or {}
	local size=opts.Size or UDim2.fromOffset(780,540)
	local theme=THEMES[opts.Theme or State.ThemeName] or State.Theme

	local root=safeNew("Frame",{Parent=ROOT,Size=size,Position=UDim2.new(0.5,0,0.5,0),AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=theme.bg,BorderSizePixel=0,ZIndex=50})
	safeNew("UICorner",{Parent=root,CornerRadius=UDim.new(0,16)})
	root.ClipsDescendants=true

	-- Header
	local header=safeNew("Frame",{Parent=root,Size=UDim2.new(1,0,0,60),BackgroundTransparency=1})
	local title=safeNew("TextLabel",{Parent=header,Text=opts.Title or "DAI UI VIP",Font=Enum.Font.GothamBold,TextSize=20,TextColor3=theme.text,BackgroundTransparency=1,Position=UDim2.new(0,16,0,8),Size=UDim2.new(1,-32,0,28),TextXAlignment=Enum.TextXAlignment.Left})
	local subtitle=safeNew("TextLabel",{Parent=header,Text=opts.SubTitle or "",Font=Enum.Font.Gotham,TextSize=12,TextColor3=theme.accent,BackgroundTransparency=1,Position=UDim2.new(0,16,0,34),Size=UDim2.new(1,-32,0,18),TextXAlignment=Enum.TextXAlignment.Left})

	local content=safeNew("Frame",{Parent=root,Position=UDim2.new(0,16,0,70),Size=UDim2.new(1,-32,1,-86),BackgroundTransparency=1})
	safeNew("UIListLayout",{Parent=content,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8)})

	-- Tabs storage
	local Tabs={}
	function root:AddTab(tabOpts)
		tabOpts=tabOpts or {}
		local t={Title=tabOpts.Title or ("Tab"..(#Tabs+1))}
		t.Frame=safeNew("Frame",{Parent=content,Size=UDim2.new(1,0,0,100),BackgroundColor3=theme.bg,BorderSizePixel=0
