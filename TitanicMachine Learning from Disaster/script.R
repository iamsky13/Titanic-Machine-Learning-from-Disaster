#load train data
train <- read.csv("train.csv", header = TRUE)

#load test data
test <- read.csv("test.csv", header = TRUE)


#Since train has one variable more than test i.e. Survived, I created a new variable test.survived and added new variable/column Survived with default value None
#rep replicates None value for total no. of rows in test and combined it with test data frame to make new data frame test.survived
test.survived <- data.frame(Survived = rep("NONE",nrow(test)),test[,])