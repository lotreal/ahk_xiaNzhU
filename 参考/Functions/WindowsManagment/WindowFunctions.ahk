; Savage
; http://www.autohotkey.com/forum/viewtopic.php?t=3741
;_____Window Management Functions 
;_____A couple of useful functions for managing windows, and the variables they need to work 
;_____Include this file in your autoexecute section and you're ready to go :) 

;_____Initialize variables for window rolling 
RolledWindowIds = 
SysGet, CaptionHeight, 4 

;any window you want to ignore rolling, such as a desktop class, put here, seperated by spaces 
RollExcludeClasses = DesktopBackgroundClass 

;_____rolls window under cursor if its unrolled, unrolls if rolled 
WinToggleRoll(hwnd) 
{ 
	global 
	IfInString, RolledWindowIds, ~%hwnd%~ 
		WinUnRoll(hwnd)
	else
		WinRoll(hwnd)
} 

;_____rolls the window under cursor into its caption 
WinRoll(hwnd) 
{ 
	global 
	WinGetPos, x, y, width, height, ahk_id %hwnd% 
	if height > 45 
	{ 
		RolledWindowDim%hwnd% = %height% 
		RolledWindowIds := RolledWindowIds . "~" . hwnd . "~" 
		WinMove, ahk_id %hwnd%, , , , ,%captionheight% 
	} 
} 

;_____unrolls the window under cursor 
WinUnRoll(hwnd) 
{ 
	global 
	StringReplace, RolledWindowIds, RolledWindowIds, ~%hwnd%~ 
	Transform, OldHeight, deref, `%RolledWindowDim%hwnd%`% 
	;this shouldn't happen, but just in case .... 
	If OldHeight = 0 
	OldHeight = 400 
	WinMove, ahk_id %hwnd%, , , , ,%OldHeight% 
	RolledWindowDim%hwnd% = 0 
} 


;_____unrolls all windows, you should call this in an OnExit sub 
;WinRestore() 
;{ 
;	global RolledWindowIds 
;	StringSplit, winid, RolledWindowIds, ~ 
;	If winid0 != 0 
;	{ 
;		Loop, %winid0% 
;		{ 
;			out := winid%A_index% 
;			if out != 
;			WinUnRoll(winid%A_index%) 
;		} 
;	} 
;}

; Optimized, untested
WinRestore()
{
	Global RolledWindowIds
	Loop, Parse, RolledWindowIds, ~
	If A_LoopField <>
		WinUnRoll(A_LoopField)
}

;_____returns the id if the mouse is in the caption area of the window, excluding icon area, and certain classes 
MouseIsInCaption() 
{ 
	global CaptionHeight, RollExclude Classes 
	MouseGetPos, x, y, id 
	WinGetClass, class, Ahk_id %id% 
	WinGetPos, winx, winy, winw, winh, ahk_id %id% 
	If (x > (20 + winx)) && (x < (winx + winw)) && (y < (CaptionHeight + winy)) && (y > (winy)) && (InString(RollExcludeClasses,class) != 1) 
		return id 
	else 
		return 0 
} 

;____function version of ifinstring 
InString(lookin,lookfor) 
{ 
	IfInString, lookin, lookfor 
		return 1 
	else 
		return 0 
} 

;_____Toggles 150 transparency on/off 
ToggleActiveTransparency() 
{ 
	Winget, trans, transparent, A 
	if trans = 150 
		Winset, transparent, OFF, A 
	else 
		Winset, transparent, 150, A 
} 
