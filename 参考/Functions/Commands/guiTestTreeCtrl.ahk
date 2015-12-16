;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         micha  misifusc-mail@yahoo.de
;
; Script Function:
;	Support for TreeCtrl
;
HomePath=AHKTreeSupport\release\AHKTreeSupport.dll

hModule := DllCall("LoadLibrary", "str", HomePath) 
nRC = 0 
Gui, Add, Text,, DemoTreeView
;Gui, Add, Edit, vName
Gui, Show, w350 h350, this is a unique title
WinGet, HWND, ID, this is a unique title

; --------------- Create a TreeCtrl -------------------------------------
; -----------------------------------------------------------------------
dwexStyle := 0x10000000 | 0x01 | 0x02 | 0x04
dwStyle = 0
x = 10
y = 20
width = 300
height = 300
nID = 1234
nRC := DllCall("AHKTreeSupport\TreeCreate", DWORD, dwexStyle, DWORD, dwStyle, int, x, int, y, int, width, int, height, DWORD, HWND, int, nID, "Cdecl Int")
if (errorlevel <> 0) || (nRC = 0)
{
	MsgBox error while calling TreeCreate Errorlevel: %errorlevel% - RC: %nRC%
	return
}
Text2Insert = InsertTest
TreeHwnd := GetChildHWND(HWND, "SysTreeView321") 
nRC := DllCall("AHKTreeSupport\TreeInsertItem", DWORD, TreeHwnd, Str, Text2Insert, DWORD, -0x10000, DWORD, -0x10000, "Cdecl Int")
if (errorlevel <> 0) || (nRC = 0)
{
	MsgBox error while calling TreeInsertItem Errorlevel: %errorlevel% - RC: %nRC%
	return
}
nCode = 2 ;1=Collapse / 2=Expand / 3=toggle / 0x4000=expand partial / 0x8000=collapsereset 
nRCExpand := DllCall("AHKTreeSupport\TreeExpandCollapse", UINT, TreeHwnd, UINT, nRC, UINT, nCode, "Cdecl Int")
if (errorlevel <> 0) ;|| (nRC = 0)
{
	MsgBox error while calling TreeExpandCollapse Errorlevel: %errorlevel%
	; return
}
InsertText2TreeView(TreeHwnd, nRC, -0x0FFFE, 0, Text2Insert)	
return

InsertText2TreeView(TreeHwnd, hParent, hLastInsertedItem, counter, Text2Insert)
{	
	if counter > 3
		return

	loop, 3
	{		
		NewText2Insert = %Text2Insert%%A_INDEX%		
		;MsgBox, %TreeHwnd% %hParent% %hLastInsertedItem% %counter%
		nRC := DllCall("AHKTreeSupport\TreeInsertItem", DWORD, TreeHwnd, Str, NewText2Insert, DWORD, hParent, DWORD, hLastInsertedItem, "Cdecl Int")
		if (errorlevel <> 0) || (nRC = 0)
		{
			MsgBox error while calling TreeInsertItem Errorlevel: %errorlevel% - RC: %nRC%
			return
		}
		nCode = 2 ;1=Collapse / 2=Expand / 3=toggle / 0x4000=expand partial / 0x8000=collapsereset 
		nRCExpand := DllCall("AHKTreeSupport\TreeExpandCollapse", UINT, TreeHwnd, UINT, hParent, UINT, nCode, "Cdecl Int")
		if (errorlevel <> 0) ;|| (nRC = 0)
		{
			MsgBox error while calling TreeExpandCollapse Errorlevel: %errorlevel%
			; return
		}					
		InsertText2TreeView(TreeHwnd, nRC, hLastInsertedItem, counter+1, Text2Insert)
	}	
}
return

GuiClose:
ExitApp


GetChildHWND(ParentHWND, ChildClassNN)
{
	WinGetPos, ParentX, ParentY,,, ahk_id %ParentHWND%
	if ParentX =
		return  ; Parent window not found (possibly due to DetectHiddenWindows).
	ControlGetPos, ChildX, ChildY,,, %ChildClassNN%, ahk_id %ParentHWND%
	if ChildX =
		return  ; Child window not found, so return a blank value.
	; Convert child coordinates -- which are relative to its parent's upper left
	; corner -- to absolute/screen coordinates for use with WindowFromPoint().
	; The following INTENTIONALLY passes too many args to the function because
	; each arg is 32-bit, which allows the function to automatically combine
	; them into one 64-bit arg (namely the POINT structure):
	return DllCall("WindowFromPoint", "int", ChildX + ParentX, "int", ChildY + ParentY)
}
