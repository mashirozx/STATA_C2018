***Class4***

***Anova one-way***
use http://www.stata-press.com/data/r13/systolic.dta
describe
graph box systolic, over(drug)
mean systolic, over(drug)
oneway systolic drug
oneway ststolic drug, tabulate 
oneway systolic drug, bonferroni
display 3133.23851/9340.15517 


***anova two-way***
graph box systolic, over(drug) over(disease)
anova systolic drug disease
anova systolic drug disease drug#disease

***food waste datset***
***age***

oneway s3_1 d1_3, bonferroni
oneway s2_9 d1_3, bonferroni
oneway s2_10 d1_3, bonferroni
oneway s3_1  d1_3, bonferroni
oneway s3_2 d1_3, bonferroni
oneway s3_3  d1_3, bonferroni
oneway s4_1  d1_3, bonferroni
oneway s4_2 d1_3, bonferroni
oneway s4_3  d1_3, bonferroni
oneway s4_4  d1_3, bonferroni
oneway s4_5  d1_3, bonferroni
oneway s4_6  d1_3, bonferroni
oneway s6_1  d1_3, bonferroni
oneway s6_2 d1_3, bonferroni
oneway s6_3  d1_3, bonferroni
oneway s6_4  d1_3, bonferroni
oneway s6_5  d1_3, bonferroni

***interaction between age and gender***

anova s3_1 d1_3 gender d1_3#gender
anova s2_9 d1_3 gender  d1_3#gender
anova s2_10 d1_3 gender d1_3#gender
anova s3_1  d1_3 gender d1_3#gender
anova s3_2 d1_3 gender d1_3#gender
anova s3_3 d1_3 gender d1_3#gender
anova s4_1  d1_3 gender d1_3#gender
anova s4_2 d1_3 gender d1_3#gender
anova s4_3  d1_3 gender d1_3#gender
anova s4_4  d1_3 gender d1_3#gender
anova s4_5  d1_3 gender d1_3#gender
anova s4_6  d1_3 gender d1_3#gender
anova s6_1  d1_3 gender d1_3#gender
anova s6_2 d1_3 gender d1_3#gender
anova s6_3  d1_3 gender d1_3#gender
anova s6_4  d1_3 gender d1_3#gender
anova s6_5  d1_3 gender d1_3#gender
