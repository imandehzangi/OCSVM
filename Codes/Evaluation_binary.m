 function [A_Precision, A_Recall, A_Fmeasure] = Evaluation_binary (datalabels, predict_label)

 % validation 
[confusionMat, order] = confusionmat(datalabels,predict_label);
fn= confusionMat(1,2);
tn= confusionMat(1,1);
fp= confusionMat(2,1);
tp= confusionMat(2,2);

A_Precision=(tp/(tp+fp))*100;
A_Recall=(tp/(tp+fn))*100;
A_Fmeasure=((2*A_Precision*A_Recall)/(A_Precision+A_Recall));