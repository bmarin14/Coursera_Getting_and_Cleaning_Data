###################################################################
# 1. Merges the training and the test sets to create one data set.#
###################################################################

# 1.1. Read data

train <- read.table("./data/train/X_train.txt")
train[,562] = read.table("./data/train/y_train.txt")
train[,563] = read.table("./data/train/subject_train.txt")

test <- read.table("./data/test/X_test.txt")
test[,562] = read.table("./data/test/y_test.txt") 
test[,563] = read.table("./data/test/subject_test.txt")

# 1.2. Merge data

completeData = rbind(train, test)


###############################################################
# 2.1. Extracts only the measurements on the mean and standard 
#deviation for each measurement. 
###############################################################

# 2.1. Read features

features <- read.table("./data/features.txt") 

# 2.2. Make the feature names better suited for R with some substitutions

features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# 2.3. Get only the data on mean and std. dev.

DataWeWant <- grep(".*Mean.*|.*Std.*", features[,2])

features <- features[DataWeWant,]

DataWeWant <- c(DataWeWant, 562, 563)

completeData <- completeData[,DataWeWant]

############################################################################
# 3. Uses descriptive activity names to name the activities in the data set#
############################################################################

# 3.1. Read activity data

activity <- read.table("./data/activity_labels.txt")

# 3.2. Add the column names (features)

colnames(completeData) <- tolower(c(features$V2, "Activity", "Subject"))

i = 1
for (j in activity$V2) {
  completeData$activity <- gsub(i, j, completeData$activity)
  i <- i + 1
}

completeData$activity <- as.factor(completeData$activity)
completeData$subject <- as.factor(completeData$subject)

#######################################################################
#4. Appropriately labels the data set with descriptive variable names.#
#######################################################################

# 4.1. Make syntactically valid names

names(completeData) <- make.names(names(completeData))

# 4.2. Make clearer names
names(completeData) <- gsub('Acc',"Acceleration",names(completeData))
names(completeData) <- gsub('GyroJerk',"AngularAcceleration",names(completeData))
names(completeData) <- gsub('Gyro',"AngularSpeed",names(completeData))
names(completeData) <- gsub('Mag',"Magnitude",names(completeData))
names(completeData) <- gsub('^t',"TimeDomain.",names(completeData))
names(completeData) <- gsub('^f',"FrequencyDomain.",names(completeData))
names(completeData) <- gsub('\\.mean',".Mean",names(completeData))
names(completeData) <- gsub('\\.std',".StandardDeviation",names(completeData))
names(completeData) <- gsub('Freq\\.',"Frequency.",names(completeData))
names(completeData) <- gsub('Freq$',"Frequency",names(completeData))

###################################################################################
# 5. Creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject. 
###################################################################################

tidy = aggregate(completeData, by=list(activity = completeData$activity, subject=completeData$subject), mean)

tidy[,90] = NULL
tidy[,89] = NULL

write.table(tidy, "tidy.txt", sep="\t")
