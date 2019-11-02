####Let's learn how to graph things!####
##setup
library(memisc)

#we use memisc to read spss files
chickdata = as.data.set(spss.system.file("c4 ChickFlick.sav")) #reads it in as a data set

#lets turn it into a dataframe so its actually useful
chickdata = as.data.frame(chickdata)

####factoring variables####
##make some fake data
notfactor = rep(1:3, 50) #repeat function makes a string/character/number repeat
table(notfactor)

factored = factor(notfactor, 
                  levels = c(1,2,3), 
                  labels = c("swiss", "feta", "gouda"))
table(factored)

####reshaping data####
cricket = read.csv("c4 Jiminy Cricket.csv", header=TRUE)
summary(cricket)

colnames(cricket)[1] = "ID"
summary(cricket)

library(reshape)

##wide to long
longcricket = melt(cricket, 
                   id = c("ID", "Strategy"), 
                   measured = c("Success_Pre", "Succcess_Post"))

summary(longcricket)

##create the blank plot
##notice for a histogram, AES only has ONE variable
crickethist = ggplot(cricket, aes(Success_Pre))

#now fill in the plot
crickethist +
  geom_histogram(binwidth = 5, 
                 color = "green", 
                 fill = "blue") +
  xlab("Success Pre Test") + 
  ylab("Frequency")

#get rid of the stuff in the background
source("cleanup.R") #source reads in objects from a different R script in the directory

crickethist +
  geom_histogram(binwidth = 5, 
                 color = "green", 
                 fill = "blue") +
  xlab("Success Pre Test") + 
  ylab("Frequency") +
  cleanup

##import data for scatterplot
exam = read.csv("c4 Exam Anxiety.csv", header=TRUE)

##gender has to be factored before we can use it in our plot
exam$Gender = factor(exam$Gender,
                     levels = c(1,2),
                     labels = c("Male", "Female"))

####simple scatter plot####
##AES has X axis, Y axis
scatter = ggplot(exam, aes(Anxiety, Exam)) #first just set up a blank plot

#now fill in the plot
scatter +
  geom_point() +
  xlab("Anxiety Score") +
  ylab("Exam Score") +
  cleanup

####simple scatter with regression line####
scatter +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "indianred4") +
  xlab("Anxiety Score") +
  ylab("Exam Score") +
  cleanup

####grouped scatter plot###
##AES has X axis, Y axis, color/fill are the legend
scatter2 = ggplot(exam, aes(Anxiety, Exam, color = Gender, fill = Gender)) #makes blank plot

scatter2 +
  geom_point() +
  geom_smooth(method = "lm") +
  xlab("Anxiety Score") +
  ylab("Exam Score") +
  cleanup + 
  #scale_fill_manual(name = "Gender of Participant",
   #                 labels = c("Men", "Women"),
  #                  values = c("green", "dodgerblue")) +
  scale_color_manual(name = "Gender of Participant",
                     labels = c("Men", "Women"),
                     values = c("red", "dodgerblue"))

####Bar Charts Start here!####
chick = chickdata

#chick$gender = factor(chick$gender, 
#                      levels = c(1,2), 
#                      labels = c("Men", "Women"))

#chick$film = factor(chick$film,
#                    levels = c(1,2),
#                    labels = c("Bridget Jones", "Memento"))

####bar charts with one variable####
##AES has X axis (categorical), Y axis (continuous)
chickbar = ggplot(chickdata, aes(film, arousal))

chickbar + 
  stat_summary(fun.y = mean, 
               geom = "bar", 
               fill = "White", 
               color = "Black") +
  stat_summary(fun.data = mean_cl_normal, 
               geom = "errorbar", 
               width = .2, 
               position = "dodge") +
  cleanup +
  xlab("Movie Watched by Participants") +
  ylab("Arousal Level") +
  scale_x_discrete(labels = c("Girl Film", "Guy Film"))

####bar chart two independent variables####
##AES has X axis (categorical), Y axis (continuous), fill legend (categorical)
chickbar2 = ggplot(chickdata, aes(film, arousal, fill = gender))
chickbar2 +
  stat_summary(fun.y = mean,
               geom = "bar",
               position = "dodge") +
  stat_summary(fun.data = mean_cl_normal,
               geom = "errorbar", 
               position = position_dodge(width = 0.90),
               width = .2) +
  xlab("Film Watched") +
  ylab("Arousal Level") + 
  cleanup +
  scale_fill_manual(name = "Gender of Participant", 
                    labels = c("Boys", "Girls"),
                    values = c("cadetblue4", "Gray"))
