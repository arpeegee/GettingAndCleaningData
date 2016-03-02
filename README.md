# README

## Scope
This repository is my submission for the course project of "Getting and Cleaning Data" on coursera.

## From the instructions
The purpose of the Getting and Cleaning Data Course Project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Files in this repository
* run_analysis.R: R script that

   1. Merges the training and the test sets to create one data set.
   2. Extracts only the measurements on the mean and standard deviation for each measurement.
   3. Uses descriptive activity names to name the activities in the data set
   4. Appropriately labels the data set with descriptive variable names.
   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* TidyData.txt: resulting tidy data set
* CodeBook.md: code book that describes the variables, the data, and any transformations or work performed to clean up the data
* README.md: this file