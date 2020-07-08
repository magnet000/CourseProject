# FINAL PROJECT "Getting and cleaning data" 

setwd("/Users/IMAN/Desktop/UCI HAR Dataset")

## We get all the files within test and train except of the internal signals.

trainfile <- list.files( "train", full.names = TRUE )[-1]
testfile  <- list.files( "test" , full.names = TRUE )[-1]

## To read them we will use read.table function and lapply

files <- c(trainfile, testfile)

data <- lapply(files, read.table, sep="")

View(data)

## In the following part of script we will bind the rows for both train and set different data frames (there's 3 data frames for both train and set), we will get
### 3 data frames that we would then merge by columns.

data <- mapply(rbind, data[c(1:3)], data[c(4:6)])

View(data)

## Now using cbind() we can merge de two of the data frames and we will get 1:
DT <- do.call(cbind, data)

## We can explore a bit our final data set, we have 425422 observations and 563 variables.
str(DT)

## Now we can set the names for the variables (step 4 of the course project), we know that:
###Column 1 is subject, columns 2 to 562 are the features and column 563 is the index that corresponds to some activity.
###We first read the text that contains the names for features

fnames <- read.table("/Users/IMAN/Desktop/UCI HAR Dataset/features.txt", header = F, stringsAsFactors = F)

DT <- data.table::setnames(DT,c(1:563), c("subject", fnames$V2, "activity"))

View(DT)

## Now that all the feature variables have their respective names, we will proceed to subset the mean and 
### standard deviation variables for the measurments.

DT2 <- DT[,c(1,grep("mean\\(\\)|std", names(DT)),563)]
View(DT2)

## Next step is to use descriptive names to name the different activities to the "activity" variable.
### I'll use the recode function to match every number to its respective activity as the "anames" object shows.

anames <- read.table("/Users/IMAN/Desktop/UCI HAR Dataset/activity_labels.txt", header = F)
anames
DT2$activity <- car::recode(DT2$activity, 
                            '1= "walking";
                            2= "walking_upstairs";
                            3= "walking_downstairs";
                            4= "sitting";
                            5= "standing";
                            6= "laying"', as.factor=T)

summary(DT2$activity)


## The final step is to create a new tidy data set with the avarage of each variable for each activity and each subject.
library(dplyr)
DTN <- DT2 %>% group_by(subject, activity) %>% summarise_at(-(1:3),mean,na.rm = T)

View(DTN)

write.table(DTN, file="tidy_dataset.txt", row.names = FALSE)


