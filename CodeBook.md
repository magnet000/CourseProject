# Code Book

## About the original data

You can get to the original data in this following link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The data set includes information about 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz of different activities using a smartphone. These features were captured using accelerometers and gyroscopes that are implemented on the smartphones. 

For each of the signals captured they calculated a set of variables:

1. mean(): Mean value
2. std(): Standard deviation
3. mad(): Median absolute deviation 
4. max(): Largest value in array
5. min(): Smallest value in array
6. sma(): Signal magnitude area
7. energy(): Energy measure. Sum of the squares divided by the number of values. 
8. iqr(): Interquartile range 
9. entropy(): Signal entropy
10. arCoeff(): Autorregresion coefficients with Burg order equal to 4
11. correlation(): correlation coefficient between two signals
12. maxInds(): index of the frequency component with largest magnitude
13. meanFreq(): Weighted average of the frequency components to obtain a mean frequency
14. skewness(): skewness of the frequency domain signal 
15. kurtosis(): kurtosis of the frequency domain signal 
16. bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Furthermore, they provide also a file containing what activity corresponds to each measurement and also a file containing the features names (name of each of the variables, 16 variables per signal)

It has to be said that this data consists on two different data sets that need to be merged (the test data set and the train data set).

## About the tidy data set

For this project we used the variables that calculated the mean (mean()) and standard deviation() only, for each of the signals once the two data sets are merged.

In the final data set the variables are the average of each of the variables especified above grouped by each subject and each activity (for example, for every particular signal, the average of all the the means for "walking" activity and subject number 1, and so forth).

So, for example, more detailed, if we take the variable "tBodyAcc-std()-X", which is the standard deviation of the time captured for body accelaration in direction X, each row of this variable corresponds to the mean of that variable but grouped by an activity and a subject. So the first row for that variable is subject "1" and activity "standing", so the value in that cell corresponds to the mean of all the standard deviations of the signals that were captured for subject "1" and the activity "standing".
