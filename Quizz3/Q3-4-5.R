#download data.table
list.of.packages <- c("data.table")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#load data.table
library(data.table)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,destfile="./Quizz3/FGDP.csv",method="curl")
dtGDP <- data.table(read.csv("./Quizz3/GDP.csv", skip=4, nrows = 215))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP","Long.Name", "gdp"))

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl,destfile="./Quizz3/FEDSTATS_Country.csv",method="curl")
dtFEDSTATS <- data.table(read.csv("./Quizz3/FEDSTATS_Country.csv"))

#merge 2 data.tables
dt <- merge(dtGDP, dtFEDSTATS, all = TRUE, by = c("CountryCode"))

#Match the data based on the country shortcode
sum(!is.na(unique(dt$rankingGDP)))

#Sort the data frame in descending order by GDP rank 
dt[order(rankingGDP, decreasing = TRUE), list(CountryCode, Long.Name.x, Long.Name.y, rankingGDP, gdp)][13]

#Calculate average GDP ranking for the "High income: OECD" and "High income: nonOECD" group
dt[, mean(rankingGDP, na.rm = TRUE), by = Income.Group]

#Cut the GDP ranking into 5 separate quantile groups
breaks <- quantile(dt$rankingGDP, probs = seq(0, 1, 0.2), na.rm = TRUE)
dt$quantileGDP <- cut(dt$rankingGDP, breaks = breaks)
#Make a table versus Income.Group
dt[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantileGDP")]