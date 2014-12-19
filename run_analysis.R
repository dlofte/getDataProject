<<<<<<< HEAD
setwd("~/R/getdata/getDataProject")
=======
setwd("~/R/getdata/project")
>>>>>>> origin/master

# Reading the unzipped data.  
xTest <- read.table("./UCI HAR Dataset//test/X_test.txt", sep="")
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt", sep="")
subTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep="")

xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", sep="")
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", sep="")
subTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep="")

# Putting the data together, first we column bind the xtest, ytest into test and xtrain, ytrain into train data.
# Then we will row bind test and train.

test<- cbind(xTest, yTest,subTest)
train <- cbind(xTrain, yTrain, subTrain)

rawdata <- rbind(train, test)

# subsetting rawdata for features with "mean" or "std" in their name, note I choose excluded the features with "meanFreq" 
# in the name as it was a weighted average where I am unsure of how it was wieghted.

ms_cols <-c(1:6,41:46,81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 
             345:350,  424:429,  503:504, 516:517, 529:530, 542:543, 555:561, 562, 563 )
data <-rawdata[,ms_cols]

summary(data)
head(data)

# Now we are going to give descriptive names to the coded activity labels from the original y data sets.

data[data[,74] == 1,74]  <- "walking"
data[data[,74] == 2,74]  <- "walkindatagUp"
data[data[,74] == 3,74]  <- "walkingDown"
data[data[,74] == 4,74]  <- "sitting"
data[data[,74] == 5,74]  <- "standing"
data[data[,74] == 6,74]  <- "laying"

# The following code should rename the variable names from V1, V2 to something more descriptive.
# Using a powerful text editor (notepade++)I found all the feature names in features.txt including the the word "mean" and "std",
# and excluded meanFreq.  I saved the list of features as a txt file "vnames.txt"  I read it in as a table and grabbed all the names
# from the 4th column which is the name given for each column by the original researchers.  If you investigate vnames.txt you will 
# see that I did some minor editting.  Each name that ends with mean included an "()" which I have edited out.
vnames <- read.table("vnames.txt", header = F)
head(vnames)
tail(vnames)

names(data) <- vnames[,4]
  #("tBodyAcc_mean_X", "tBodyAcc_mean_Y", "tBodyAcc_mean_Z", "tGravityAcc-mean()-X", "tGravityAcc-mean-Y",
   #              "tGravityAcc-mean-Z", "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z")
summary(data)


## We use melt along with dcast to form tidy data.  We select "SubjectID" and "Activity" is ID variables and use melt to create 
## dataMelt.  Using dcast on dataMelt we find the mean of all variables broken down by SubjectId and Activity.  We save the result as 
## tidyData

library(reshape2)

dataMelt <- melt(data, id = c("SubjectID", "Activity"))
head(dataMelt)
tidyData <- dcast(dataMelt, SubjectID + Activity ~ variable, mean)



