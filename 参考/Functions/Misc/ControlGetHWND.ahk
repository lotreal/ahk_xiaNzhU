;****Function to retrieve a control's handle.
ControlGetHWND(WindowHWND, CtrlClass, CtrlInstance) 
{ 
  ; Retrieves the handle of a control 
  ; WindowHWND - Handle to the parent window (window that contains the control) 
  ; CtrlClass - ClassName of the control 
  ; CtrlInstance - Instance number of the control 
  Loop, %CtrlInstance% 
  { 
    tempHWND := DllCall("FindWindowExA", "Uint", WindowHWND, "Uint", tempHWND, "str", CtrlClass, "str", NULL, "Uint") 
    If tempHWND = 0 
      Break 
  } 
  Return tempHWND 
}