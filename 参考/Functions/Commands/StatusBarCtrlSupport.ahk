; SB_Segments: Initiates a Status Bar and divides it into segments. Depends on "VarSetCapacity" and "InsertInteger". 
; Usage: You put the positions of your segments into a string like this "10,20,100,200,-1". The numbers determins the right edge of the segment,
; "-1" means 'make a final segment filling the remaining space until the rightmost border' 
; If the string is empty ("") you'll only see the size grip (see sample below) 
; Sample: SB_Segments("20,44,200,350,450,-1") 
; To get the correct GUI for a status bar you should have to do a 'Gui +LastFound' before calling 'SB_Segments' 
; To resize the Statusbar with the Gui: 
;           guisize: 
;           SendMessage, 5, 0, 0,, ahk_id %BarHWND%  ; 5 is WM_SIZE 
;           return 
SB_Segments(segs) 
{ 
	global BarHWND 
	; WS_CHILD (0x40000000) + WS_VISIBLE (0x10000000) = 0x50000000: 
	BarHWND := DllCall("CreateStatusWindow", int, 0x50000000, str, "", UInt, WinExist(), UInt, 5555) 
	if (segs = "") { 
		VarSetCapacity(parts, 4)  ; Create 'parts' and make it 4 Byte times n segments large 
		SendMessage, 0x404, 1, &parts,, ahk_id %BarHWND%  ; Sends the number of segments and its positions to the status bar 
		return, BarHWND 
	} else { 
		n = 0 
		loop, Parse, segs, CSV         ; How many segments are needed -> n 
	    n++ 
	    VarSetCapacity( parts, 4*n )   ; Create 'parts' and make it 4 Byte times n segments large 
	    loop, Parse, segs, CSV         ; Fill the var 'parts' with content (the postitons) 
	    InsertInteger( A_LoopField, parts, 4 * ( A_Index - 1 ) ) ; Reserves 4 Bytes per run in the string "parts" 
	    SendMessage, 0x404, %n%, &parts,, ahk_id %BarHWND%           ; Sends the number of segments and its positions to the status bar 
	    return, BarHWND 
    } 
} 

; SB_Icon: Adds an icon to a specific segment within a status bar 
; SEG is the number of the segment (the first segment is 1, the second 2...) 
; NAME is the filename of the graphic to show 
; Sample: SB_Icon(1, "icon.ico")  This puts the file 'icon.ico' into the first segment of your status bar 
SB_Icon(seg, name) 
{ 
    global BarHWND 
    seg-- ; subs 1 from the segment, because it starts with zero 
    hicon := DllCall("LoadImage", UInt, NULL, Str, name, UInt, 1, Int, 16, Int, 16, UInt, 0x10|0x2000) 
    if hicon 
        SendMessage, 0x40F, seg, hicon,, ahk_id %BarHWND%  ; 0x40F is SB_SETICON 
    return 
} 

; SB_Text: Puts a text into a segment of your status bar 
; SEG is the number of the segment (the first segment is 1, the second 2...) 
; TEXT is the text to display. Put it into doublequotes 
; Sample: SB_Text(1,"Hello World!") 
SB_Text(seg, text) 
{ 
    global BarHWND 
    seg-- 
    SendMessage, 0x401, %seg%, &text,, ahk_id %BarHWND%  ; 0x401 is SB_SETTEXT 
    return 
} 

InsertInteger(pInteger, ByRef pDest, pOffset = 0, pSize = 4) 
; To preserve any existing contents in pDest, only pSize number of bytes starting at pOffset 
; are altered in it. The caller must ensure that pDest has sufficient capacity. 
{ 
   mask := 0xFF  ; This serves to isolate each byte, one by one. 
   Loop %pSize%  ; Copy each byte in the integer into the structure as raw binary data. 
   { 
      DllCall("RtlFillMemory", UInt, &pDest + pOffset + A_Index - 1, UInt, 1, UChar, (pInteger & mask) >> 8 * (A_Index - 1)) 
      mask := mask << 8  ; Set it up for isolation of the next byte. 
   } 
} 
; ----- Sample with empty bar (shows only the size grip) 
;#singleinstance force 
;
;gui, +resize 
;gui, show, h50 w200 
;
;; add statusbar control: 
;gui, +lastfound 
;SB_Segments("") 
;return 
;
;guisize: 
;SendMessage, 5, 0, 0,, ahk_id %BarHWND%  ; 5 is WM_SIZE 
;return 
