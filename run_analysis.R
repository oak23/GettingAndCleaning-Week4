library(dplyr)

setwd('C:/Users/oak/Desktop/GettingAndCleaning-Week4')

# download and unzip data
fileurl='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileurl,destfile = 'harus.zip')
unzip('harus.zip')
file.remove('harus.zip')

# read activity labels
activity_labels = read.table('UCI HAR Dataset/activity_labels.txt')$V2

# read feature vector
features = read.table('UCI HAR Dataset/features.txt')$V2

# read subject vector
subject = rbind(read.table('UCI HAR Dataset/test/subject_test.txt'),
                read.table('UCI HAR Dataset/train/subject_train.txt'))
# set name (that will be column name in the data frame)
names(subject) = 'subject'
# cast to factor 
# (melt function will implicitly use variables other than factors and characters as id variables)
subject = as.factor(subject$subject)

# read data
x = rbind(read.table('UCI HAR Dataset/test/X_test.txt'),
          read.table('UCI HAR Dataset/train/X_train.txt'))
# 4. Appropriately labels the data set with descriptive variable names.
names(x) = make.names(features, unique = T, allow_ = T)
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
x = select(x, which(grepl('mean\\.|std', names(x))))

# read labels
y = rbind(read.table('UCI HAR Dataset/test/y_test.txt'),
          read.table('UCI HAR Dataset/train/Y_train.txt'))
names(y) = 'activity'
# 3. Uses descriptive activity names to name the activities in the data set
y = lapply(y, function(i){activity_labels[i]})

# create one data frame
dat = cbind(subject, x, y)

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
dat.avg <- dcast(melt(dat), subject + activity ~ variable, mean)
write.table(dat.avg, "avg.txt", row.names = FALSE, quote = FALSE)
  










