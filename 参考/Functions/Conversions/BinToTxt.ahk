;Converts Bininary String to Text String
BinToTxt(binarystring) 
{ 
	autotrim, off 
	loop 
	{ 
		var=128 
		ascii=0 

		StringRight, byte, binarystring, 8 

		if byte= 
			break 

		StringTrimRight, binarystring, binarystring, 8 

		Loop, parse, byte 
		{ 
			if a_loopfield = 1 
			ascii+=%var% 
			var/=2 
		} 

		transform, text, Chr, %ascii% 
		alltext=%text%%alltext% 
	} 
	autotrim, on 
	return alltext 
}