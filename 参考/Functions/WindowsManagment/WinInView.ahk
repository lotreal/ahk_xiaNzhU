;Function to return if window is hidden or not, change, or toggle state.
; Author: Invalid User
;; Param 1: Check/Change
;	Check - Returns -1 if window does not exist
;			Returns 0 if window is hidden
;			Returns 1 If Window is showing

;	Change - Returns -1 if Window does not exist
;			 Returns 0 if Windows final state is Hidden
;			 Returns 1 If Windows final state is Showing
;########################################################
;; Param 6: Effect
;	 0 (zero) - Hides window
;	 1 (one) - Shows window
;    2 (two) - Toggles current state.
;
;	 Returns "Error" for bad params
WinInView(Action, WinTitle, WinText="", ExcludeTitle="", ExcludeText="", Effect="")
{
	DHWState = %A_DetectHiddenWindows%
	If Action Not in Check,Change
		Result = Error
	DetectHiddenWindows, On
	IfWinNotExist, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
		Result = -1
	;Else If Window Exists
	IfWinExist, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	{
		DetectHiddenWindows, Off
		WinGetPos, WinX,,,, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText% 
		;If Window is hidden
		If WinX =
			Result = 0
		;If Window is showing
		Else
			Result = 1
	}
	If Action = Change
	{
		;Confirm Effect to take place, Return Error if None.
		If Effect Not between 0 and 2
			Result = Error
		;Show the window if it hidden
		If (Effect = 1) OR (Result = 0 AND Effect = 2)
		{
			WinShow, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
			Result = 1
		}
		;Hide the window if it is shown
		If (Effect = 0) OR (Result = 1 AND Effect = 2) 
		{
			WinHide, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
			Result = 0
		}	
	}
	DetectHiddenWindows, %DHWState%
	Return Result
}