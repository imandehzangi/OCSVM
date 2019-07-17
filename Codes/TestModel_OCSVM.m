function [TestModel_label, data_score, T] = TestModel_OCSVM(SVMModel, dataset)

 [TestModel_label,data_score] = predict(SVMModel,dataset);
 
 % T = samples which are predicted as positive for trainset
T = ones (size(dataset,1),1)*3;

for index_train = 1:size(dataset,1)
    if (data_score(index_train)>0)
        T(index_train) = 2;
    end
end
