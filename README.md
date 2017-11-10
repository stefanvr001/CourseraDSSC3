#################################################

Getting and Cleaning Data Course Projectless 


###########################

DESCRIPTION OF RUN_ANALYSIS.R

###########################

1) IMPORTED TRAIN MEASUREMENTS, PARTICIPANT ID AND ACTIVITY ID. 3 IMPORTS ARE THE COMBINED.
2) IMPORTED TEST MEASUREMENTS, PARTICIPANT ID AND ACTIVITY ID. 3 IMPORTS ARE THE COMBINED.
3) TEST AND TRAIN DATASETS ARE THEN MERGED, BUT BEFPORE BEING MERGED A FIELD CONTAINING "TEST" OR "TRAIN" TO TRACE FROM WHICH SET THE ENTRY WAS ORIGINALLY OBTAINED. 
4) COLUMNS CONTAINING "MEAN()" AND "STD()" WERE IDENTIFIED AND RETAINED IN A NEW DATAFRAME.
5) SOME SLIGHT CHANGES WERE MADE TO THE NAMES OF THE COLUMNS TO MAKE IT "EASIER" ON THE EYES.
6) ANOTHER DATAFRAME WAS CREATED AVERAGING THE COLUMNS USING SQLDF AND GROUPING BY PARTICIPANT ID AND ACTIVITY.


###########################

ORIGINAL INPUT OF THE DATA INTO THE RUN_ANALYSIS.R IS THE RAW DATA FROM THE "HUMAN ACTIVITY RECOGNITION USING SMARTPHONES DATASET VERSION 1.0"

"Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto."
"Smartlab - Non Linear Complex Systems Laboratory"
"DITEN - Università degli Studi di Genova."
"Via Opera Pia 11A, I-16145, Genoa, Italy."
"activityrecognition@smartlab.ws"
"www.smartlab.ws"

ORIGINAL EXTRACT:

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. "


- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.  "
