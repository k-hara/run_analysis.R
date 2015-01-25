## Create a data directory if necessary.
if (!file.exists("./data")){dir.create("./data")}
## Download and unzip the data.
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/Dataset.zip", method="curl")
unzip("./data/Dataset.zip", exdir="./data/")
## Activate dplyr package.
library(dplyr)
## Make datasets.
colNames <- read.table("./data/UCI HAR Dataset/features.txt",)
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
y_test <-read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = "activity")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = "activity")
## Merge the datasets.
subject <- rbind(subject_train, subject_test)
activity <-rbind(y_train, y_test)
features<-c(as.character(colNames$V2))
  # Replace the specific characters in features to make them correct syntaxically.
features1<-gsub( "\\(", "qq", gsub("\\)", "QQ", gsub("-", "_", features)))
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names=features1)
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names=features1)
x_all <- rbind(x_train, x_test)
## Extracts only the measurements on the mean and standard deviation for each measurement. 
x_mean_std <- select(x_all, contains("mean"), contains("std"))
## Uses descriptive activity names to name the activities in the data set
activity$activity[activity$activity==1]<-"WALKING"
activity$activity[activity$activity==2]<-"WALKING_UPSTAIRS"
activity$activity[activity$activity==3]<-"WALKING_DOWNSTAIRS"
activity$activity[activity$activity==4]<-"SITTING"
activity$activity[activity$activity==5]<-"STANDING"
activity$activity[activity$activity==6]<-"LAYING"
## Merge all required datasets.
dfStep4 <-cbind(subject, activity, x_mean_std)
## Group the data in the new dataset by subject and activity.
by_subject_activity <- group_by(dfStep4, subject, activity)
## Summarize the grouped data and creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
tidydf <-summarise_each(by_subject_activity, funs(mean))
## Recover the features and label the dataset with appropriate descriptive variable names. 
colnames(tidydf)  <-gsub("qq", "\\(", gsub("QQ", "\\)", gsub("_", "-", colnames(tidydf))))
## Output the dataset as a text file.
write.table(tidydf, file="./data/tidydf.txt", row.names=FALSE)
