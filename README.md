---
title: "Readme"
author: "Coursera Student"
date: "March 21, 2015"
output: html_document
keep_md: true
---
#Getting and Cleaning Data: Course Project
The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

###Project Files
- R Script to get and clean data: RunAnalysis.R
- Final tidy data output file (from Step 5): TidyDataFile.txt
- Codebook: Codebook.md
- Readme: This file!

###Overview and Notes
My project uses a single script (RunAnalysis.R) to execute all five steps of the course project and create a tidy data file. 
For evaluation, the tidy data file can be read back into R using 

*data <- read.table("TidyDataFile.txt", header = TRUE)*  
*View(data)*

Note: If file is stored in a different path than the working folder, please provide file path in the read.table call.

The codebook for this project follows the format suggested by TA in
* https://class.coursera.org/getdata-012/forum/thread?thread_id=9 to refer  
* https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf and samples provided at  
* https://github.com/JorisSchut/Data-Science/blob/master/Other%20stuff/Codebook%20template.Rmd#project-description and  
* http://datasciencespecialization.github.io/getclean/

*The Inertial Signals data was not used in my project.*

### Steps
The *RunAnalysis.R* script follows the steps below:

* __Step 1__: Merge the training and test sets to create one data set. I merge training and test sets for measurement, activity and subject data methodically.  
*Note: I don’t create a combined dataset that includes measurement, activity and subject datasets into a single dataframe until Step 2 (after I extract the mean and std columns).*
  + 1.a Merge measurement data with correct column names
    + Measurement data from X_test,  X_train text files are read into individual data frames. 
    + Column names for the measurement data are read from features text file into another data frame.
    + Column names are applied to both test and training data sets
    + A combined dataset (xcombined: 10299x561) is created with the test and training data sets.

  + 1.b Merge activity data with correct column name
    + Activity data from y_test and y_train text files are read into individual data frames
    + A combined dataset (ycombined: 10299x1) is created with the correct column name.

  + 1.c Merge subject data with correct column name
    + Activity data from subject_test and subject_train text files are read into individual data frames
    + A combined dataset (subjectcombined: 10299x1) is created with the correct column name.  
* __Step 2__: Extract only measurements on mean and standard deviation for each observation. I extract measurements where variable names exactly match “mean()” and “std()”, using grepl. This results in a dataset (meanstddata: 10299x66).  I then combine subject, activity, meanstddata to form a new dataset (newdata: 10299x68).  
    + *Note that since I use exact matching, I don’t extract variables that contain mean in the variable name but don’t measure the mean (such as meanFreq()).*
* __Step 3__: Use descriptive activity names to name activities in the dataset. Using as.factor and levels, I map the activities in the Activity column of newdata to the six descriptive labels. 
* __Step 4__: Appropriately label the dataset with descriptive variable names. I perform a few transformations on the variable names with gsub to make them legal and easily understood variable names in R.  
The transformations are: 
    + Replace hyphens (-) with periods (.) since hyphens are illegal in R variable names
    + Remove open and close parentheses () since () are illegal in R variable names
    + Replace the first character “t” with “Time.” and “f” with “Frequency.” using a for loop and substr operations to make the variable names more readable. 
    + Example transformations are:
        + "tBodyAcc-mean()-X" -> "Time.BodyAcc.mean.X"  
        + "fBodyBodyGyroJerkMag-std()" -> "Frequency.BodyBodyGyroJerkMag.std" 
    + The final data set in Step 4 (newdata: 10299x68) has legal and readable variable names.  
* __Step 5__: Create a second, independent tidy data set with the average of each variable for each activity and each subject. I used the aggregate function to reshape the data such that for each activity-subject combination (6x30 = 180 rows), I calculate the mean measurement value (for 66 measurements).   My final tidy dataset in Step 5 (tidydata: 180x68) has average values of each measurement variable and is written into a textfile.