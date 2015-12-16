StringGetPos(InputVar, SearchText, Mode="", Offset="") 
{ 
   StringGetPos, OutputVar, %InputVar%, % SearchText, % Mode, % Offset 
   Return OutputVar 
}