fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile="./Quizz3/ss06hid.csv",method="curl")
dt <- read.csv("./Quizz3/ss06hid.csv")
agricultureLogical <- dt$ACR == 3 & dt$AGS == 6
#get the first 3 values
which(agricultureLogical)[1:3]