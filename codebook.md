#Getting And Cleaning Data Peer Assessment Codebook

The datasets provided come in several formats which are not easy to read and understand. 

Those variables were found in several documents downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

With the available description found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

I combined rows and columns to make a data set where the columns start with with Subjects (or participants in the study), then the next column is activity, and all the following columns are measurements of standard deviation and mean from the triaxial observations of the Samsung Galaxy S smartphone.

In the subject column we have a number which represents anonymous participants. These numbers can range between 1 and 30 since there were 30 volunteers. 

In the activities column we can see 1 of 6 activities happening when an observation is recorded. These activities are as follows:

1 - Walking
2 - Walking Upstairs
3 - Walking Downstairs
4 - Sitting
5 - Standing
6 - Laying

In the following remaining columns I used the names of the given observation types from the triaxial readings. These were renamed slightly from their original labels in order to be more descriptive. 

 The original list can of these features is called “features.txt”

I processed each of the following:
“t” becomes “Time”
“f” becomes “Frequency”
“Acc” becomes “Accelerometer”
“Gyro” becomes “Gyroscope”
“Mag” becomes “Magnitude”
“BodyBody” becomes “Body”

Here is an example of how the label transformed “fBodyAccMag-mean()” to “FrequencyBodyAccelerometerMagnitude-mean()”. 

Other than that change you can find the original feature name formula’s in the feature_info.txt

The run_analysis.R contains this script and creates a second, independent tidy data set with the average of each variable for each activity and each subject.