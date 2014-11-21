Getting and Cleaning Data Course Project
========================================
This file describes how run_analysis.R script works.

* First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder with "data".

* Make sure the folder "data" and the run_analysis.R script are both in the current working directory.

* Second, use source("run_analysis.R") command in RStudio. 

* Third, you will find that one output file named "tidy.txt" is generated in the current working directory:

* Finally, use data <- read.table("tidy.txt") command in RStudio to read the file.