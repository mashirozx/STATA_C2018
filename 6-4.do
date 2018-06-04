clear all
use "C:\WorkDirectory\GitHub\STATA_C2018\数据包\auto.dta", clear

* long lines in do-file
* method 1
summarize weight price displ headroom /// 
rep78 length turn gear_ratio 

* method 2
summarize weight price displ headroom /* 
*/ rep78 length turn /*
*/ gear_ratio

* method 3
#delimit ; /*定界*/
summarize weight price displ headroom   
rep78 length turn gear_ratio;
#delimit cr

use "C:\WorkDirectory\GitHub\STATA_C2018\数据包\uslifeexp2.dta", clear
scatter le year, c(l) xlabel(#10, grid)
scatter le year, c(l) xlabel(1900 1918 1940 (20) 2000, grid)
scatter le year, connect(l) ytitle(average life expectancy) xtitle(year) title(the trend of life expectancy in US)

sysuse auto, clear
scatter mpg price weight
scatter mpg weight || scatter price weight, yaxis(2)

use "C:\WorkDirectory\GitHub\STATA_C2018\数据包\citytemp.dta", clear
graph bar (mean) tempjuly tempjan, over(region)
graph bar (mean) tempjuly tempjan, over(division)
graph bar tempjuly tempjan, over(region) over(division)
graph bar tempjan tempjuly, over(region) stack

use "C:\WorkDirectory\GitHub\STATA_C2018\数据包\wage.dta", clear
scatter educ wage || scatter exper wage, yaxis(2)
graph bar (mean) wage, over(female)
graph bar (mean) educ, over(female)
graph bar (mean) exper, over(female)

sysuse auto, clear
* 一次拟合
scatter mpg weight || lfit mpg weight
* 二次拟合
scatter mpg weight || qfit mpg weight

use "C:\WorkDirectory\GitHub\STATA_C2018\数据包\uslifeexp2.dta", clear
scatter le year, name(graph1)
scatter le year, c(l) name(graph2)
scatter le year, c(l) msymbol(i) name(graph3)
* Combine multigraph
graph combine graph1 graph2 graph3

use "C:\WorkDirectory\GitHub\STATA_C2018\数据包\wage.dta", clear
* 相关系数矩阵
correlate wage educ exper tenure
* 协方差矩阵
correlate wage educ exper tenure, covariance
/*
 * sig选项给每一个相关系数做显著性检验，这个检验的原假设是总体相关系数是0，在每一个相关系数下方标明了检验的p值。
 * star(.05)是为显著性超过0.05的相关系数打上星号，
 * print(.05)则是仅显示这些显著的相关系数。
 */
pwcorr wage educ exper tenure, sig star(0.05)
pwcorr wage educ exper tenure, sig star(0.05) print(0.05)
// correlate 与 pwcorr 的区别是对缺失值的处理，前者要求数据没有缺失值

* 相关系数数字背后的图形直觉
graph matrix wage educ exper tenure

