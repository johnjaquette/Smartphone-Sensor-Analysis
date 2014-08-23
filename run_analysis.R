# Analysis of Human Activity Recognition Using Smartphones Dataset Version 1.0

# Data provided by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
# www.smartlab.ws
# Data available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# Analysis by John Jaquette for Coursera class Getting and Cleaning Data

# Before running this analysis, make sure you have the following files in your working directory:
# activity_labels.txt
# features.txt
# subject_test.txt
# subject_train.txt
# X_test.txt
# X_train.txt
# y_test.txt
# y_train.txt

## Read the data in

activity_labels<-read.table("activity_labels.txt",colClasses="character")
features<-read.table("features.txt",colClasses="character")
subject_test<-read.table("subject_test.txt",colClasses="integer")
subject_train<-read.table("subject_train.txt",colClasses="integer")
X_test<-read.table("X_test.txt",colClasses="numeric")
X_train<-read.table("X_train.txt",colClasses="numeric")
y_test<-read.table("y_test.txt",colClasses="integer")
y_train<-read.table("y_train.txt",colClasses="integer")

## Combine test and training data

xframe<-rbind(X_train,X_test)
sframe<-rbind(subject_train,subject_test)
yframe<-rbind(y_train,y_test)

## Label the columns in each frame

names(xframe)=features[,2]
names(sframe)="Subject"
names(yframe)="Activity"

## Combine sensor, subject, and activity data into one frame

cframe<-cbind(xframe,sframe,yframe)

## Extract only the measurements on the mean and standard deviation for each measurement, as well as Subject and Activity.
## These are the variables from features.txt that contain "mean", "Mean", or "std".

tframe<-cframe[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,294:296,345:350,373:375,424:429,452:454,503:504,513,516:517,526,529:530,539,542:543,552,555:563)]

## Create a function that returns a vector of the average of each variable for a given subject/activity combination

averages<-function(subject,activity){
  result<-numeric()
  nframe<-subset(tframe,Subject == subject & Activity == activity)
  for (i in 1:88){
    result<-c(result, mean(nframe[,i]))
  }
  return(result)
}

## Initialize a tidy data frame with the averages for subject 1, activity 1

tidy<-data.frame(rbind(averages(1,1)),row.names=NULL)

## Label columns 1:86 to indicate these data are averages

for (i in 1:86){
  names(tidy)[i]=paste("mean",names(tframe)[i])
}

## Add 5 more rows to this data frame for subject 1, activities 2:6

for (i in 2:6){
  tidy<-rbind(tidy,averages(1,i))
}

## Add the remaining rows for subjects 2:30, activities 1:6

for(i in 2:30){
  for(j in 1:6){
    tidy<-rbind(tidy,averages(i,j))
  }
}

## Apply descriptive activity names

for(i in 1:180){
  tidy[i,88] = activity_labels[tidy[i,88],2]
}

return(tidy)
