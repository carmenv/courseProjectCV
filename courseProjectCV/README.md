## How the code works

The code requires the folders train and test with the X, y, subject and activity files to be in the same path.
The script first load the train files (X,y,subject,activity) using the cbind function. It does the same for the test files. Next, it puts together both files using rbind.
For the second requirement, I’ve used the names of the features and using a regular function, I have extracted the positions of the features containing the words “mean” or “std”. 
Using merge, I have replaced the code of the Activity with their respective names given in the file activity labels.
To assign meaningful names I have replaced the t with time and the f with frequency in the feature columns. I have also replace the parenthesis and I have used camelCase plus periods to separate the name of the feature from the axis (XYZ)

It is required the plyr package to use the aggregate function
The script returns the tidyData with the average of each column by Subject and Activity

## CodeBook
The source data for these data set was taking from experiments than have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope,acceleration and  angular velocity has been captured. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. In our dataset we have put together the train and the test dataset.

Column1: Subject: Number of the individual performing the experiment
Column2: Activity: 6 different values describing the activity executed: LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS

Columns3-88:
Report the average calculated grouping the measurements of all the experiments by Subject and Activity 
Variables “timeBodyAcc”, report the Acceleration in different axis (X,Y,Z) The axis is included in the name


These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean