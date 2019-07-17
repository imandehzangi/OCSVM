% separate data to train/test
% k shows the precentage of the size of training samples
function [trainset,testset, trainlabels, testlabels, validationset_test, validationlabels_test]=...
    Separate_Data(ScaledTrain,k,v)

n = size(ScaledTrain,1);
ntrain = floor(k*n);

trainind = randperm(n,ntrain);

trainset =  ScaledTrain(trainind,1:end-1);
trainlabels = ScaledTrain(trainind,end);
testset = ScaledTrain(setdiff([1:n],trainind),1:end-1);
testlabels = ScaledTrain(setdiff([1:n],trainind),end);

validationset_test = trainset (1:round(v*size(trainset,1)),:);
validationlabels_test = trainlabels(1:round(v*size(trainset,1)));

trainset = trainset((1+round(v*size(trainset,1))):end,:);
trainlabels = trainlabels((1+round(v*size(trainlabels,1))):end);