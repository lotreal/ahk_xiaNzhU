;Ini Testing
#Include %A_ScriptDir%\FileManagment\IniSectionGet.ahk
#Include %A_ScriptDir%\FileManagment\IniKeyGet.ahk

IniRead, Var1, %A_ScriptDir%\TestIni.ini, Section = 1, KeyName2
IniRead, Var2, %A_ScriptDir%\TestIni.ini, Section2, Key21
MsgBox %Var1% `n %Var2%

F9::Reload