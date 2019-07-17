function [A_Precision_test, A_Recall_test, A_Fmeasure_test,...
                    A_Precision_validation, A_Recall_validation, A_Fmeasure_validation,...
                    xlRange2,outlierRateV,B_perc_tt,B_perc_tv] =...
                    OCSVM_method(ScaledTrain, k, v, MethodParam, OutlierFraction)
if (strcmp(MethodParam,'RBF')== 1)
    xlRange2 = 'A9';
    MethodParam = 'RBF';
    KernelFunction = 'RBF';

else 
    if (strcmp(MethodParam,'LINEAR')== 1)
        xlRange2 = 'A10';
        MethodParam = 'LINEAR';
        KernelFunction = 'LINEAR';
    end
end

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

[test_label,test_score, T_test] = TestModel_OCSVM(SVMModel_train,testset);

%% Evaluation 
[A_Precision_test, A_Recall_test,A_Fmeasure_test, A_Sensitivity_test ] = ...
    Evaluation_OCSVM(testset, testlabels, T_test, test_score);

%% Validation Phase
validationset = [trainset;testset];
validationlabels = [trainlabels;testlabels];

B_N_validationset = size(validationset,1);
B_perc_tv = (B_N_validationset_test/B_N_validationset)*100;

[OCSVMModel_validation,misclassification_rateV,outlierRateV] = TrainModel_OCSVM(validationset, validationlabels,KernelFunction,OutlierFraction);

[validation_label, validation_score, T_validation] = ...
    TestModel_OCSVM(OCSVMModel_validation, validationset_test);

[A_Precision_validation, A_Recall_validation, A_Fmeasure_validation, A_Sensitivity_validation ]=...
     Evaluation_OCSVM(validationset_test, validationlabels_test, T_validation, validation_score);

