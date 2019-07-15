
clc;
clear;

result = [zeros(3,1),zeros(3,1),zeros(3,1),zeros(3,1),zeros(3,1),zeros(3,1)];
result_t = [zeros(11,1),zeros(11,1),zeros(11,1)];
result_v = [zeros(11,1),zeros(11,1),zeros(11,1)];

result_final_p = [zeros(5,1),zeros(5,1),zeros(5,1)];
result_final_r = [zeros(5,1),zeros(5,1),zeros(5,1)];
result_final_f = [zeros(5,1),zeros(5,1),zeros(5,1)];

% k shows the precentage of the training samples
% v shows the percentage of the validation_test samples
k = .82;
v = .27;
%% method: 1-OCSVM % 2-CPUGP % 3-Smalter % 4-KNN % 5-DT
% disease: 1-Adrenal % 2-Heart % 3-Colorectal % 4-Prostate % 5-Lung
d = 5:5; % disease
for method = 1:5
% method =1;
j = 1; % Number of Iterations
% RBF % LINEAR % polynomial % gaussian

if (method == 1)
    MethodName = 'OCSVM';
    OFraction = .01;
    for disease = d
        MethodParam = 'LINEAR';
        OutlierFraction = OFraction;
        for p = 1:2  % parameters
            OutlierFraction = OFraction;
            for i = 1:j
                [Train, ScaledTrain,T, Data, UData, ScaledUdata, T2, DiseaseName,...
                    xlRange, xlRange6, xlRange4, xlRange3, xlRange5] =  LoadData(method, disease);
                
                [A_Precision_test, A_Recall_test, A_Fmeasure_test,...
                    A_Precision_validation, A_Recall_validation, A_Fmeasure_validation,...
                    xlRange2,outlierRateV,B_perc_tt,B_perc_tv]=...
                    OCSVM_method(ScaledTrain, k, v, MethodParam, OutlierFraction);

                result_t(i,:) = [A_Precision_test, A_Recall_test, A_Fmeasure_test];
                result_v(i,:) = [A_Precision_validation, A_Recall_validation, A_Fmeasure_validation];

%                 OutlierFraction = outlierRateV;
            end
            result_t(i+1,1)= mean(result_t(1:i,1));
            result_t(i+1,2)= mean(result_t(1:i,2));
            result_t(i+1,3)= mean(result_t(1:i,3));

            result_v(i+1,1)= mean(result_v(1:i,1));
            result_v(i+1,2)= mean(result_v(1:i,2));
            result_v(i+1,3)= mean(result_v(1:i,3));

            if p == 2
                ind = 4;
            else 
                ind = 1;
            end
            result(1,ind)= result_t(i+1,1);
            result(1,ind+1)= result_t(i+1,2);
            result(1,ind+2)= result_t(i+1,3);
            
            result(2,ind)= result_v(i+1,1);
            result(2,ind+1)= result_v(i+1,2);
            result(2,ind+2)= result_v(i+1,3);
            
            Diff_per = abs(result(1,ind) - result(2,ind));
            Diff_rec = abs(result(1,ind+1) - result(2,ind+1));
            Diff_F = abs(result(1,ind+2) - result(2,ind+2));
            
            Precision = result(2,ind);
            Recall = result(2,ind+1);
            Fmeasure = result(2,ind+2);
            
            writeToExcel(MethodName,DiseaseName,...
            Precision,Recall,Fmeasure,...
            xlRange,xlRange6,xlRange4,xlRange2,MethodParam,xlRange3,xlRange5,...
            Diff_per, Diff_rec,Diff_F);
            
            % for OCSVM
            filename ='D:\PAYANNAME\Bio\_OK\_Paper\_end\_MyPapers2\_end1\_Submit Paper\„ﬁ«·Â œÊ„\„ﬁ«·Â œÊ„ „‰\Code\result_final2.xlsx';
            A1 = {DiseaseName,result(2,ind), result(2,ind+1), result(2,ind+2),Diff_per, Diff_rec,Diff_F};
            sheet1 = MethodParam;
            xlswrite(filename,A1,sheet1,xlRange);
            
            MethodParam = 'RBF';
            OutlierFraction = OFraction;
        end

%      result(3,1) = abs(result(1,1) - result(2,1));% Diff_per LINEAR
%      result(3,2) = abs(result(1,2) - result(2,2));
%      result(3,3) = abs(result(1,3) - result(2,3));
%      result(3,4) = abs(result(1,4) - result(2,4));% Diff_per RBF
%      result(3,5) = abs(result(1,5) - result(2,5));
%      result(3,6) = abs(result(1,6) - result(2,6));
     
%     if((result(3,1)<result(3,4) &&  result(3,2)<result(3,5)) || (result(3,3)< result(3,6)))
%         result_final_p(method,disease) = result(2,1);
%         result_final_r(method,disease) = result(2,2);
%         result_final_f(method,disease) = result(2,3);
%     else         
%             result_final_p(method,disease) = result(2,4);
%             result_final_r(method,disease) = result(2,5);
%             result_final_f(method,disease) = result(2,6);
%     end

%         if(result_final_p(method,disease) == result(2,1))
%             MethodParam = 'LINEAR';
%             Diff_per = result(3,1);
%             Diff_rec = result(3,2);
%             Diff_F = result(3,3);
%         else
%             if(result_final_p(method,disease) == result(2,4))
%                 MethodParam = 'RBF';
%                 Diff_per = result(3,4);
%                 Diff_rec = result(3,5);
%                 Diff_F = result(3,6);
%             end
%         end
        
%         Precision = result_final_p(method,disease);
%         Recall = result_final_r(method,disease);
%         Fmeasure = result_final_f(method,disease);
%         
%         writeToExcel(MethodName,DiseaseName,...
%         Precision,Recall,Fmeasure,...
%         xlRange,xlRange6,xlRange4,xlRange2,MethodParam,xlRange3,xlRange5,...
%         Diff_per, Diff_rec,Diff_F);
    end  
end


if (method == 2)
    MethodName = 'CPUGP';
    OFraction = .01;
    for disease = d
        MethodParam = 'LINEAR';
        OutlierFraction = OFraction;
        for p = 1:2  % parameters
            OutlierFraction = OFraction;
            for i = 1:j
                [Train, ScaledTrain,T, Data, UData, ScaledUdata, T2, DiseaseName,...
                    xlRange, xlRange6, xlRange4, xlRange3, xlRange5] =  LoadData(method, disease);
                
                [A_Precision_test, A_Recall_test, A_Fmeasure_test,...
                    A_Precision_validation, A_Recall_validation, A_Fmeasure_validation,...
                    xlRange2,outlierRateV,B_perc_tt,B_perc_tv]=...
                    CPUGP_method(ScaledUdata, ScaledTrain, k, v, MethodParam, OutlierFraction);

                result_t(i,:) = [A_Precision_test, A_Recall_test, A_Fmeasure_test];
                result_v(i,:) = [A_Precision_validation, A_Recall_validation, A_Fmeasure_validation];

%                 OutlierFraction = outlierRateV(1);
            end
            result_t(i+1,1)= mean(result_t(1:i,1));
            result_t(i+1,2)= mean(result_t(1:i,2));
            result_t(i+1,3)= mean(result_t(1:i,3));

            result_v(i+1,1)= mean(result_v(1:i,1));
            result_v(i+1,2)= mean(result_v(1:i,2));
            result_v(i+1,3)= mean(result_v(1:i,3));

            if p == 2
                ind = 4;
            else 
                ind = 1;
            end
            result(1,ind)= result_t(i+1,1);
            result(1,ind+1)= result_t(i+1,2);
            result(1,ind+2)= result_t(i+1,3);
            
            result(2,ind)= result_v(i+1,1);
            result(2,ind+1)= result_v(i+1,2);
            result(2,ind+2)= result_v(i+1,3);
            
            Diff_per = abs(result(1,ind) - result(2,ind));
            Diff_rec = abs(result(1,ind+1) - result(2,ind+1));
            Diff_F = abs(result(1,ind+2) - result(2,ind+2));
            
            Precision = result(2,ind);
            Recall = result(2,ind+1);
            Fmeasure = result(2,ind+2);
            
            writeToExcel(MethodName,DiseaseName,...
            Precision,Recall,Fmeasure,...
            xlRange,xlRange6,xlRange4,xlRange2,MethodParam,xlRange3,xlRange5,...
            Diff_per, Diff_rec,Diff_F);
                      
            MethodParam = 'RBF';
%             OutlierFraction = OFraction;
        end
    end  
end

if (method == 3)
    MethodName = 'Smalter method';
    OFraction = .01;
    for disease = d
        MethodParam = 'LINEAR';
        OutlierFraction = OFraction;
        for p = 1:2  % parameters
            OutlierFraction = OFraction;
            for i = 1:j
                [Train, ScaledTrain,T, Data, UData, ScaledUdata, T2, DiseaseName,...
                    xlRange, xlRange6, xlRange4, xlRange3, xlRange5] =  LoadData(method, disease);
                
                [A_Precision_test, A_Recall_test, A_Fmeasure_test,...
                    A_Precision_validation, A_Recall_validation, A_Fmeasure_validation,...
                    xlRange2,outlierRateV,B_perc_tt,B_perc_tv]=...
                    Smalter_method(ScaledUdata, ScaledTrain, k, v, MethodParam, OutlierFraction);

                result_t(i,:) = [A_Precision_test, A_Recall_test, A_Fmeasure_test];
                result_v(i,:) = [A_Precision_validation, A_Recall_validation, A_Fmeasure_validation];

                OutlierFraction = outlierRateV(1);
            end
            result_t(i+1,1)= mean(result_t(1:i,1));
            result_t(i+1,2)= mean(result_t(1:i,2));
            result_t(i+1,3)= mean(result_t(1:i,3));

            result_v(i+1,1)= mean(result_v(1:i,1));
            result_v(i+1,2)= mean(result_v(1:i,2));
            result_v(i+1,3)= mean(result_v(1:i,3));
        
            if p == 2
                ind = 4;
            else 
                ind = 1;
            end
            result(1,ind)= result_t(i+1,1);
            result(1,ind+1)= result_t(i+1,2);
            result(1,ind+2)= result_t(i+1,3);
            
            result(2,ind)= result_v(i+1,1);
            result(2,ind+1)= result_v(i+1,2);
            result(2,ind+2)= result_v(i+1,3);
            
            Diff_per = abs(result(1,ind) - result(2,ind));
            Diff_rec = abs(result(1,ind+1) - result(2,ind+1));
            Diff_F = abs(result(1,ind+2) - result(2,ind+2));
            
            Precision = result(2,ind);
            Recall = result(2,ind+1);
            Fmeasure = result(2,ind+2);
            
            writeToExcel(MethodName,DiseaseName,...
            Precision,Recall,Fmeasure,...
            xlRange,xlRange6,xlRange4,xlRange2,MethodParam,xlRange3,xlRange5,...
            Diff_per, Diff_rec,Diff_F);
                      
            MethodParam = 'RBF';
            OutlierFraction = OFraction;
        end
    end  
end

% for KNN
Distance = 'euclidean';
if (method == 4)
    MethodName = 'KNN';
    for disease = d
        MethodParam = 'euclidean, k = 5';
        NumNeighbors = 5;
        for p = 1:2  % parameters
            for i = 1:j
                [Train, ScaledTrain,T, Data, UData, ScaledUdata, T2, DiseaseName,...
                    xlRange, xlRange6, xlRange4, xlRange3, xlRange5] =  LoadData(method, disease);
                
                [A_Precision_test, A_Recall_test, A_Fmeasure_test,...
                    A_Precision_validation, A_Recall_validation, A_Fmeasure_validation,...
                    xlRange2,B_perc_tt,B_perc_tv]=...
                    KNN_method(ScaledUdata, ScaledTrain, k, v, Distance,NumNeighbors);

                result_t(i,:) = [A_Precision_test, A_Recall_test, A_Fmeasure_test];
                result_v(i,:) = [A_Precision_validation, A_Recall_validation, A_Fmeasure_validation];

            end
            result_t(i+1,1)= mean(result_t(1:i,1));
            result_t(i+1,2)= mean(result_t(1:i,2));
            result_t(i+1,3)= mean(result_t(1:i,3));

            result_v(i+1,1)= mean(result_v(1:i,1));
            result_v(i+1,2)= mean(result_v(1:i,2));
            result_v(i+1,3)= mean(result_v(1:i,3));

        
            if p == 2
                ind = 4;
            else 
                ind = 1;
            end
            result(1,ind)= result_t(i+1,1);
            result(1,ind+1)= result_t(i+1,2);
            result(1,ind+2)= result_t(i+1,3);
            
            result(2,ind)= result_v(i+1,1);
            result(2,ind+1)= result_v(i+1,2);
            result(2,ind+2)= result_v(i+1,3);
            
            Diff_per = abs(result(1,ind) - result(2,ind));
            Diff_rec = abs(result(1,ind+1) - result(2,ind+1));
            Diff_F = abs(result(1,ind+2) - result(2,ind+2));
            
            Precision = result(2,ind);
            Recall = result(2,ind+1);
            Fmeasure = result(2,ind+2);
            
            writeToExcel(MethodName,DiseaseName,...
            Precision,Recall,Fmeasure,...
            xlRange,xlRange6,xlRange4,xlRange2,MethodParam,xlRange3,xlRange5,...
            Diff_per, Diff_rec,Diff_F);
                      
            MethodParam = 'euclidean, k = 3';
            NumNeighbors = 3;
        end
    end  
end

if (method == 5)
    MethodName = 'DT';
    MethodParam = '_';
    
    for disease = d
        for p = 1:1  % No parameters
            for i = 1:j
                [Train, ScaledTrain,T, Data, UData, ScaledUdata, T2, DiseaseName,...
                    xlRange, xlRange6, xlRange4, xlRange3, xlRange5] =  LoadData(method, disease);
                
                [A_Precision_test, A_Recall_test, A_Fmeasure_test,...
                    A_Precision_validation, A_Recall_validation, A_Fmeasure_validation,...
                    xlRange2]=...
                    DT_method(ScaledUdata, ScaledTrain, k, v);

                result_t(i,:) = [A_Precision_test, A_Recall_test, A_Fmeasure_test];
                result_v(i,:) = [A_Precision_validation, A_Recall_validation, A_Fmeasure_validation];

            end
            result_t(i+1,1)= mean(result_t(1:i,1));
            result_t(i+1,2)= mean(result_t(1:i,2));
            result_t(i+1,3)= mean(result_t(1:i,3));

            result_v(i+1,1)= mean(result_v(1:i,1));
            result_v(i+1,2)= mean(result_v(1:i,2));
            result_v(i+1,3)= mean(result_v(1:i,3));
        
            ind = 1;

            result(1,ind)= result_t(i+1,1);
            result(1,ind+1)= result_t(i+1,2);
            result(1,ind+2)= result_t(i+1,3);
            
            result(2,ind)= result_v(i+1,1);
            result(2,ind+1)= result_v(i+1,2);
            result(2,ind+2)= result_v(i+1,3);
            
            Diff_per = abs(result(1,ind) - result(2,ind));
            Diff_rec = abs(result(1,ind+1) - result(2,ind+1));
            Diff_F = abs(result(1,ind+2) - result(2,ind+2));
            
            Precision = result(2,ind);
            Recall = result(2,ind+1);
            Fmeasure = result(2,ind+2);
            
            writeToExcel(MethodName,DiseaseName,...
            Precision,Recall,Fmeasure,...
            xlRange,xlRange6,xlRange4,xlRange2,MethodParam,xlRange3,xlRange5,...
            Diff_per, Diff_rec,Diff_F);
                      
            MethodParam = '_';
        end
    end  
end
end

        
