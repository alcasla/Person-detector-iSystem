%%
% Data preparation. 
% Dataset reading to extract features, label instances. Objective is
% generate data structure to train and test a model (supervised learning).
% Dataset: INRIA person dataset
%

%full path to dataset folder ('data' in my case) and subpath images inside it
path = 'C:\Users\Alcasla\Universidad\Máster Ciencia de Datos\Extracción de características en imágenes\Prácticas\1 Descriptores\data\';
trainB = [path 'train\background\'];
trainP = [path 'train\pedestrians\'];
testB = [path 'test\background\'];
testP = [path 'test\pedestrians\'];

%save image names from each directory
namTraB = dir(strcat(trainB,'*.png'));
namTraP = dir(strcat(trainP,'*.png'));
namTstB = dir(strcat(testB,'*.png'));
namTstP = dir(strcat(testP,'*.png'));

%Save training image features of backgrounds one by row in a matrix
ftTraB = zeros(numel(namTraB), 6195);
for i = 1:numel(namTraB)
    im = imread(strcat(namTraB(i).folder,'\',namTraB(i).name));
    ftTraB(i,:) = LBP_features(LBPu(im));
end
csvwrite('featuresBackgroundTra.csv', ftTraB);

%Save training image features of pedestrians one by row in a matrix
ftTraP = zeros(numel(namTraP), 6195);
for i = 1:numel(namTraP)
    im = imread(strcat(namTraP(i).folder,'\',namTraP(i).name));
    ftTraP(i,:) = LBP_features(LBPu(im));
end
csvwrite('featuresPedestriansTra.csv', ftTraP);

%Save test image features of backgrounds one by row in a matrix
ftTstB = zeros(numel(namTstB), 6195);
for i = 1:numel(namTstB)
    im = imread(strcat(namTstB(i).folder,'\',namTstB(i).name));
    ftTstB(i,:) = LBP_features(LBPu(im));
end
csvwrite('featuresBackgroundTst.csv', ftTstB);

%Save test image features of pedestrians one by row in a matrix
ftTstP = zeros(numel(namTstP), 6195);
for i = 1:numel(namTstP)
    im = imread(strcat(namTstP(i).folder,'\',namTstP(i).name));
    ftTstP(i,:) = LBP_features(LBPu(im));
end
csvwrite('featuresPedestriansTst.csv', ftTstP);
