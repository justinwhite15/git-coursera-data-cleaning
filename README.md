# README

This repo contains a script to process the Human Activity Recognition Using Smartphones Data Set whose original source is [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### File Contents
* README.md - this file
* .gitignore - GIT ignore file to excude dataset folder to save Github space
* run_analysis.R - MAIN script that does all data processing
* tidyDataNarrow.txt - Final export of run_analysis.R script that contains all tidy data
* CodeBook.md - Code book that expains final structure of tidy data set

## Steps to Reproduce Analysis
1. Create a 'dataset' directory and download the datasets from [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
2. Run the run_analysis.R script.
3. A tidyDataNarrow.txt file will be created by the script in step #2.

## Analysis Performed
The data is split in two ways.  It is split into a test and train data sets. Each data set is then further split into three files: X, Y, and subject.  
1. Bind together using cbind the X,Y, and subject data sets. This completes two complete data set (test and train)
2. Bind together both datasets using rbind.
3. Only the mean and standard deviations measurments are desired, so determine which columns (both names and numbers) in the data sets to keep by using grep to find all columns names containing mean and std.
4. Subset the data to include only the desired identifying and measurement columns.
5. Melt the data so each row includes only identifying information and one measurement.
6. Create the final tidy data set that find the mean of each measurement for each activity for each subject.
7. Write out the final tidy data set to the tidyDataNarrow.txt file.
