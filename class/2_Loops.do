*loops allow you to save time on repetitive commands
*example combining several datasets or making same transformations across multiple variables
*the three commands mostly used in Stata to do loops are
	*1)Foreach
	*2)Forvalues
	*3) Levelsof
	*4) Others (like the command "for")
	
*they work excellently with macros
*reference
	*https://www.ssc.wisc.edu/sscc/pubs/stata_prog1.htm
********************************************************************************
clear all
set more off
********************************************************************************FOREACH
sysuse auto

*let us say we want to do log transformations of a set of variables
gen ln_price = log(price)
gen ln_mpg = log(mpg)
gen ln_weight = log(weight)


*you have another option
	*(1)create first a local
	local vars "price mpg weight"
	
	*(2)then use the foreach command
	foreach var of local vars { //open the loop with curly brackets
		gen ln_`var'2 = log(`var') //reference to the elements `var' of the local vars
									//note: I put also "2" because the names
										//are already taken by the previous transformations
	} //close the loop

* let us check
summarize ln_price ln_price2 ln_mpg ln_mpg2 ln_weight ln_weight2
drop ln_price ln_price2 ln_mpg ln_mpg2 ln_weight ln_weight2 //let us drop all the variables I created for the example
						
						/*in general
						foreach macro name in list of values {
						one or more statements defined in terms of that macro name
						}
						*/
						
*Another example****************************************************************
foreach x of varlist * { //note here the "trample card" * used to reference all the possible variables
	capture gen log`x' = log(`x')
	capture gen sqrt`x' = sqrt(`x')
	capture gen rec`x' = 1/`x'
}
drop log* sqrt* rec* //use again the trample card "*"; this is standard in regular expessions

*note the use of capture, if Stata meets an error message continues to operate
/*Why might the generate commands not work? Suppose in our case that the variables
in memory included some string variables, so that any attempt to take logarithms
or square roots or reciprocals of those variables would fail. The solution is to say, by
means of capture, �unless this will not work�. In other terms it is a way to tell Stata
to do the transformation for all the numeric variables.
*/
foreach x of varlist _all { //note here the _all used to reference all the possible variables: same result
	capture gen log `x' = log(`x')
	capture gen sqrt`x' = sqrt(`x')
	capture gen rec `x' = 1 /`x'
}
/*note also that in this second case I do not have to create a list of variables
in a local before starting the loop*/

*another example
foreach q of numlist 11/13 {
	gen price`q' = price
}
********************************************************************************FORVALUES
/*forvalues is complementary to foreach. It can be thought of as an important special
case of foreach, for cycling through certain types of numlist, but presented a little more
directly.*/

forval i = 6/10 {
	gen price`i' = log(price)
}

********************************************************************************
forval i = 1(2)5 {
	gen price`i' = log(price)
}
********************************************************************************LEVELSOF
*sometimes you don not want to loop through different variables but through different
*values of a given variable
levelsof rep78
display "`r(levels)'"
levelsof rep78, local(levels_of_rep78)
foreach rep of local levels_of_rep78 {
	gen v`rep' = 100 * `rep'
}
********************************************************************************Nested Loops
clear
*loops can be nested, this means you can use a looping command within another and so on...
*what is the order of appeareance?
forval i=1/3 {
	foreach letter in a b c {
		display "`i',`letter'"
	}
}

foreach letter in a b c {
	forval i=1/3 {
		display "`letter',`i'"
	}
}

*stata takes the first value in the outer loop and loops for all the values of the inner loop

********************************************************************************Initialization
clear
use monthyear.dta //include a dataset with data on income by month and year
*let us create indicators for the period without reference to month and year
*so example incJan1990 becomes inc1 ... and so on

local period 1 //initialize period with a local

forvalues year = 1990/2010 {
	foreach month in Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec {
		rename inc`month'`year' inc`period'
		
local period = `period'+1 //update period
	}
}
********************************************************************************