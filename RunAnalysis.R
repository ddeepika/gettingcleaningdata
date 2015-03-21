# Getting and Cleaning Data Project
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# you want a run_analysis R script, a ReadMe markdown document, a Codebook markdown document, and a tidy data text file (this last goes on Coursera).

# Step 1: Merges the training and the test sets to create one data set.

## Step 1a: Read Measurement Data and Column Names into dataframes.
## Apply columnnames to dataframes.
## Concatenate measurement test and training dataframes.
xtest <- read.table("./Dataset/test/X_test.txt")
xtrain <- read.table("./Dataset/train/X_train.txt")
features <- read.table("./Dataset/features.txt")
names(xtest) <- features[,2]
names(xtrain) <- features[,2]
xcombined <- rbind(xtest,xtrain)

## Step 1b: Read Activity data into dataframes
## Concatenate activity test and training dataframes.
## Apply columnname to dataframe.
ytest <- read.table("./Dataset/test/Y_test.txt")
ytrain <- read.table("./Dataset/train/Y_train.txt")
ycombined <- rbind(ytest,ytrain)
colnames(ycombined) <- c("Activity")

## Step 1c: Read Subject data into dataframes
## Concatenate subject test and training dataframes.
## Apply columnname to dataframe.
subjecttest <- read.table("./Dataset/test/subject_test.txt")
subjecttrain <- read.table("./Dataset/train/subject_train.txt")
subjectcombined <- rbind(subjecttest, subjecttrain)
colnames(subjectcombined) <- c("Subject")

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# Extract data with mean() and std() variables only
# Not considering meanFreq() etc since grepl uses an exact match with fixed argument
meancols <- xcombined[,grepl("mean()",names(xcombined), fixed=TRUE)]
stdcols <- xcombined[,grepl("std()",names(xcombined), fixed=TRUE)]
meanstddata <- cbind(meancols, stdcols)

# Merge Subject, Activity and Means/Std Data
newdata <-cbind(subjectcombined, ycombined)
newdata <- cbind(newdata,meanstddata)

# Step 3: Uses descriptive activity names to name the activities in the data set
newdata$Activity <-as.factor(newdata$Activity)
levels(newdata$Activity) <- c ("WALKING", "WALKING_UPSTAIRS", 
                                 "WALKING_DOWNSTAIRS", "SITTING", 
                                 "STANDING", "LAYING")


# Step 4: Appropriately labels the data set with descriptive variable names.
# Variable names are transformed into legal R names by replacing hyphens with
# periods and removing parantheses
colNames <- names(newdata)
colNames <- gsub("-",".",colNames)
colNames <- gsub("\\(","",colNames)
colNames <- gsub("\\)","",colNames)

# Variable names are made more readable by replacing the prefix "t" and "f" 
# in the variable names with "Time." and "Frequency."
for (i in 1:length(colNames))
{
    if (substr(colNames[i],1,1) == "t") 
        colNames[i] <- sub("t","Time.",colNames[i])
    if (substr(colNames[i],1,1) == "f") 
        colNames[i] <- sub("f","Frequency.",colNames[i])
}
# Transformed variable names are applied to the column names
names(newdata) <- colNames

# Step 5: Create a second, independent tidy data set with the average of each 
# variable for each activity and each subject.
tidydata <- aggregate(newdata[3:68],by=newdata[1:2], mean)

# Write tidy data matrix into file
write.table(tidydata,file="TidyDataFile.txt", row.names=FALSE)

# Instruction for reading the TidyDataFile back in R
#readbackdata <- read.table("TidyDataFile.txt", header=TRUE)
#View(readbackdata)
