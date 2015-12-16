;Temperature Conversion
;Author: Invalid User
;Param 1:
;	F Returns Param2 Converted to FahrenHeit
;	C Returns Param2 Converted to Celsius
;Param 2:
;	Temperature to be converted
;If Param 1 Invalid an empty string is returned
;if Param 2 not a digit an empty string is returned
TempConv(T,N)
{
	If T = F
		R := (N * 2) - (N * 2 * 0.1) + 32
	If T = C
		R := (N - 32) * (5/9)
	Return R
}