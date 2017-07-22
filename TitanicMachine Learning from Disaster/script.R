#load train data
train <- read.csv("train.csv", header = TRUE)

#load test data
test <- read.csv("test.csv", header = TRUE)

#Since train has one variable more than test i.e. Survived, I created a new variable test.survived and added new variable/column Survived with default value None
#rep replicates None value for total no. of rows in test and combined it with test data frame to make new data frame test.survived
test.survived <- data.frame(Survived = rep("NONE", nrow(test)), test[,])

#Our both test.Survived and train has same variables we combine them both
combine.data <- rbind(train, test.survived)

#According to definition of Kaggle Pclass is Ticket class that gives socio economic status so it should not be integer you can check its structure using str(combine.data)
combine.data$Pclass <- as.factor(combine.data$Pclass)

#changed data type of survived as well according to kaggle also chr data type is not prefered in ML
combine.data$Survived <- as.factor(combine.data$Survived)

#gives total number of death, number of who survived and no. that is unknown 
table(combine.data$Survived)

#gives total no. of passengers in each class 
table(combine.data$Pclass)

#visualisation is always better than data only
#install package ggplot2


#load library
library(ggplot2)

#we can use our common sense, first class passenger might have higher survival rate because they might get room higher up in the ship and that make you close to life boat just to make sure
#since we can say passengers survived or not we must use training data sets
#we change datatype of Pclass (same previous reason) 
train$Pclass <- as.factor(train$Pclass)
#you can check structure using str(train)

#plot graph
ggplot(train, aes(x = Pclass, fill = factor(Survived))) +
geom_bar(width = 0.5) +
xlab("Pclass") +
ylab("count") +
labs(fill = "Pclassss")

#check structure of train data set Name is labeled as factor and from description of kaggle it should be char
train$Name <- as.character(train$Name)

#checking if there is two person of same name just to check if there are duplicate names and yeah two names are repeated 
length(unique(combine.data$Name))

#find duplicate name and save it as vector
dup.name <- as.character(combine.data[which(duplicated(as.character(combine.data$Name))),"Name"])

#to know if they are different people with same name or its just duplicate records
combine.data[which(combine.data$Name %in% dup.name),]
#they are different people with same name

#load library
library(stringr)

#make a new data frame from those rows that has Miss in the name
misses <- combine.data[which(str_detect(combine.data$Name, "Miss.")),]
#to see first 5 rows
misses[1:5,]

#similarly Mrs in the name
mrses <- combine.data[which(str_detect(combine.data$Name, "Mrs.")),]
mrses[1:5,]

#for graphical display
#extract Mr. Miss. Mrs etc
extractTitle <- function(name) {
name<-as.character(name)
if (length(grep("Miss.", name)) > 0) {
    return("Miss.")
}
if (length(grep("Mr.", name)) > 0) {
    return("Mr.")
}
if (length(grep("Mrs.", name)) > 0) {
    return("Mrs.")
}
if (length(grep("Master.", name)) > 0) {
    return("Master.")
}
else {
return("Other")
}
}

titles <- NULL

#extract Title and add its value to new column in combine.data
for (i in 1:nrow(combine.data)) {
titles <- c(titles,extractTitle(combine.data[i,"Name"]))
}

combine.data$Titles <- as.factor(titles)

#create graphical diagram
#Titles vs number with survived and death grouped by class ticket
ggplot(combine.data[1:891,], aes(x = Titles, fill = Survived)) +
geom_bar(width = 0.5) +
facet_wrap(~Pclass) +
xlab("Titles") +
ylab("number") +
labs(fill = "Survived")


#create graphical diagram
#sex vs number with survived and death grouped by class ticket
ggplot(combine.data[1:891,], aes(x = Sex, fill = Survived)) +
geom_bar(width = 0.5) +
facet_wrap(~Pclass) +
xlab("Sex") +
ggtitle("Pclass")+
ylab("number") +
labs(fill = "Survived")

#to see if all data are available
Summary(combine.data$Age)

#to see unavailable data in training set
summary(combine.data[1:891,"Age"])



#create graphical diagram
#sex vs number with survived and death grouped by class ticket
ggplot(combine.data[1:891,], aes(x = Age, fill = Survived)) +
geom_histogram(binwidth =10) +
facet_wrap(~Sex + Pclass) +
xlab("age") +
ggtitle("Pclass") +
ylab("number") +
labs(fill = "Survived")


#for children
boys <- combine.data[which(combine.data$Titles == "Master."),]

#to check min amd max age
summary(boys$Age)

