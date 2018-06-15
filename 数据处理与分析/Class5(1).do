**class5**

**correlation: organic food consumption - dataset***

correlate a8 b8 c8 d8 e8
pwcorr a8 b8 c8 d8 e8, sig star(1) 
pwcorr a8 b8 c8 d8 e8, sig star(1) listwise
pwcorr a8 b8 c8 d8 e8, sig star(1) casewise
  
**scattergram**
use http://www.stata-press.com/data/r13/census9.dta
twoway (scatter medage drate)
twoway (scatter medage drate) (lfit medage drate)

*simple linear regression*
regress medage drate

sysuse nlsw88.dta 
twoway (scatter wage tenure)
regress wage tenure
predict PredictedWage, xb
twoway (scatter wage tenure) (line PredictedWage tenure)

drop PredictedWage

***multiple linear regression***
regress wage tenure hours ttl_exp
regress wage tenure hours ttl_exp, beta

***testing OLS assumpitions***
predict wage_predict
predict wage_residuals, residual
hettest
regress wage tenure hours ttl_exp, robust
vif
ovtest
