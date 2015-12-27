==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================

The script run_analysis.R serves in transforming the data contained in a variety of data sets provided
for this project, in the directory UCI HAR Dataset, and producing a tidy data set with only a selected
number of columns whose names have been modified according to the project requirements, which calculates
the averages of these important remaining columns per subject and per project.
======================================

We inherit all the data sets provided in UCI HAR Dataset.

Those that we use for the generation of our own data set are quoted below.

=========================================

   DATA SETS PROVIDED:::

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample, 
   with the volunteer team belonging to the "train discipline". Its range is from 1 to 30. 

- 'train/subject_test.txt': Each row identifies the subject who performed the activity for each window sample,
   with the volunteer team belonging to the "train discipline". Its range is from 1 to 30. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

=========================================

     DATA SETS GENERATED VIA run_analysis.R for the final submission

My final tidy data set: tidydata.txt contains/makes use of the following variables:

-  subject_train.txt and subject_test.txt stored as subTrain and subTest, where subTrain contains those
   ids/subject that belong to the Train section, while subTest contain those belonging to the Test section.

- subject_train.txt and subject_test.txt transformed as teamTrain and teamTest which are essentially 
  markers of whether any subject belongs to the category 1 (team=Train) or to the category 2 (team=Test).

- y_train.txt and y_test.txt have been transformed as yTrain and YTest. They show which of the 
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

The final tidy data is grouped per subject/id (1-30) and per activity (1-6) in order to: 
1) accommodate the requirement of one observation per row, 2) facilitate the final request: 
the computation of the average value for each variable relevant to a given subject following a given activity.
Therefore, we had to shift from a narrow (long) to a wide data set.

=========================================

The column names, description of the variables, and type of values that populated them follow:

ID
  1:30 { The ids of the subjects (volunteers) that perform the experiments.}

ID is a numeric column.

Team
  1: The subject/id belongs to the Train Sector
  2: The subject/id belongs to the Test Sector

When the two separate datasets get mixed, it may make great sense for certain applications to indicate the 
the team where the subject works.This is a numeric column.


ACTIVITY
   WALKING corresponds to 1
   WaLKING_UPSTAIRS corresponding to 2
   WALKING DOWNSTAIRS corresponding to 3
   SITTING corresponding to 4
   STUDYING  corresponding to 5
   LaYING correspondng to 6.

Activity is a character column (transformed this way from the corresponding number column for the purposes 
of the project). It's formulated from'activity_labels.txt', which links the class labels with their activity name. 
   

The following 66 columns are selected from columns contained in the xTrain (or equivalently xTest) dataset. This subset
contains only the columns that compute the mean and the Standard Deviation ofthe variables pertinent to the Siemens experiment.
Decided not to include MeanFrequency related variables because meanFrequency serves as an alltogether additional variable which
calculates the frequencies experienced in the experiment, but to compute the mean and the std we would neet to calculate: 
mean(meanFrequency) and std(meanFrequency).But these variables do not exist in the xTrain data set, so we do not need to take
them into account. Selecting a subset of columns from xTrain data set that contain mean and std in their names and omitting also 
the MeanFreq related variables for reasons just explained above, we are just left with 66 out of 561 columns (if we were to include 
MeanFreq related variables we would have 79 columns but decided to proceed without considering those). The 66 columns that 
calculate the mean and the std of the experiment variables are quoted below. The original column names can be found in the features.txt
but we have also expanded the names adhering to the rules of a tidy data and deploying these column names to the full meaning of the words
that are abbreviated in features.txt

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
 
The value calculated under each column is computed as follows: 
We group our tidydata set by ID and ACTIVITY columns and while the remaining 66 columns shown above now contain more than one values
each corresponding to an aggregated number of observation that share the same ID and ACTIVITY. We then take the mean of these aggregated
observations as follows: F1 %>% summarise_each(funs(mean)) -> F2
After that, each of the 66 column variables contains only the mean values per ID and ACTIVITY of the columns with variables described above.

The original values in these 66 columns before we group the tidydata set by ID and ACTIVITY and before we take the mean are taken from:
xTrain and xTest datasets. The related information is contained in the readme.txt data set contained in the UCI HAR Dataset and in the
features.txt and features_info.txt files from UCI HAR Dataset.
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
- The units of the Time related variables are: seconds
- The units of the Frequency related variables are: radians/seconds.