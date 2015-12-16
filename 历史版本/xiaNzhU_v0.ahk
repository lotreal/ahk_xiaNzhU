; ------------------------------------------------------------------------------
; Var Config {
INI_FILE = %A_WorkingDir%\zxbb.ini

; 一般设定
KO_ONCE      = 1
ADD_HP_WHEN = 0.5
ADD_MP_WHEN = 0.01

; 热键
HK_SKILL1   = 1
HK_SKILL2   = 2
HK_PICKUP   = 3
HK_ADDHP    = F1
HK_ADDMP    = F4
HK_REST     = 7
HK_DANGER   = 8

; ------------------------------------------------------------------------------
myTotalHP := 219

monbarMax := 548
monbarMin := 430
monbarY := 54
monbarColor := 0x4141FD

hpbarMax := 240
hpbarMin := 123
hpbarY := 41
hpbarColor := 0x0000F8

mpbarMax := 240
mpbarMin := 123
mpbarY := 59
mpbarColor := 0xD56D22

tpX := 240
tpY := 41
tpC := 1

SWITCH_CHECKHP  := true
; 日志设置
LOG_TO_CHAT     := false
; ------------------------------------------------------------------------------
readConfig() {
    global
    IniRead, KO_ONCE,       %INI_FILE%, Config, KO_ONCE,        %KO_ONCE%
    IniRead, ADD_HP_WHEN,   %INI_FILE%, Config, ADD_HP_WHEN,    %ADD_HP_WHEN%
    IniRead, ADD_MP_WHEN,   %INI_FILE%, Config, ADD_MP_WHEN,    %ADD_MP_WHEN%

    IniRead, HK_SKILL1, %INI_FILE%, Hotkey, HK_SKILL1,  %HK_SKILL1%
    IniRead, HK_SKILL2, %INI_FILE%, Hotkey, HK_SKILL2,  %HK_SKILL2%
    IniRead, HK_PICKUP, %INI_FILE%, Hotkey, HK_PICKUP,  %HK_PICKUP%
    IniRead, HK_ADDHP,  %INI_FILE%, Hotkey, HK_ADDHP,   %HK_ADDHP%
    IniRead, HK_ADDMP,  %INI_FILE%, Hotkey, HK_ADDMP,   %HK_ADDMP%
    IniRead, HK_REST,   %INI_FILE%, Hotkey, HK_REST,    %HK_REST%
    ;MsgBox, The value is %KO_ONCE%.
}
readConfig()

writeConfig() {
    global
    IniWrite, %KO_ONCE%,        %INI_FILE%, Config, KO_ONCE
    IniWrite, %ADD_HP_WHEN%,    %INI_FILE%, Config, ADD_HP_WHEN
    IniWrite, %ADD_MP_WHEN%,    %INI_FILE%, Config, ADD_MP_WHEN


    IniWrite, %HK_SKILL1%,  %INI_FILE%, Hotkey, HK_SKILL1
    IniWrite, %HK_SKILL2%,  %INI_FILE%, Hotkey, HK_SKILL2
    IniWrite, %HK_PICKUP%,  %INI_FILE%, Hotkey, HK_PICKUP
    IniWrite, %HK_ADDHP%,   %INI_FILE%, Hotkey, HK_ADDHP
    IniWrite, %HK_ADDMP%,   %INI_FILE%, Hotkey, HK_ADDMP
    IniWrite, %HK_REST%,    %INI_FILE%, Hotkey, HK_REST
}
;}
; ------------------------------------------------------------------------------
; GUI {

Gui, Font, S14 CDefault, Verdana

Gui, Add, Tab, x12 y16 w490 h339 , 一般设置|技能快捷键|日志
Gui, Add, Text, x26 y60 w210 h30 , 打几个怪物后休息？
Gui, Add, Edit, x316 y60 w90 h30 vKO_ONCE, %KO_ONCE%
Gui, Add, Text, x26 y110 w250 h30 , 当HP低于百分之几时加血？
Gui, Add, Edit, x316 y110 w90 h30 vADD_HP_WHEN, %ADD_HP_WHEN%
Gui, Add, Text, x26 y160 w250 h30 , 当MP低于百分之几时加蓝？
Gui, Add, Edit, x316 y160 w90 h30 vADD_MP_WHEN, %ADD_MP_WHEN%
Gui, Add, Text, x26 y210 w320 h30 , 当HP低于百分之几时按危险键？
Gui, Add, Edit, x316 y210 w90 h30 , 开发中
Gui, Add, Text, x26 y260 w250 h30 , 每隔几分钟自动换线？
Gui, Add, Edit, x316 y260 w90 h30 , 开发中

Gui, Tab, 2
Gui, Add, Text, x26 y60 w140 h30 , 普通攻击技能
Gui, Add, Hotkey, x196 y60 w100 h30 vHK_SKILL1, %HK_SKILL1%
Gui, Add, Text, x26 y100 w140 h30, 连续技
Gui, Add, Hotkey, x196 y100 w100 h30 vHK_SKILL2, %HK_SKILL2%
Gui, Add, Text, x26 y140 w140 h30 , 拣取物品
Gui, Add, Hotkey, x196 y140 w100 h30 vHK_PICKUP, %HK_PICKUP%
Gui, Add, Text, x26 y180 w140 h30 , 加HP
Gui, Add, Hotkey, x196 y180 w100 h30 vHK_ADDHP, %HK_ADDHP%
Gui, Add, Text, x26 y220 w140 h30 , 加MP
Gui, Add, Hotkey, x196 y220 w100 h30 vHK_ADDMP, %HK_ADDMP%
Gui, Add, Text, x26 y260 w140 h30 , 打坐
Gui, Add, Hotkey, x196 y260 w100 h30 vHK_REST, %HK_REST%
Gui, Add, Text, x26 y300 w140 h30 , 危险时按
Gui, Add, Hotkey, x196 y300 w100 h30 , %HK_DANGER%

Gui, Tab, 3
Gui, Add, Edit, x26 y60 w460 h280 vAppLog, %A_Now%
Gui, Tab

Gui, Add, Button, x286 y370 w170 h50 , OK
Gui, Add, Button, x96 y370 w170 h50 , Test

; Generated using SmartGUI Creator 4.0
Gui, submit, NoHide
;Gui, Show, x154 y137 h437 w523, 《诛仙》·宝宝版
Return

;}
; ------------------------------------------------------------------------------
; GUI Events{
GuiClose:
ExitApp

GuiMinimize:
Gui, Hide
return

ButtonOk:
    Gui, submit, NoHide
    writeConfig()
    ;ExitApp
return

ButtonTest:
    Gui, submit, NoHide
    ;logger("add")  ;测试logger
    MsgBox %KO_ONCE%
    ;ExitApp
return
;}
; ------------------------------------------------------------------------------
; Functions {
; ------------------------------------------------------------------------------
logger(msg) {
    global
    logToGui(msg)
    if LOG_TO_CHAT
        logToChat(msg)
}
debug(msg) {
    logger(msg)
}
logToClipboard(msg) {
}
logToChat(msg) {
	MouseClick, left, 894, 723
    clipboard = %msg%
    Send ^v
    Sleep 100
    Send ^{Enter}
    MouseClick, left, 937, 482
}
logToGui(msg) {
    global
    Gui, submit, NoHide
    GuiControl,, AppLog, %AppLog%`n%msg%
    Gui, submit, NoHide
    ;MsgBox %AppLog%
}
;------------------------------------------------------------------------------
coloreq(x,y,c) {
	PixelGetColor, color, x, y
	return color = c
}
;------------------------------------------------------------------------------
getColor(x,y) {
	PixelGetColor, color, x, y
    ;str = The color at %x%, %y% is %color%
    ;debug(str)
	return color
}
;------------------------------------------------------------------------------
getSpColorOfBar(fromP, toP, yP, percent) {
    spX := fromP + Ceil((toP - fromP) * percent)
    return getColor(spX, yP)
}
;------------------------------------------------------------------------------
getPercentFromColorBar(fromP, toP, yP, barColor) {
    totalLength := toP - fromP
    barLength := 0
    Loop, %totalLength% {
        if !coloreq(fromP+barLength, yP, barColor)
            break
        barLength++
    }
    p := barLength / totalLength
    ;debug(p)
    return p
}
;------------------------------------------------------------------------------
getMonHP() {
    global monbarMax
    global monbarMin
    global monbarY
    global monbarColor

    p := getPercentFromColorBar(monbarMin, monbarMax, monbarY, monbarColor)
    return p
}
;------------------------------------------------------------------------------
getMyHP() {
    global hpbarMax
    global hpbarMin
    global hpbarY
    global hpbarColor

    p := getPercentFromColorBar(hpbarMin, hpbarMax, hpbarY, hpbarColor)
    return p
}
;------------------------------------------------------------------------------
getMyMP() {
    global
    p := getPercentFromColorBar(mpbarMin, mpbarMax, mpbarY, mpbarColor)
    return p
}
;------------------------------------------------------------------------------
; 是否选中怪物
monsterIsChecked() {
	;检查怪物标题条左上角颜色是否为黑色
	return coloreq(432, 30, "0x0C0E10")
}
;------------------------------------------------------------------------------
; 是否已选中没人打的怪物
commonMonsterIsChecked() {
	if !monsterIsChecked() {
	    return false
	} else {
		;检查最右端的血条颜色是否为红色
        ret := coloreq(548, 54, 0x4141FD)
		return ret
	}
}
;------------------------------------------------------------------------------
hpisfull() {
    global
    ret := coloreq(hpbarMax, hpbarY, hpbarColor)
	return ret
}
isHpLess(percent) {
    global
    ret := getSpColorOfBar(hpbarMin, hpbarMax, hpbarY, percent) != hpbarColor
	return ret
}
;------------------------------------------------------------------------------
mpisfull() {
    global
    ret := coloreq(mpbarMax, mpbarY, mpbarColor)
	return ret
}
isMpLess(percent) {
    global
    ret := getSpColorOfBar(mpbarMin, mpbarMax, mpbarY, percent) != mpbarColor
	return ret
}
;------------------------------------------------------------------------------
checkMonHited(mu, idx) {
    static count := 0
    static hp1 := 0
    static hp2 := 0

    if idx = 0
        count = 0

    ret := "unknow"
	if monsterIsChecked() == 0 { ;怪物没有选中
    	count := 0
    	return "noMonster"
    }

    if count = 0
        hp1 := getMonHP()

    if count = %mu%
    {
        hp2 := getMonHP()
        SetFormat, float, 0.2
        str = hp1: %hp1%, hp2: %hp2%
        debug(str)
        count := 0
        if hp2 - hp1 < 0
            ret := "hited"
        else
            ret := "nohit"
    } else
        count++

    return ret
}
;------------------------------------------------------------------------------
; 选中没人打的怪物，暂无延时处理
checkmonster() {
	debug("寻找没人打的怪物")
	Loop, 200
	{
		Send {tab}
		Loop, 20
		{
			Sleep 100
			if monsterIsChecked()
		    	break
		}
		if commonMonsterIsChecked()
	    	break
	}
    debug("已经选中没人打的怪物！")
}
;------------------------------------------------------------------------------
addHp() {
    global
    Send {%HK_ADDHP%}
    Sleep 50
    Send {%HK_SKILL1%}{%HK_SKILL2%}
    Sleep 500
}
addMp() {
    global
    Send {%HK_ADDMP%}
    Sleep 50
    Send {%HK_SKILL1%}{%HK_SKILL2%}
    Sleep 500
}
attack() {
    global
	; 攻击
	debug("攻击")
	Send {%HK_SKILL1%}
	Sleep 100
	Send {%HK_SKILL2%}
	; 直到怪物死亡
	Loop, 100
	{
		Sleep 200
        if checkMonHited(25, %a_index%) == "nohit" {
            debug("怪物血可能没有减少")
            Send {%HK_SKILL1%}{%HK_SKILL1%}{%HK_SKILL1%}
            Sleep 100
            Send {%HK_SKILL2%}
        }
		if !monsterIsChecked() ;怪物死亡
	    	break
	}
    debug("怪物已经死亡！")
}
;------------------------------------------------------------------------------
pickitem() { ; 捡东西
    debug("准备捡东西")
    global HK_PICKUP
	Loop, 10
	{
	    retort()
	    Sleep, 200
        Send {%HK_PICKUP%}
	}
    debug("捡东西完毕")
}
;------------------------------------------------------------------------------
kill() {
	checkmonster()
	attack()
    pickitem()
}

retort() { ; INFO 恢复反击前的事宜
	if monsterIsChecked() {
        debug("开始反击")
    	attack()
        pickitem()
        debug("反击结束！")
        return true
    } else
        return false
}
;------------------------------------------------------------------------------
rest() { ; 休息
    global
    debug("开始打坐")
	Sleep 200
	Send {%HK_REST%}
	; 直到hp,mp都满
	Loop, 4000
	{
		if retort() {
            Sleep 200
            Send {%HK_REST%}
        }
		Sleep 200
        ;debug(getMyHP())
		if hpisfull() and mpisfull()
	    	break
	}
	debug("休息好了!")
    ; 解除休息状态
    Send {%HK_SKILL1%}
    Sleep 500
}
;------------------------------------------------------------------------------
todo() {
    global
	loop, %KO_ONCE% {
	    kill()
	}
	rest()
}
;------------------------------------------------------------------------------
login() {
	Send qq33275433{tab}4or3v3r{Enter}
    ;Send qq7020140{tab}b3auty{Enter}
    ;Send lotreal{tab}b3auty{Enter}

}
; 屏幕像素颜色取样测试 {
tpright() {
    global
    getColor(++tpX, tpY)
    MouseMove, tpX, tpY
}

tpleft() {
    global
    getColor(--tpX, tpY)
    MouseMove, tpX, tpY
}

tpUp() {
    global
    getColor(tpX, --tpY)
    MouseMove, tpX, tpY
}

tpDown() {
    global
    getColor(tpX, ++tpY)
    MouseMove, tpX, tpY
}
^Left::tpleft()
^Right::tpright()
^Up::tpUp()
^Down::tpDown()
;}
; 发声函数 {
hpAlertSound() {
}
;}
;}
; ------------------------------------------------------------------------------
; Hotkeys {
^!HOME::ListVars  ;{
;}
Pause::Pause  ;{
;}

$F9::login()  ;{
;}

$F11::  ;{
    Send ^h
    loop {
    	todo()
    }
return  ;}

$F12::Reload ;{
;}

^$F12::Gui, Show, x154 y137 h437 w523, 《诛仙》·宝宝版 ;{
;}

^!z::   ;{
    MouseGetPos, MouseX, MouseY
    PixelGetColor, color, %MouseX%, %MouseY%
    msg = The color at %MouseX%, %MouseY% is %color%.
    debug(msg)
    MouseMove, %MouseX%, %MouseY%
return  ;}
;#Persistent
^h::    ;{检测怪物状态，是否击中
    if SWITCH_CHECKHP {
        SetTimer, CloseMailWarnings, 500
        SoundPlay, %A_WinDir%\Media\ding.wav
    } else {
        SetTimer, CloseMailWarnings, off
        SoundPlay, %A_WinDir%\Media\ding.wav
        Sleep 300
        SoundPlay, %A_WinDir%\Media\ding.wav
    }
    SWITCH_CHECKHP := not SWITCH_CHECKHP
return  ;}

CloseMailWarnings:
    if isHpLess(ADD_HP_WHEN) {
        addHp()
        SoundPlay, %A_WinDir%\Media\ding.wav
    }
    if isMpLess(ADD_MP_WHEN) {
        addMp()
        SoundPlay, %A_WinDir%\Media\ding.wav
    }
return

^j::    ;{检测健康状态
    SetFormat, float, 0.2
    s := "【人物状态】"
    myhp := getMyHP()
    mymp := getMyMP()

    if hpisfull()
        s .= "HP: 满"
    if mpisfull() = 1
        s .= "MP: 满"

    s .= "HP百分比："myhp
    s .= " MP百分比："mymp

    if monsterIsChecked() {
        s .= " 【怪物状态】"
        s .= "剩余血量："getMonHP()
    }
    debug(s)
return  ;}

^t::    ;{测试用
    debug(isMpLess(0.9))
;}
^!c::LOG_TO_CHAT := not LOG_TO_CHAT ;{日志输出到聊天窗口开关
;}
;}
