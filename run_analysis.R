
setwd("~/R/getdata/getDataProject")



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


# This next step is out of order but it is what I believe an easier way of getting column names.  I read in the features.txt
# as a table vnames. I then set the 2nd column of vnames as the names of the rawdata.  Lastly I add "activity" and "subjectID"
# as the names of the last two columns which were yTest/Train and subTest/Train.

vnames <- read.table("./UCI HAR Dataset/features.txt", header = F)

names(rawdata)<- vnames[,2]
names(rawdata)[562:563] <- c("activity", "subjectID") 

names(rawdata)
# subsetting rawdata for features with "mean" or "std" in their name, note I choose excluded the features with "meanFreq" 
# in the name as it was a weighted average where I am unsure of how it was wieghted.  I went through the features.txt and
# found the columns by hand.

ms_cols <-c(1:6,41:46,81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 
             345:350,  424:429,  503:504, 516:517, 529:530, 542:543, 555:561, 562, 563 )
data <-rawdata[,ms_cols]


summary(data)
head(data)
names(data)
#  Grabbing the column names to use for the codebook

write.table(names(data), file = "codebook.txt", row.name = F)


# Now we are going to give descriptive names to the coded activity labels from the original y data sets.

data[data[,74] == 1,74]  <- "walking"
data[data[,74] == 2,74]  <- "walkingUp"
data[data[,74] == 3,74]  <- "walkingDown"
data[data[,74] == 4,74]  <- "sitting"
data[data[,74] == 5,74]  <- "standing"
data[data[,74] == 6,74]  <- "laying"




## We use melt along with dcast to form tidy data.  We select "SubjectID" and "Activity" is ID variables and use melt to create 
## dataMelt.  Using dcast on dataMelt we find the mean of all variables broken down by SubjectId and Activity.  We save the result as 
## tidyData

library(reshape2)

dataMelt <- melt(data, id = c("subjectID", "activity"))
head(dataMelt)
tidyData <- dcast(dataMelt, subjectID + activity ~ variable, mean)
head(tidyData)
write.table(tidyData, file = "tidyData.txt", row.name = F)


