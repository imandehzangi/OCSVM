function [A_Precision_test, A_Recall_test, A_Fmeasure_test,...
                    A_Precision_validation, A_Recall_validation, A_Fmeasure_validation,...
                    xlRange2,B_perc_tt,B_perc_tv]=...
                    KNN_method(ScaledUdata, ScaledTrain, k, v, Distance, NumNeighbors)
if(NumNeighbors == 3)
    xlRange2 = 'A3';
    MethodParam = 'euclidean, k = 3';
else
    if (NumNeighbors == 5)
        xlRange2 = 'A4';
        MethodParam = 'euclidean, k = 5';
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
Mdl_train = fitcknn(trainset,trainlabels,'NumNeighbors',NumNeighbors,...
    'Distance',Distance);

%% TEST MODEL

[testpredict_label,predict_score_test,predict_cost_test] = predict(Mdl_train,testset);

%% Evaluation 
[A_Precision_test, A_Recall_test, A_Fmeasure_test] = ...
    Evaluation_binary(testlabels, testpredict_label);
%% Validation Phase
validationset = [trainset;testset];
validationlabels = [trainlabels;testlabels];

B_N_validationset = size(validationset,1);
B_perc_tv = (B_N_validationset_test/B_N_validationset)*100;

Mdl_validation = fitcknn(validationset,validationlabels,'NumNeighbors',NumNeighbors,...
    'Distance',Distance);

[validationpredict_label,predict_score_validation,predict_cost_validation] =...
    predict(Mdl_validation,validationset_test);

[A_Precision_validation, A_Recall_validation, A_Fmeasure_validation] = ...
    Evaluation_binary(validationlabels_test, validationpredict_label);

 Diff_per = A_Precision_validation - A_Precision_test;
 Diff_rec = A_Recall_validation - A_Recall_test;
 Diff_F = A_Fmeasure_validation - A_Fmeasure_test;
