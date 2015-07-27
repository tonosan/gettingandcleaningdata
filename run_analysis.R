#setwd("C:/Users/Posgrado Psicología/Documents/Course project")
######Getting data######
test<-read.table("UCI HAR Dataset/test/X_test.txt")
train<-read.table("UCI HAR Dataset/train/X_train.txt")
#######Concatenating test and train data ######
test.train<-rbind(test,train)
#######Naming variables######
var.name<-read.table("UCI HAR Dataset/features.txt")
names(test.train)<-var.name$V2
#######Naming subjects######
subj.test<-read.table("UCI HAR Dataset/test/subject_test.txt")
subj.train<-read.table("UCI HAR Dataset/train/subject_train.txt")
id<-c(subj.test$V1,subj.train$V1)
#######Getting the activities#######
acti.test<-read.table("UCI HAR Dataset/test/y_test.txt")
acti.train<-read.table("UCI HAR Dataset/train/y_train.txt")
activity<-c(acti.test$V1,acti.train$V1)
test.train<-cbind(id,activity,test.train)
#######Appropiate labels for activities#######
test.train$activity<-factor(test.train$activity,
  levels=c(1,2,3,4,5,6),
  labels=c("Walking","Walking_Upstairs","Walking_Downstairs","Sitting","Standing","Laying"))
library(dplyr)
library(tidyr)
#From http://stackoverflow.com/questions/28549045/dplyr-select-error-found-duplicated-column-name
new.colnames<-make.names(names=names(test.train),unique=T,allow_ = T)
names(test.train)<-new.colnames
#######Selecting variables of mean and std#######
data<-select(test.train,id,activity,contains("mean.."),contains("std"))
#######Creating tidy data set#######
library(reshape2)
meltdata<-melt(data,id=c("id","activity"))
head(meltdata)
tidy.d<-group_by(meltdata,id,activity,variable)%>%
  summarise(mean=mean(value))
tidy.d
write.table(tidy.d,file="tidy.data.txt",quote = F,sep="\t",row.names = F)
