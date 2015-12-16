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

myCID := getComputerID()
mySN := getSN(myCID)

msgbox % myCID
msgbox % mySN

Gui, Font, S14 CDefault, Verdana
Gui, Add, Edit, x6 y20 w450 h50 , d878d9646fc26427d36937d45698ac0d
Gui, Add, Button, x126 y120 w230 h60 , Éú³É
; Generated using SmartGUI Creator 4.0
Gui, Show, x303 y249 h204 w477, New GUI Window
Return

GuiClose:
ExitApp

cfgSN := ""
IniRead, cfgSN, %INI_FILE%, Config, SN, %cfgSN%

 loop {
    if (cfgSN == mySN) {
        break
    }

    InputBox, InputPass, key, , ,,,,,,,%myCID%
    If ErrorLevel
      ExitApp

    If (InputPass = mySN)
    {
        IniWrite, %mySN%, %INI_FILE%, Config, SN
        msgbox OK
        break
    }
    Else
    {
        msgbox error
    }
}

; Reg {
getComputerID() {
    id = "xiaNzhU"
    file = %A_Temp%\mac.txt
    RunWait, %ComSpec% /c ipconfig /all > %file%, , Hide ; ipconfig (slow)
    FileRead, mac, %file%
    RegExMatch(mac, "Physical Address.*?(0.*)", mac)
    ;filedelete, c:\mac.txt
    smac := RegExReplace(mac1, "(\w{2})-(\w{2})", "$2$1")
    id .= smac
    id .= A_ComputerName
    id := Hash(id, StrLen(id))
    perfix := SubStr(Hash(id, StrLen(id), 4),3 ,4)
    id := RegExReplace(id, "(\w{4})(\w{4})(\w{4})(\w{4})", "-$4-$2")
    id = %perfix%%id%
    return id
}

getSN(id) {
    ; compute sn
    id := RegExReplace(id, "(\w{1})(\w{1})", "$2$1")
    id := RegExReplace(id, "(\w{2})(\w{2})", "$2$1")
    id := RegExReplace(id, "(\w{4})(\w{4})", "$2$1")
    id := Hash(id, StrLen(id))
    id := Hash(id, StrLen(id), 4)
    id := Hash(id, StrLen(id), 4)
    id := Hash(id, StrLen(id))
    perfix := SubStr(Hash(id, StrLen(id), 4),3 ,4)
    id := RegExReplace(id, "(\w{4})(\w{4})(\w{4})(\w{4})", "-$4-$2")
    id = %perfix%%id%
    return id
}

Hash(ByRef sData, nLen, SID = 3)   ; SID: 3 for MD5, 4 for SHA
{
   DllCall("advapi32\CryptAcquireContextA", "UintP", hProv, "Uint", 0, "Uint", 0, "Uint", 1, "Uint", 0xF0000000)
   DllCall("advapi32\CryptCreateHash", "Uint", hProv, "Uint", 0x8000|0|SID , "Uint", 0, "Uint", 0, "UintP", hHash)

   DllCall("advapi32\CryptHashData", "Uint", hHash, "Uint", &sData, "Uint", nLen, "Uint", 0)

   DllCall("advapi32\CryptGetHashParam", "Uint", hHash, "Uint", 2, "Uint", 0, "UintP", nSize, "Uint", 0)
   VarSetCapacity(HashVal, nSize, 0)
   DllCall("advapi32\CryptGetHashParam", "Uint", hHash, "Uint", 2, "Uint", &HashVal, "UintP", nSize, "Uint", 0)

   DllCall("advapi32\CryptDestroyHash", "Uint", hHash)
   DllCall("advapi32\CryptReleaseContext", "Uint", hProv, "Uint", 0)

   SetFormat, Integer, H
   Loop, %nSize%
   {
   nValue := *(&HashVal + A_Index - 1)
   StringReplace, nValue, nValue, 0x, % (nValue < 16 ? 0 :)
   sHash .= nValue
   }

   Return sHash
}
;}