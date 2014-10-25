setwd("D:/Mis Documentos/Project Cleaning Data")
traindata = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
names(traindata)
traindata[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
names(traindata)
traindata[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
names(traindata)

testdata = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
names(testdata)
testdata[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testdata[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

#load the activities
activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

# Read features and make the feature names better suited for R with some substitutions
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
# find the -mean and -std matches and chage it for Mena and Std
# Then replace all - by empty spaces.
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# Merge training and test sets together (fist data set with training ans tested data)
allData = rbind(traindata, testdata)

# Get only the data on mean and std. dev.
colsWeWant <- grep(".*Mean.*|.*Std.*", features[,2])
# First reduce the features table to what we want
features <- features[colsWeWant,]
# Now add the last two columns (subject and activity)
colsWeWant <- c(colsWeWant, 562, 563)
# And remove the unwanted columns from allData
allData <- allData[,colsWeWant]
# Add the column names (features) to allData
colnames(allData) <- c(features$V2, "Activity", "Subject")
colnames(allData) <- tolower(colnames(allData))

currentActivity = 1
##replace the number by the specific label

for (currentActivityLabel in activityLabels$V2) {
  allData$activity <- gsub(currentActivity, currentActivityLabel, allData$activity)
  currentActivity <- currentActivity + 1
}

##Identify the factors in each vector
#
allData$activity <- as.factor(allData$activity) # it prints 6 Levels: LAYING SITTING STANDING WALKING ... WALKING_UPSTAIRS
allData$subject <- as.factor(allData$subject) # it prints 30 Levels: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 ... 30

tidy <- aggregate(allData, by=list(activity = allData$activity, subject=allData$subject), mean)

# Remove the subject and activity column, since a mean of those has no use
tidy[,90] = NULL
tidy[,89] = NULL
# generate the document with the final data set
write.table(tidy, "tidy.txt", sep="\t")