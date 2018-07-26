## Loading raw data sets.

library(plyr)
library(data.table)

subjecttrain = read.table('./train/subject_train.txt',header=FALSE)
xtrain = read.table('./train/x_train.txt',header=FALSE)
ytrain = read.table('./train/y_train.txt',header=FALSE)

subjecttest = read.table('./test/subject_test.txt',header=FALSE)
xtest = read.table('./test/x_test.txt',header=FALSE)
ytest = read.table('./test/y_test.txt',header=FALSE)

## 1. Organizing and combining raw data sets into single one.

xdata <- rbind(xtrain, xtest)
ydata <- rbind(ytrain, ytest)
subjectdata <- rbind(subjecttrain, subjecttest)


## 2. Extract only the measurements on the mean and standard deviation for each measurement.
## xdata subset based on the logical vector to keep only desired columns, i.e. mean() and std().

xdata_mean_std <- xdata[, grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2])]
names(xdata_mean_std) <- read.table("features.txt")[grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2]), 2] 
View(xdata_mean_std)

##3. Use descriptive activity names to name the activities in the data set.

ydata[, 1] <- read.table("activity_labels.txt")[ydata[, 1], 2]
names(ydata) <- "Activity"
View(ydata)

## 4. Appropriately label the data set with descriptive activity names.

names(subjectdata) <- "Subject"
summary(subjectdata)


## Organizing and combining all data sets into single one.

singledata <- cbind(xdata_mean_std, ydata, subjectdata)

## Defining descriptive names for all variables.

names(singledata) <- make.names(names(singledata))
names(singledata) <- gsub('Acc',"Acceleration",names(singledata))
names(singledata) <- gsub('GyroJerk',"AngularAcceleration",names(singledata))
names(singledata) <- gsub('Gyro',"AngularSpeed",names(singledata))
names(singledata) <- gsub('Mag',"Magnitude",names(singledata))
names(singledata) <- gsub('^t',"TimeDomain.",names(singledata))
names(singledata) <- gsub('^f',"FrequencyDomain.",names(singledata))
names(singledata) <- gsub('\\.mean',".Mean",names(singledata))
names(singledata) <- gsub('\\.std',".StandardDeviation",names(singledata))
names(singledata) <- gsub('Freq\\.',"Frequency.",names(singledata))
names(singledata) <- gsub('Freq$',"Frequency",names(singledata))

View(singledata)

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

names(singledata)

wholedata<-aggregate(. ~Subject + Activity, singledata, mean)
wholedata<-wholedata[order(wholedata$Subject,wholedata$Activity),]
write.table(wholedata, file = "tidydata.txt",row.name=FALSE)
