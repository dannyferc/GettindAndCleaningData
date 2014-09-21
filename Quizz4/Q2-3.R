#download data.table
list.of.packages <- c("data.table")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#load data.table
library(data.table)

dtGDP <- data.table(read.csv("./Quizz4/GDP.csv", skip=4, nrows=215, stringsAsFactors=FALSE))

dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
gdp <- as.numeric(gsub(",", "", dtGDP$gdp))

mean(gdp, na.rm=TRUE)


isUnited <- grepl("^United", dtGDP$Long.Name)
summary(isUnited)

