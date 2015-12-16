#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
#Persistent

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; ------------------------------------------------------------------------------
; Var Config {
;SetFormat, float, 0.2

INI_FILE    = %A_WorkingDir%\config.ini

; 一般设定
KO_ONCE      = 0
ADD_HP_WHEN = 1000
ADD_MP_WHEN = -1

; 热键
HK_SKILL1   = F2
HK_SKILL2   = F3
HK_PICKUP   = 3
HK_ADDHP    = F1
HK_ADDMP    = F4
HK_REST     = F7
HK_BUF      = F6
;HK_DANGER   = 8

; 技能相关设定
CD_SKILL    = 12    ; 单位：秒
BUF_TIME    = 600   ; 单位：秒
; ------------------------------------------------------------------------------
T_Nothing       = 0
T_FindMonster   = 1
T_KOMonster     = 2
T_PickItem      = 3
T_Rest          = 4

NO_MONSTER      = -1

Char_Doing      := T_FindMonster

; ------------------------------------------------------------------------------
OCR_ERROR       = -1

keyStr0 =
(
0x494A20
0xEBF02A
0xFAFF2B
0xEBF02A
0x676822

)
keyStr1 =
(
0x848624
0xB0B426

)
keyStr2 =
(
0x676822
0xEBF02A
0xFAFF2B
0xFAFF2B
0x939624

)
keyStr3 =
(
0x757723
0xFAFF2B
0xFAFF2B
0xFAFF2B
0x939624

)
keyStr4 =
(
0x2C2C1E
0xEBF02A
0x848624

)
keyStr5 =
(
0xA2A525
0xFAFF2B
0xFAFF2B
0xFAFF2B
0xFAFF2B
0x3A3B1F

)
keyStr6 =
(
0x3A3B1F
0xCED228
0xFAFF2B
0xFAFF2B
0xA2A525

)
keyStr7 =
(
0x939624
0xFAFF2B
0xFAFF2B
0xFAFF2B
0xFAFF2B
0xFAFF2B
0xCED228

)
keyStr8 =
(
0x676822
0xEBF02A
0xFAFF2B
0xFAFF2B
0x848624

)
keyStr9 =
(
0x676822
0xEBF02A
0xFAFF2B
0xFAFF2B
0x757723

)
keyStrS =
(
0x757723
0x848624

)
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
    IniRead, HK_BUF,    %INI_FILE%, Hotkey, HK_BUF,     %HK_BUF%

    IniRead, CD_SKILL, %INI_FILE%, Skill, CD_SKILL,  %CD_SKILL%
    IniRead, BUF_TIME, %INI_FILE%, Skill, BUF_TIME,  %BUF_TIME%
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
    IniWrite, %HK_BUF%,     %INI_FILE%, Hotkey, HK_BUF

    IniWrite, %CD_SKILL%,  %INI_FILE%, Skill, CD_SKILL
    IniWrite, %BUF_TIME%,  %INI_FILE%, Skill, BUF_TIME
}
;}
; ------------------------------------------------------------------------------
; GUI {
Menu, Tray, NoStandard
Menu, Tray, Add, 设置, mwt_ShowMain
Menu, Tray, Add, 退出, mwt_Exit
Menu, Tray, Default , 设置

/*
Menu, FileMenu, Add, &Open    Ctrl+O, mwt_ShowMain  ; See remarks below about Ctrl+O.
Menu, FileMenu, Add, E&xit, mwt_ShowMain
Menu, HelpMenu, Add, &About, mwt_ShowMain
Menu, MyMenuBar, Add, &File, :FileMenu  ; Attach the two sub-menus that were created above.
Menu, MyMenuBar, Add, &Help, :HelpMenu
Gui, Menu, MyMenuBar


; EXAMPLE #2: This is a working script that creates a popup menu that is displayed when the user presses the Win-Z hotkey.

; Create the popup menu by adding some items to it.
Menu, MyMenu, Add, Item1, MenuHandler
Menu, MyMenu, Add, Item2, MenuHandler
Menu, MyMenu, Add  ; Add a separator line.

; Create another menu destined to become a submenu of the above menu.
Menu, Submenu1, Add, Item1, MenuHandler
Menu, Submenu1, Add, Item2, MenuHandler

; Create a submenu in the first menu (a right-arrow indicator). When the user selects it, the second menu is displayed.
Menu, MyMenu, Add, My Submenu, :Submenu1

Menu, MyMenu, Add  ; Add a separator line below the submenu.
Menu, MyMenu, Add, Item3, MenuHandler  ; Add another menu item beneath the submenu.
;return  ; End of script's auto-execute section.
*/




;Gui, Color, cccccc
Gui, Font, S14 CDefault, Verdana

;Gui, Add, Tab,  x9 y18 w540 h370 , 快捷键|QQ
; ------------------------------------------------------------------------------
guiY = 36  ; 1st row's y
guiLH = 50  ; Line Height

Gui, Add, Edit, x20 y%guiY% w120 h30 ReadOnly, Аттаск I
Gui, Add, Text, xp+0 yp+%guiLH% wp+0 hp+0, Аттαск Ⅱ
Gui, Add, Text, xp+0 yp+%guiLH% wp+0 hp+0 , Рιск
Gui, Add, Text, xp+0 yp+%guiLH% wp+0 hp+0 , Нρ
Gui, Add, Text, xp+0 yp+%guiLH% wp+0 hp+0 , Мρ
Gui, Add, Text, xp+0 yp+%guiLH% wp+0 hp+0 , Яеsт
;Gui, Add, Text, xp+0 yp+%guiLH% wp+0 hp+0 , Βμf

Gui, Add, Hotkey, x156 y%guiY% w100 h30 vHK_SKILL1, %HK_SKILL1%
Gui, Add, Hotkey, xp+0 yp+%guiLH% wp+0 hp+0 vHK_SKILL2, %HK_SKILL2%
Gui, Add, Hotkey, xp+0 yp+%guiLH% wp+0 hp+0 vHK_PICKUP, %HK_PICKUP%
Gui, Add, Hotkey, xp+0 yp+%guiLH% wp+0 hp+0 vHK_ADDHP, %HK_ADDHP%
Gui, Add, Hotkey, xp+0 yp+%guiLH% wp+0 hp+0 vHK_ADDMP, %HK_ADDMP%
Gui, Add, Hotkey, xp+0 yp+%guiLH% wp+0 hp+0 vHK_REST, %HK_REST%
;Gui, Add, Hotkey, xp+0 yp+%guiLH% wp+0 hp+0 vHK_BUF, %HK_BUF%

;Gui, Add, Text, x270 y%guiY% w36 h30 , }
;Gui, Add, DropDownList,x310 y%guiY% w100 vColorChoice, Monster||M+Boss|M+Char|All

guiY += guiLH * 3
Gui, Add, Text, x270 y%guiY% w36 h30 , ≤
Gui, Add, Text, xp+0 yp+%guiLH% wp+0 hp+0 , ≤
Gui, Add, Text, xp+0 yp+%guiLH% wp+0 hp+0 , ＝
;Gui, Add, Text, xp+0 yp+%guiLH% wp+0 hp+0 , Ω

Gui, Add, Edit, x310 y%guiY% w100 h30 vADD_HP_WHEN, %ADD_HP_WHEN%
Gui, Add, Edit, xp+0 yp+%guiLH% wp+0 hp+0 vADD_MP_WHEN, %ADD_MP_WHEN%
Gui, Add, Edit, xp+0 yp+%guiLH% wp+0 hp+0 vKO_ONCE, %KO_ONCE%
;Gui, Add, Edit, xp+0 yp+%guiLH% wp+0 hp+0 vBUF_TIME, %BUF_TIME%

Gui, Add, Button, Default gSaveConfig x190 y368 w180 h50 , Sаvе
Gui, Add, Checkbox, vOnlyHeal gGuiSetNow, Οηlγ Ηеαl 〖Γ10〗
Gui, Add, Checkbox, xp+290 yp+0 wp+0 hp+0 vImute gGuiSetNow, Мцтё

Gui, submit, NoHide

Gui, Font, S10 underline
Gui, Add, Text, x308 y3 w248 Right cBlue gGetHelp, http://lotreal.yo2.cn
Gui, Font, S9 norm
Gui, Add, Text, x308 yp+1 w112 cBlue Right, 使用说明参见：
Gui, Add, Text, x308 yp+18 w248 Right, 弑神v鬼公子
Gui, Font, S9 underline
Gui, Add, Text, x308 yp+18 w248 cRed Right gShowAdvSetup, 高级选项
Gui, Font, S9 norm



; ------------------------------------------------------------------------------

Gui, 2:Add, Text, x11 y16 w32 h30 ,
Gui, 2:Add, Text, x55 y14 w315 h65 , 用户配置文件保存桌面设置和其他与您的用户帐户有关的信息。可在您使用的每台计算机上创建不同的配置文件，或选定一个漫游配置文件用在您使用的每台计算机上。
Gui, 2:Add, Text, x11 y88 w315 h14 , 储存在本机上的配置文件(&P):
Gui, 2:Add, ListView, x11 y106 w360 h141 ,
Gui, 2:Add, Button, x121 y259 w90 h23 , 更改类型(&C)
Gui, 2:Add, Button, x217 y259 w75 h23 , 删除(&D)
Gui, 2:Add, Button, x298 y259 w75 h23 , 复制到(&T)
Gui, 2:Add, Button, x217 y347 w75 h23 , 确定
Gui, 2:Add, Button, x298 y347 w75 h23 , 取消

;Gui, +Disabled
;showMainWindow()
SoundPlay, %A_WinDir%\Media\ding.wav
return
;}
; ------------------------------------------------------------------------------
; GUI Events{
showMainWindow() {
    Gui, Show, x155 y119 h459 w560, ΖΗυΧιαη Щ.2
}

ShowAdvSetup:
    ;Gui 2:+OwnDialogs
    ;Gui, 2:Show
    Msgbox 此功能调试中，暂不开放
return

GuiClose:
    MsgBox, 4,, Ｓцяё Ёхιт？
    IfMsgBox Yes
        ExitApp
return

SaveConfig:
    ;Menu, MyMenu, Show
    Gui, submit, NoHide
    writeConfig()
    MsgBox γеs，Ι dσ！

    ;ExitApp
return

GuiSetNow:
    Gui, submit, NoHide
return

mwt_Exit:
    ExitApp
return

mwt_ShowMain:
    showMainWindow()
return

GetHelp:
    Run http://lotreal.yo2.cn/196087
return

MenuHandler:
MsgBox You selected %A_ThisMenuItem% from the menu %A_ThisMenu%.
return

#z::Menu, MyMenu, Show  ; i.e. press the Win-Z hotkey to show the menu.
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

notify() {
    global Imute
    if (Imute = 0) {
        SoundPlay, %A_WinDir%\Media\ding.wav
    }
}

debug(msg) {
    clipboard = %msg%
}

logger(msg) {
    ;clipboard = %clipboard%`n%msg%
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
getMonsterHpP() {
    global
    if !monsterIsChecked()
        return NO_MONSTER
    p := getPercentFromColorBar(monbarMin, monbarMax, monbarY, monbarColor)
    return p
}
;------------------------------------------------------------------------------
; -1 表示探测失败
getCharHp() {
    hpStr := GetMatrix(920,627,1008,627)
    hpStr := getMatrixBeforeDash(hpStr)
    hp := CharStatusOcr(hpStr)
    return hp
}
;------------------------------------------------------------------------------
getCharHpP() {
    global
    p := getPercentFromColorBar(hpbarMin, hpbarMax, hpbarY, hpbarColor)
    return p
}
;------------------------------------------------------------------------------
getCharMp() {
    mpStr := GetMatrix(920,642,1008,642)
    mpStr := getMatrixBeforeDash(mpStr)
    mp := CharStatusOcr(mpStr)
    return mp
}
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
isHpLess(percent) {
    global
    ret := getSpColorOfBar(hpbarMin, hpbarMax, hpbarY, percent) != hpbarColor
	return ret
}
;------------------------------------------------------------------------------
isMpLess(percent) {
    global
    ret := getSpColorOfBar(mpbarMin, mpbarMax, mpbarY, percent) != mpbarColor
	return ret
}
;------------------------------------------------------------------------------
findMonster(cdTime=1500) {
    static startTime = -9999    ;-9999保证第一次操作
    tick := A_TickCount
    elapsedTime := tick - startTime
    if (elapsedTime - cdTime >= 0) {
        Send {tab}
        startTime := tick
        ;debug("按一下tab键")
    }
}
addCharHP(cdTime=1800) {
    global
    static startTime = -9999    ;-9999保证第一次操作
    tick := A_TickCount
    elapsedTime := tick - startTime
    if (elapsedTime - cdTime >= 0) {
        S_ADDHP++
        Send {%HK_ADDHP%}
        startTime := tick
        notify()
    }
}
addCharMP(cdTime=1800) {
    global
    static startTime = -9999    ;-9999保证第一次操作
    tick := A_TickCount
    elapsedTime := tick - startTime
    if (elapsedTime - cdTime >= 0) {
        S_ADDMP++
        Send {%HK_ADDMP%}
        startTime := tick
        notify()
    }
}
getbuf(cdTime=1800) {   ;这个功能有必要吗？？
    global
    static startTime = -9999    ;-9999保证第一次操作
    tick := A_TickCount
    elapsedTime := tick - startTime
    if (elapsedTime - cdTime >= 0) {
        S_ADDMP++
        Send {%HK_ADDMP%}
        startTime := tick
        notify()
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
        Sleep 1000
        Send {%HK_SKILL2%}
        ;debug("按一下普攻，再按一下连续招")
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
    ;debug(s)
}
rest() { ; 休息
    global
	Sleep 200
    ;debug("打坐")
	Send {%HK_REST%}
    Sleep 200
}
exitRest() { ; 休息
    global
    ;debug("不打坐了")
    Send {%HK_SKILL1%}
	Sleep 600
}

statToGui(msg) {
    global
    ;GuiControl,, Stat, %msg%
    ;Gui, submit, NoHide
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
    ;s := "【统计信息】"
    ;s = %s%`n预计每小时打怪%koph%只；
    ;s = %s%`n预计每小时升级%expph%`%(假设一只怪涨0.05`%)；
    ;s = %s%`n预计每小时用红药%hpph%个；
    ;s = %s%`n预计每小时用蓝药%mpph%个。
    return 1
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

; Unit Test {
statusTest() {
    global NO_MONSTER
    SetFormat, float, 0.2

    hp := getCharHp()
    mp := getCharMp()
    s = 气血%hp%真气%mp%

    mhp:= getMonsterHpP()   ; -1表示没有怪物
    if mhp = %NO_MONSTER%
        s .= "没怪"
    else
        s .= "怪还有"mhp
    debug(s)
}

getMousePos() {
    MouseGetPos, xpos, ypos
    s = The cursor is at X%xpos% Y%ypos%.
    debug(s)
}

GetMatrix(x1,y1,x2,y2)
{
    xCount := x2 - x1 + 1
    yCount := y2 - y1 + 1
	Loop, %xCount%
	{
		Loop, %yCount%
		{
			PixelGetColor, Pix, %x1%, %y1%
			;Matrix = %Matrix%|(%x1%, %y1%)%Pix%
            Matrix = %Matrix%%Pix%
			y1++
		}
        x1++
		y1 -= %yCount%
        Matrix = %Matrix%`n
	}
	;StringTrimLeft, Matrix, Matrix, 1
	Return %Matrix%
}

getMatrixBeforeDash(matrix) {
    matrix := RegExReplace(matrix, "^(0x1D1D1D\n)*", "")
    matrix := RegExReplace(matrix, "0x1D1D1D\n0x1D1D1D\n0x757723\n0x848624(\w|\n)*$", "")
    return matrix
}

CharStatusOcr(Colors) {
    global keyStr0
    global keyStr1
    global keyStr2
    global keyStr3
    global keyStr4
    global keyStr5
    global keyStr6
    global keyStr7
    global keyStr8
    global keyStr9
    global keyStrS

    numbit :=  Ceil(StrLen(Colors) / 63)
    maxnum := 10**numbit - 1


    Colors := RegExReplace(Colors, "((0x1D1D1D\n)+)", "-")
    ;Colors := RegExReplace(Colors, "(\n|-)*$", "")
    ;Colors := RegExReplace(Colors, "\n", "*")
    ;msgbox %Colors%
    ;StringSplit, retArray, Colors, -,
    retnum := 0
    Loop, parse, Colors, -
    {
        keyStr = %A_LoopField%

        thebit  := 10 ** (numbit - a_index)
        ;sss := RegExReplace(keyStr0, "(\n)", "*")
        ;msgbox % sss
        if (keyStr = "") {
            Continue
        }
        if (keyStr = keyStr0) {
        } else if (keyStr = keyStr1) {
            retnum += thebit
        } else if (keyStr = keyStr2) {
            retnum += thebit * 2
        } else if (keyStr = keyStr3) {
            retnum += thebit * 3
        } else if (keyStr = keyStr4) {
            retnum += thebit * 4
        } else if (keyStr = keyStr5) {
            retnum += thebit * 5
        } else if (keyStr = keyStr6) {
            retnum += thebit * 6
        } else if (keyStr = keyStr7) {
            retnum += thebit * 7
        } else if (keyStr = keyStr8) {
            retnum += thebit * 8
        } else if (keyStr = keyStr9) {
            retnum += thebit * 9
        } else if (keyStr = keyStrS) {
            return retnum
        } else {
            retnum += thebit * 9
        }
        ;msgbox, %a_index%:`n%keyStr%`ns = %s%
    }
    return retnum
}

saleItem() {
    MouseGetPos, xpos, ypos
    MouseClickDrag, left, %xpos%, %ypos%, 616, 421
    ; Max
    Click 580, 390
    ; T
    Click 603, 418
    Send {BS}{BS}
    Send 99
    Send {tab}
    Send {BS}{BS}
    Send 1
    Click 475, 443
    MouseMove %xpos%, %ypos%
    clipboard = 彪悍的四级奇珍
}
;}
;}
; ------------------------------------------------------------------------------
; Hotkeys {
~Pause::Pause  ;{
;}

~F10::    ;{停止工作，但保留加血加蓝功能
    ;Gui, submit, NoHide
    OnlyHeal := (OnlyHeal=1 ? 0 : 1)
    GuiControl,, OnlyHeal, %OnlyHeal%
    Gui, submit, NoHide
    notify()
return
;}

~F11::  ;{
    notify()
    SetTimer, playGame, 250
return
;}

~F12::Reload ;{
;}

~^F12::showMainWindow() ;{
;}

~&::    ;{命令行配置
    notify()
    ;inputString = &MP=0.6
    Input, inputString, V I, {enter}
    StringSplit, tokens, inputString, =  ; Omits periods.
    cfgItem := tokens1
    cfgValue := tokens2
    ;MsgBox, You entered "%inputString%"`nItem="%cfgItem%"`nV="%cfgValue%"

    StringLen, length, cfgValue
    if (length > 0) {
        if (cfgItem = "hp") {
            ADD_HP_WHEN := cfgValue
            ;MsgBox set hp to  %cfgValue%
        } else if (cfgItem = "mp") {
            ADD_MP_WHEN := cfgValue
        } else if (cfgItem = "ko") {
            KO_ONCE := cfgValue
        }
    }
    writeConfig()
    notify()
return
;}

~^M::    ;{静音开关
    ;Gui, submit, NoHide
    Imute := (Imute=1 ? 0 : 1)
    GuiControl,, Imute, %Imute%
    Gui, submit, NoHide
return
;}
~^RButton::
    saleItem()
return

~^t::    ;{程序调试用
    if (1=1) {
        statusTest()
        ;getCharHpP2()
        ;getMousePos()
        return
    }
    ;hpStr := GetMatrix(935,627,1004,627)
    if (1=1) {
        ;hpStr := GetMatrix(920,640,1008,652)
        hpStr := GetMatrix(920,642,1008,642)
        hpStr := getMatrixBeforeDash(hpStr)
        myMp := CharStatusOcr(hpStr)
        ;msgbox % myMp
        ;942,627,1004,636.
        debug(hpStr)
        return
    }
/*
hpStr = ;{

(
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x848624
0xB0B426
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x676822
0xEBF02A
0xFAFF2B
0xFAFF2B
0x848624
0x1D1D1D
0x1D1D1D
0x3A3B1F
0xCED228
0xFAFF2B
0xFAFF2B
0xA2A525
0x1D1D1D
0x1D1D1D
0x676822
0xEBF02A
0xFAFF2B
0xFAFF2B
0x848624
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x757723
0x848624
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x848624
0xB0B426
0x1D1D1D
0x1D1D1D
0x1D1D1D
0x676822
0xEBF02A
0xFAFF2B
0xFAFF2B
0x848624
0x1D1D1D
0x1D1D1D
0x3A3B1F
0xCED228
0xFAFF2B
0xFAFF2B
0xA2A525
0x1D1D1D
0x1D1D1D
0x676822
0xEBF02A
0xFAFF2B
0xFAFF2B
0x848624
0x1D1D1D
)   ;}
CharStatusOcr(hpStr)
return
*/
DllCall("QueryPerformanceFrequency", "int64P", perffreq)
DllCall("QueryPerformanceCounter", "int64P", perfcount0)

myhp := getCharHp()

DllCall("QueryPerformanceCounter", "int64P", perfcount1)
s := (perfcount1 - perfcount0) / perffreq
s = myHp: %myhp% (use time: %s%s)
hpStr = %hpStr%`n`n%s%
clipboard := hpStr
return
;}

;~^!HOME::ListVars  ;{
;}

;}
; ------------------------------------------------------------------------------
playGame: ; {主线程
    IfWinNotActive , Element Client
    {
        return
    }

    hp := getCharHp()
    hpp := getCharHpP()
    mp := getCharMp()
    mpp := getCharMpP()
    mhp:= getMonsterHpP()   ; -1表示没有怪物
    if (hp = OCR_ERROR) {
        hp := 99999
    }

    ;mtype   ;敌人类型:人，怪物
    ;debugs(hp,mp,mhp)
    ; if service(,SERVICE_HEALADD)
    logStr = myHp: %hp% addHp: %ADD_HP_WHEN%
    logger(logStr)
    if (enableHeal()) {
        if (hp < ADD_HP_WHEN) {
            ;Msgbox, %hp% < %ADD_HP_WHEN%
            addCharHP() ;实际hp提升，但变量hp值不变
        }
        if (mp< ADD_MP_WHEN) {
            addCharMP()
        }
    }

    if (OnlyHeal = 1) {
        return
    }

    if (mhp != NO_MONSTER) {
        if (Char_Doing = T_FindMonster) {   ; and mhp = 1) {
            Char_Doing := T_KOMonster
            ;debug("找到怪了")
        } else if (Char_Doing = T_FindMonster and mhp < 1 and hp >= lastHP) {
            ;debug("找到的怪物被人打了，重找")
            findMonster(500)
        } else if (Char_Doing = T_KOMonster) {
            ;;debug("打怪中，继续打")
        } else {
            ;debug("被主动怪盯上了，K它")
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
            ;debug("怪死了")
            S_KOMONSTER++
            Char_Doing := T_PickItem
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

    if (KO_ONCE > 0 and S_KOMONSTER > 0 and mod(S_KOMONSTER, KO_ONCE) = 0
        and Char_Doing = T_Nothing ) {
        ;and (hpp < 0.75 or mpp < 0.75)) {  hpp,mpp check unlike
        Char_Doing := T_Rest
        rest()
    }

    if (Char_Doing = T_Rest and (hpp > 0.96 and mpp > 0.96)) {
        exitRest()
        Char_Doing := T_Nothing
    }

    lastHP := hp
    lastMHP := mhp
;    stat()
return
;}