##****************************************************
## Getting and Cleaning Data - Project - Aug 2015
## Soumyajit Rakshit
##
## This script below will accomplish the requirements of progect for the "Getting and Cleaning Data" course:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##
## Comments are included inline
##****************************************************

rm(list=ls())

## We will use the plyr library
library(plyr)

## Set working directory to the location where the UCI HAR Dataset was unzipped
setwd("./UCI HAR Dataset")

## Load all files to variables
f_feature <- read.table('./features.txt',header=FALSE); #imports features.txt
f_act_lbl <- read.table('./activity_labels.txt',header=FALSE); #imports activity_labels.txt
f_x_train <- read.table('./train/x_train.txt',header=FALSE); #imports x_train.txt
f_y_train <- read.table('./train/y_train.txt',header=FALSE); #imports y_train.txt
f_sub_train <- read.table('./train/subject_train.txt',header=FALSE); #imports subject_train.txt

f_x_test <- read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
f_y_test <- read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt
f_sub_test <- read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt

## Assigin column names to the data imported above
colnames(f_act_lbl) <- c('activityId','activityType');
colnames(f_sub_train) <- "subjectId";
colnames(f_x_train) <- f_feature[,2];
colnames(f_y_train) <- "activityId";

colnames(f_sub_test) <- "subjectId";
colnames(f_x_test) <- f_feature[,2];
colnames(f_y_test) <- "activityId";

## 1. Merges the training and the test sets to create one data set.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Binding sensor data
Training_Data <- cbind(f_y_train,f_sub_train,f_x_train);
Test_Data <- cbind(f_y_test,f_sub_test,f_x_test);
Sensor_Data <- rbind(Training_Data,Test_Data);

## Sensor_Data will be used to select the desired mean() & stddev() columns
colNames <- colnames(Sensor_Data); 

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Identify values for the ID, mean() & stddev() columns by assigning TRUE and FALSE for others
v_extract <- (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

## Subset Sensor_Data table
Sensor_Data <- Sensor_Data[v_extract==TRUE];

## 3. Uses descriptive activity names to name the activities in the data set.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Combine the Sensor_Data set with the acitivityType table to include descriptive activity names
Sensor_Data <- merge(Sensor_Data,f_act_lbl,by='activityId',all.x=TRUE);

## Updating the colNames vector to include the new column names after merge
colNames <- colnames(Sensor_Data); 

## 4. Appropriately labels the data set with descriptive names.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Assigning new names to the variable
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

## Reassign the new names
colnames(Sensor_Data) <- colNames;

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Create a new table minus activityType column
Final_Sensor_Data <- Sensor_Data[,names(Sensor_Data) != 'activityType'];

## Summarizing the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject
Tidy_Sensor_Data <- aggregate(Final_Sensor_Data[,names(Final_Sensor_Data) != c('activityId','subjectId')],by=list(activityId=Final_Sensor_Data$activityId,subjectId = Final_Sensor_Data$subjectId),mean);

## Merging the tidyData with activityType to include descriptive acitvity names
Tidy_Sensor_Data <- merge(Tidy_Sensor_Data,f_act_lbl,by='activityId',all.x=TRUE);

## Export the Tidy_Sensor_Data set to Tidy_Sensor_Data.txt
setwd("../submission")
write.table(Tidy_Sensor_Data, './Tidy_Sensor_Data.txt',row.names=FALSE,sep='\t');


