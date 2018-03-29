*remember that:
*	 for Stata (and any other statistical package) any dataset is a
*	 RECTANGULAR ARRAY OF (i) VARIABLES (COLUMN DIMENSIONS) and (ii) OBSERVATIONS (ROW DIMENSION)
********************************************************************************
*LOOPS are usually used for lists of VARIABLES (what is one exception?)
*when operating through groups of OBSERVATIONS loops are rarely used in Stata.
*Bysort groups are useful to proceed through groups of observations characterised by common
*variables' characteristics. Let us proceed.
********************************************************************************
*Ref: Cox, N. J. (2002). Speaking Stata: How to move step by: step. Stata Journal, 2(1), 86-102.

*Ref: A really NICE website to learn Stata, and more: http://data.princeton.edu/stata/
********************************************************************************
set more off
clear all

*This column focuses on the "by varlist" construct in Stata
*idea behind by: is just this: do something separately for each group of
*observations defined by a specified combination of variable(s) list (varlist).

sysuse auto //sysuse because this is an in build stata "toy" dataset
			//otherwise you would just go with "use
			
*but I know ... now you hate dealing always with this dataset? Does Stata offer 
*other toy dataset to practice? YES! ... just type ...
sysuse dir

*let us now only on the portion (subgroup) of the dataset containing only observations
*commonly grouped by "foreign" type
summarize
	*let us take a little detour: (indentation!)
	*generate a variable wit a LOOOONG NAAAAME! >>>
	set seed 123456
	gen SuperSmartInstructor = runiform()
	summarize //now you see the long name is abbreviated and you cant read it
	*solve: there is a User Written (UW) command called "fsum": most of those for Stata 
	*are usually stored in the SSC repository here: https://ideas.repec.org/s/boc/bocode.html
	capture ssc install fsum //Quesiton: why do I use the "capture" command?
	fsum //this command shows the whole name without abbreviation
	*how to get help on how to use "fsum" (as any other stata command?)
	help fsum
	
	*another UW command in stata is "nmissing" it is useful
	*[try your code here to install and get help from it]
*以上自己看*
describe //another command to understand better what type of data you have
codebook, compact //another command i like a lot!!!

*well sorry ... let us go back to the main topic ... bygrouping!!! :)
*Oh no ... wait! First of all do you remember the key variable of the "auto.dta" dataset?
*QUESTION: do you remember its synthax?
	*(1) duplicates make
	*(2) duplicates report make
	*(3) report duplicates make
	*(4) duplicate report make
	
*QUESTION: what would you do if you want to know more about how to use this GREAT command?

*OK now let us do this with the by or "by" construct
by foreign: sum //you see only sum typed? (==summarize)
by foreign: describe //heck! well i learned something new ... some commands do not support bygrouping
by foreign: codebook, compact //heck! well i learned something new ... some commands do not support bygrouping
by foreign: tabulate price mpg if mpg <= 20 //please note the if qualifiers: it poses conditions on the range of mpg
by foreign: tabstat price mpg if mpg <= 20 //why dont you digit "help tabstat" to learn more about this command?

********************************************************************************
********************************************************************************SORTING
********************************************************************************
*In several cases, and before bygrouping, it makes sense to sort on the variables of interest
sort mpg //let us see what happens
sort rep78 //let us note that for Stata missing values "." are comparable to VERY LAAAARGE NUMBERS!
sort make //what happens when I sort on the base of a string variable?
sort foreign //numbers appear in "black"; string variables in "red"; when you sort "blue" variables ... what does it happen?

*TIP: sometimes data are already sorted ok ... but ALWAYS sort the data to be 100% sure
*QUESTION: what if you want to sort by foreign and WITHIN foreign by mpg?
	*(1) sort foreign
	*	 sort mpg
	*(2) sort foreign
	*	 sort mpg
	*(3) sort foreign mpg
	*(4) sort mpg foreign
*there is also a way to make the variables of interes appear first in the list
order foreign mpg

*so you should really type teo commands ...
sort foreign
by foreign: sum

*... not really, because this is done MANY times in data exploration, Stata
*allows writing ti in comapct form:

bysort foreign: sum //also "bys foreign: sum" is possible, this is also my favourite ... yeah I know who cares?
********************************************************************************SORTING AND GROUPING ACCORDING TO MULTIPLE VARIABLES
********************************************************************************Sorting when using longitudinal data
*LONGITUDINAL data are data for which each observation is observed at differnt points in time
*These are also called "PANEL" data
*Example
* id	Age		HeightCm
*John	10		120
*John	15		160
*John	20		180
*John	25		180
*Margie 10		xxx
*Margie 15		xxx
*and so on and so on
********************************************************************************
clear all
*let us load a Panel Data, World Bank - World Developmet Indicators
use WBWDI_toy.dta

sum
*let us browse the data to have an idea
*question what is the key?

*now we can do grouping in two ways
	*all countries by year
	*all years by country (Panel)

*排序
sort countrycode year  //browse
sort year countrycode //browse
*bys应该是一个类似apply的操作
bys countrycode: sum GdpPerCapita
bys year: sum LifeExpectBirth

*Final note: do you see that the same dataset is also in .xls and .txt format?
*How would you use those if the .dta format was not available?
*HINT: start playing with the File >>> Import menu from the Stata GUI ... it is going to be very useful
********************************************************************************
*But let us back to the auto.dta dataset
clear
sysuse auto

preserve //I am preserving the dataset because what I am going to do DESTROYS the previous dataset

	*let us day I want to know how many subgroups of data I have by combining Foreign and rep78 variables?
	*one way would be using the "contract" command and listing the resutl or browsing the dataset created
	contract foreign rep78
	list //... and let us understand what we have done
	
restore //go back to the original dataset

*Question: think abut the two commands
*"sort foreign rep78" and "sort rep78 foreign"
	*(1) they will produce the same groups T/F
	*(2) they will make observations and groups appear in the same order T/F
	*(3) they will make variables to appear in the same order T/F
********************************************************************************
********************************************************************************BUILT IN _n _N
********************************************************************************
/*we want to group observations in group because
we want to operate in these groups independently for some reason*/

*_n indicates the observation number in the dataset as it is currently ordered
*_N indicates the Total number of observations in the Dataset
*however we can combine _n and _N operators to use these methods of counting WITHIN specific groups

generate nid = _n //generate variables
generate Nid = _N

order nid Nid //... and browse to understand what we have done
*so you see that Nid does NOT depend on the ordering but nid does

/*PUNCHLINE>>>Under  by varlist: + _n/_N combination, the _n and _N operators, function
WITHIN each group of observations as defined by the varlist and not the entire dataset*/

*for example we want now to know how many groups are generated by combining 
*foreign and rep78 and how many observations within each group

bys foreign rep78: gen nid_bygroup = _n
bys foreign rep78: gen Nid_bygroup = _N
order nid_bygroup Nid_bygroup
sort Nid_bygroup nid_bygroup //We seem to have accomplished the task, but the group identifiers 
							//look quite Ugly because the progression skips some integers in that it depends on the 
							//number of observations within the group
							//this will generate MISTAKES if the total number of observations in two or more groups
							//is the same. Do we have a CORRECT WAY TO SOLVE IT?
							
drop Nid_bygroup nid_bygroup //let us get rid of the wrong group identifier

*the egen command (help egen) is one of the most powerful command in Stata to operate within groups!
*you want to learn how it works very well. It will save you time and headaches

sort foreign rep78
egen GroupId1 = group(foreign rep78)

sort rep78 foreign
egen GroupId2 = group(foreign rep78)

sort rep78 foreign
egen GroupId3 = group(rep78 foreign)

order GroupId* foreign rep78 //... and browse to understand what we ahve done

*but now i realize that when missing values are present the egen ...group combination
*does not assign an id to the group

help egen //and look if the command had OPTIONS to obviate thi problem

sort rep78 foreign
egen GroupId4 = group(rep78 foreign), missing
order GroupId* foreign rep78 //... and browse
*it seems that the option missin (all options in Stata go after the main command and a comma ","
*DOES the trick! :)))))))))))))0
********************************************************************************
*now I want within-group variables recording: (1) the Total observations in the groups and (2) the within group ordering of observations
*and (3) that follows the foreign, rep78 sorting order and (4) that includes groups generated by missing values

*(1) bys GroupId1: gen Nid_GroupId1 = _N
* 	 bys GroupId1: gen nid_GroupId1 = _n
*	
*(2) bys GroupId4: gen Nid_GroupId4 = _N
* 	 bys GroupId4: gen nid_GroupId4 = _n
*
*(3) sort foreign rep78
*	 egen GroupId5 = group(foreign rep78), missing
*	 bys GroupId5: gen Nid_GroupId5 = _N
*	 bys GroupId5: gen nid_GroupId5 = _n
*
*(4) egen GroupId6 = group(foreign rep78), missing
*	 bys GroupId6: gen Nid_GroupId6 = _N
*	 bys GroupId6: gen nid_GroupId6 = _n

order GroupId* foreign rep78 //let us check
assert GroupId5 == GroupId6 //Assert：比较两组间是否有区别
assert GroupId4 == GroupId5
assert GroupId4 == GroupId6
assert GroupId1 == GroupId5
********************************************************************************
********************************************************************************Distinguishing between first and last obervations
********************************************************************************Within a group
*Idea: _n == 1 is a logical test for being the first observations (or in the group of the first ones if ties)
	*_n == _N is a logical assertion for being the last one (or in the group of the last ones if ties)
	
*note that usually "LOGICAL ASSERTION" of equality is "==", while VALUE ASSIGNMENT is "="
*this is not true only in Stata as in almost any other language ... Python, R etc ...

*Example#1: compute the difference in mpg between the last and first values in each group
*how would you do that?

*Example #2: check if there are duplicates observations in the dataset
bysort *: assert _N == 2 //by using the wildcard *
*or
duplicates report *

sort foreign rep78
egen GroupId5 = group(foreign rep78), missing
bys GroupId5: gen Nid_GroupId5 = _N
bys GroupId5: gen nid_GroupId5 = _n

*find the difference between the first values and last values of mpg within each group 
sort GroupId5 foreign rep78 mpg
order GroupId5 foreign rep78 mpg

bys GroupId5: gen MpgDiff = mpg[_N] - mpg[1] // note in this case _n == 1
order GroupId5 foreign rep78 mpg MpgDiff

*check if the next value within the group is equal to the previous one
bys GroupId5: gen MpgEqual = 0 if mpg[_n] != mpg[_n-1] // != means "different"
bys GroupId5: replace MpgEqual = 1 if mpg[_n] == mpg[_n-1]

*put a "1" also to the previous value
bys GroupId5: replace MpgEqual = 1 if mpg[_n] == mpg[_n+1]
order GroupId5 foreign rep78 mpg MpgDiff MpgEqual

********************************************************************************
*Exercise: build unique idnetifiers for all possible groups within GroupId5
*that have the same value
********************************************************************************
