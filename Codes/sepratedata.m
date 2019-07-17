function [trainset,testset, trainlabels, testlabels] = sepratedata(data,k)

% k shows the precentage of the size of training samples
n = size(data,1);
ntrain = floor(k*n);

trainind = randperm(n,ntrain);

trainset =  data(trainind,1:end-1);
trainlabels = data(trainind,end);
testset = data(setdiff([1:n],trainind),1:end-1);
testlabels = data(setdiff([1:n],trainind),end);