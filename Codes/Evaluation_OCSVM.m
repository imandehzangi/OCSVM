
function [Precision, Recall, F_measure, Sensitivity ] = Evaluation_OCSVM(dataset, datalabels, T, data_score)

% T = samples which are predicted as positive for trainset
% yfx = samples which are predicted as positive AND was positive originally for trainset
yfx = ones (size(dataset,1),1)*3;
for index_train = 1:size(dataset,1)
    if ( datalabels(index_train) == 2) &&  (2 == T(index_train))
        yfx(index_train) = 2;
    end
end

% evaluation 
TP_data_score = sum((data_score>0));
FN_data_score = sum((data_score<0));

Precision = (sum(yfx==2))/size(datalabels,1)*100;
Recall = (TP_data_score)/ (TP_data_score + FN_data_score)*100;
F_measure = 2*((Precision*Recall)/(Precision+Recall));
Sensitivity = TP_data_score / (TP_data_score + FN_data_score)*100;