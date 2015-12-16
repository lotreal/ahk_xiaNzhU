; EX############################################ 
; FUNCTION to extract the numeric part of a string 
; If a StartSign is defined, the number found after it will be exctracted, until a alphabetic character appears 
; If the StartSign is ommitted, the first number will be found 
; ErrorLevel is set to 1 if the String contains no number otherwise to 0 


ExtractNum(EX_InStr,EX_StartSign) 
  { 
    EX_OutNum = 
    EX_FoundNumTrue = 
    If EX_StartSign = 
      EX_StartSignTrue = Y 
    else 
      EX_StartSignTrue = 
          
    StringLen, EX_InStrLen, EX_InStr 
    Loop, %EX_InStrLen% 
      { 
        StringMid, EX_OutputVar, EX_InStr, A_Index, 1 
        If (EX_OutputVar = EX_StartSign) 
          EX_StartSignTrue = Y 
          
        if EX_OutputVar in 1,2,3,4,5,6,7,8,9,0 
          { 
            If EX_StartSignTrue = Y 
              { 
                EX_OutNum = %EX_OutNum%%EX_OutputVar% 
                EX_FoundNumTrue = Y 
              } 
          }    
          Else 
          { 
            If EX_FoundNumTrue = Y 
              Break 
          }      
      } 
    If EX_OutNum = 
      ErrorLevel = 1  
    Else 
      ErrorLevel = 0 

    Return EX_OutNum                
  }