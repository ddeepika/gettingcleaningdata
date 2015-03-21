#CodeBook for Getting and Cleaning Data Project

##Project Description
The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. This project gets data from several source files (test and training data for measurement, activity and subject variables), extracts specific variables (mean and standard deviation values), tidies the data (associates descriptive column headers and includes activity labels), and finally creates a tidy grouped dataset (providing averaged measurement values by activity and subject).

##Study Design
###Raw data files that were provided include
1. test and training data sets for measurement (Xtest (2947x561), Xtrain (7352x561))
2. test and training data sets for activity (ytest (2947x561), ytrain (7352x561))
3. test and training data sets for subjects (subjecttest (2947x561), subjecttrain (7352x561))
4. list of 561 measurement variables (features (561x2))
5. explanation of measurement variables (features_info)
6. list of 6 activity labels (activity_labels)

###Creating Tidy Data File
1. Concatenate test and training data for measurements, activity and subjects resulting in three dataframes
  + measurement: xcombined [10299 x 561]
  + activity: ycombined [10299 x 1]
  + subject: subjectcombined [10299 x 1]
2. Extract 66 measurement variables that contain "mean()"" and "std()" from xcombined
  + relevant variables: meanstddata [10299 x 66]
  + Combine activity, subject and extracted variables into 1 dataframe
  + *relevant data : newdata (10299x68)*
3. Replace activity column integer values with labels provided in activity_labels.txt
   + *updated data : newdata (10299x68)*
4. Transform 66 measurement variable names to be legal and readable variable names in R
   + Replace hyphens (-) with periods (.) since hyphens are illegal in R variable names
   + Remove open and close parentheses () since () are illegal in R variable names
   + Replace the first character “t” with “Time.” and “f” with “Frequency.” using a for loop and substr operations to make the variable names more readable. 
   + Example transformations are:
     + "tBodyAcc-mean()-X" -> "Time.BodyAcc.mean.X"  
     + "fBodyBodyGyroJerkMag-std()" -> "Frequency.BodyBodyGyroJerkMag.std" 
   + *updated data: newdata (10299x68)*
5. Create independent tidy data set with the average of each variable for each activity and each subject
    + Reshape data such that for each activity-subject combination (6x30 = 180 rows) the mean measurement value (for 66 measurements) is calculated
    + updated data: tidydata (10299x68)

##Data Dictionary
###Variables in Tidy Data File
1. Column 1: Subject: Integer value (1:30) representing individual subjects in the experiment
2. Column 2: Activity: Factor with 6 levels ("WALKING", "WALKING_UPSTAIRS","WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING") corresponding to activities performed by the subjects
3. Column 3-68: Average Measurement Values (of Mean and Standard Deviation) by Subject and Activity

The measurement values are based on raw Time and Frequency values of accelerometer and gyroscope 3-axial signals in X, Y, Z coordinates. The body linear acceleration and angular velocity were derived in time to obtain Jerk signals. The magnitude of these three-dimensional signals were calculated using the Euclidean norm. Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequency domain signals. 

####Measurement Variables
* Mean Values, Unit = Time
    + Time.BodyAcc.mean.X
    + Time.BodyAcc.mean.Y
    + Time.BodyAcc.mean.Z
    + Time.GravityAcc.mean.X
    + Time.GravityAcc.mean.Y
    + Time.GravityAcc.mean.Z
    + Time.BodyAccJerk.mean.X
    + Time.BodyAccJerk.mean.Y
    + Time.BodyAccJerk.mean.Z
    + Time.BodyGyro.mean.X"
    + Time.BodyGyro.mean.Y
    + Time.BodyGyro.mean.Z
    + Time.BodyGyroJerk.mean.X
    + Time.BodyGyroJerk.mean.Y
    + Time.BodyGyroJerk.mean.Z
    + Time.BodyAccMag.mean
    + Time.GravityAccMag.mean
    + Time.BodyAccJerkMag.mean
    + Time.BodyGyroMag.mean
    + Time.BodyGyroJerkMag.mean
* Mean Values, Unit = Frequency
    + Frequency.BodyAcc.mean.X
    + Frequency.BodyAcc.mean.Y
    + Frequency.BodyAcc.mean.Z
    + Frequency.BodyAccJerk.mean.X
    + Frequency.BodyAccJerk.mean.Y
    + Frequency.BodyAccJerk.mean.Z
    + Frequency.BodyGyro.mean.X
    + Frequency.BodyGyro.mean.Y
    + Frequency.BodyGyro.mean.Z
    + Frequency.BodyAccMag.mean
    + Frequency.BodyBodyAccJerkMag.mean
    + Frequency.BodyBodyGyroMag.mean
    + Frequency.BodyBodyGyroJerkMag.mean
* Standard Deviation Values, Unit = Time
    + Time.BodyAcc.std.X
    + Time.BodyAcc.std.Y
    + Time.BodyAcc.std.Z
    + Time.GravityAcc.std.X
    + Time.GravityAcc.std.Y
    + Time.GravityAcc.std.Z
    + Time.BodyAccJerk.std.X
    + Time.BodyAccJerk.std.Y
    + Time.BodyAccJerk.std.Z
    + Time.BodyGyro.std.X
    + Time.BodyGyro.std.Y
    + Time.BodyGyro.std.Z
    + Time.BodyGyroJerk.std.X
    + Time.BodyGyroJerk.std.Y
    + Time.BodyGyroJerk.std.Z
    + Time.BodyAccMag.std
    + Time.GravityAccMag.std
    + Time.BodyAccJerkMag.std
    + Time.BodyGyroMag.std
    + Time.BodyGyroJerkMag.std
* Standard Deviation Values, Unit = Frequency
    + Frequency.BodyAcc.std.X
    + Frequency.BodyAcc.std.Y
    + Frequency.BodyAcc.std.Z
    + Frequency.BodyAccJerk.std.X
    + Frequency.BodyAccJerk.std.Y
    + Frequency.BodyAccJerk.std.Z
    + Frequency.BodyGyro.std.X
    + Frequency.BodyGyro.std.Y
    + Frequency.BodyGyro.std.Z
    + Frequency.BodyAccMag.std
    + Frequency.BodyBodyAccJerkMag.std
    + Frequency.BodyBodyGyroMag.std
    + Frequency.BodyBodyGyroJerkMag.std
