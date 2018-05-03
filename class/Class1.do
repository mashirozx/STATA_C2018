***Class1***

**descriptive stats***
describe
lookfor income 
list 

fre s2_2 
fre gender
rename d1_7 education 
fre education 
fre d1_7
fre d1_6

list s2_2
list s2_2 if s3_3 > 1 
list s2_2 in 1
list s2_2 in 1/10 

tabulate gender if education == 0 | education == 3
tabulate education if gender == 1 & d1_6 == 4

tabulate gender 
tabulate education

help tabulate 
tabulate gender if education == 1 
tabulate gender if education == 4
fre gender
tabulate education if gender == 0
tabulate education if gender == 1

***summarize***

sum age
sum age, detail
sum age if gender == 1

***bivariate stats and association tests
rename s2_9 food_trash_bag
rename s3_3 food_recycling

tabulate food_trash_bag food_recycling
rename s2_9 food_trash_bag
rename s3_3 food_recycling
tabulate food_trash_bag food_recycling, cell
tabulate food_trash_bag food_recycling, row
tabulate education food_recycling, row chifood_trash_bag food_recycling, column 

tabulate gender food_trash_bag, row 
tabulate gender food_trash_bag, row chi

tabulate education food_recycling, row chi 
recode education (1 2 3 4 = 0) (5 = 1), generate (edu_dummy)
label define edu_dummy_label 0 "less_than_college" 1 "college_or_above"
label values edu_dummy edu_dummy_label

tabulate edu_dummy food_recycling, row chi

recode food_recycling (1 2 3 = 1) (4 = 0), generate (food_recycling_dummy)
label define food_recycling_dummy_label 1 "yes_at_least1" 0 "no"
label values food_recycling_dummy food_recycling_dummy_label

tabulate edu_dummy food_recycling_dummy, column chi

***confidence interval***
ci age


