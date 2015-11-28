####################################################################
# Getting and Cleaning Data Course Project, from Coursera
# Date: 22/11/2015
####################################################################
library(plyr)

# Load activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
# Load features labels
features <- read.table("UCI HAR Dataset/features.txt")
# search mean and Std measures
featmeanStdPos<-grep(".*mean.*|.*std.*", features$V2);

xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")
xtrainmeanstd<-xtrain[featmeanStdPos]
ytrain<-read.table("UCI HAR Dataset/train/Y_train.txt")
subjecttrain<-read.table("UCI HAR Dataset/train/subject_train.txt")

trainjoin<-cbind(subjecttrain, ytrain,xtrainmeanstd)

xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
xtestmeanstd<-xtest[featmeanStdPos]
ytest<-read.table("UCI HAR Dataset/test/Y_test.txt")
subjecttest<-read.table("UCI HAR Dataset/test/subject_test.txt")
testjoin<-cbind(subjecttest, ytest, xtestmeanstd)

traintestjoin<-rbind(trainjoin, testjoin)

colnames(traintestjoin)<-c("subject","activity",as.character(features$V2[featmeanStdPos]))
traintestjoin$activity<-factor(traintestjoin$activity, levels=activity_labels$V1,labels=activity_labels$V2)
traintestjoin$subject<-as.factor(traintestjoin$subject)
xactivities<-traintestjoin$activity
alv2<-as.character(activity_labels$V2)
foo<-mapvalues(xactivities, from = c(1,2,3,4,5,6), to = alv2)
traintestjoin$activity<-foo

# Output result into a text file
write.table(traintestjoin, "tidy.txt", row.names = FALSE, quote = FALSE)



