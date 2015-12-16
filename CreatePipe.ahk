#NoEnv
/*
The (child) console app reads from StdIn and write to StdOut/StdErr.
So, it needs to access the handles hStdInRd and/or hStdOutWr of the StdIn and/or StdOut pipes.
*/

;/* Example1
sCmd := "ipconfig /all"
sWork := ""

CreatePipe(hStdOutRd, hStdOutWr)  ; Create a pipe for StdOut
SetHandleInformation(hStdOutWr)   ; make the handle hStdOutWr inheritable to a child process, the console app
pid := CreateProcess(sCmd, sWork) ; Create the console app without creating a console window
StdOutput(sOutput, hStdOutRd, hStdOutWr) ; complete the StdOut

MsgBox % sOutput
;*/

/* Example2
sCmd := "sort.exe"
sWork := ""
sInput := "abc`r`nefg`r`nhijk`r`n0123`r`nghjki`r`ndflgkhu`r`n"

CreatePipe(hStdInRd , hStdInWr ) ; Create a pipe for StdIn
CreatePipe(hStdOutRd, hStdOutWr) ; Create a pipe for StdOut

SetHandleInformation(hStdInRd ) ; make the handle hStdInRd inheritable to a child process, the console app
SetHandleInformation(hStdOutWr) ; make the handle hStdOutWr inheritable to a child process, the console app

pid := CreateProcess(sCmd, sWork) ; Create the console app without creating a console window

StdInput( sInput , hStdInRd , hStdInWr ) ; complete the StdIn
StdOutput(sOutput, hStdOutRd, hStdOutWr) ; complete the StdOut

MsgBox % sOutput
*/


CreateProcess(sCmd, sWork = "")
{
   Global hStdInRd , hStdInWr
   Global hStdOutRd, hStdOutWr

   VarSetCapacity(pi, 4 * 4)
   VarSetCapacity(si, 68, 0)

   EncodeInteger(&si +  0, VarSetCapacity(si))   ; size of si
   EncodeInteger(&si + 44, 0x100)         ; STARTF_USESTDHANDLES
   EncodeInteger(&si + 56, hStdInRd)      ; hStdInput
   EncodeInteger(&si + 60, hStdOutWr)      ; hStdOutput
   EncodeInteger(&si + 64, hStdOutWr)      ; hStdError

   DllCall("CreateProcess", "Uint", 0, "str", sCmd, "Uint", 0, "Uint", 0, "int", True, "Uint", 0x08000000, "Uint", 0, "str", (sWork ? sWork : "."), "Uint", &si, "Uint", &pi)   ; bInheritHandles and CREATE_NO_WINDOW

   ptr := &pi
   hProc := *ptr++ | *ptr++ << 8 | *ptr++ << 16 | *ptr++ << 24
   hThrd := *ptr++ | *ptr++ << 8 | *ptr++ << 16 | *ptr++ << 24
   pid   := *ptr++ | *ptr++ << 8 | *ptr++ << 16 | *ptr++ << 24
   tid   := *ptr++ | *ptr++ << 8 | *ptr++ << 16 | *ptr++ << 24

   CloseHandle(hProc)
   CloseHandle(hThrd)

   Return pid
}

CreatePipe(ByRef hRead, ByRef hWrite)
{
   Return DllCall("CreatePipe", "UintP", hRead, "UintP", hWrite, "Uint", 0, "Uint", 0)
}

StdInput(ByRef sInput, hStdInRd, hStdInWr)
{
   DllCall("WriteFile", "Uint", hStdInWr, "str", sInput, "Uint", StrLen(sInput), "UintP", nWr, "Uint", 0)

   CloseHandle(hStdInWr)
   Loop
   {
      If DllCall("GetFileSize", "Uint", hStdInRd, "Uint", 0) <= 0
         Break
      Sleep, 10
   }
   CloseHandle(hStdInRd)
}

StdOutput(ByRef sOutput, hStdOutRd, hStdOutWr)
{
   Loop
   {
      If ( nLen := DllCall("GetFileSize", "Uint", hStdOutRd, "Uint", 0) ) > 0
      {
         VarSetCapacity(sTemp, nLen, 0)
         DllCall("ReadFile", "Uint", hStdOutRd, "str", sTemp, "Uint", nLen, "UintP", nRd, "Uint", 0)
         sOutput .= sTemp
      }
      Else
      {
         Global pid
         Process, Exist, %pid%
         If !ErrorLevel
             Break
      }
      Sleep, 10
   }

   CloseHandle(hStdOutRd)
   CloseHandle(hStdOutWr)
}

CloseHandle(Handle)
{
   Return DllCall("CloseHandle", "Uint", Handle)
}

GetHandleInformation(Handle)
{
   DllCall("GetHandleInformation", "Uint", Handle, "UintP", nFlags)
   Return nFlags
}

SetHandleInformation(Handle, nFlags = 1)
{
   Return DllCall("SetHandleInformation", "Uint", Handle, "Uint", nFlags, "Uint", nFlags)   ; HANDLE_FLAG_INHERIT
}

EncodeInteger(ref, val)
{
   DllCall("ntdll\RtlFillMemoryUlong", "Uint", ref, "Uint", 4, "Uint", val)
}
