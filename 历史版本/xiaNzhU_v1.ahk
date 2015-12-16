; ------------------------------------------------------------------------------
; Var Config {
;SetFormat, float, 0.2

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

CD_SKILL   = 12
; ------------------------------------------------------------------------------
T_Nothing       = 0
T_FindMonster   = 1
T_KOMonster     = 2
T_PickItem      = 3
T_Rest          = 4

NO_MONSTER      = -1

Char_Doing      := T_FindMonster
; ------------------------------------------------------------------------------
; { 统计用
S_BOOTTIME  := A_TickCount
S_ADDHP     = 0
S_ADDMP     = 0
S_KOMONSTER = 0

lastHP      = 1
lastMHP     = 1

D_mhp_dec   = 2
;}
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

mwt_StandardMenu = N

if mwt_StandardMenu = Y
    Menu, Tray, Add
else
{
    Menu, Tray, NoStandard
    Menu, Tray, Add, 显示主界面, mwt_ShowMain
    Menu, Tray, Add, 退出, mwt_Exit
    Menu, Tray, Default , 显示主界面
}

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

    IniRead, CD_SKILL, %INI_FILE%, Skill, CD_SKILL,  %CD_SKILL%
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

    IniWrite, %CD_SKILL%,  %INI_FILE%, Skill, CD_SKILL
}
;}
; ------------------------------------------------------------------------------
; GUI {
;Gui, Color, cccccc
Gui, Font, S14 CDefault, Verdana

Gui, Add, Tab, x12 y16 w490 h339 , 一般设置|快捷键|统计|日志|使用说明
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
Gui, Add, Text, x306 y100 w90 h30 , 攻击周期
Gui, Add, Edit, x396 y100 w50 h30 vCD_SKILL, %CD_SKILL%
Gui, Add, Text, x452 y100 w30 h30 , 秒
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
Gui, Add, Edit, x26 y60 w460 h280 vStat, 按F10刷新统计结果(默认每分钟统计一次)

Gui, Tab, 4
FormatTime, TimeString, R
Gui, Add, Edit, x26 y60 w460 h280 vAppLog, 程序启动于 %TimeString%

Gui, Tab, 5
Gui, Add, Text, x26 y60 w460 h280 vUseIntro,
Gui, Tab

Gui, Add, Button, x206 y370 w170 h50 , OK

; Generated using SmartGUI Creator 4.0
Gui, submit, NoHide
;Gui, +Disabled
;Gui, Show, x154 y137 h437 w523, 《诛仙》·宝宝版
writeIntro()
Return

;}
; ------------------------------------------------------------------------------
; GUI Events{
GuiClose:
    myExit()
return

ButtonOk:
    Gui, submit, NoHide
    writeConfig()
    ;ExitApp
return

mwt_ShowMain:
    showMainWindow()
return

mwt_Exit:
    ExitApp
return

myExit() {
    MsgBox, 4, 嘿, 确定要退出吗？
    IfMsgBox Yes
        ExitApp
}

writeIntro() {
    global
    s =
    (
首先，游戏画面必须设置为 分辨率1024*768 + 全屏模式
设定好技能键后，走到练功区，按F11开始。
【F11】开始自动打怪
【Pause】暂停/恢复自动打怪
【F12】重启程序，中止自动打怪
【Ctrl+F12】显示主界面
【F10】刷新统计结果(默认每分钟统计一次)
【Ctrl+F10】把统计结果放入剪贴板

发现程序差错请联系：弑神v鬼公子
)
    GuiControl,, UseIntro, %s%
    Gui, submit, NoHide
}
;}
; ------------------------------------------------------------------------------
; Functions {
; ------------------------------------------------------------------------------
; 日志函数 {
logger(msg) {
    global
    FormatTime, TimeString, T12, Time
    msg = %TimeString% : %msg%
    logToGui(msg)
    if (LOG_TO_CHAT) {
        logToChat(msg)
    }
}
debug(msg) {
    logger(msg)
}
logToClipboard(msg) {
}
logToChat(msg) {
	MouseClick, left, 848, 709
    clipboard = %msg%
    Send ^v
    Sleep 100
    Send ^{Enter}
    MouseClick, left, 848, 692
}
logToGui(msg) {
    global
    Gui, submit, NoHide
    GuiControl,, AppLog, %AppLog%`n%msg%
    Gui, submit, NoHide
    ;MsgBox %AppLog%
}
;}
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
getMonsterHpP() {
    global
    if !monsterIsChecked()
        return NO_MONSTER
    p := getPercentFromColorBar(monbarMin, monbarMax, monbarY, monbarColor)
    return p
}
;------------------------------------------------------------------------------
getCharHpP() {
    global
    p := getPercentFromColorBar(hpbarMin, hpbarMax, hpbarY, hpbarColor)
    return p
}
;------------------------------------------------------------------------------
getCharMpP() {
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
login() {
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

findMonster(cdTime=1500) {
    static startTime = -9999    ;-9999保证第一次操作
    tick := A_TickCount
    elapsedTime := tick - startTime
    if (elapsedTime - cdTime >= 0) {
        Send {tab}
        startTime := tick
        debug("按一下tab键")
    }
}
logFindMonster() {
    lastFind = A_Now
}
addCharHP(cdTime=500) {
    global
    static startTime = -9999    ;-9999保证第一次操作
    tick := A_TickCount
    elapsedTime := tick - startTime
    if (elapsedTime - cdTime >= 0) {
        S_ADDHP++
        Send {%HK_ADDHP%}
        startTime := tick
        Sleep 200
        SoundPlay, %A_WinDir%\Media\ding.wav
    }
}
addCharMP(cdTime=500) {
    global
    static startTime = -9999    ;-9999保证第一次操作
    tick := A_TickCount
    elapsedTime := tick - startTime
    if (elapsedTime - cdTime >= 0) {
        S_ADDMP++
        Send {%HK_ADDMP%}
        startTime := tick
        Sleep 200
        SoundPlay, %A_WinDir%\Media\ding.wav
    }
}
attack(mhp, cdTime) {
    global
    static startTime = -99999999    ;保证第一次操作

    if (cdTime = 0) {
        mhpDemon(mhp, 0)
    } else {
        mhpDemon(mhp, 5500)
    }
    if (D_mhp_dec <= 0) {
        debug(D_mhp_dec)
        cdTime = 0
    }

    tick := A_TickCount
    elapsedTime := tick - startTime
    if (elapsedTime - cdTime >= 0) {
        debug(D_mhp_dec)
        Sleep 100
        Send {%HK_SKILL1%}
        Sleep 400
        Send {%HK_SKILL2%}
        debug("按一下普攻，再按一下连续招")
        startTime := tick

    }
}
pickitem() { ; 捡东西
    global
    s = 我
	Loop, 10
	{
        s = %s%捡.
        Send {%HK_PICKUP%}
	    Sleep, 200
	}
    debug(s)
}
rest() { ; 休息
    global
	Sleep 200
    debug("打坐")
	Send {%HK_REST%}
    Sleep 200
}
exitRest() { ; 休息
    global
    debug("不打坐了")
    Send {%HK_SKILL1%}
	Sleep 600
}
debugs(hp, mp, mhp) {
    global
    SetFormat, float, 0.2
    s := "【人物状态】"
    s .= "HP百分比："hp
    s .= " MP百分比："mp
    s .= " 【怪物状态】"
    if mhp = %NO_MONSTER%
        s .= "没有怪物"
    else
        s .= "剩余血量："mhp
    debug(s)
}
statToGui(msg) {
    global
    GuiControl,, Stat, %msg%
    Gui, submit, NoHide
}
stat(cdTime=60000) {
    global
    static startTime = -60000    ;-9999保证第一次操作
    tick := A_TickCount
    elapsedTime := tick - startTime
    if (elapsedTime - cdTime >= 0) {
        statToGui(getStat())
    }
}
getStat() {
    global

    elapsedTime := A_TickCount - S_BOOTTIME
    etHour := elapsedTime / (1000*60*60)
    koph := Ceil(S_KOMONSTER/etHour)
    hpph := Ceil(S_ADDHP/etHour)
    mpph := Ceil(S_ADDMP/etHour)

    SetFormat, float, 0.2
    expph := 0.05 * koph
    s := "【统计信息】"
    s = %s%`n预计每小时打怪%koph%只；
    s = %s%`n预计每小时升级%expph%`%(假设一只怪涨0.05`%)；
    s = %s%`n预计每小时用红药%hpph%个；
    s = %s%`n预计每小时用蓝药%mpph%个。
    return s
}

showMainWindow() {
    Gui, Show, x154 y137 h437 w523, 《诛仙》·弑神版
}

;有怪正常时 0 < v <= 1
;有怪不正常时 v <= 0
;第一次取样 v = 2
mhpDemon(mhp, cdTime) {
    global
    static startTime = -99999999    ;保证第一次操作
    static lastMHP = 2  ;保证第一次计算不为0
    tick := A_TickCount
    startTime := tick

    if (cdTime = 0) {
        lastMHP := mhp
        D_mhp_dec := 2  ;表示为第一次取样
        return
    }

    elapsedTime := tick - startTime
    if (elapsedTime - cdTime > 0) {
        D_mhp_dec := lastMHP - mhp
        lastMHP := mhp
    }
}
;}
; ------------------------------------------------------------------------------
; Hotkeys {
~^!HOME::ListVars  ;{
;}
~Pause::Pause  ;{
;}

~F10::    ;{输出统计信息
    stat(0)
return  ;}

~^F10::    ;{输出统计信息
    clipboard := getStat()
return  ;}

~$F11::  ;{
    SoundPlay, %A_WinDir%\Media\ding.wav
    SetTimer, playGame, 200
return  ;}

~$F12::Reload ;{
;}

~^$F12::showMainWindow() ;{
;}

~^!c::   ;{
    MouseGetPos, MouseX, MouseY
    PixelGetColor, color, %MouseX%, %MouseY%
    msg = The color at %MouseX%, %MouseY% is %color%.
    debug(msg)
    MouseMove, %MouseX%, %MouseY%
return  ;}

~^t::    ;{测试用
return  ;}

~^!l::LOG_TO_CHAT := not LOG_TO_CHAT ;{日志输出到聊天窗口开关
;}
;}

playGame: ; {主线程
    hp := getCharHpP()
    mp := getCharMpP()
    mhp:= getMonsterHpP()   ; -1表示没有怪物

    ;mtype   ;敌人类型:人，怪物
    ;debugs(hp,mp,mhp)
    if (hp < ADD_HP_WHEN) {
        addCharHP() ;实际hp提升，但变量hp值不变
    }
    if (mp< ADD_MP_WHEN) {
        addCharMP()
    }

    if (mhp != NO_MONSTER) {
        if (Char_Doing = T_FindMonster and mhp = 1) {
            Char_Doing := T_KOMonster
            debug("找到怪了")
        } else if (Char_Doing = T_FindMonster and mhp < 1 and hp >= lastHP) {
            debug("找到的怪物被人打了，重找")
            findMonster(500)
        } else if (Char_Doing = T_KOMonster) {
            ;debug("打怪中，继续打")
        } else {
            debug("被主动怪盯上了，K它")
            if (Char_Doing = T_Rest) {
                exitRest()
            }
            Char_Doing := T_KOMonster
        }
    }

    if (Char_Doing = T_Nothing) {
        Char_Doing := T_FindMonster
    }

    if (Char_Doing = T_FindMonster) {
        findMonster()
    }
    if (Char_Doing = T_KOMonster) {
        if (mhp = NO_MONSTER) {
            debug("怪死了")
            S_KOMONSTER++
            Char_Doing := T_PickItem
            logFindMonster()
        } else {
            if (mhp - lastMHP > 0) {
                attack(mhp, 0)  ; 是新的怪物
            } else {
                attack(mhp, CD_SKILL * 1000)
            }
        }
    }
    if (Char_Doing = T_PickItem) {
        pickitem()
        Char_Doing := T_Nothing
    }

    if (S_KOMONSTER > 0 and mod(S_KOMONSTER, KO_ONCE) = 0 and Char_Doing = T_Nothing
        and (hp < 0.75 or mp < 0.75)) {
        Char_Doing := T_Rest
        rest()
    }

    if (Char_Doing = T_Rest and (hp > 0.96 and mp > 0.96)) {
        exitRest()
        Char_Doing := T_Nothing
    }

    lastHP := hp
    lastMHP := mhp

    stat()
return
;}