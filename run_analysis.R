############################################################################################
#The purpose of this project is to demonstrate ability to collect, work with, and clean a 
#data set. The goal is to prepare tidy data that can be used for later analysis. 
#Final output required to submit:
#1) a tidy data set as described below, 
#2) a link to a Github repository with your script for performing the analysis, and 
#3) a code book that describes the variables, the data, and any transformations or work that 
#   were performed to clean up the data called CodeBook.md. 
#Also include a README.md in the repo with your scripts. 
#This repo explains how all of the scripts work and how they are connected.

#This run_analysis.R does the following. 
#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names. 
#5.From the data set in step 4, creates a second, independent tidy data set with the average 
#  of each variable for each activity and each subject.
############################################################################################

############################################################################################
#0.Preparation
#install pre-requisites
#Set working directory & Download the source file
############################################################################################
install.packages("dplyr")
library(dplyr)

## step 1: Set Working Directory to folder where run_analysis.R was stored
setwd("C:\Users\hwee.see.teh\Documents\Git\GettingAndCleaningDataProject")

## step 2: download zip file from website
if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfilepath <- "./data/project_dataset.zip"
download.file(fileUrl,destfile = destfilepath)

## step 3: unzip data
zipfile <- unzip(destfilepath, exdir = "./data")

############################################################################################
#1.Merges the training and the test sets to create one data set.
############################################################################################
## step 1: load subject, data label & data into R
## TRAIN
train.subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
train.datalabel_y <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
train.data_x <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
## TEST
test.subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
test.datalabel_y <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test.data_x <- read.table("./data/UCI HAR Dataset/test/X_test.txt")

## step 2: merge train and test data into single data set
## concatenate rows from train & test
subject <- rbind(train.subject, test.subject)
subject <- rename(subject, subject = V1)

datalabel <- rbind(train.datalabel_y, test.datalabel_y)
datalabel <- rename(datalabel, activity = V1)

data <- rbind(train.data_x, test.data_x)

## merge columns
subjectdata <- cbind(subject,datalabel)
mergedata <- cbind(subjectdata, data)

############################################################################################
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
############################################################################################
## step 1: load features into R
datafeatures <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
datafeatures <- rename(datafeatures, featureNum = V1, feature = V2)

## step 2: get only subset of feature on mean and standard deviation
featureIndex <- grepl("mean\\(\\)|std\\(\\)", datafeatures$feature)
subsetFeatures <- datafeatures[featureIndex,]
subsetFeatures <- mutate(subsetFeatures, featureDataCol = paste0("V",featureNum))

## Step 3: Extract mean and standard deviation columns in data
subsetMergeData <- mergedata[, c(1,2,subsetFeatures$featureNum+2)]

## Step 4: convert data label into feature name
colnames(subsetMergeData) <- c("subject", "activity", subsetFeatures$feature)

############################################################################################
#3.Uses descriptive activity names to name the activities in the data set
############################################################################################
## step 1: load activity label into R
datalabelactivity <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
datalabelactivity <- rename(datalabelactivity, activityNum = V1, activityLabel = V2)

## step 2: create new factor variable with activity name
subsetMergeData$activity <- factor(subsetMergeData$activity, levels = datalabelactivity[,1], labels = datalabelactivity[,2])

############################################################################################
#4.Appropriately labels the data set with descriptive variable names. 
############################################################################################
names(subsetMergeData) <- gsub("^([Tt])", "time", names(subsetMergeData))
names(subsetMergeData) <- gsub("^([Ff])", "freq", names(subsetMergeData))
names(subsetMergeData) <- gsub("([Bb]ody)|([Bb]ody)([Bb]ody)", "Body", names(subsetMergeData))
names(subsetMergeData) <- gsub("-mean", "Mean", names(subsetMergeData))
names(subsetMergeData) <- gsub("-std", "Std", names(subsetMergeData))
names(subsetMergeData) <- gsub("\\()", "", names(subsetMergeData))
names(subsetMergeData) <- gsub("-", "_", names(subsetMergeData))

############################################################################################
#5.From the data set in step 4, creates a second, independent tidy data set with the average
#  of each variable for each activity and each subject. 
############################################################################################
## step 1: create subject factor
subsetMergeData$subject <- as.factor(subsetMergeData$subject)

## step 2: calculate average(mean) for each variables by activity & subject factor
activitySubjectAvg <- subsetMergeData %>%
        group_by(subject, activity) %>%
        summarize_each(funs(mean))

## step 3: write to txt file
write.table(activitySubjectAvg, "./Data/tidyAverageData.txt", row.names = FALSE)
