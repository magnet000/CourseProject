# Analysis explanation

In the script "run_analysis.R" we can find all the steps that have been token in order to get to the tidy data set. The steps are not in the same order as the indications.

## Steps explaining the code
After setting our working directory, we proceed to get the files needed.

```
trainfile <- list.files( "train", full.names = TRUE )[-1]
testfile  <- list.files( "test" , full.names = TRUE )[-1]
```
With this bit of code we made two lists of files correspondinf to the folders where the data is in for both train and test data sets. The [-1] is needed in order to avoid getting the "Inertial Signals" of each data set.

```
files <- c(trainfile, testfile)
data <- lapply(files, read.table, sep="")
```
With this other bit of code we got to read all the files in the lists created before "trainfile" and "testfile".

## Step 1 of the indications
The next step consists on merge the different data sets, by rows, the two objects corresponding for each train and test data set are combined by rows. 

```
data2 <- mapply(rbind, data[c(1:3)], data[c(4:6)])
```
It has been used the "mapply" function because the data was in a huge list, so to apply a function to objects that are inside a list, you can use mapply. 
The "rbind" function binds the bits of data set by rows. We end up with a large data set that already contains values of train and test.

The next step is to combine the three data frames (three because the subject column and activity column were in different files).
```
DT <- do.call(cbind, data)
```
What cbind does is combine the three data frames by columns, each object of the list is a column in the final data set.
Now we have a large data set that contains both values of test and train data sets and also all the variables like subject and activity.

## Step 4 of the indications
The next step consists on getting the names and place them in the merged data frame for the feature variables, as they are in a different file:

```
fnames <- read.table("/Users/IMAN/Desktop/UCI HAR Dataset/features.txt", header = F, stringsAsFactors = F)

DT <- data.table::setnames(DT,c(1:563), c("subject", fnames$V2, "activity"))
```
As you can see, I first got the names that were in the "features" file, and then with the "setnames" function I inserted the names into the data frame. The first columns corresponds to the subject number so I wrote it down, for the columns 2 to 262 the names are provided by the "fnames" object and the 563rd row corresponds to the "activity" captured.

## Step 2 of the indications
Now that all the variables have their respective names, we will proceed to subset the mean and standard deviation variables for the measurments which was the required for the course.
```
DT2 <- DT[,c(1,grep("mean\\(\\)|std", names(DT)),563)]
```
With this bit of code, we create a subset where its columns have either mean() or std() in the name. You have to use the \\(\\) for the mean bit because there are some variables called meanFreq() that we are not interested in and simply typing "mean" would also get the meanFreq() variables. 

## Step 3 of the indications
Next step is to use descriptive names to name the different activities to the "activity" variable as originally they are expressed as numbers.
I'll use the recode function to match every number to its respective activity as the "anames" object shows (the activity names were also in a different file).
```
anames <- read.table("/Users/IMAN/Desktop/UCI HAR Dataset/activity_labels.txt", header = F)
anames
DT2$activity <- car::recode(DT2$activity, 
                            '1= "walking";
                            2= "walking_upstairs";
                            3= "walking_downstairs";
                            4= "sitting";
                            5= "standing";
                            6= "laying"', as.factor=T)
```
With this part of the code you get your variable "activity" to be a factor rather than an integer and also you transform each of the values to their respective activity.

## Step 5
The final step is to create a new tidy data set with the avarage of each variable for each activity and each subject. 
So the tidy set that is provided is not the original values, but the average for each of the columns grouped by the activity and the subject, that can be achieved with the following bit of code:

```
library(dplyr)
DTN <- DT2 %>% group_by(subject, activity) %>% summarise_at(-(1:3),mean,na.rm = T)
```
With this we get our final tidy data set.
