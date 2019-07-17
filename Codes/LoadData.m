function [Train, ScaledTrain,T, Data, UData, ScaledUdata, T2, DiseaseName,...
    xlRange, xlRange6, xlRange4, xlRange3, xlRange5] =  LoadData(m, d)
% Load AML Data

exp_all=readtable('C:\Users\Akram\Desktop\SharifWorkshop\exp.csv');
exp_all = exp_all(:,2:end);
exp_all = table2array(exp_all);
% exp_all_u = unique(exp_all, 'rows') ; % check duplicates
% exp_all_not_nan = Normalize(exp_all); % check NaN data

positive_up =readtable('C:\Users\Akram\Desktop\SharifWorkshop\Positive_UP.csv');
positive_up=positive_up(:,2:end);
positive_up = table2array(positive_up);
% positive_up_not_nan = Normalize(positive_up);
positive_up_u = unique(positive_up, 'rows') ;

positive_down =readtable('C:\Users\Akram\Desktop\SharifWorkshop\Positive_Down.csv');
positive_down=positive_down(:,2:end);
positive_down = table2array(positive_down);
% positive_down_not_nan = Normalize(positive_down);
positive_down_u = unique(positive_down, 'rows') ;

positive_set = [positive_up_u;positive_down_u];
% positive_set_not_nan = Normalize(positive_set);
positive_set_u = unique(positive_set, 'rows') ;

uSet=setdiff(exp_all,positive_set_u,'rows');
% uSet_u = unique(uSet, 'rows') ;
%%
if (d == 1)
Data = positive_set_u;
UData = uSet;   
DiseaseName = 'AML';
end

Train= Data;
[Train,T]= rmoutliers(Train); 

%Scale data
 [nTrain,NoFeature] = size(Train);
 ScaledTrain=(Train-repmat(min(Train),nTrain,1))./(repmat(max(Train),nTrain,1)-repmat(min(Train),nTrain,1));
 ScaledTrain = [ScaledTrain, ones(size(ScaledTrain,1),1)*2];

UTrain=UData;
[UTrain,T2]= rmoutliers(UTrain);

%Scale Udata
 [nUdata,NoFeatureU] = size(UTrain);
 ScaledUdata=(UTrain-repmat(min(UTrain),nUdata,1))./(repmat(max(UTrain),nUdata,1)-repmat(min(UTrain),nUdata,1));
 ScaledUdata = [ScaledUdata, ones(size(ScaledUdata,1),1)*3];


if (m ==1)
    if (d == 1)
        xlRange = 'A2';
        xlRange6 = 'A3';
        xlRange4 = 'G2';
        xlRange3 = 'I2';
        xlRange5 = 'I3';
    else
        if (d == 2)
            xlRange = 'A4';
            xlRange6 = 'A5';
            xlRange4 = 'G3';
            xlRange3 = 'I4';
            xlRange5 = 'I5';
        else
            if (d == 3)
                xlRange = 'A6';
                xlRange6 = 'A7';
                xlRange4 = 'G4';
                xlRange3 = 'I6';
                xlRange5 = 'I7';
            else
                if (d == 4)
                    xlRange = 'A8';
                    xlRange6 = 'A9';
                    xlRange4 = 'G5';
                    xlRange3 = 'I8';
                    xlRange5 = 'I9';
                else
                    if (d == 5)
                        xlRange = 'A10';
                        xlRange6 = 'A11';
                        xlRange4 = 'G6';
                        xlRange3 = 'I10';
                        xlRange5 = 'I11';
                    end
                end
            end
        end
    end
else
    if (m ==2)
        if (d == 1)
            xlRange = 'A2';
            xlRange3 = 'G2';
            xlRange4 = 'G2';
            xlRange5 = 'G3';
            xlRange6 = 'A3';
        else
            if (d == 2)
            xlRange = 'A4';
            xlRange3 = 'G4';
            xlRange4 = 'G3';
            xlRange5 = 'G5';
            xlRange6 = 'A5';
            else
                if (d == 3)
                xlRange = 'A6';
                xlRange3 = 'G6';
                xlRange4 = 'G4';
                xlRange5 = 'G7';
                xlRange6 = 'A7';
                else
                    if (d == 4)
                    xlRange = 'A8';
                    xlRange3 = 'G8';
                    xlRange4 = 'G5';
                    xlRange5 = 'G9';
                    xlRange6 = 'A9';
                    else
                        if (d == 5)
                        xlRange = 'A10';
                        xlRange3 = 'G10';
                        xlRange4 = 'G6';
                        xlRange5 = 'G11';
                        xlRange6 = 'A11';
                        end
                    end
                end
            end
        end
    else
        if (m == 3)
            if (d == 1)
                xlRange = 'A2';
                xlRange6 = 'A3';
                xlRange4 = 'G2';
                xlRange3 = 'E2';
                xlRange5 = 'E3';
            else
                if (d == 2)
            xlRange = 'A4';
            xlRange6 = 'A5';
            xlRange4 = 'G3';
            xlRange3 = 'E4';
            xlRange5 = 'E5';
                else
                    if (d == 3)
                xlRange = 'A6';
                xlRange6 = 'A7';
                xlRange4 = 'G4';
                xlRange3 = 'E6';
                xlRange5 = 'E7';
                    else
                        if (d == 4)
                    xlRange = 'A8';
                    xlRange6 = 'A9';
                    xlRange4 = 'G5';
                    xlRange3 = 'E8';
                    xlRange5 = 'E9';
                        else
                            if (d == 5)
                        xlRange = 'A10';
                        xlRange6 = 'A11';
                        xlRange4 = 'G6';
                        xlRange3 = 'E10';
                        xlRange5 = 'E11';
                            end
                        end
                    end
                end
            end
        else
            if (m == 4)
                if (d == 1)
                    xlRange = 'A2';
                    xlRange6 = 'A3';
                    xlRange4 = 'G2';
                    xlRange3 = 'B2';
                    xlRange5 = 'B3';
                else
                    if (d == 2)
            xlRange = 'A4';
            xlRange6 = 'A5';
            xlRange4 = 'G3';
            xlRange3 = 'B4';
            xlRange5 = 'B5';
                    else
                        if (d == 3)
                xlRange = 'A6';
                xlRange6 = 'A7';
                xlRange4 = 'G4';
                xlRange3 = 'B6';
                xlRange5 = 'B7';
                        else
                            if (d == 4)
                    xlRange = 'A8';
                    xlRange6 = 'A9';
                    xlRange4 = 'G5';
                    xlRange3 = 'B8';
                    xlRange5 = 'B9';
                            else
                                if (d == 5)
                        xlRange = 'A10';
                        xlRange6 = 'A11';
                        xlRange4 = 'G6';
                        xlRange3 = 'B10';
                        xlRange5 = 'B11';
                                end
                            end
                        end
                    end
                end
            else
                if (m == 5)
                    if (d == 1)
                    xlRange = 'A2';
                    xlRange6 = 'A3';
                    xlRange4 = 'G2';
                    xlRange3 = 'D2';
                    xlRange5 = 'D3';
                    else
                        if (d == 2)
            xlRange = 'A4';
            xlRange6 = 'A5';
            xlRange4 = 'G3';
            xlRange3 = 'D4';
            xlRange5 = 'D5';
                        else
                            if (d == 3)
                xlRange = 'A6';
                xlRange6 = 'A7';
                xlRange4 = 'G4';
                xlRange3 = 'D6';
                xlRange5 = 'D7';
                            else
                                if (d == 4)
                    xlRange = 'A8';
                    xlRange6 = 'A9';
                    xlRange4 = 'G5';
                    xlRange3 = 'D8';
                    xlRange5 = 'D9';
                                else
                                    if (d == 5)
                        xlRange = 'A10';
                        xlRange6 = 'A11';
                        xlRange4 = 'G6';
                        xlRange3 = 'D10';
                        xlRange5 = 'D11';
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


            
        




    