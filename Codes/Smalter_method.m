function [A_Precision_test, A_Recall_test, A_Fmeasure_test,...
                    A_Precision_validation, A_Recall_validation, A_Fmeasure_validation,...
                    xlRange2,outlierRateV,B_perc_tt,B_perc_tv]=...
                    Smalter_method(ScaledUdata, ScaledTrain, k, v, MethodParam, OutlierFraction)

if (strcmp(MethodParam,'RBF')== 1)
    xlRange2 = 'A5';
    MethodParam = 'RBF';
    KernelFunction = 'RBF';
else 
    if(strcmp(MethodParam,'LINEAR')== 1)
        xlRange2 = 'A6';
        MethodParam = 'LINEAR';
        KernelFunction = 'LINEAR';
    end
end

%% Blance number of each class
mi = min(size(ScaledTrain,1),size(ScaledUdata,1));
ma = max(size(ScaledTrain,1),size(ScaledUdata,1));

m = mi/ma;

if(size(ScaledTrain,1)> size(ScaledUdata,1))
[ScaledTrain,~,ScaledTrainLabels]  = sepratedata(ScaledTrain,m);
ScaledUdata = ScaledUdata(:,1:end-1);
ScaledUdataLabels = ones(size(ScaledUdata,1),1)*3;
else
[ScaledUdata,~,ScaledUdataLabels]  = sepratedata(ScaledUdata,m);
ScaledTrain = ScaledTrain(:,1:end-1);
ScaledTrainLabels = ones(size(ScaledUdata,1),1)*2;
end

ScaledTrain = [ScaledTrain,ScaledTrainLabels ; ScaledUdata,ScaledUdataLabels];

%% separate data to train/test
[trainset,testset, trainlabels, testlabels, validationset_test, validationlabels_test] =...
    Separate_Data(ScaledTrain,k,v);

B_N_trainset = size(trainset,1);
B_N_testset = size(testset,1);
B_N_validationset_test = size(validationset_test,1);

B_perc_tt = (B_N_testset/B_N_trainset)*100;

%% TRAIN MODEL
[SVMModel_train,misclassification_rate,outlierRate] = TrainModel_OCSVM(trainset, trainlabels,KernelFunction,OutlierFraction);

%% TEST MODEL
[testpredict_label,testscore] = predict(SVMModel_train,testset);
%% Evaluation 
[A_Precision_test, A_Recall_test, A_Fmeasure_test] = ...
    Evaluation_binary(testlabels, testpredict_label);

%% Validation Phase
validationset = [trainset;testset];
validationlabels = [trainlabels;testlabels];

B_N_validationset = size(validationset,1);
B_perc_tv = (B_N_validationset_test/B_N_validationset)*100;

[SVMModel_validation,misclassification_rateV,outlierRateV] = TrainModel_OCSVM(validationset, validationlabels,KernelFunction,OutlierFraction);% 0.01

[validationpredict_label,validationscore] = predict(SVMModel_validation,validationset_test);

[A_Precision_validation, A_Recall_validation, A_Fmeasure_validation] = ...
    Evaluation_binary(validationlabels_test, validationpredict_label);

 Diff_per = A_Precision_validation - A_Precision_test;
 Diff_rec = A_Recall_validation - A_Recall_test;
 Diff_F = A_Fmeasure_validation - A_Fmeasure_test;
