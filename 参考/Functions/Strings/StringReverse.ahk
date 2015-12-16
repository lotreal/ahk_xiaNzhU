;String Reverse Function.
;Turns "this" into "siht"
StringReverse(String) 
{ 
   Loop, Parse, %String% 
        ResultString = %A_LoopField%%ResultString% 
   Return ResultString 
}