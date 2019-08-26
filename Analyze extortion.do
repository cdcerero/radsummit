********************************************************************************
*             				   ANALYZING EXTORTION SURVEY                     *
********************************************************************************

*Set previous folder to this folder as working directory
*Ex: cd "C:\Users\Ipacol\Google Drive\Medellin Gangs\Intervention Millenium Neighborhoods\Data collection\Representative and endline survey"

*Import tabulated data

import excel ".\Business pilots\raw\2019-08-15 Extortion results.xlsx", sheet("Sheet1") clear

rename A id
rename B list_status
rename C role
rename D activities
rename E sales
rename F sales_freq
rename G profits
rename H profits_freq
rename I customers
rename J customers_freq
rename K employees
rename L list_experiment
rename M extortion_amount
rename N extortion_amount_freq

*Label var
foreach var of varlist _all {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1/1


*1)Extortion rate
gen extortion = 1 if extortion_amount > 0
replace extortion = 0 if extortion_amount == 0

log using ".\Results\Extortion analysis.smcl"
tab extortion

*2) Mean of list situations
tabstat list_experiment, stat( mean sd q) by(list_status)
ttest list_experiment, by(list_status)

*3) Missings analysis
tabmiss _all

log close

translate ".\Results\Extortion analysis.smcl" ".\Results\Extortion analysis..pdf"
