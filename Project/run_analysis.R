#set working directory
setwd("/Users/dfernandezcanon/Documents/Development/R/Project/GettindAndCleaningData/Project")

#load features
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

#load activities
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

#load test data
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")

#name variables test
colnames(xTest) <- features
colnames(subjectTest) <- "Subject"
yTest[,2] = activityLabels[yTest[,1]]
colnames(yTest) = c("ActivityID", "ActivityLabel")


#load training data
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

#name variables test
colnames(xTrain) <- features
colnames(subjectTrain) <- "Subject"
yTrain[,2] = activityLabels[yTrain[,1]]
colnames(yTrain) = c("ActivityID", "ActivityLabel")

#merge X data from training and test and get only the mean and std features
dataX <- rbind(xTest,xTrain)
featuresMeanStd <- grep("mean|std", features)
dataX <- dataX[,featuresMeanStd]

#create test data.frame
test <- cbind(subjectTest, yTest)

#create training data.frame
training <- cbind(subjectTrain, yTrain)

#merge training and test data
subDF <- rbind(test, training)

#merge data with mean and std x values
DF <- cbind(subDF,dataX)

#calculate mean for each activity and each subject
tidy <- aggregate(DF, by=list(activityLabel = DF$ActivityLabel, subject = DF$Subject), mean)

#drop variables that are not used anymore
drops <- c("Subject","ActivityLabel")
tidy <- tidy[,!(names(tidy) %in% drops)]

#write the content of tidy into a new file
write.table(tidy, "tidy.txt", sep="\t", row.name=FALSE)

