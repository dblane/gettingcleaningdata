#Getting And Cleaning Data Peer Assessment Codebook

The datasets provided come in several formats which are not easy to read and understand. 

Those variables were found in several documents downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

With the available description found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

I combined rows and columns to make a data set where the columns start with with Subjects (or participants in the study), then the next column is activity, and all the following columns are measurements of standard deviation and mean from the triaxial observations of the Samsung Galaxy S smartphone.

* testActivity is the imported data from "y_test.txt"
* testFeatures is the imported data from "X_test.txt"
* testSubject is the imported data from "subject_test.txt"
* trainActivity is the imported data from "y_train.txt"
* trainFeatures is the imported data from "X_train.txt"
* trainSubject is the imported data from "subject_train.txt"
* subjectComb combines the testSubject and trainSubject into one dataset
* featureComb combines the testFeatures and trainFeatures into one dataset
* activityComb combines the testActivity and trainActivity into one dataset
* featuresnames contains all the names of each 561 features
* combineCol is used to combine subjectComb and activityComb into one dataset
* activityNames is the result of using factoring to change activity observations into words
* allData contains the all the merged data
* allData2 contains an aggregate mean of 180 obervations of 68 variables

In the subject column we have a number which represents anonymous participants. These numbers can range between 1 and 30 since there were 30 volunteers. 

In the activities column we can see 1 of 6 activities happening when an observation is recorded. These activities are as follows:

* 1 - Walking
* 2 - Walking Upstairs
* 3 - Walking Downstairs
* 4 - Sitting
* 5 - Standing
* 6 - Laying

In the following remaining columns I used the names of the given observation types from the triaxial readings. These were renamed slightly from their original labels in order to be more descriptive. 

 The original list can of these features is called “features.txt”

I processed each of the following

1. “t” becomes “Time”
2. “f” becomes “Frequency”
3. “Acc” becomes “Accelerometer”
4. “Gyro” becomes “Gyroscope”
5. “Mag” becomes “Magnitude”
6. “BodyBody” becomes “Body”

Here is an example of how the label transformed “fBodyAccMag-mean()” to “FrequencyBodyAccelerometerMagnitude-mean()”. 

Other than that change you can find the original feature name formula’s in the feature_info.txt

The run_analysis.R contains this script and creates a second, independent tidy data set with the average of each variable for each activity and each subject.