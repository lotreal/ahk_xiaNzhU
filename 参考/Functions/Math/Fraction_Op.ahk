;<Fraction_Op.ahk>
;N = 12346609


;MsgBox % CommonFactor(N)
;F9::Reload

IsFraction(N)   ;Returns 0 if not Fraction, 1 if is. 
{ 
	;Factoring N is done recursively.
	;If N is prime, itself is the only divisor (and 1). 
	;If we find a proper divisor of N, attach it to the
	;list of divisors and get the factors N//i.
	;Does not reconize numbers like 1^2/3 as a fraction                                                                                                                                                                                                                                                                                                                  
	StringGetPos i, N, / 
	IfLess i,0, Return 0    ; no / 
		StringLeft L, N, i 
	If L is not Integer 
		Return 0             ; left of / is not integer 
	StringTrimLeft R, N, i+1 
	If R is not Integer 
		Return 0             ; right of / is not integer 
	Return 1 
}

;----------------------------------------
DeciToFraction(D)   ;Turns a decimal into a fraction. Not Reduced 
{ 
   R = 1 
   Loop 
   { 
      If (Ceil(D) = D) 
         break 
      D *= 10 
      R *= 10 
   } 
   Return Ceil(D) "/" R 
}
;----------------------------------
;Returns reduced result of dividing F1 by F2
DivFraction(F1,F2)
{
	F1 := Fraction(F1)
	F2 := Fraction(F2)
	StringSplit, F1_, F1, / ;Split and define Nu and De of each F
	StringSplit, F2_, F2, /
	Nu1 = %F1_1%
	De1 = %F1_2%
	Nu2 = %F2_1%
	De2 = %F2_2%
	
	Nu2 = %De2%
	De2 = %F2_1%
	
	Fr1 = %Nu1%/%De1%	
	Fr2 = %Nu2%/%De2%
	R := MultiFraction(Fr1,Fr2)
	Return R
}
;----------------------------------------------
;Returns Reduced result of mulitplying F2 with F2
MultiFraction(F1,F2)
{
	F1 := Fraction(F1)
	F2 := Fraction(F2)
	StringSplit, F1_, F1, / ;Split and define Nu and De of each F
	StringSplit, F2_, F2, /
	Nu1 = %F1_1%
	De1 = %F1_2%
	Nu2 = %F2_1%
	De2 = %F2_2%
	
	Nu := Nu1 * Nu2
	De := De1 * De2	

	R = %Nu%/%De%
	R := Reduce(R)
	R := MixNum(R)
	Return R
	
}
;------------------------------------------
LCM(N1,N2)   ; Least Common Multiple of N1 and N2 
{ 
   Return N1*N2//GCD(N1,N2) 
}
;------------------------------------------
;AddFraction Function, add fraction1 with fraction.
;Returns mixed number if possible, reduced
AddFraction(F1,F2)
{
	F1 := Fraction(F1) ;Convert to improper fractions
	F2 := Fraction(F2)
	StringSplit, F1_, F1, / ;Split and define Nu and De of each F
	StringSplit, F2_, F2, /
	Nu1 = %F1_1%
	De1 = %F1_2%
	Nu2 = %F2_1%
	De2 = %F2_2%
	
	Nu1 := Nu1 * De2
	Nu2 := Nu2 * De1
	De := De1 * De2
	Nu := Nu1 + Nu2
	
	R = %Nu%/%De%
	R := Reduce(R)
	R := MixNum(R)
	Return R
}
;------------------------------------------
;SubFraction Function, subtract fraction2 from fraction1.
;Returns mixed number if possible, reduced
SubFraction(F1,F2)
{
	F1 := Fraction(F1) ;Convert to improper fractions
	F2 := Fraction(F2)
	StringSplit, F1_, F1, / ;Split and define Nu and De of each F
	StringSplit, F2_, F2, /
	Nu1 = %F1_1%
	De1 = %F1_2%
	Nu2 = %F2_1%
	De2 = %F2_2%
	
	Nu1 := Nu1 * De2
	Nu2 := Nu2 * De1
	De := De1 * De2
	Nu := Nu1 - Nu2
	
	R = %Nu%/%De%
	R := Reduce(R)
	R := MixNum(R)
	Return R
}
;----------------------------------------------------------------------
;Reduce function reduces fraction.
Reduce(N)
{
	If N Contains %A_Space%
	{
		StringSplit, NA, N, %A_Space%
		W = %NA1%
		N = %NA2%
	}
	StringSplit, NA, N, `/
	Nu = %NA1%
	De = %NA2%
	GCD := GCD(Nu,De)
	Nu := Nu / GCD
	De := De / GCD
	If Nu = %De%
	{
		If W = 
			W = 0
		R := W + 1
		Return R
	}	
	If De = 1
	{
		If W = 
			W = 0
		R := W + Nu
		Return R
	}
	R = %W% %Nu%/%De%
	Return R
}
;-----------------------------------------------------------------------
;Greatest Common Denominator
;Returns the GCD of N1 and N2
;If N1 = N2 the returned value will be equal to N1 and N2 as they are Equal, respecfully
;That is the sets of Common factors are equal
;For ex: If 9 and 9 are compared, 9 is returned
;		 If 12 and 12 are compared, 12 is returned respectfully
GCD(N1,N2)   ; Greatest Common Divisor of N1 and N2 (Euclidean algorithm) 
{ 
   Loop 
   { 
      IfEqual N2,0, Return N1 
      N1 := N1 - (N1//N2)*N2 
      IfEqual N1,0, Return N2 
      N2 := N2 - (N2//N1)*N1 
   } 
}

GCD_2(N1,N2)  ; Greatest Common Divisor of N1 and N2 (Euclidean algorithm) 
{ 
   Loop 
   { 
      IfEqual N2,0, Return N1 
      N := Mod(N1,N2) 
      N1 = %N2% 
      N2 = %N% 
   } 
}
;------------------------------------------------
;IsPrime Function: Figures if number is Prime or Composite
;Returns -1 if N is not a digit
;Returns 0 if Prime number
;Returns 1 if Composite number
IsPrime(N)   ; -1 if N is not a digit; 1 if Prime or 1; 0 if Composite 
{ 
   If N Is Not Digit 
      Return -1 
   If N in 1,2,3,5,7,11    ; often called cases directly 
      Return 1 
   If N in 0,4,6,8,9,10 
      Return 0 
   Loop % Ceil(Sqrt(N))-1 
   { 
      i := A_Index + 1 
      If ((N//i)*i = N)    ; N is divisible by i 
         Return 0 
   } 
   Return 1 
}

IsPrime_2(N)  ; Return -1 if N is not Integer, 1 if Prime or 1, 0 if composite or 0 
{ 
   If N is not Integer 
      Return -1 
   If N in 1,2,3,5,7,11    ; often called cases directly 
      Return 1 
   If N in 0,4,6,8,9,10 
      Return 0 
   If (Mod(N,2)=0 or Mod(N,3)=0) 
      Return 0 
   c:= Floor(Sqrt(N)*1.000000001) ; against rounding errors 
   i = 5 
   j = 2 
   Loop 
   { 
      IfGreater i,%c%, Return 1 
      If (Mod(N,i) = 0)    ; N is divisible by i 
         Return 0 
      i += j 
      j := 6-j 
   } 
}
;--------------------------------------------------------
MixNum(N)   ; improper fraction to a mixed number. Ex: "13/6" -> "2+1/6" 
{ 
	Re := IsFraction(N)
	If Re = 1
	{
		StringSplit, P, N, / 
		R := P1//P2 
		IfEqual R,0, Return N 
		P1 -= R*P2 
		IfEqual P1,0, Return R 
		Return R "+" P1 "/" P2 ; Mixed numbers have + instead of Space, allowing formatted input 
	}
	Return N
}
;--------------------------------------------------------
;Least Common Denominator
;Returns the LCD of N1 and N2
LCD(N1,N2)
{
	NL = 1,2,3,4,5,6,7,8,9
	If N1 = %N2%
		Return "1"
	;CFL is Common Factor List
	Loop, 2
	{
		I := N%A_Index%
		LInt := A_Index
		Loop, %I%
		{
			R := N%LInt% / A_Index
			StringSplit, R, R, .
			If R2 Not Contains %NL%
			;Use this method so second array not needed to check how many items list 
			;for trimming comma(s)
			{ 
				If CFL%LInt% =
					CFL%LInt% = %R1%
				Else
					CFL%LInt% := R1 "," CFL%LInt%
			}	
		}
	}
	Sort, CFL1, N D,
	Sort, CFL2, N D,
	StringSplit, CL, CFL1, `,
	Loop, %CL0% 
	{
		Factor := CL%A_Index%
		If Factor = 1
			Continue
		If Factor In %CFL2%
			Break
	}
	If Factor Not In %CFL2%
		Return "1"
	Return Factor
}
;------------------------------------------------------------
;Fraction function turns mixed number into a improper fractions
;N formats is W N/D
;Ex: 12 2/3
;Formula is:
;	[(W*D) + N] / D
Fraction(N)
{
	If N Not Contains %A_Space%
		Return N
	StringSplit, WN, N, %A_Space%
	StringSplit, FN, WN2, /
	W = %WN1%
	N = %FN1%
	D = %FN2%
	N := W * D + N
	Result = %N%/%D%
	Return Result
	ListVars

}
;---------------------------------------------------------
Factor(N)   ; list of factors 
{ 
   N := Abs(N) 
   IfLess N,4, Return N 
   Loop % Ceil(Sqrt(N))-1 
   { 
      i := A_Index + 1 
      If ((N//i)*i = N)    ; N is divisible by i 
         Return i "," Factor(N//i)   ; Recursively on reduced part 
   } 
   Return N 
}

;Returns list of common factors of N
Factor_2(N)
{
	NL = 1,2,3,4,5,6,7,8,9
	;CFL is Common Factor List
	Loop, %N%
	{
		R := N / A_Index
		StringSplit, R, R, .
		If R2 Not Contains %NL%
		;Use this method so second array not needed to check how many items list 
		;for trimming comma(s)
		{ 
			If CFL =
				CFL = %R1%
			Else
				CFL = %R1%,%CFL%
		}	
	}
	Return CFL
}
;--------------------------------------------------------
Primes(N)   ; returns a list of primes up to N > 1 
{ 
   Primes = 2              ; First is the even prime 2 
   i = 3 
   Loop % (N-1)//2 
   { 
      IfNotEqual P%i%,0, { ; Not marked as composite: Prime is found 
         Primes = %Primes%,%i% 
         j := i*i          ; Small multiples are already marked 
         Loop 
         { 
            IfGreater j,%N%, Break 
            P%j% = 0       ; Mark multiples as composite 
            j += i 
         } 
      } 
      i += 2               ; next odd number 
   } 
   Return Primes 
}