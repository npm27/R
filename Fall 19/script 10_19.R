####Setup####
dat = read.csv("data_9_28.csv")
summary(dat)

#rename columns
colnames(dat)[1] = "SubID"

summary(dat)

View(dat)

##Using basic functions
##descriptives
mean(dat) #this won't work. We need to denote the columns
mean(dat$Exam)
sd(dat$Exam)

m1 = mean(dat$Exam)
min(dat$Anxiety)

max(dat$Anxiety)

##chance object class
dat$SubID = as.character(dat$SubID)
mean(dat$SubID)

####Learn to Install a package####
#to install a package, you'll need to run the install.package function
#once you have it, call the library

install.packages("psych") #only run this once if you don't already have the package installed

library(psych) #run this at the start of each session

#use this instead of summary because it is better!
describe(dat)

####Missing Data####
missing = read.csv("data_10_12.csv")

describe(missing) #doesn't tell us what we are missing

summary(missing)

##take the mean
mean(missing$Exam_1) #won't work
mean(missing$Exam_1, na.rm = TRUE)
sd(missing$Final, na.rm = T) #capital T also works

#remove NAs
nomiss = na.omit(missing)

##subsetting!
sub1 = subset(nomiss,
              nomiss$Final > 75) #greater
sub2 = subset(nomiss,
              nomiss$Final <= 75) #less than or equal
sub3 = subset(nomiss,
              nomiss$Final == 75) #exactly equal
sub4 = subset(nomiss,
              nomiss$Final > 50 & nomiss$Final < 75) #between the two points
sub5 = subset(nomiss,
              nomiss$Final > 50 | nomiss$Final < 75) #outside the two points

#| = OR, & = AND

##Crosstabbing
#we crosstab with tapply (T-APPLY, NO TAPPLY)
tapply(dat$Exam,
       dat$Gender, mean)
tapply(dat$Exam,
       dat$Gender, sd)
tapply(missing$Midterm,
       missing$Group, mean)
tapply(missing$Midterm,
       missing$Group, mean, na.rm = TRUE)


