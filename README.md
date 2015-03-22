#Getting And Cleaning Data Peer Assessment
#### This readme describes the way the script works
Open all files and assign each to a corressponding data set. This will make it easier to merge
In the next step.

'''
setwd("./gettingcleaningdataproject")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="Dataset.zip",method="curl")
unzip(zipfile="Dataset.zip",exdir="./SamsungData")
testActivity <- read.table(file.path("SamsungData","UCI HAR Dataset", "test","y_test.txt"), header = FALSE)
trainActivity <- read.table(file.path("SamsungData","UCI HAR Dataset", "test","y_train.txt"), header = FALSE)
trainSubject <- read.table(file.path("SamsungData","UCI HAR Dataset", "test","subject_train.txt"), header = FALSE)
testSubject <- read.table(file.path("SamsungData","UCI HAR Dataset", "test","subject_test.txt"), header = FALSE)
testFeatures <- read.table(file.path("SamsungData","UCI HAR Dataset", "test","X_test.txt"), header = FALSE)
trainFeatures <- read.table(file.path("SamsungData","UCI HAR Dataset", "test","X_train.txt"), header = FALSE)
'''
This is merging the files together to create one data set. We'll use the rbind function which attaches datasets
to other datasets by adding them to the bottom of the last row of the previous data set. In order to keep the different
data separated based on type we will merge 'test' and 'train' data based on Subject, Activity, and Features.

'''
subjectComb <- rbind(trainSubject,testSubject)
activityComb <- rbind(trainActivity,testActivity)
featureComb <- rbind(trainFeatures,testFeatures)
'''
We give the variables a name so that we can reference them later

'''
names(subjectComb) <- c("subject")
names(activityComb) <- c("activity")
featuresnames <- read.table(file.path("features.txt"), head=FALSE)
names(featureComb) <- featuresnames$V2
'''
Now we'll get all the data into one frame and merge the columns so we'll have access to all the data
in one spot
'''
combineCol <- cbind(subjectComb,activityComb)
'''
In this section we will extract the measurements for only the mean and standard deviation. The methods
used will be std() and mean()

'''
onlyFeatureNames <- featuresnames$V2[grep("mean\\(\\)|std\\(\\)", featuresnames$V2)]
onlySubandAct <- c(as.character(onlyFeatureNames), "subject", "activity")
'''

These next variables will be used to created more descriptive activity names to the data set. 

'''
activityNames <- read.table(file.path("activity_labels.txt"), header=FALSE)
'''

In order to correctly assign each activity we have to use the as.factor function to rename
each of the values from 1-6 with their corresponding descriptive names.

'''
allData$activity <- as.character(allData$activity)
allData$activity[allData$activity == 1] <- "Walking"
allData$activity[allData$activity == 2] <- "Walking Upstairs"
allData$activity[allData$activity == 3] <- "Walking Downstairs"
allData$activity[allData$activity == 4] <- "Sitting"
allData$activity[allData$activity == 5] <- "Standing"
allData$activity[allData$activity == 6] <- "Laying"
allData$activity <- as.factor(allData$activity)

This next part is a little tough because we have to use regex to find and replace the names of some of the
name where it's not immediately apparent. 

'''
names(allData) <- gsub("^t", "Time", names(allData))
names(allData) <- gsub("^f", "Frequency", names(allData))
names(allData) <- gsub("Acc", "Accelerometer", names(allData))
names(allData) <- gsub("Gyro", "Gyroscope", names(allData))
names(allData) <- gsub("Mag", "Magnitude", names(allData))
names(allData) <- gsub("BodyBody", "Body", names(allData))
'''

Now that all the names are descriptive and readable by everyone, we can make a 'tidy' data set which we
we can use to calculate the average of each variable.

'''
library(plyr)
allData2 <- aggregate(. ~subject + activity, allData, mean)
allData2 <- allData2[order(allData2$subject,allData2$activity),]
write.table(allData2, file = "tidydata.txt",row.name=FALSE)
'''