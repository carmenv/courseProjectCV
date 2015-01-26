# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="FUCI-HAR-dataset.zip",method="curl")
# Loading training data, 561 features, subjects and activity code
trainX = read.table("train/X_train.txt")
trainLabels = read.table("train/y_train.txt")
names(trainLabels) = c('Activity')
trainSubjects = read.table("train//subject_train.txt")
names(trainSubjects) = c('Subjects')
trainDF = cbind(trainX, trainSubjects,trainLabels)

# Loading test data, 561 features, subjects and activity code
testX = read.table("test/X_test.txt")
testLabels = read.table("test//y_test.txt")
names(testLabels) = c('Activity')
testSubjects = read.table("test//subject_test.txt")
names(testSubjects) = c('Subjects')
testDF = cbind(testX, testSubjects,testLabels)

#1. Merges the training and the test sets to create one data set.
df = rbind(trainDF,testDF)

features = read.table("features.txt",as.is=TRUE)
positionMeanStdFeatures = which(grepl("mean|std|Mean",features$V2))
featuresLabels = features$V2[positionMeanStdFeatures]

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
columnsToKeep = c(positionMeanStdFeatures,562,563)
dfMeanStdev = df[,columnsToKeep] # Keep Mean and Std measurements, subject and activity label

#3. Uses descriptive activity names to name the activities in the data set
activityLabels =read.table("activity_labels.txt")
names(activityLabels) <- c("Activity","nameActivity")
dfMeanStdev2 = merge(dfMeanStdev,activityLabels,by="Activity")
dfMeanStdev2$Activity = NULL # drop code for activity
names(dfMeanStdev2)[length(names(dfMeanStdev2))] <- "Activity"
dfMeanStdev2$Activity = as.character(dfMeanStdev2$Activity)

#4. Appropriately labels the data set with descriptive variable names. 
newFeaturesLabels = gsub("tB","timeB",featuresLabels)
newFeaturesLabels = gsub("tG","timeG",newFeaturesLabels)
newFeaturesLabels = gsub("fB","frequencyB",newFeaturesLabels)
newFeaturesLabels = gsub("-mean\\(\\)",".Mean",newFeaturesLabels)
newFeaturesLabels = gsub("-std\\(\\)",".Std",newFeaturesLabels)
newFeaturesLabels = gsub("-meanFreq\\(\\)",".MeanFreq",newFeaturesLabels)
newFeaturesLabels = gsub("-X",".X",newFeaturesLabels)
newFeaturesLabels = gsub("-Y",".Y",newFeaturesLabels)
newFeaturesLabels = gsub("-Z",".Z",newFeaturesLabels)
newFeaturesLabels = gsub("BodyBody","Body",newFeaturesLabels)
newFeaturesLabels = gsub("angle\\(t","angleT",newFeaturesLabels)
newFeaturesLabels = gsub(",gravityMean\\)",".gravityMean",newFeaturesLabels)
newFeaturesLabels = gsub("\\).",".",newFeaturesLabels)
newFeaturesLabels = gsub("\\(X.",".X.",newFeaturesLabels)
newFeaturesLabels = gsub("\\(Y.",".Y.",newFeaturesLabels)
newFeaturesLabels = gsub("\\(Z.",".Z.",newFeaturesLabels)
names(dfMeanStdev2)<-c(newFeaturesLabels, "Subject","Activity")

tidyData = aggregate(. ~ Subject+Activity, data = dfMeanStdev2, mean)

tidyData