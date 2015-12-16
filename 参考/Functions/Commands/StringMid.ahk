StringMid(InputVar, StartChar, Count , L="") 
{ 
   StringMid, OutputVar, %InputVar%, % StartChar, % Count, % L 
   Return OutputVar 
}