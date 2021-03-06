#download data.table
list.of.packages <- c("data.table")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#load data.table
library(data.table)

dtEd <- data.table(read.csv("./Quizz4/EDSTATS_Country.csv"))
dt <- merge(dtGDP, dtEd, all=TRUE, by=c("CountryCode"))

isFiscalYearEnd <- grepl("fiscal year end", tolower(dt$Special.Notes))
isJune <- grepl("june", tolower(dt$Special.Notes))
table(isFiscalYearEnd, isJune)
dt[isFiscalYearEnd & isJune, Special.Notes]
