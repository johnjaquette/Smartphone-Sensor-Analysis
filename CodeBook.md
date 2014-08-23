~

Analysis of Human Activity Recognition Using Smartphones Dataset Version 1.0

Data provided by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

www.smartlab.ws

Data available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Analysis by John Jaquette for Coursera class Getting and Cleaning Data

run.analysis.R returns an R object, tidy, which is a data.frame of 180 rows and 88 columns.
Each row has a unique subject/activity pair from 1 to 30 subjects and 1 to 6 activities. 
Columns 1 to 86 are for mean sensor measurements, or features, as calculated in the analysis. Column 87 is for the subject number, and column 88 is for the activity description.

The following description of features is excerpted from the original dataset's features_info.txt:

~

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value

std(): Standard deviation

meanFreq(): Weighted average of the frequency components to obtain a mean frequency

angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean

tBodyAccMean

tBodyAccJerkMean

tBodyGyroMean

tBodyGyroJerkMean

~

Raw accelerometer measurements were taken in standard gravity units 'g', and raw gyroscopic measurements were taken in radians per second. Features examined in this analysis were normalized and bounded within [-1,1].

The first step in the analysis was to read the data in using read.table. The following files were read in and assigned to individual R objects: 

activity_labels.txt

features.txt

subject_test.txt

subject_train.txt

X_test.txt

X_train.txt

y_test.txt

y_train.txt

Next, test and training data were combined using rbind(). Feature columns were labeled using the features object. Subject and activity columns were labeled with "Subject" and "Activity".

Next, the sensor, subject, and activity data were combined into a single data.frame using cbind().

From this data.frame, measurements on the mean and standard deviation for each measurement were extracted. These are the variables from features.txt that contain "mean", "Mean", or "std", identified in columns 1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,294:296,345:350,373:375,424:429,452:454,503:504,513,516:517,526,529:530,539,542:543,552, and 555:563.

Next, a function called averages() was written that returns a vector of the average of each variable for a given subject/activity combination.

Using this function, a tidy data frame was constructed with the average of each variable for each activity and each subject. 

The variable columns in this tidy data frame were labeled using paste() to paste "mean" before the original variable names. 

Descriptive activity names were applied by reassigning each value in the 88th column with the appropriate activity name from the activity_labels object.

Finally, run_analysis.R returns the tidy data set.
