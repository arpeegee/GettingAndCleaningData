# Getting and Cleaning Data - Course Project

library(dplyr)

# Step 1 - Merges the training and the test sets to create one data set.

# URL of data source
dataurl <- "https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip"

# download and store file
download.file(url=dataurl,
              destfile = "./data/UCI_HAR_Dataset.zip")
dateDownloaded <- date()

# unzip file
unzipped <- unzip(zipfile = "./data/UCI_HAR_Dataset.zip",
                  exdir = "./data/")

# read in data
# training data
training_set <- read.table(file = "data/UCI HAR Dataset/train/X_train.txt")
training_labels <- read.table(file = "data/UCI HAR Dataset/train/y_train.txt")
training_subjects <- read.table(file = "data/UCI HAR Dataset/train/subject_train.txt")
training_data <- cbind(training_subjects,
                       training_labels,
                       training_set)
# test data
test_set <- read.table(file = "data/UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table(file = "data/UCI HAR Dataset/test/y_test.txt")
test_subjects <- read.table(file = "data/UCI HAR Dataset/test/subject_test.txt")
test_data <- cbind(test_subjects,
                   test_labels,
                   test_set)
# read features to label data
features <- read.table(file = "data/UCI HAR Dataset/features.txt")
# read activity labels to label activities
activities <- read.table(file = "data/UCI HAR Dataset/activity_labels.txt")
colnames(activities) <- c("Activity", "ActivityLabel")

# merge training and test data sets
merged_data <- rbind(training_data,
                     test_data)

# label the merged data
colnames(merged_data) <- c("Subject", "Activity", as.character(features[,2]))

# Step 2 - Extracts only the measurements on the mean and standard deviation
# for each measurement.

# identify columns with "mean" or "std"
cols <- grep(pattern = "mean|std",
             x = colnames(merged_data))

# subset merged data set
merged_data_subset <- merged_data[,c(1, 2, cols)]

# Step 3 - Uses descriptive activity names to name the activities in the
# data set

merged_data_subset_actlabels <- merge(x = merged_data_subset,
                                      y = activities,
                                      by.x = "Activity",
                                      by.y = "Activity")
col_to_be_dropped <- c("Activity")
merged_data_subset_actlabels <- merged_data_subset_actlabels[, !(names(merged_data_subset_actlabels) %in% col_to_be_dropped)]

# Step 4 - Appropriately labels the data set with descriptive variable names.

column_names <- colnames(merged_data_subset_actlabels)
column_names <- gsub(pattern = "^t", replacement = "Time", x = column_names)
column_names <- gsub(pattern = "^f", replacement = "Frequency", x = column_names)
column_names <- gsub(pattern = "Acc", replacement = "Acceleration", x = column_names)
column_names <- gsub(pattern = "Mag", replacement = "Magnitude", x = column_names)
column_names <- gsub(pattern = "-mean\\()", replacement = "Mean", x = column_names)
column_names <- gsub(pattern = "-std\\()", replacement = "StandardDeviation", x = column_names)
column_names <- gsub(pattern = "-", replacement = "", x = column_names)
column_names <- gsub(pattern = "meanFreq\\()", replacement = "MeanFrequency", x = column_names)

colnames(merged_data_subset_actlabels) <- column_names

# Step 5 - From the data set in step 4, creates a second, independent tidy
# data set with the average of each variable for each activity and each subject.

# group and summarise
GroupedData <- group_by(.data = merged_data_subset_actlabels,
                        Subject, ActivityLabel)
TidyData <- summarise_each(tbl = GroupedData,
                           funs(mean))

# export
write.table(x = TidyData,
            file = "TidyData.txt")
