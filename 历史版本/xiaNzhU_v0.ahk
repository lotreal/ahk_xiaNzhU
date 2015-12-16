; ------------------------------------------------------------------------------
; Var Config {
INI_FILE = %A_WorkingDir%\zxbb.ini

; һ���趨
KO_ONCE      = 1
ADD_HP_WHEN = 0.5
ADD_MP_WHEN = 0.01

; �ȼ�
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
; ��־����
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

Gui, Add, Tab, x12 y16 w490 h339 , һ������|���ܿ�ݼ�|��־
Gui, Add, Text, x26 y60 w210 h30 , �򼸸��������Ϣ��
Gui, Add, Edit, x316 y60 w90 h30 vKO_ONCE, %KO_ONCE%
Gui, Add, Text, x26 y110 w250 h30 , ��HP���ڰٷ�֮��ʱ��Ѫ��
Gui, Add, Edit, x316 y110 w90 h30 vADD_HP_WHEN, %ADD_HP_WHEN%
Gui, Add, Text, x26 y160 w250 h30 , ��MP���ڰٷ�֮��ʱ������
Gui, Add, Edit, x316 y160 w90 h30 vADD_MP_WHEN, %ADD_MP_WHEN%
Gui, Add, Text, x26 y210 w320 h30 , ��HP���ڰٷ�֮��ʱ��Σ�ռ���
Gui, Add, Edit, x316 y210 w90 h30 , ������
Gui, Add, Text, x26 y260 w250 h30 , ÿ���������Զ����ߣ�
Gui, Add, Edit, x316 y260 w90 h30 , ������

Gui, Tab, 2
Gui, Add, Text, x26 y60 w140 h30 , ��ͨ��������
Gui, Add, Hotkey, x196 y60 w100 h30 vHK_SKILL1, %HK_SKILL1%
Gui, Add, Text, x26 y100 w140 h30, ������
Gui, Add, Hotkey, x196 y100 w100 h30 vHK_SKILL2, %HK_SKILL2%
Gui, Add, Text, x26 y140 w140 h30 , ��ȡ��Ʒ
Gui, Add, Hotkey, x196 y140 w100 h30 vHK_PICKUP, %HK_PICKUP%
Gui, Add, Text, x26 y180 w140 h30 , ��HP
Gui, Add, Hotkey, x196 y180 w100 h30 vHK_ADDHP, %HK_ADDHP%
Gui, Add, Text, x26 y220 w140 h30 , ��MP
Gui, Add, Hotkey, x196 y220 w100 h30 vHK_ADDMP, %HK_ADDMP%
Gui, Add, Text, x26 y260 w140 h30 , ����
Gui, Add, Hotkey, x196 y260 w100 h30 vHK_REST, %HK_REST%
Gui, Add, Text, x26 y300 w140 h30 , Σ��ʱ��
Gui, Add, Hotkey, x196 y300 w100 h30 , %HK_DANGER%

Gui, Tab, 3
Gui, Add, Edit, x26 y60 w460 h280 vAppLog, %A_Now%
Gui, Tab

Gui, Add, Button, x286 y370 w170 h50 , OK
Gui, Add, Button, x96 y370 w170 h50 , Test

; Generated using SmartGUI Creator 4.0
Gui, submit, NoHide
;Gui, Show, x154 y137 h437 w523, �����ɡ���������
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
    ;logger("add")  ;����logger
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
; �Ƿ�ѡ�й���
monsterIsChecked() {
	;��������������Ͻ���ɫ�Ƿ�Ϊ��ɫ
	return coloreq(432, 30, "0x0C0E10")
}
;------------------------------------------------------------------------------
; �Ƿ���ѡ��û�˴�Ĺ���
commonMonsterIsChecked() {
	if !monsterIsChecked() {
	    return false
	} else {
		;������Ҷ˵�Ѫ����ɫ�Ƿ�Ϊ��ɫ
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
	if monsterIsChecked() == 0 { ;����û��ѡ��
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
; ѡ��û�˴�Ĺ��������ʱ����
checkmonster() {
	debug("Ѱ��û�˴�Ĺ���")
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
    debug("�Ѿ�ѡ��û�˴�Ĺ��")
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
	; ����
	debug("����")
	Send {%HK_SKILL1%}
	Sleep 100
	Send {%HK_SKILL2%}
	; ֱ����������
	Loop, 100
	{
		Sleep 200
        if checkMonHited(25, %a_index%) == "nohit" {
            debug("����Ѫ����û�м���")
            Send {%HK_SKILL1%}{%HK_SKILL1%}{%HK_SKILL1%}
            Sleep 100
            Send {%HK_SKILL2%}
        }
		if !monsterIsChecked() ;��������
	    	break
	}
    debug("�����Ѿ�������")
}
;------------------------------------------------------------------------------
pickitem() { ; ����
    debug("׼������")
    global HK_PICKUP
	Loop, 10
	{
	    retort()
	    Sleep, 200
        Send {%HK_PICKUP%}
	}
    debug("�������")
}
;------------------------------------------------------------------------------
kill() {
	checkmonster()
	attack()
    pickitem()
}

retort() { ; INFO �ָ�����ǰ������
	if monsterIsChecked() {
        debug("��ʼ����")
    	attack()
        pickitem()
        debug("����������")
        return true
    } else
        return false
}
;------------------------------------------------------------------------------
rest() { ; ��Ϣ
    global
    debug("��ʼ����")
	Sleep 200
	Send {%HK_REST%}
	; ֱ��hp,mp����
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
	debug("��Ϣ����!")
    ; �����Ϣ״̬
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
; ��Ļ������ɫȡ������ {
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
; �������� {
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

^$F12::Gui, Show, x154 y137 h437 w523, �����ɡ��������� ;{
;}

^!z::   ;{
    MouseGetPos, MouseX, MouseY
    PixelGetColor, color, %MouseX%, %MouseY%
    msg = The color at %MouseX%, %MouseY% is %color%.
    debug(msg)
    MouseMove, %MouseX%, %MouseY%
return  ;}
;#Persistent
^h::    ;{������״̬���Ƿ����
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

^j::    ;{��⽡��״̬
    SetFormat, float, 0.2
    s := "������״̬��"
    myhp := getMyHP()
    mymp := getMyMP()

    if hpisfull()
        s .= "HP: ��"
    if mpisfull() = 1
        s .= "MP: ��"

    s .= "HP�ٷֱȣ�"myhp
    s .= " MP�ٷֱȣ�"mymp

    if monsterIsChecked() {
        s .= " ������״̬��"
        s .= "ʣ��Ѫ����"getMonHP()
    }
    debug(s)
return  ;}

^t::    ;{������
    debug(isMpLess(0.9))
;}
^!c::LOG_TO_CHAT := not LOG_TO_CHAT ;{��־��������촰�ڿ���
;}
;}
