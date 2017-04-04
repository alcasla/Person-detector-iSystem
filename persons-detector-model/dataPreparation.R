#Data reading
workingDirectory = getwd()
trainBackgroung = paste(workingDirectory, "/data/featuresBackgroundTra.csv", sep="")
trainPedestrians= paste(workingDirectory, "/data/featuresPedestriansTra.csv", sep="")
testBackground  = paste(workingDirectory, "/data/featuresBackgroundTst.csv", sep="")
testPedestrians = paste(workingDirectory, "/data/featuresPedestriansTst.csv", sep="")
rm(workingDirectory)

trainBackgroung = read.csv2(trainBackgroung, sep=",", header=FALSE);
    colnames(trainBackgroung) =paste("ft",1:dim(trainBackgroung)[2])
trainPedestrians = read.csv2(trainPedestrians, sep=",", header=F);
    colnames(trainPedestrians) =paste("ft",1:dim(trainPedestrians)[2])
testBackground = read.csv2(testBackground, sep=",", header=F);
    colnames(testBackground) =paste("ft",1:dim(testBackground)[2])
testPedestrians = read.csv2(testPedestrians, sep=",", header=F);
    colnames(testPedestrians) =paste("ft",1:dim(testPedestrians)[2])

#Generate joint of training sets and attach class column
train = rbind(trainBackgroung,trainPedestrians)
    class = matrix(nrow=dim(train)[1], 0)
    class[(dim(trainBackgroung)[1]+1):length(class)] = 1
  train = cbind(train, class)
test = rbind(testBackground,testPedestrians)
    class = matrix(nrow=dim(test)[1], 0)
    class[(dim(testBackground)[1]+1):length(class)] = 1
  test = cbind(test, class)

#save data in files
write.table(train, 'data/train.csv', sep=',', row.names=F)
write.table(test, 'data/test.csv', sep=',', row.names=F)

