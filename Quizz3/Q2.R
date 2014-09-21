#download library jpeg
list.of.packages <- c("jpeg")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#load library jpeg
library(jpeg)

#download the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg "
download.file(fileUrl,destfile="./Quizz3/Fjeff.jpg",method="curl")

#read the jpeg
img <- readJPEG("./Quizz3/Fjeff.jpg", native = TRUE)

#calculate quantile
quantile(img, probs = c(0.3, 0.8))
