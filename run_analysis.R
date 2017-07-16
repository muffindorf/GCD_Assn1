## Read file from URL 

library(reshape2)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "gcdassyn1.zip"

if(!file.exists(filename)) {
        download.file(fileurl, filename, method="curl")
}
if (!file.exists("UCI HAR Dataset")) {
        unzip(filename) 
}

## Load wanted features and activity labels 
# Note that all features wanted have "mean" or "std" in between something and some other things

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_labels[,2] <- as.character(activity_labels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
selectfeatures <- grep(".*mean.*|.*std.*", features[,2])
selected_features <- features[selectfeatures,2]
selected_features <- gsub("[()]", "", selected_features)

## Load and merge train and test data

train <- read.table("UCI HAR Dataset/train/X_train.txt")[selectfeatures]
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_data <- cbind(train_subjects, train_activities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[selectfeatures]
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_data <- cbind(test_subjects, test_activities, test)

merged_data <- rbind(train_data, test_data)
colnames(merged_data) <- c("subject", "activity", selected_features)

## Apply appropriate labels to the activities, plus make subject number into factors

merged_data$activity <- factor(merged_data$activity, levels = activity_labels[,1], labels = activity_labels[,2])
merged_data$subject <- as.factor(merged_data$subject)

## Create second dataset with subject, activity, and mean of each variable

molten_data <- melt(merged_data, id = c("subject", "activity"))
reshaped_data <- dcast(molten_data, formula = subject + activity ~ variable, mean)

## Write tidy data and list of variables

write.table(reshaped_data, "tidy_gcd_assyn1.txt", row.names = F, quote = F)
write.table(colnames(reshaped_data), "gcd_assyn1_codebook.txt", quote = F)
