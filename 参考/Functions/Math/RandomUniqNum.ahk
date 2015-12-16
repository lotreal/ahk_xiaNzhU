RandomUniqNum(Min,Max,N) 
{ 
   If (Max - Min + 1 < N) 
   { 
      MsgBox Cannot have %N% different numbers between %MIN% and %MAX% 
      return 
   } 

   Loop %N% 
   { 
     i := A_Index 
     Loop 
     { 
       Random R, %MIN%, %MAX%     ; R = random number 
       j := Index_%R%             ; get value from Indexes 
       If j is number 
         If j between 1 and % i - 1 
           If (R_%j% = R) 
             continue             ; repetition found, try again 
       Index_%R% := i             ; store index 
       R_%i% := R                 ; store in R_1, R_2... 
       RNList = %RNList%,%R% 
       break                      ; different number 
     } 
   } 
   StringTrimLeft RNList,RNList,1 ; remove leading "," 
   Return RNList 
}