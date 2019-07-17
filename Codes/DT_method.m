function [A_Precision_test, A_Recall_test, A_Fmeasure_test,...
                    A_Precision_validation, A_Recall_validation, A_Fmeasure_validation,...
                    xlRange2]=...
                    DT_method(ScaledUdata, ScaledTrain, k, v)
xlRange2 = 'A2';
MethodParam = '_';

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
[train_c, train_tree] = TrainModel_DT(trainset, trainlabels);

%% TEST MODEL
[testpredict_label, testscore, test_node, test_cnum] = predict(train_tree, testset);

%% Evaluation 
[A_Precision_test, A_Recall_test, A_Fmeasure_test] = ...
    Evaluation_binary(testlabels, testpredict_label);

%% Validation Phase
validationset = [trainset;testset];
validationlabels = [trainlabels;testlabels];

B_N_validationset = size(validationset,1);
B_perc_tv = (B_N_validationset_test/B_N_validationset)*100;

[validation_c, validation_tree] = TrainModel_DT(validationset, validationlabels);

[validationpredict_label, validation_score, validation_node, validation_cnum] = ...
    predict(validation_tree, validationset_test);

[A_Precision_validation, A_Recall_validation, A_Fmeasure_validation] = ...
    Evaluation_binary(validationlabels_test, validationpredict_label);
