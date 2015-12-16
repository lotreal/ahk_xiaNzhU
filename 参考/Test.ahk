;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

G_ID = 8

$F11::
; &hp=0.6
; &mp=0.2
; &ko=6
inputString = &hp=0.6

StringLeft, firstChar, inputString, 1
if (firstChar!="&") {
    return
}
StringSplit, tokens, inputString, =, .  ; Omits periods.

cfg := tokens1
cfgValue :=
StringLen, length, InputVar

if (tokens2 != "") {
    cmd := tokens1
    if (cmd="&hp") {
        MsgBox % set hp tokens2
    } else if (cmd="&mp") {
        MsgBox % set mp tokens2
    }
}
Loop, %tokens0%
{
    this_color := tokens%a_index%
    MsgBox, Color number %a_index% is %this_color%.
}
this_color := tokens3
MsgBox, Color number %a_index% is %this_color%.
return

testv() {
    global
    t := G_ID
    MsgBox %t%
    if t = G_ID ; XXXXXXXXXX
        MsgBox X1

    if t = %G_ID%
        MsgBox X2
    return G_ID
}

$F12::Reload ;{
;}

