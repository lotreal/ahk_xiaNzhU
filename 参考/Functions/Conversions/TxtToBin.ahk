;Converts text string to bininary string
TxtToBin(string) 
{ 

	Loop, parse, string 
	{ 
		var=128 

		Transform, tobin, Asc, %A_LoopField% 

		loop, 8 
		{ 
			oldtobin=%tobin% 
			tobin:=tobin-var 

			value=1 

			if tobin<0 
			{ 
				tobin=%oldtobin% 
				value=0 
			} 

			var/=2 
			allvalues=%allvalues%%value% 
		} 
	} 
return allvalues 
}