% train model for trainset
function [OCSVMModel_train,misclassification_rate,outlierRate] = TrainModel_OCSVM(dataset, label,KernelFunction,OutlierFraction)

rng(0);
OCSVMModel_train = fitcsvm(dataset,label,'Standardize',true,...
    'KernelScale','auto','KernelFunction',KernelFunction,...
    'OutlierFraction',OutlierFraction);

% Crossvalidation
CVSVMModel = crossval(OCSVMModel_train);
% Estimate the out-of-sample misclassification rate.
misclassification_rate = kfoldLoss(CVSVMModel);
[~,scorePred] = kfoldPredict(CVSVMModel);
outlierRate = mean(scorePred<0);
