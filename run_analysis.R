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

nTrain <- as.vector(t(features[2]))

nLabels <- as.vector(actLabels[2])
nLabels <- t(nLabels)
# nLabels <- cat(nLabels)

colnames(xTrain) <- nTrain
colnames(xTest) <- nTrain


# if we check the dimensions of xTrain-xTest before and after, I
# find out that the column numbers have been reduced from 561 to 477.
# So, there were duplicates.

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


# Taking care of step 2 before step 1 to handle issues
# of memory limitation and size. Will first reduce the 
# size of xTrain and xTest, and then will proceed to making
# a single data unit out of combining these.

# We need to reduce the number of columns of xTrain and XTest
# to extract these columns only related to the computation of
# mean and std. 
#Tested for "Std" and no entry in the names of 
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


# STEP 3

# I change the name in each of the data sets yTrain and yTest that contain 
# the numbers of activities.

for (i in 1:length(nLabels)) T3[3][T3[3]==i] <- nLabels[i]


# STEP 4
T3Store <- names(T3)

names(T3) <- sub("-","",names(T3))

names(T3) <- make.names(names(T3))

T3Store1 <- names(T3)

names(T3) <- sub("std..","Std",names(T3))
names(T3) <- sub("mean..","Mean",names(T3))

names(T3) <- sub("n.X","nX",names(T3))
names(T3) <- sub("n.Y","nY",names(T3))
names(T3) <- sub("n.Z","nZ",names(T3))

names(T3) <- sub("d.X","dX",names(T3))
names(T3) <- sub("d.Y","dY",names(T3))
names(T3) <- sub("d.Z","dZ",names(T3))

T3Store2 <- names(T3)

names(T3) <- sub("tBody","TimeBody",names(T3))
names(T3) <- sub("fBody","FrequencyBody",names(T3))
names(T3) <- sub("tGravity","TimeGravity",names(T3))
names(T3) <- sub("Gyro","Gyroscopic",names(T3))
names(T3) <- sub("Acc","Accelerometer",names(T3))
names(T3) <- sub("Mag","Magnitude",names(T3))

T3Store3 <- names(T3)

TStore <- T3

# STEP 5

# I want to group the T3 data set both by ID and ACTIVITY in order to
# create the proper meaningful framework that computes the average for
# each ID AND ACTIVITY

F1 <- group_by(T3,ID,ACTIVITY)

dim(F1)

F1 %>% summarise_each(funs(mean)) -> F2

dim(F2)


TidyData.txt <- write.table(F2, file="C:/Users/kyriakos/Desktop/COURSERA/tidydata.txt",row.name=FALSE)



