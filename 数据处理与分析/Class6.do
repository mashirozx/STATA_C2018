***class6

***pcfa

describe a8 b8 c8 d8 e8
summarize a8 b8 c8 d8 e8
factor a8 b8 c8 d8 e8, pcf
alpha  a8 b8 c8 d8 e8
alpha  a8 b8 c8 d8 e8, item 
alpha  a8 b8 c8 d8 e8, item asis
predict factor 
histogram factor
quietly sum 
replace factor = factor - `r(min)'
sum factor 
rename factor trust 

egen trust2 = rowmean(a8 b8 c8 d8 e8)
histogram trust2
correlate trust trust2
