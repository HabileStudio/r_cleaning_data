## Instructions

The raw data is inside the "data/" folder.

Github does not allow for big files to be uploaded, so you'll have to put X_train.txt in "data/train/" and X_test.txt in "data/test/"

Here is the link for the raw data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## Description

This dataset is a sorted and cleaned version of raw data that were gathered on the topic of wearable computing.

The authors' summary explains the raw data as such:

*The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.*


## Information about the original datasets

You can find info about the raw data in the data folder, inside README.txt

## Final dataset

Here are some info on the analysis of the different datasets to provide this cleaned dataset:
1. Variables and activities were extracted and names were made readable
2. Activities and subject ids were added to the dataset
3. Only the columns concerning means and standard deviations were used
4. We have merged the data from train and from test
5. We've grouped the overall data by activity and subject and extracted the means for each of the observed variables
