*Class2

use C:\WorkDirectory\GitHub\STATA_C2018\class\Dta\FoodWaste.dta

rename d1_7 education 

***variable transformation: reducing the categories***
**s4_6 waste grouping is meaningul
*分组：按照`fre s4_6`输出的结果序号分组、重编码
*recode varlist (rule) [(rule) ...] [, generate(newvar)]

*ssc install fre
 
fre s4_6
recode s4_6 (1 2 3 = 0) (4 5 = 1) (6 = .), generate (s4_6_dummy)
fre s3_1  
recode s3_1 (1 2 = 1)(3 4 = 0),generate (s3_1_dummy) 

fre s4_6_dummy
fre s3_1_dummy  

label define Dummy 0 "No" 1 "Yes"
label values s4_6_dummy Dummy
label values s3_1_dummy Dummy

tab s4_6_dummy s3_1_dummy, row chi
*似乎是和变量独立性相关。。

*does the situation change by gener?*

tab s4_6_dummy s3_1_dummy if gender == 0, row chi
tab s4_6_dummy s3_1_dummy if gender == 1, row chi

*and for individuals with a an University diploma?

tab s4_6_dummy s3_1_dummy if education > 4, row chi

*confidence interval 

ci age 
mean age, level (99) 
display 37.4013 - 34.4928
display 37.86099 - 34.03311

*hypothesis testing 
ttest age == 34
ttest age, by( s3_1_dummy)
ttest age, by( s3_1_dummy)


**solution to questions class 2
ttest age, by (s5_4 )  

ttest age, by (gender) 

fre s4_2
replace s4_2 = . if s4_2  == 6
egen age_dummy = cut(age), at (15 30 100)
ttest s4_2, by (age_dummy)






