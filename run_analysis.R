
# Observations are split into the 'test' and 'train data sets
# The 'X' portion of the data set has all of the observations
# The 'Y' portion of the data set has the activity
# The 'subject' portion of the data set has the subjects identity integer

library(plyr)
library(reshape2)


#
# Load All Needed Raw Data Files
#
testX <- read.table("dataset/test/X_test.txt")
testY <- read.table("dataset/test/y_test.txt")
testSubject <- read.table("dataset/test/subject_test.txt")

trainX <- read.table("dataset/train/X_train.txt")
trainY <- read.table("dataset/train/y_train.txt")
trainSubject <- read.table("dataset/train/subject_train.txt")

features <- read.table("dataset/features.txt")
names(features) <- c('rowId','label')

activities <- read.table("dataset/activity_labels.txt")
names(activities) <- c('activityId','activityName')

#
# Combine and Merge Data 
#
tidyData <- 
# The y and subject datasets include the activity and subject label
testMerged <- cbind(testX,testY,testSubject)
trainMerged <- cbind(trainX,trainY,trainSubject)

# Merge the merged data sets for one complete set of all observations
dataMerged <- rbind(testMerged, trainMerged)


#
# Determine Columns To Keep and Create Data Labels
#

# Column labels are enumerated in the features dataset in the second column
ColLabels <- as.character(features$label)

# Find all of the column numbers for column labels with `mean(` or `std(` in their title
ColNumsWithMeanAndStdDev <- grep("mean\\(|std\\(", ColLabels)
ColNamesWithMeanAndStdDev <- ColLabels[grep("mean\\(|std\\(", ColLabels)]

# The second to last and last columns have the activity and the subject that we want to keep
ColNumsToKeep <- c(ColNumsWithMeanAndStdDev, ncol(dataMerged) - 1, ncol(dataMerged))
ColNamesToKeep <- c(ColNamesWithMeanAndStdDev, "activityId","subjectId")

#
# Create subset of data and label data
#
data <- dataMerged[,ColNumsToKeep]
names(data) <- ColNamesToKeep

#
# Create friendlier activity names
#
data <- merge(data,activities, by.x = "activityId", by.y = "activityId")


#
# Melt data and summarize
#

# Melt data so each row has just one observation to adhere to tidy data principles
# Resulting data frame has columns of 'subjectId','activityId','activityName','variable','value'
dataMelt <- melt(data,id=c('subjectId','activityId','activityName'))


# Created summarized tidy data
tidyDataNarrow <- ddply(dataMelt, c('subjectId','activityId','activityName','variable'), summarise, mean = mean(value))
names(tidyDataNarrow) <- c('subjectId', 'activityId','activityName','measurement', 'mean')

#
# Write out tidy data
#
write.table(tidyDataNarrow, 'tidyDataNarrow.txt', sep="\t", row.name=FALSE)

