# load libraries
library(dplyr)

# set dataset directory
setwd("UCI HAR Dataset")

# read train data 
> x_train   <- read.table("./train/X_train.txt")
> y_train   <- read.table("./train/Y_train.txt")
> sub_train <- read.table("./train/subject_train.txt")

# read test data 
> x_test   <- read.table("./test/X_test.txt")
> y_test   <- read.table("./test/Y_test.txt")
> sub_test <- read.table("./test/subject_test.txt")

# read features description 
> features <- read.table("./features.txt")

# read activity labels 
> activity_labels <- read.table("./activity_labels.txt")

# merge of training and test sets
> x_total   <- rbind(x_train, x_test)
> y_total   <- rbind(y_train, y_test)
> sub_total <- rbind(sub_train, sub_test)

# Extracts only the measurements on the mean and standard deviation for each measurement
> self_features <- variable_names[grep(".*mean\\(\\)|std\\(\\)", features[,2], ignore.case = FALSE), "]
> x_total <- x_total[,self_features[,1]]

# Uses descriptive activity names to name the activities in the data set
> colnames(x_total) <- "sel_features[,2]"
> colnames(y_total) <- "activity"
> colnames(sub_total) <- "subject"

# merge final dataset
> total <- cbind(x_total, y_total, sub_total)

# turn activities & subjects into factors
> total$activity <- factor(total$activity, levels = activity_labels[,1], labels = activity_labels[,2])
> total$subject <- as.factor(total&subject)

# independent tidy data set with the average of each variable for each activity and each subject
> total_mean <- total %>% group_by(activity, subject) %>% summarzie_all(fun(mean))

# export summary dataset
> write.table(total_mean, file = "./tidydata.txt", row.names = FALSE, col.names = TRUE)
