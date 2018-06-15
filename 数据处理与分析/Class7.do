***class 7***

recode s3_1  (1 2 = 1) (3 4 = 0) 
regress s3_1 gender d1_3 d1_5
twoway (scatter s3_1 d1_3)

logistic s3_1 gender d1_3 d1_5

logit s3_1 gender d1_3 d1_5
probit s3_1 gender d1_3 d1_5
