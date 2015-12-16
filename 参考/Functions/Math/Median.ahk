;Median fucntion
;Returns Median in a set of numbers
;list must be comma delimited
Median(List)
{
	Sort, List, N D,  ; Sort numerically, use comma as delimiter.

	;Create Array
	StringSplit, Set, List, `,
;Figure if odd or even
	R := Set0 / 2
	StringSplit, B, R, .
	StringLeft, C, B2, 1
	;Even
	If C = 0
	{
		pt1 := B1 + 1
		Med := (Set%B1% + Set%pt1%) / 2
	}
	;Odd
	Else
	{
		Med := Ceil(R)
		Med := Set%Med%	
	}
	Return Med
}