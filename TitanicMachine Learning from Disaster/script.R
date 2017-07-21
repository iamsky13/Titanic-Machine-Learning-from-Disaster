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

#checking if there is two person of same name and yeah two names are repeated
length(unique(combine.data$Name))
