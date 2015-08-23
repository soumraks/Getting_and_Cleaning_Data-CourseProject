# Read Me
## for PROJECT on Getting and Cleaning Data Project Course
###### Author: Soumyajit Rakshit

#### How To
This repository contains R code and documentation for the PROJECT submission of the Data Science's track course "Getting and Cleaning data", available in coursera.

Before running the **_run_analysis.R_** script; download the required data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzip the files to the **_UCI HAR Dataset_** folder. The script can be run from the parent directory.

CodeBook.md describes the variables, the data, and any transformations or work that was performed to clean up the data.

run_analysis.R contains all the code to perform the analyses described in the 5 steps. They can be launched in RStudio by just importing the file.

The cleaned up data is generated as a text file outpot named **_Tidy_Sensor_Data.txt_**.

#### Script Details
The R script, run_analysis.R, does the following:
1.	Load the activity and feature info
2.	Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
3.	Loads the activity and subject data for each dataset, and merges those columns with the dataset
4.	Merges the two datasets
5.	Converts the activity and subject columns into factors
6.	Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
7.  The end result is shown in the file Tidy_Sensor_Data.txt