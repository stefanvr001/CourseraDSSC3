
######## CONSTRUCT TRAIN SET
setwd("C:/Users/VA5005/Documents/R/R Exercises/Coursera/Course 3/UCI HAR Dataset/train")

train_id<-read.table("subject_train.txt")
train_gyro_measurements<-read.table("X_train.txt")
train_activity<-read.table("Y_train.txt")

train_df<-cbind(train_id, train_gyro_measurements, train_activity)
remove(train_id, train_gyro_measurements, train_activity)

setwd("C:/Users/VA5005/Documents/R/R Exercises/Coursera/Course 3/UCI HAR Dataset")
features<-read.table("features.txt")
str(features$V2)
features$V2<-as.character(features$V2)

names(train_df)<-c("Participant_id", features$V2, "Activity")
remove(features)

activity_labels<-read.table("activity_labels.txt")
activity_labels$V2<-as.character(activity_labels$V2)

train_df$Activity_label<-""
for(i in 1:length(activity_labels$V2)){
  index<-which(train_df$Activity == activity_labels$V1[i])
  if(length(index)>0){
    train_df$Activity_label[index]<-activity_labels$V2[i]
  }
}

remove(activity_labels)


######## CONSTRUCT TEST SET
setwd("C:/Users/VA5005/Documents/R/R Exercises/Coursera/Course 3/UCI HAR Dataset/test")

test_id<-read.table("subject_test.txt")
test_gyro_measurements<-read.table("X_test.txt")
test_activity<-read.table("Y_test.txt")

test_df<-cbind(test_id, test_gyro_measurements, test_activity)
remove(test_id, test_gyro_measurements, test_activity)

setwd("C:/Users/VA5005/Documents/R/R Exercises/Coursera/Course 3/UCI HAR Dataset")
features<-read.table("features.txt")
str(features$V2)
features$V2<-as.character(features$V2)

names(test_df)<-c("Participant_id", features$V2, "Activity")
remove(features)

activity_labels<-read.table("activity_labels.txt")
activity_labels$V2<-as.character(activity_labels$V2)

test_df$Activity_label<-""
for(i in 1:length(activity_labels$V2)){
  index<-which(test_df$Activity == activity_labels$V1[i])
  if(length(index)>0){
    test_df$Activity_label[index]<-activity_labels$V2[i]
  }
}

remove(activity_labels)


######## MERGE TRAIN & TEST
train_df$source<-"train"
test_df$source<-"test"

combined_set<-rbind(train_df, test_df)


######## KEEP MEAN AND STD COLUMNS
names(combined_set)<-gsub("[^A-Za-z0-9]", "", names(combined_set))
index1<-grep(pattern = "mean", x = names(combined_set))
index2<-grep(pattern = "std", x = names(combined_set))

index<-c(index1, index2)
index<-sort(index)
index<-c(1,index,563,564,565)

combined_set2<-combined_set[,index]

index3<-grep(pattern = "Freq", x = names(combined_set2))

combined_set3<-combined_set2[,-index3]

names(combined_set3)<-gsub("mean", "Mean",names(combined_set3))
names(combined_set3)<-gsub("X", "AxisX",names(combined_set3))
names(combined_set3)<-gsub("Y", "AxisY",names(combined_set3))
names(combined_set3)<-gsub("Z", "AxisZ",names(combined_set3))

names(combined_set3)<-gsub("std", "StdDev",names(combined_set3))



######## CREATE DATASET WITH MEANS OF COLUMNS PER PARTICIPANT AND ACTIVITY 

MeansPerActivity<-sqldf::sqldf("select Participantid, 
                            Activitylabel, 
                            
                            avg(tBodyAccMeanAxisX) as tBodyAccMeanAxisX,
                            avg(tBodyAccMeanAxisY) as tBodyAccMeanAxisY,
                            avg(tBodyAccMeanAxisZ) as tBodyAccMeanAxisZ,
                            avg(tBodyAccStdDevAxisX) as tBodyAccStdDevAxisX,
                            avg(tBodyAccStdDevAxisY) as tBodyAccStdDevAxisY,
                            avg(tBodyAccStdDevAxisZ) as tBodyAccStdDevAxisZ,
                            avg(tGravityAccMeanAxisX) as tGravityAccMeanAxisX,
                            avg(tGravityAccMeanAxisY) as tGravityAccMeanAxisY,
                            avg(tGravityAccMeanAxisZ) as tGravityAccMeanAxisZ,
                            avg(tGravityAccStdDevAxisX) as tGravityAccStdDevAxisX,
                            avg(tGravityAccStdDevAxisY) as tGravityAccStdDevAxisY,
                            avg(tGravityAccStdDevAxisZ) as tGravityAccStdDevAxisZ,
                            avg(tBodyAccJerkMeanAxisX) as tBodyAccJerkMeanAxisX,
                            avg(tBodyAccJerkMeanAxisY) as tBodyAccJerkMeanAxisY,
                            avg(tBodyAccJerkMeanAxisZ) as tBodyAccJerkMeanAxisZ,
                            avg(tBodyAccJerkStdDevAxisX) as tBodyAccJerkStdDevAxisX,
                            avg(tBodyAccJerkStdDevAxisY) as tBodyAccJerkStdDevAxisY,
                            avg(tBodyAccJerkStdDevAxisZ) as tBodyAccJerkStdDevAxisZ,
                            avg(tBodyGyroMeanAxisX) as tBodyGyroMeanAxisX,
                            avg(tBodyGyroMeanAxisY) as tBodyGyroMeanAxisY,
                            avg(tBodyGyroMeanAxisZ) as tBodyGyroMeanAxisZ,
                            avg(tBodyGyroStdDevAxisX) as tBodyGyroStdDevAxisX,
                            avg(tBodyGyroStdDevAxisY) as tBodyGyroStdDevAxisY,
                            avg(tBodyGyroStdDevAxisZ) as tBodyGyroStdDevAxisZ,
                            avg(tBodyGyroJerkMeanAxisX) as tBodyGyroJerkMeanAxisX,
                            avg(tBodyGyroJerkMeanAxisY) as tBodyGyroJerkMeanAxisY,
                            avg(tBodyGyroJerkMeanAxisZ) as tBodyGyroJerkMeanAxisZ,
                            avg(tBodyGyroJerkStdDevAxisX) as tBodyGyroJerkStdDevAxisX,
                            avg(tBodyGyroJerkStdDevAxisY) as tBodyGyroJerkStdDevAxisY,
                            avg(tBodyGyroJerkStdDevAxisZ) as tBodyGyroJerkStdDevAxisZ,
                            avg(tBodyAccMagMean) as tBodyAccMagMean,
                            avg(tBodyAccMagStdDev) as tBodyAccMagStdDev,
                            avg(tGravityAccMagMean) as tGravityAccMagMean,
                            avg(tGravityAccMagStdDev) as tGravityAccMagStdDev,
                            avg(tBodyAccJerkMagMean) as tBodyAccJerkMagMean,
                            avg(tBodyAccJerkMagStdDev) as tBodyAccJerkMagStdDev,
                            avg(tBodyGyroMagMean) as tBodyGyroMagMean,
                            avg(tBodyGyroMagStdDev) as tBodyGyroMagStdDev,
                            avg(tBodyGyroJerkMagMean) as tBodyGyroJerkMagMean,
                            avg(tBodyGyroJerkMagStdDev) as tBodyGyroJerkMagStdDev,
                            avg(fBodyAccMeanAxisX) as fBodyAccMeanAxisX,
                            avg(fBodyAccMeanAxisY) as fBodyAccMeanAxisY,
                            avg(fBodyAccMeanAxisZ) as fBodyAccMeanAxisZ,
                            avg(fBodyAccStdDevAxisX) as fBodyAccStdDevAxisX,
                            avg(fBodyAccStdDevAxisY) as fBodyAccStdDevAxisY,
                            avg(fBodyAccStdDevAxisZ) as fBodyAccStdDevAxisZ,
                            avg(fBodyAccJerkMeanAxisX) as fBodyAccJerkMeanAxisX,
                            avg(fBodyAccJerkMeanAxisY) as fBodyAccJerkMeanAxisY,
                            avg(fBodyAccJerkMeanAxisZ) as fBodyAccJerkMeanAxisZ,
                            avg(fBodyAccJerkStdDevAxisX) as fBodyAccJerkStdDevAxisX,
                            avg(fBodyAccJerkStdDevAxisY) as fBodyAccJerkStdDevAxisY,
                            avg(fBodyAccJerkStdDevAxisZ) as fBodyAccJerkStdDevAxisZ,
                            avg(fBodyGyroMeanAxisX) as fBodyGyroMeanAxisX,
                            avg(fBodyGyroMeanAxisY) as fBodyGyroMeanAxisY,
                            avg(fBodyGyroMeanAxisZ) as fBodyGyroMeanAxisZ,
                            avg(fBodyGyroStdDevAxisX) as fBodyGyroStdDevAxisX,
                            avg(fBodyGyroStdDevAxisY) as fBodyGyroStdDevAxisY,
                            avg(fBodyGyroStdDevAxisZ) as fBodyGyroStdDevAxisZ,
                            avg(fBodyAccMagMean) as fBodyAccMagMean,
                            avg(fBodyAccMagStdDev) as fBodyAccMagStdDev,
                            avg(fBodyBodyAccJerkMagMean) as fBodyBodyAccJerkMagMean,
                            avg(fBodyBodyAccJerkMagStdDev) as fBodyBodyAccJerkMagStdDev,
                            avg(fBodyBodyGyroMagMean) as fBodyBodyGyroMagMean,
                            avg(fBodyBodyGyroMagStdDev) as fBodyBodyGyroMagStdDev,
                            avg(fBodyBodyGyroJerkMagMean) as fBodyBodyGyroJerkMagMean,
                            avg(fBodyBodyGyroJerkMagStdDev) as fBodyBodyGyroJerkMagStdDev

                            from combined_set3
                            group by Participantid, Activitylabel
                            ")


write.table(MeansPerActivity, "Course3Submission.txt",row.names = FALSE)   



