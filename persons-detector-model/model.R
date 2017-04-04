#Data reading
train = read.csv2('data/train.csv', sep=",", header=T)
test = read.csv2('data/test.csv', sep=",", header=T)

train = apply(train, MARGIN=2, as.numeric)
train[,6196] = as.factor(train[,6196])
test = apply(test, MARGIN=2, as.numeric)
test[,6196] = as.factor(test[,6196])

require(randomForest)
set.seed(123456)

#-------------- Models with different nTrees
rfModel = randomForest::randomForest(class ~ ., data=train, ntree=5)
plot(rfModel)
prediction = predict(rfModel, newdata=test)
#__________________________________________________________________

rfModel = randomForest::randomForest(class ~ ., data=train, ntree=20)
plot(rfModel)
prediction = predict(rfModel, newdata=test)
#__________________________________________________________________

rfModel = randomForest::randomForest(class ~ ., data=train, ntree=50)
plot(rfModel)
prediction = predict(rfModel, newdata=test)
#__________________________________________________________________

rfModel = randomForest::randomForest(class ~ ., data=train, ntree=100)
plot(rfModel)
prediction = predict(rfModel, newdata=test)
#__________________________________________________________________

#transform output to binary
prediction[which(prediction < 1.5)] = 1
prediction[which(!(prediction < 1.5))] = 2
prediction = as.integer(prediction)

1-length(which(!(test[,6196]==prediction)))/length(prediction)

caret::confusionMatrix(prediction, test[,6196])

#Random Forest Models
# nTrees=5    -  0.95 accuracy
# nTrees=20   -  0.9636364 accuracy
# nTrees=50   -  0.9681818 accuracy
# nTrees=100  -  0.9690909 accuracy

