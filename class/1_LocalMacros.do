*Let us talk about local and global macros
*based on:
	*Speaking Stata: How to face lists with fortitude by Nicholas J. Cox
	*http://data.princeton.edu/stata/programming.html
********************************************************************************
clear all
set more off
********************************************************************************
sysuse auto //load the data remember?
browse //look at the data in memory
*let us talk a bit first the colos that you see (black, blue, and red)


local mylocal "trunk weight length turn displacement" //assign variables to the "mylocal" placeholder.
												//mylocal is a local macro
												//note: Stata reads "rhsvar" as a SINGLE string
												//note: mylocal
*now we need to recall in Stata's memory the content of the placeholder
capture display mylocal //this does not work because mylocal has no meaning for stata
					//I "capture" this because I want Stata to move on despite the error message
display "mylocal" // this would just display "mylocal" as a string variable

/*the way in which we recall the placeholder (its content) to Stata is by introducing the 
name of the local macro by (`) and ending by ('): NOTE that the left quote or backtick
 ` differs from the closing or right quote or apostrophe ' */
display `mylocal' //this one displays the first values of the variables
*same as
display make price //would display "AMC Concord4099"

display "`mylocal'" //you have to enclose the local into double quotes so to call back the full string of variables names
*think about it
	*first Stata "unpacks" `mylocal'
	*second puts the content into "" so to consider it a string
	*same as
display "Carrot"

*additional note
local mylocal trunk weight length turn displacement // you dont have to put double quotes SAME for Stata
											  // I overwrite the old local macro with a new one
display "`mylocal'"
********************************************************************************
*deliberate practice #1: are local macros names case-sensitive?

********************************************************************************
*deliberate practice #2: let us say you want to add gear_ratio variables to the mylocal local macro
	*overwrite a new one
	local mylocal "trunk weight length turn displacement gear_ratio"
	display "`mylocal'"
	
	*but more in the spirit of locals ...
	local mylocal "`mylocal' gear_ratio" //do you see what we are doing?
	display "`mylocal'" //let us check

********************************************************************************
*local macros and numeric values
local numbers 1 //initialize the local
local numbers = `numbers' + 1 //update the local 计算等式
display "`numbers'"
*please note what happens if you do not execute all the previous three lines all together

*note is this the same?:
local numbers 1
local numbers `numbers' + 1  // 输出 string
display "`numbers'" //DONT RUN the code! please stop and think what will be the result?

********************************************************************************
**********************************************************Compound double quotes
********************************************************************************
*some strings come with quotes: example -> She said: "Quotes can be tricky"
*how are we going to put it into a local macro?
local saying She said: "Quotes can be tricky"
local saying "She said: "Quotes can be tricky""
//you see that it does NOT work?
*try to display it, Stata does not know which double quotes are for 

/*The answer is to use COMPOUND DOUBLE QUOTES, `" and "', as delimiters. The
first marks the start and the second marks the end of a macro.*/
local saying `"She said: "Quotes can be tricky""'

*how should you display it now?
	*(1) display `"saying"'
	*(2) display "`saying'"
	*(3) display `"`saying'"'

*a bit more challenging:
local metasaying `"He said `"She said: "Quotes can be tricky""'"'
local metasaying `"He said `saying'"'
display `"`metasaying'"'
********************************************************************************
*******************************************************Just if you hadnt enough! A bit more about locals ;)
********************************************************************************
*gen local
local vars make price mpg
*or
local vars "make price mpg"

*note
display `vars' //shows you the vars values of the first observation

display "vars" //just shows you the string "vars"
display `"vars"' //what does it do? >>> treats `" and "' as compound quotes, not needed in this case, but same results

display "`vars'" //shows you the text content of the local

*append elements to preexisting local
local vars_plus `vars' rep78 headroom
display "`vars_plus'"

*experiment: change local "vars"
local vars make price //leave out mpg now, will vars_plus be updated automatically?

display "`vars_plus'" //the answer is ... "no" var_plus remains linked to the old vars local definition

*is there a way out? yes ESCAPING with "\" the nested local
*so that the local is not evaluated right away, but first reevaluated: example
local vars "make price mpg"
local vars_plus \`vars' rep78 headroom
display "`vars_plus'"
local vars make price //drop mpg (these are left out)
display "`vars_plus'"
********************************************************************************Extended macro functions
local depvars "price weight length"
local n_models : word count `depvars'
display "`n_models'"
********************************************************************************
