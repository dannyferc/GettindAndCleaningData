#download data.table
list.of.packages <- c("quantmod")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#load quantmod
library(quantmod)

amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
