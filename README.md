==================================================================
Human Activity Recognition Using Smartphones Dataset
for Coursera Class: Getting and Cleaning Data
==================================================================

Maria S.
for Coursera Class: Getting and Cleaning Data, 12-27-2015
==================================================================

In this readme file I present and describe my script run_analysis.R

The purpose of this script is to collect the proper data sets from UCI HAR dataset, combine together
in one data set the information gathered from two teams of volunteers (these that work on the actual
train data and those that work on the test data) and transform and manipulate this unified data set 
in order to produce a tidy data set that takes the average (per subject and activity) of a number of
variables of interest.

======================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The UCI HAR provided dataset includes the following files that we make use of:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

=========================================


run_analysis.R use and transformations:

 My final tidy data set: tidydata.txt contains/makes use of the following variables:

-  subject_train.txt and subject_test.txt stored as subTrain and subTest, where subTrain contains those
   ids/subject that belong to the Train section, while subTest contain those belonging to the Test section.

- subject_train.txt and subject_test.txt are also transformed to teamTrain and teamTest which are essentially 
  markers of whether any subject belongs to the category 1 (team=Train) or to the category 2 (team=Test).

- y_train.txt and y_test.txt have been transformed to yTrain and YTest. They show which of the 
  6 activities contained in 'activity_labels.txt' is performed by any of the subject and corresponds to any
  ROW of the dataset.

- x_train.txt and x_test.txt have been transformed to xTrain and xTest. They both contain measurements for 
  561 variables, corresponding to one row of the dataset, i.e., to one subject, and are appended at the far 
  right end of the data sets. Information on the nature of the variables and their measurements is contained
  in the provided features_info.txt file and in the provided features.txt.

=========================================

The final tidy data set: "tidydata.txt" is a merge of the two separate data sets Train and Test into one
via the rbind function. However, I'm adding an extra column "Team" which designates which sector the 
volunteers are working on: 1 for train, 2 for test. 
Furthermore, as we are asked in the assignment to keep to our results only the measurements for the variables
that compute the average (mean or Mean) and the standard Deviation (std or Std). Hence, we discard a great 
amount of the initial 561 variables for the final data set and we end up with 66 instead of 561 for both
xTrain and xTest.

=========================================

DESCRIPTION AND USE OF run_analysis.R

=========================================

WORKING DIRECTORIES  - INPUT  - OUTPUT
=========================================

run_analysis.R must be stored in the same directory with UCI HAR Dataset.

We execute run_analysis from the same working directory that contains the script of course and UCI HAR Dataset.

The script automatically reads via read.table the above discussed data sets from UCI HAR Dataset and incorporates them
in the program with the names described above. We do not provide any input to the script.
It executes the steps that will be described below and finally as output it provides the tidydata.txt that is a unified 
tidy data set adhering to the requirements of the project. 
tidydata via the write.table command gets stored to the directory we select but also appears in the screen.
We select to store it in the same working directory where run_analysis.R and UCI HAR datasets is stored.

=========================================

run_analysis.R high level description

=========================================

For the requirements and manipulations of data sets conducted in this script we use the following libraries and read the 
following tables from UCI HAR datasets, as shown below:

library(data.table)
library(plyr)
library(dplyr)


subTrain <- read.table("C:/Users/kyriakos/Desktop/COURSERA/UCI HAR Dataset/train/subject_train.txt")
subTest <- read.table("C:/Users/kyriakos/Desktop/COURSERA/UCI HAR Dataset/test/subject_test.txt")
xTrain <- read.table("C:/Users/kyriakos/Desktop/COURSERA/UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("C:/Users/kyriakos/Desktop/COURSERA/UCI HAR Dataset/train/y_train.txt")
xTest <- read.table("C:/Users/kyriakos/Desktop/COURSERA/UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("C:/Users/kyriakos/Desktop/COURSERA/UCI HAR Dataset/test/y_test.txt")
actLabels <- read.table("C:/Users/kyriakos/Desktop/COURSERA/UCI HAR Dataset/activity_labels.txt")
features <- read.table("C:/Users/kyriakos/Desktop/COURSERA/UCI HAR Dataset/features.txt")


We have a number of disparate data sets to be combined together.
First we want to build one solid data set for the Train Subject team, another for the Test Subject team and then 
merge them together.

The Train data set (tmpTrain) will compose of the following data sets: subTrain, teamTrain, yTrain, xTrain.
The Test data set (tmpTest) will compose of the following data sets: subTest, teamTest, yTest, xTest.

All data sets but teamTrain and teamTest are directly obtained from reading the UCI HAR datsets as described above.

=========================================
STEP 1 and STEP 2: 
1) Merge the training and the test sets to create one data set.
2) Extract only the measurements on the mean and standard deviation for each measurement. 
=========================================

I build tmpTrain by cbinding together the disparate data sets in the following ordeR:
subTrain, teamTrain, yTrain, XTrain.

I build tmpTest by cbinding together the disparate data sets in the following ordeR:
subTest, teamTest, yTest, XTest.

The column contents are obtained from UCI HAR datasets but I change the names of the column as seen fit:
colnames(subTrain) -> ID
colnames(teamTrain) -> Team
Colnames(yTrain) -> ACTIVITY
colnames(xTrain) -> ***  I end up selecting only 66 from the 561 columns contained in the xTrain (or equivalently xTest) dataset. 
                     This subset contains only columns that compute the mean and the Standard Deviation of the variables
                     pertinent to the Siemens experiment. Decided not to include MeanFrequency related variables because 
                     meanFrequency serves as an alltogether additional variable which calculates the frequencies experienced 
                     in the experiment, but to compute the mean and the std we would neet to calculate: 
                     mean(meanFrequency) and std(meanFrequency).
                     But these variables do not exist in the xTrain data set, so we do not need to take them into account. 
                     Selecting a subset of columns from xTrain data set that contain mean and std in their names and omitting
                     also the MeanFreq related variables, I'm left with 66 out of 561 columns (if having included MeanFreq 
                     related variables I would end up with 79 columns but decided to proceed without considering those). 
                     The 66 columns that calculate the mean and the std of the experiment variables are quoted later. 
                     The original column names can be found in the features.txt but I've also expanded the names 
                     adhering to the rules of a tidy data and deploying these column names to the full meaning of the words 
                     that are abbreviated in features.txt

                     For example: tbodyaccmean()_X was transformed to: TimeBodyAccelerometerMeanX
                                  fbodygyrojerkstd()_Z was transformed to: FrequencyBodyGyroscopicJerkStdZ

Now, the original names or the variables of xTrain and xTest are obtained from the features[2] data set as shown below:

nTrain <- as.vector(t(features[2]))

nLabels <- as.vector(actLabels[2])
nLabels <- t(nLabels)

colnames(xTrain) <- nTrain
colnames(xTest) <- nTrain

The colnames of the other data sets to be combined are sent individually.

colnames(yTrain) <- c("ACTIVITY")

colnames(yTest) <- c("ACTIVITY")

colnames(subTrain) <- c("ID")
colnames(subTest) <- c("ID")

# The data column Team was created by myself to designate to which team 
# a specific subject/volunteers belongs to: {Train=1, Test=2}. This extra
# column turns out not to play an important role for this assignment but
# I felt that this was a requirement that may be very useful for many uses 
# of this combined data set. 

tmp1 <- rep(1,nrow(subTrain))
teamTrain <- as.data.frame(tmp1)
colnames(teamTrain) <- c("Team")

tmp2 <- rep(2,nrow(subTest))
teamTest <- as.data.frame(tmp2)
colnames(teamTest) <- c("Team")

# With so many entries I check for duplicates in the column names
# and if I find any, I remove them with the following commands:

xTrain <- xTrain[,!duplicated(colnames(xTrain))]
xTest <- xTest[,!duplicated(colnames(xTest))]

# if we check the dimensions of xTrain-xTest before and after, I
# find out that the column numbers have been reduced from 561 to 477.
# So, there were duplicates.


# Taking care of step 2 before step 1 to handle issues
# of memory limitation and size. Will first reduce the 
# size of xTrain and xTest, and then proceed to making
# a single data unit out of combining these.

# We need to reduce the number of columns of xTrain and XTest
# to extract these columns only related to the computation of
# mean and std. 
# Tested for "Std" and no entry in the names of 
# XTrain-xTest columns has been found. 
# Tested for "Mean" and additional entries have been found but 
# the operation of these variables that contain Mean is different
# than what being asked in the exercise, so I choose to ignore them
# at this point.I also choose to ignore "meanFrequency" columns because
# these "means" serve a different purpose.

extTrain_mean <- grep("mean",names(xTrain))
extTrain_std <- grep("std",names(xTrain))

# By displaying extTrain_mean and extTrain_std we find there're
# 46 columns that calculate the mean of certain variables and 
# 33 that calculate the std. Exactly equivalent is the case for
# xTest, as the two data frames share common column names.

# We combine and sort all entries we want to keep. They're 79 in total.
CombTrain <- c(extTrain_std,extTrain_mean)
CombTrain <- sort(CombTrain)
CombTrain

# Now, we reduce xTrain and xTest in size by choosing to leave intact
# only the columns designated by CombTrain (same for xTrain and xTest)

tmpTrain <- select(xTrain,CombTrain)
tmpTest <- select(xTest,CombTrain)

# dim(tmpTrain) -> 7352 79. 
# dim(tmpTest)  -> 2947 79.

# However, I find that the column names that contain meanFreq are irrelevant 
# to computing the mean and the std of a variable. We can remove this variable 
#as well, with the following command:

tmpTrain <- tmpTrain[,-grep("meanFreq",colnames(tmpTrain))]
tmpTest <- tmpTest[,-grep("meanFreq",colnames(tmpTest))]

# dim(tmpTrain) -> 7352 66. 
# dim(tmpTest)  -> 2947 66.

# First we combine all columns for each separate team department
# of volunteers (Train or Test) separately using the cbind command.

So, now, having three columns: ID, Team, ACTIVITY and 66 columns of experiment variables,
we have 69 columns in total and are ready to bind all data sets together:
I am doing this with the use of the cbind (for the data sets of each of the Train team and Test team)
and rbind commands as follows:

T1Train <- cbind(subTrain,teamTrain)
T2Train <- cbind(T1Train,yTrain)
T3Train <- cbind(T2Train,tmpTrain)
tmp3Train <- T3Train

T1Test <- cbind(subTest,teamTest)
T2Test <- cbind(T1Test,yTest)
T3Test <- cbind(T2Test,tmpTest)
tmp3Test <-T3Test

# dim(T3Train) -> 7352 69. 
# dim(T3Test) -> 2947 69. 

# Now we merge the two tables of the two separate teams: train, test
#by using rbind function of R.

T3 <- rbind(T3Train,T3Test)
dim(T3)

# We get dim(T3) -> 10299 69
# T3 combines all the data frames of interest in one data set T3.
# At this point we have taken care of Step1 and Step2.

T3 contains the combined data resulting from steps 1 and steps 2. 

=========================================
STEP 3: 

3) Uses descriptive activity names to name the activities in the data set

=========================================

I use nLabels to populate our combined data set with the activities  measured in the experiments.

> nLabels
 "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" "STANDING" "LAYING"

# I change the name in each of the data sets yTrain and yTest that contain 
# the names and numbers of activities.

for (i in 1:length(nLabels)) T3[3][T3[3]==i] <- nLabels[i]

nLabels data set contains the names and number of the activities.

Activity is a character column. It's formulated from'activity_labels.txt', which links the class labels 
with their activity name.


=========================================
STEP 4: 

4) Appropriately labels the data set with descriptive variable names

The 66 columns that 
calculate the mean and the std of the experiment variables are quoted below. The original column names can be found 
in the features.txt but I also expanded the names adhering to the rules of a tidy data and deploying these column names
to the full meaning of the words that are abbreviated in features.txt

For example: tbodyaccmean()_X was transformed to: TimeBodyAccelerometerMeanX
             fbodygyrojerkstd()_Z was transformed to: FrequencyBodyGyroscopicJerkStdZ

All the 66 column (variable) names used in the final tidy data set are quoted here.
 

 [1] "TimeBodyAccelerometerMeanX"                      "TimeBodyAccelerometerMeanY"                     
 [3] "TimeBodyAccelerometerMeanZ"                      "TimeBodyAccelerometerStdX"                      
 [5] "TimeBodyAccelerometerStdY"                       "TimeBodyAccelerometerStdZ"                      
 [7] "TimeGravityAccelerometerMeanX"                   "TimeGravityAccelerometerMeanY"                  
 [9] "TimeGravityAccelerometerMeanZ"                   "TimeGravityAccelerometerStdX"                   
[11] "TimeGravityAccelerometerStdY"                    "TimeGravityAccelerometerStdZ"                   
[13] "TimeBodyAccelerometerJerkMeanX"                  "TimeBodyAccelerometerJerkMeanY"                 
[15] "TimeBodyAccelerometerJerkMeanZ"                  "TimeBodyAccelerometerJerkStdX"                  
[17] "TimeBodyAccelerometerJerkStdY"                   "TimeBodyAccelerometerJerkStdZ"                  
[19] "TimeBodyGyroscopicMeanX"                         "TimeBodyGyroscopicMeanY"                        
[21] "TimeBodyGyroscopicMeanZ"                         "TimeBodyGyroscopicStdX"                         
[23] "TimeBodyGyroscopicStdY"                          "TimeBodyGyroscopicStdZ"                         
[25] "TimeBodyGyroscopicJerkMeanX"                     "TimeBodyGyroscopicJerkMeanY"                    
[27] "TimeBodyGyroscopicJerkMeanZ"                     "TimeBodyGyroscopicJerkStdX"                     
[29] "TimeBodyGyroscopicJerkStdY"                      "TimeBodyGyroscopicJerkStdZ"                     
[31] "TimeBodyAccelerometerMagnitudeMean"              "TimeBodyAccelerometerMagnitudeStd"              
[33] "TimeGravityAccelerometerMagnitudeMean"           "TimeGravityAccelerometerMagnitudeStd"           
[35] "TimeBodyAccelerometerJerkMagnitudeMean"          "TimeBodyAccelerometerJerkMagnitudeStd"          
[37] "TimeBodyGyroscopicMagnitudeMean"                 "TimeBodyGyroscopicMagnitudeStd"                 
[39] "TimeBodyGyroscopicJerkMagnitudeMean"             "TimeBodyGyroscopicJerkMagnitudeStd"             
[41] "FrequencyBodyAccelerometerMeanX"                 "FrequencyBodyAccelerometerMeanY"                
[43] "FrequencyBodyAccelerometerMeanZ"                 "FrequencyBodyAccelerometerStdX"                 
[45] "FrequencyBodyAccelerometerStdY"                  "FrequencyBodyAccelerometerStdZ"                 
[47] "FrequencyBodyAccelerometerJerkMeanX"             "FrequencyBodyAccelerometerJerkMeanY"            
[49] "FrequencyBodyAccelerometerJerkMeanZ"             "FrequencyBodyAccelerometerJerkStdX"             
[51] "FrequencyBodyAccelerometerJerkStdY"              "FrequencyBodyAccelerometerJerkStdZ"             
[53] "FrequencyBodyGyroscopicMeanX"                    "FrequencyBodyGyroscopicMeanY"                   
[55] "FrequencyBodyGyroscopicMeanZ"                    "FrequencyBodyGyroscopicStdX"                    
[57] "FrequencyBodyGyroscopicStdY"                     "FrequencyBodyGyroscopicStdZ"                    
[59] "FrequencyBodyAccelerometerMagnitudeMean"         "FrequencyBodyAccelerometerMagnitudeStd"         
[61] "FrequencyBodyBodyAccelerometerJerkMagnitudeMean" "FrequencyBodyBodyAccelerometerJerkMagnitudeStd" 
[63] "FrequencyBodyBodyGyroscopicMagnitudeMean"        "FrequencyBodyBodyGyroscopicMagnitudeStd"        
[65] "FrequencyBodyBodyGyroscopicJerkMagnitudeMean"    "FrequencyBodyBodyGyroscopicJerkMagnitudeStd" 


To be able to transform the variable names from the original to the above, I had to manually extract and modify
a number of letters or strings, using the command sub as shown below.

Also, in order to get rid of the parentheses, which are not considered a valid descriptive feature of the column
names, I used the command make.names to transform the names to acceptable format. From thereon, using the command
sub it was easier to manipulate the 66 column names, remove '-','.', etc., and expand abbreviations to their full names.
I quote the code I wrote below:


names(T3) <- sub("-","",names(T3))

names(T3) <- make.names(names(T3))

names(T3) <- sub("std..","Std",names(T3))
names(T3) <- sub("mean..","Mean",names(T3))

names(T3) <- sub("n.X","nX",names(T3))
names(T3) <- sub("n.Y","nY",names(T3))
names(T3) <- sub("n.Z","nZ",names(T3))

names(T3) <- sub("d.X","dX",names(T3))
names(T3) <- sub("d.Y","dY",names(T3))
names(T3) <- sub("d.Z","dZ",names(T3))


names(T3) <- sub("tBody","TimeBody",names(T3))
names(T3) <- sub("fBody","FrequencyBody",names(T3))
names(T3) <- sub("tGravity","TimeGravity",names(T3))
names(T3) <- sub("Gyro","Gyroscopic",names(T3))
names(T3) <- sub("Acc","Accelerometer",names(T3))
names(T3) <- sub("Mag","Magnitude",names(T3))

T3Store3 <- names(T3)

TStore <- T3


=========================================
STEP 5: 

5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
for each activity and each subject.

=========================================


# I want to group the T3 data set both by ID and ACTIVITY in order to
# create the proper meaningful framework that computes the average for
# each ID AND ACTIVITY

The value calculated under each column is computed as follows: 
We group our tidydata set by ID and ACTIVITY columns and while the remaining 66 columns shown above now contain 
more than one values each corresponding to an aggregated number of observation that share the same ID and ACTIVITY. 
We then take the mean of these aggregated observations. After that, each of the 66 column variables contains only the
mean values per ID and ACTIVITY of the columns with variables described above.

The code used to produce the tidy data set is the following:

F1 <- group_by(T3,ID,ACTIVITY)

dim(F1): (10299,69)

# Then we summarize each of the remaining variables by taking the mean of all the observations in their group of same
# id and same activity. We use the following command to execute this: 

F1 %>% summarise_each(funs(mean)) -> F2

dim(F2): (180, 69)

Indeed, the final tidy data set F2 contains 180 observations (rows) which makes sense because we have computed the average
values of the experiment variables per single ID and per single ACTIVITY. We have 30 distinct IDs and 6 distinct activities.
Hence 180 = 30 x 6. 

Each observation now contains the mean for each of the 66 experiment variables.

Inevitably the variable Team is also summarized and the mean is calculated, but since this is a constant same number everywhere
it's mean remains the same (either 1 or 2). We keep it there even though it does not have any use for this current
project, but it may get important for any future application and manipulation of this data set.


=========================================

FINAL STEP: Export the Result:

TidyData.txt <- write.table(F2, file="C:/Users/kyriakos/Desktop/COURSERA/tidydata.txt",row.name=FALSE)

=========================================


Below I quote a small portion of the Result, summarized with str function

> str(F2)


Classes ‘grouped_df’, ‘tbl_df’, ‘tbl’ and 'data.frame':	180 obs. of  69 variables:
 $ ID                                             : int  1 1 1 1 1 1 2 2 2 2 ...
 $ ACTIVITY                                       : chr  "LAYING" "SITTING" "STANDING" "WALKING" ...
 $ Team                                           : num  1 1 1 1 1 1 2 2 2 2 ...
 $ TimeBodyAccelerometerMeanX                     : num  0.222 0.261 0.279 0.277 0.289 ...
 $ TimeBodyAccelerometerMeanY                     : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
 $ TimeBodyAccelerometerMeanZ                     : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
 $ TimeBodyAccelerometerStdX                      : num  -0.928 -0.977 -0.996 -0.284 0.03 ...
 $ TimeBodyAccelerometerStdY                      : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
 $ TimeBodyAccelerometerStdZ                      : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...
 $ TimeGravityAccelerometerMeanX                  : num  -0.249 0.832 0.943 0.935 0.932 ...
 $ TimeGravityAccelerometerMeanY                  : num  0.706 0.204 -0.273 -0.282 -0.267 ...
 $ TimeGravityAccelerometerMeanZ                  : num  0.4458 0.332 0.0135 -0.0681 -0.0621 ...
 $ TimeGravityAccelerometerStdX                   : num  -0.897 -0.968 -0.994 -0.977 -0.951 ...
 $ TimeGravityAccelerometerStdY                   : num  -0.908 -0.936 -0.981 -0.971 -0.937 ...
 $ TimeGravityAccelerometerStdZ                   : num  -0.852 -0.949 -0.976 -0.948 -0.896 ...
 $ TimeBodyAccelerometerJerkMeanX                 : num  0.0811 0.0775 0.0754 0.074 0.0542 ...
 $ TimeBodyAccelerometerJerkMeanY                 : num  0.003838 -0.000619 0.007976 0.028272 0.02965 ...
 $ TimeBodyAccelerometerJerkMeanZ                 : num  0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...
 $ TimeBodyAccelerometerJerkStdX                  : num  -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...
 $ TimeBodyAccelerometerJerkStdY                  : num  -0.924 -0.981 -0.986 0.067 -0.102 ...