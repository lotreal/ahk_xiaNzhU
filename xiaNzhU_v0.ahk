; ------------------------------------------------------------------------------
; Var Config {
;SetFormat, float, 0.2

INI_FILE = %A_WorkingDir%\config.ini

; 一般设定
KO_ONCE      = 6
ADD_HP_WHEN = 0.6
ADD_MP_WHEN = 0.2

; 热键
HK_SKILL1   = F2
HK_SKILL2   = F3
HK_PICKUP   = F5
HK_ADDHP    = F1
HK_ADDMP    = F4
HK_REST     = F7
;HK_DANGER   = 8

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

Menu, Tray, NoStandard
Menu, Tray, Add, 显示主界面, mwt_ShowMain
Menu, Tray, Add, 退出, mwt_Exit
Menu, Tray, Default , 显示主界面


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

Gui, Add, Tab,  x9 y18 w540 h370 , 一般设置|快捷键|统计|日志|使用说明
; ------------------------------------------------------------------------------
Gui, Add, Text, x32 y66 w210 h30 , 打几个怪物后休息？
Gui, Add, Text, xp+0 yp+50 wp+0 hp+0 , 当HP低于多少时加血？
Gui, Add, Text, xp+0 yp+50 wp+0 hp+0 , 当MP低于多少时加蓝？
Gui, Add, Text, xp+0 yp+50 wp+0 hp+0 , 攻击周期(单位：秒)

Gui, Add, Edit, x266 y66 w70 h30 vKO_ONCE, %KO_ONCE%
Gui, Add, Edit, xp+0 yp+50 wp+0 hp+0 vADD_HP_WHEN, %ADD_HP_WHEN%
Gui, Add, Edit, xp+0 yp+50 wp+0 hp+0 vADD_MP_WHEN, %ADD_MP_WHEN%
Gui, Add, Edit, xp+0 yp+50 wp+0 hp+0 vCD_SKILL, %CD_SKILL%

;Gui, Add, Text, x26 y216 w320 h30 , 当HP低于百分之几时按危险键？
;Gui, Add, Edit, x316 y216 w90 h30 , 开发中
;Gui, Add, Text, x26 y266 w250 h30 , 每隔几分钟自动换线？
;Gui, Add, Edit, x316 y266 w90 h30 , 开发中

Gui, Tab, 2

Gui, Add, Text, x32 y66 w140 h30 , 起手技
Gui, Add, Text, xp+0 yp+50 wp+0 hp+0, 主攻击技
Gui, Add, Text, xp+0 yp+50 wp+0 hp+0 , 拣取物品
Gui, Add, Text, xp+0 yp+50 wp+0 hp+0 , 加红
Gui, Add, Text, xp+0 yp+50 wp+0 hp+0 , 加蓝
Gui, Add, Text, xp+0 yp+50 wp+0 hp+0 , 打坐

Gui, Add, Hotkey, x156 y66 w100 h30 vHK_SKILL1, %HK_SKILL1%
Gui, Add, Hotkey, xp+0 yp+50 wp+0 hp+0 vHK_SKILL2, %HK_SKILL2%
Gui, Add, Hotkey, xp+0 yp+50 wp+0 hp+0 vHK_PICKUP, %HK_PICKUP%
Gui, Add, Hotkey, xp+0 yp+50 wp+0 hp+0 vHK_ADDHP, %HK_ADDHP%
Gui, Add, Hotkey, xp+0 yp+50 wp+0 hp+0 vHK_ADDMP, %HK_ADDMP%
Gui, Add, Hotkey, xp+0 yp+50 wp+0 hp+0 vHK_REST, %HK_REST%

;Gui, Add, Text, x26 y300 w140 h30 , 危险时按
;Gui, Add, Hotkey, x196 y300 w100 h30 , %HK_DANGER%

Gui, Tab

Gui, Add, Button, Default gSaveConfig x190 y398 w180 h50 , 设置好了

Gui, Font, S10 CDefault, Verdana
Gui, Tab, 1
Gui, Add, Text, x350 y66 w180 h30, 整数，数越大打坐越少效率越高。默认为：6
Gui, Add, Text, xp+0 yp+50 wp+0 hp+0, 0 到 1 之间的小数。`n默认为：0.6
Gui, Add, Text, xp+0 yp+50 wp+0 hp+0, 0 到 1 之间的小数。`n默认为：0.2
Gui, Add, Text, xp+0 yp+50 wp+0 hp+0, 必须大于两个攻击技能用一遍的时间，默认为12秒

Gui, Tab, 2
skillHS =
(
　　　　　设置说明

【起手技】一般设置为普通攻击，天音也可设置为加血技。【主攻击技】请针对怪物设置相应的连续技，或设置为普通攻击。
程序打怪方式为先按一下【起手技】，再按一下【主攻击技】，然后不再按键直到怪物死亡。

如日志所示：
16:11:25 : 找到怪了
16:11:26 : 按一下【起手技】，再按一下【主攻击技】
16:11:32 : 怪死了
)
Gui, Add, Text, x296 y66 w210 h320, %skillHS%

Gui, Tab, 3
Gui, Add, Edit, x20 y66 w520 h310 vStat cBlue
    ,按F10刷新统计结果(默认每分钟统计一次)。`n快捷键(Ctrl+F10)可以把统计结果放入剪贴板以便在游戏中查看。

Gui, Tab, 4
FormatTime, TimeString, R
Gui, Add, Edit, x20 y66 w520 h310 vAppLog cBlue, 程序启动于 %TimeString%

Gui, Font, S14 CDefault, 宋体
Gui, Tab, 5
introString =
(

1. 游戏画面必须设置为 分辨率1024*768 + 全屏模式；

2. 设定好技能键后，走到练功区，按F11开始；

3. 快捷键说明：
   开始自动打怪...............F11
   暂停/恢复自动打怪..........Pause Break
   重启程序，中止自动打怪.....F12
   显示主界面................Ctrl+F12


★ 仅限朋友内部使用，请勿随意流传以免被封。
★ 发现程序差错及建议请联系：弑神v鬼公子
)
Gui, Add, Text, x40 y66 w480 h310, %introString%

Gui, submit, NoHide
;Gui, +Disabled
;showMainWindow()
Return

;}
; ------------------------------------------------------------------------------
; GUI Events{
GuiClose:
    myExit()
return

SaveConfig:
    Gui, submit, NoHide
    writeConfig()
    MsgBox 好的，我知道该怎么做了！
    ;ExitApp
return

mwt_ShowMain:
    showMainWindow()
return

mwt_Exit:
    ExitApp
return

myExit() {
    MsgBox, 4, 确定吗确定吗确定吗, 确定要退出吗？
    IfMsgBox Yes
        ExitApp
}
showMainWindow() {
    Gui, Show, x155 y119 h459 w560, zx12
}
;}
; ------------------------------------------------------------------------------
; Functions {
; ------------------------------------------------------------------------------
;switch = -1 表示没有参数
enableHeal(switch = -1) {
    static sw = true
    sw := (switch = -1) ? sw : switch
    return sw
}
enableFindMonster(switch = -1) {
    static sw = true
    sw := (switch = -1) ? sw : switch
    return sw
}

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
addCharHP(cdTime=1000) {
    global
    static startTime = -9999    ;-9999保证第一次操作
    tick := A_TickCount
    elapsedTime := tick - startTime
    if (elapsedTime - cdTime >= 0) {
        S_ADDHP++
        Send {%HK_ADDHP%}
        startTime := tick
        ;SoundPlay, %A_WinDir%\Media\ding.wav
    }
}
addCharMP(cdTime=1000) {
    global
    static startTime = -9999    ;-9999保证第一次操作
    tick := A_TickCount
    elapsedTime := tick - startTime
    if (elapsedTime - cdTime >= 0) {
        S_ADDMP++
        Send {%HK_ADDMP%}
        startTime := tick
        ;SoundPlay, %A_WinDir%\Media\ding.wav
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
        ;debug(D_mhp_dec)
        cdTime = 0
    }

    tick := A_TickCount
    elapsedTime := tick - startTime
    if (elapsedTime - cdTime >= 0) {
        ;debug(D_mhp_dec)
        Sleep 400
        ;SoundPlay, %A_WinDir%\Media\ding.wav
        Send {%HK_SKILL1%}
        Sleep 400
        Send {%HK_SKILL2%}
        debug("按一下【起手技】，再按一下【主攻击技】")
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
	    Sleep, 125
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
;                            PK      KM
;自动加血开关    ctrl+A      X       X
;自动寻怪开关    ctrl+Tab            X
;自动打怪开关    ctrl+K              X

;重新启动程序    F12
;自动打怪        F11
;PK模式          F9/{Enter}
^Tab::
    enableFindMonster(!enableFindMonster())
return


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
    SetTimer, playGame, 250
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
addCharHP()
return  ;}

~^!l::LOG_TO_CHAT := not LOG_TO_CHAT ;{日志输出到聊天窗口开关
;}
;}

playGame: ; {主线程
    IfWinNotActive , Element Client
    {
        return
    }

    hp := getCharHpP()
    mp := getCharMpP()
    mhp:= getMonsterHpP()   ; -1表示没有怪物

    ;mtype   ;敌人类型:人，怪物
    ;debugs(hp,mp,mhp)
    ; if service(,SERVICE_HEALADD)
    if (enableHeal()) {
        if (hp < ADD_HP_WHEN) {
            addCharHP() ;实际hp提升，但变量hp值不变
        }
        if (mp< ADD_MP_WHEN) {
            addCharMP()
        }
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

    if (enableFindMonster() and Char_Doing = T_FindMonster) {
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