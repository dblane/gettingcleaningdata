setwd("./gettingcleaningdataproject")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="Dataset.zip",method="curl")
unzip(zipfile="Dataset.zip",exdir="./SamsungData")
testActivity <- read.table(file.path("SamsungData","UCI HAR Dataset", "test","y_test.txt"), header = FALSE)
trainActivity <- read.table(file.path("SamsungData","UCI HAR Dataset", "test","y_train.txt"), header = FALSE)
trainSubject <- read.table(file.path("SamsungData","UCI HAR Dataset", "test","subject_train.txt"), header = FALSE)
testSubject <- read.table(file.path("SamsungData","UCI HAR Dataset", "test","subject_test.txt"), header = FALSE)
testFeatures <- read.table(file.path("SamsungData","UCI HAR Dataset", "test","X_test.txt"), header = FALSE)
trainFeatures <- read.table(file.path("SamsungData","UCI HAR Dataset", "test","X_train.txt"), header = FALSE)
subjectComb <- rbind(trainSubject,testSubject)
activityComb <- rbind(trainActivity,testActivity)
featureComb <- rbind(trainFeatures,testFeatures)
names(subjectComb) <- c("subject")
names(activityComb) <- c("activity")
featuresnames <- read.table(file.path("features.txt"), head=FALSE)
names(featureComb) <- featuresnames$V2
combineCol <- cbind(subjectComb,activityComb)
onlyFeatureNames <- featuresnames$V2[grep("mean\\(\\)|std\\(\\)", featuresnames$V2)]
onlySubandAct <- c(as.character(onlyFeatureNames), "subject", "activity")
activityNames <- read.table(file.path("activity_labels.txt"), header=FALSE)
allData$activity <- as.character(allData$activity)
allData$activity[allData$activity == 1] <- "Walking"
allData$activity[allData$activity == 2] <- "Walking Upstairs"
allData$activity[allData$activity == 3] <- "Walking Downstairs"
allData$activity[allData$activity == 4] <- "Sitting"
allData$activity[allData$activity == 5] <- "Standing"
allData$activity[allData$activity == 6] <- "Laying"
allData$activity <- as.factor(allData$activity)
names(allData) <- gsub("^t", "Time", names(allData))
names(allData) <- gsub("^f", "Frequency", names(allData))
names(allData) <- gsub("Acc", "Accelerometer", names(allData))
names(allData) <- gsub("Gyro", "Gyroscope", names(allData))
names(allData) <- gsub("Mag", "Magnitude", names(allData))
names(allData) <- gsub("BodyBody", "Body", names(allData))
library(plyr)
allData2 <- aggregate(. ~subject + activity, allData, mean)
allData2 <- allData2[order(allData2$subject,allData2$activity),]
write.table(allData2, file = "tidydata.txt",row.name=FALSE)
library(knitr)
knit2html ("codebook.Rmd");








