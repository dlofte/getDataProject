getDataProject
======================
David Lofte 12/20/2014
======================
For this project we were tasked with tidying up data from the Human Activity Recognition Using Smartphones Dataset.  The original data set was separated in multiple data sets, so our first step was to combine them into a single larger data set.  We then renamed the activity labels from coded values "1", "2", ... into more descriptive names "walking", "walkingup".  The original dataset lacked column names so we added them as well.  I chose to grab the names by reading the features.txt in as a table vnames, then setting the names of the rawdata file(which was the combined data), to the appropriate column of table vnames.  Our professor was only intested in the means and stand deviations of measurements. So I when through features.txt with notepad++ search and found the rows with mean and std.  I later filtered out any row with meanfreq as a feature.  meanfreq was a weighted average, I am not sure why it was weighted or how so I choose to exclude it.  I then used the melt function of reshape2 library to narrow the data using "subjectID" and "activity" as ID variables.  Then using the dcast function  we can see the relationship between subjectID and activity to the means of the mean and standard deviation measurements.  This is our tidy data.  Notice each column of tidy data is one measurement and has a fairly discriptive name ( that is made more clear in the codebook).  Also their are no coded categorical measurements instead the categorical measurements have descriptive labels.  Lastly eachrow is approriately one observation.     
==================================================================
I feel I should include a description of original data:
	The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

	The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.
========================================================================================================
The files/directories found in this repo are:
	-UCI HAR Dataset directory which is the original Human Activity Recognition USing Smartphones Dataset.
	
	-run_analysis.R which handles the tidying up and analysis of the data described above.  Note that run_analysis reads the file in from the UCI HAR Dataset directory.
	
	-.Rhistory an R history file (I used this folder as my working directory
	
	-codebook.txt which gives a further discription of the column/measurement names.
	
	-tidyData.txt  our final tidy data set.
	
	