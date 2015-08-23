# Code Book 
## for PROJECT on Getting and Cleaning Data Project Course
###### Author: Soumyajit Rakshit

#### Introduction
* The script **_run_analysis.R_** performs the 5 steps described in the course project's definition.
* All available data is loaded into variables using the _read.table()_ function.
* Once loaded, proper column names are assigned to the dataset using _colnames()_ function.
* All similar data is merged then using the _cbind()_ and _rbind()_ functions.
* The 'mean' and 'std dev' columns are identified using the _grepl()_ function.
* A final data set is combined with the activity labels using _merge()_ function.
* The final tidy up data is then writted to disk using the _write.table()_ function.

#### Variables Used
The following variables contain data from the downloaded files:
* f_feature - imports features.txt
* f_act_lbl - imports activity_labels.txt
* f_x_train - imports x_train.txt
* f_y_train - imports y_train.txt
* f_sub_train - imports subject_train.txt
* f_x_test - imports x_test.txt
* f_y_test - imports y_test.txt
* f_sub_test - imports subject_test.txt

The following variables merges the previous datasets to further analysis:
* Training_Data - merges all the training data
* Test_Data - merges all the test data

Other Variables:
* Sensor_Data - merges all data sets and goes through multiple transformation of coloum segregation, mearging with other datasets.
* Tidy_Sensor_Data - Is the final dataset that can be used for further analysis. This is saved as **_Tidy_Sensor_Data.txt_**