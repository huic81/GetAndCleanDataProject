# Getting And Cleaning Data Project
Assignment: Getting and Cleaning Data Course Project

## Objectives and Guidelines
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. Output of this will be: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. As well as a README.md in the repo with the scripts. This repo explains how all of the scripts work and how they are connected.

## The Data Sources
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Tasks
The R script called run_analysis.R does the following. 
<ol>
<li>Download the source data into working directory and write into R for processing.</li>
<li>Merges the training and the test sets to create one data set.</li>
<li>Extracts only the measurements on the mean and standard deviation for each measurement. Name the variables by it's measurement description.</li>
<li>Uses descriptive activity names to name the activities in the data set.</li>
<li>Appropriately labels the data set with descriptive variable names.</li>
<li>From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.</li>
<li>write the tidy output from step 6 into text file and stored in "data/tidyAverageData.txt" inside working directory</li>
</ol>

## Reproduce Steps
<ol>
<li>Open the run_analysis.R R script.</li>
<li>Set the working directory to the path where the run_analysis.R R script was stored under ## step 1: Set Working Directory to folder where run_analysis.R was stored.</li>
<li>Run the script.</li>
</ol>

## Output
<ol>
<li>The R script saved as "run_analysis.R".</li>
<li>The tidy dataset file saved as "tidyAverageData.txt" which stored inside the data folder.</li>
<li>Codebook markdown file that describes the variables, the data, and any transformations or work that you performed to clean up the data saved as "CodeBook.md".</li>
</ol>
