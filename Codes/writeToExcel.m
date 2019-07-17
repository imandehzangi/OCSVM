
% write to excell
function [] = writeToExcel(MethodName,DiseaseName,...
    Precision,Recall,Fmeasure,...
    xlRange,xlRange6,xlRange4,xlRange2,MethodParam,xlRange3,xlRange5,...
    Diff_per, Diff_rec,Diff_F)

filename ='C:\Users\Akram\Desktop\SharifWorkshop\result_final.xlsx';

A = {DiseaseName,MethodParam,Precision, Recall, Fmeasure};
sheet1 = MethodName;
if (strcmp(MethodParam,'RBF') || strcmp(MethodParam,'euclidean, k = 3') || strcmp(MethodParam,'_'))
xlswrite(filename,A,sheet1,xlRange);
elseif strcmp(MethodParam,'LINEAR') || strcmp(MethodParam,'euclidean, k = 5')
    xlswrite(filename,A,sheet1,xlRange4);
    xlswrite(filename,A,sheet1,xlRange6);
end


B = {MethodName,MethodParam,Precision, Recall, Fmeasure,Diff_per, Diff_rec,Diff_F};
sheet2 = DiseaseName;
xlswrite(filename,B,sheet2,xlRange2);

% Precision
C = {Precision,MethodParam};
sheet3 = 'Precision';
if (strcmp(MethodParam,'RBF') || strcmp(MethodParam,'euclidean, k = 3'))
xlswrite(filename,C,sheet3,xlRange3);
elseif (strcmp(MethodParam,'LINEAR') || strcmp(MethodParam,'euclidean, k = 5'))
    xlswrite(filename,C,sheet3,xlRange5);
elseif (strcmp(MethodParam,'_'))
    C_DT = {Precision};
    xlswrite(filename,C_DT,sheet3,xlRange3);
end

% Recall
D = {Recall,MethodParam};
sheet4 = 'Recall';
if (strcmp(MethodParam,'RBF') || strcmp(MethodParam,'euclidean, k = 3'))
xlswrite(filename,D,sheet4,xlRange3);
elseif (strcmp(MethodParam,'LINEAR') || strcmp(MethodParam,'euclidean, k = 5'))
    xlswrite(filename,D,sheet4,xlRange5);
    elseif (strcmp(MethodParam,'_'))
    D_DT = {Recall};
    xlswrite(filename,D_DT,sheet4,xlRange3);
end

% Fmeasure
E = {Fmeasure,MethodParam};
sheet5 = 'Fmeasure';
if (strcmp(MethodParam,'RBF') || strcmp(MethodParam,'euclidean, k = 3'))
xlswrite(filename,E,sheet5,xlRange3);
elseif (strcmp(MethodParam,'LINEAR') || strcmp(MethodParam,'euclidean, k = 5'))
    xlswrite(filename,E,sheet5,xlRange5);
        elseif (strcmp(MethodParam,'_'))
        E_DT = {Recall};
        xlswrite(filename,E_DT,sheet5,xlRange3);
end

