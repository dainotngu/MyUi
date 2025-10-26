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
local function tween(inst,props,time,style,dir)
    local info=TweenInfo.new(time or 0.25,style or Enum.EasingStyle.Quad,dir or Enum.EasingDirection.Out)
    local ok,tw = pcall(function() return TweenService:Create(inst,info,props) end)
    if ok and tw then pcall(function() tw:Play() end) end
    return tw
end

-- ===== UI Root =====
local GUI_NAME="DAI_UI_V300"
if CoreGui:FindFirstChild(GUI_NAME) then safeDestroy(CoreGui[GUI_NAME]) end
local ROOT=safeNew("ScreenGui",{Name=GUI_NAME,Parent=CoreGui,ResetOnSpawn=false})
protectGui(ROOT)

-- ===== Themes 50+ =====
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
FX.FadeIn=function(obj,time)
    if not obj then return end
    local orig=obj.BackgroundTransparency or 0
    obj.BackgroundTransparency=1
    tween(obj,{BackgroundTransparency=orig},time or 0.35)
end
FX.FadeOut=function(obj,time)
    if not obj then return end
    tween(obj,{BackgroundTransparency=1},time or 0.28)
    task.delay(time or 0.28,function() if obj then obj.Visible=false end end)
end
FX.Pulse=function(obj,scale,time)
    scale=scale or 1.06
    local orig=obj.Size
    tween(obj,{Size=UDim2.new(orig.X.Scale*scale,orig.X.Offset*scale,orig.Y.Scale*scale,orig.Y.Offset*scale)},time or 0.14)
    task.delay(time or 0.14,function() tween(obj,{Size=orig},time or 0.14) end)
end
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

-- ===== Notifications =====
local function Notify(text,duration,color)
    color=color or Color3.fromRGB(255,180,0)
    duration=duration or 3
    local frame=safeNew("Frame",{Parent=ROOT,Size=UDim2.new(0,250,0,60),Position=UDim2.new(1,10,0.5,-30),BackgroundColor3=color,ZIndex=100})
    safeNew("UICorner",{Parent=frame,CornerRadius=UDim.new(0,12)})
    safeNew("TextLabel",{Parent=frame,Text=text,TextSize=14,Font=Enum.Font.GothamSemibold,TextColor3=Color3.new(1,1,1),BackgroundTransparency=1,Size=UDim2.new(1,-12,1,-12),Position=UDim2.new(0,6,0,6),TextWrapped=true})
    tween(frame,{Position=UDim2.new(1,-260,0.5,-30)},0.4)
    task.delay(duration,function()
        tween(frame,{Position=UDim2.new(1,10,0.5,-30)},0.35)
        task.delay(0.36,function() safeDestroy(frame) end)
    end)
end

-- ===== UI Window Builder =====
function UI:CreateWindow(opts)
    opts=opts or {}
    local theme=THEMES[opts.Theme or DEFAULT_THEME]
    local window=safeNew("Frame",{Parent=ROOT,Size=UDim2.fromOffset(780,540),Position=UDim2.new(0.5,0,0.5,0),AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=theme.bg,BorderSizePixel=0,ZIndex=50})
    safeNew("UICorner",{Parent=window,CornerRadius=UDim.new(0,16)})
    window.ClipsDescendants=true

    local header=safeNew("Frame",{Parent=window,Size=UDim2.new(1,0,0,60),BackgroundTransparency=1})
    safeNew("TextLabel",{Parent=header,Text=opts.Title or "DAI UI Pro",Font=Enum.Font.GothamBold,TextSize=20,TextColor3=theme.text,BackgroundTransparency=1,Position=UDim2.new(0,16,0,8),Size=UDim2.new(1,-32,0,28),TextXAlignment=Enum.TextXAlignment.Left})
    safeNew("TextLabel",{Parent=header,Text=opts.SubTitle or "",Font=Enum.Font.Gotham,TextSize=12,TextColor3=theme.accent,BackgroundTransparency=1,Position=UDim2.new(0,16,0,34),Size=UDim2.new(1,-32,0,18),TextXAlignment=Enum.TextXAlignment.Left})

    local content=safeNew("Frame",{Parent=window,Position=UDim2.new(0,16,0,70),Size=UDim2.new(1,-32,1,-86),BackgroundTransparency=1})
    safeNew("UIListLayout",{Parent=content,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8)})

    local winObj={}
    winObj.AddButton=function(opts)
        local btn=safeNew("TextButton",{Parent=content,Text=opts.Title or "Button",Size=UDim2.new(1,0,0,40),BackgroundColor3=theme.accent,TextColor3=theme.text,Font=Enum.Font.GothamBold,TextSize=16,BorderSizePixel=0})
        safeNew("UICorner",{Parent=btn,CornerRadius=UDim.new(0,12)})
        btn.MouseButton1Click:Connect(function()
            if opts.Callback then pcall(opts.Callback) end
            Notify("Clicked: "..(opts.Title or "Button"))
        end)
        return btn
    end
    winObj.AddToggle=function(opts)
        local frame=safeNew("Frame",{Parent=content,Size=UDim2.new(1,0,0,40),BackgroundTransparency=1})
        local lbl=safeNew("TextLabel",{Parent=frame,Text=opts.Title or "Toggle",Size=UDim2.new(1,-50,1,0),Position=UDim2.new(0,0,0,0),TextColor3=theme.text,Font=Enum.Font.GothamBold,TextSize=16,BackgroundTransparency=1})
        local toggle=safeNew("TextButton",{Parent=frame,Size=UDim2.new(0,40,0,40),Position=UDim2.new(1,-40,0,0),BackgroundColor3=theme.accent,Text="",BorderSizePixel=0})
        safeNew("UICorner",{Parent=toggle,CornerRadius=UDim.new(0,12)})
        local state=opts.Default or false
        local function update()
            toggle.BackgroundColor3=state and theme.accent or Color3.fromRGB(100,100,100)
        end
        update()
        toggle.MouseButton1Click:Connect(function()
            state=not state
            update()
            if opts.Callback then pcall(opts.Callback,state) end
            Notify((opts.Title or "Toggle").." "..(state and "ON" or "OFF"))
        end)
    end
    winObj.AddDropdown=function(opts)
        local frame=safeNew("Frame",{Parent=content,Size=UDim2.new(1,0,0,40),BackgroundTransparency=1})
        local lbl=safeNew("TextLabel",{Parent=frame,Text=opts.Title or "Dropdown",Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,0,0,0),TextColor3=theme.text,Font=Enum.Font.GothamBold,TextSize=16,BackgroundTransparency=1})
        local selected=opts.Default or opts.Options[1]
        local ddBtn=safeNew("TextButton",{Parent=frame,Size=UDim2.new(0,120,0,30),Position=UDim2.new(1,-130,0,5),BackgroundColor3=theme.accent,Text=selected,TextColor3=theme.text,Font=Enum.Font.GothamBold,TextSize=14})
        safeNew("UICorner",{Parent=ddBtn,CornerRadius=UDim.new(0,10)})
        local ddFrame=safeNew("Frame",{Parent=frame,Size=UDim2.new(0,120,0,#opts.Options*30),Position=UDim2.new(1,-130,0,35),BackgroundColor3=theme.bg,Visible=false,ClipsDescendants=true})
        safeNew("UICorner",{Parent=ddFrame,CornerRadius=UDim.new(0,10)})
        for i,opt in pairs(opts.Options) do
            local btn=safeNew("TextButton",{Parent=ddFrame,Text=opt,Size=UDim2.new(1,0,0,30),BackgroundColor3=theme.accent,TextColor3=theme.text,Font=Enum.Font.GothamBold,TextSize=14,BorderSizePixel=0,Position=UDim2.new(0,0,(i-1)/#opts.Options,0)})
            btn.MouseButton1Click:Connect(function()
                selected=opt
                ddBtn.Text=selected
                ddFrame.Visible=false
                if opts.Callback then pcall(opts.Callback,selected) end
                Notify(opts.Title.." chọn: "..selected)
            end)
        end
        ddBtn.MouseButton1Click:Connect(function() ddFrame.Visible=not ddFrame.Visible end)
    end
    winObj.Show=function() window.Visible=true end
    winObj.Hide=function() window.Visible=false end
    winObj.SetTheme=function(t)
        local theme=THEMES[t] or THEMES[DEFAULT_THEME]
        window.BackgroundColor3=theme.bg
        for _,obj in pairs(window:GetDescendants()) do
            if obj:IsA("TextLabel") then obj.TextColor3=theme.text end
            if obj:IsA("TextButton") then obj.BackgroundColor3=theme.accent; obj.TextColor3=theme.text end
        end
    end

    return winObj
end

UI.Notify=Notify
UI.Root=ROOT
