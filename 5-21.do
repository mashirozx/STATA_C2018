use "C:\Users\Administrator\Desktop\数据包\lifeexp.dta", clear

list country lexp gnppc if region == 2
* Attaching data label
scatter lexp gnppc if region == 2, mlabel(country)
* Label position
scatter lexp gnppc if region == 2, mlabel(country) mlabposition(8)
* Angel
scatter lexp gnppc if region == 2, mlabel(country) mlabposition(5) mlabangle(50) mlabsize(medium)
* hex color not supported 
scatter lexp gnppc if region == 2, mlabel(country) mlabcolor(orange)
* x axis num range
scatter lexp gnppc if region == 2, mlabel(country) xscale(range(-500,35000))
* there is another option scale, it's scaling the hole graph

use "C:\Users\Administrator\Desktop\数据包\uslifeexp2.dta", clear
scatter le year
scatter le year, msymbol(T)
scatter le year, connect(l) msymbol(T)
* 平滑线
scatter le year, connect(j) msymbol(T)
* dash line
scatter le year, connect(l) lpattern(dash)
scatter le year, connect(l) lpattern(dot)

********************************************
use "C:\Users\Administrator\Desktop\数据包\wage.dta", clear

scatter educ wage if female == 1
scatter exper wage if female == 1

scatter educ wage if female == 1, msymbol(O) mcolor(green) mlabsize(medium)  name(educ)
scatter exper wage if female == 1, msymbol(X) mcolor(blue) mlabsize(medium)  name(exper)
graph combine educ exper, xcommon ycommon

sysuse auto, clear

scatter mpg weight, ylabel(#10) xlabel(#10) /*not work*/
scatter mpg weight, ylabel(10(5)45) xlabel(1500 2000 3000 4000 5000)
scatter mpg weight, ytick(#100) xtick(#115)
* ylabel(min(seq)max)
scatter mpg weight, ylabel(10(5)55)

scatter mpg weight, by(foreign)
* Addign a total plot
scatter mpg weight, by(foreign, total)
scatter mpg weight, by(foreign, total rows(1))
