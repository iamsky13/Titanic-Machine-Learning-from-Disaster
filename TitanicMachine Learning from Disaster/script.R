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
