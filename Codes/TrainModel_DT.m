function [data_c, data_tree] = TrainModel_DT(dataset, datalabels)

data_c = cvpartition(datalabels,'KFold',10);
data_tree = fitctree(dataset,datalabels);
