function [ y,WP_POPT_ACC ] = muti_testLogistic_nclasses(x)

% training_bugzilla_fit = csvread('training_bugzilla_fit_1.csv');
% save('training_bugzilla_fit.mat','training_bugzilla_fit','-mat');

%test_data = csvread(['..//dataset//test_',project,'.csv']);
%save(['test_',project,'_fit.mat'],'test_data','-mat');
test_data=importdata('testing_data.mat');
valid_data = importdata('valid_data.mat');
%test_data=importdata('training_bugzilla_fit.mat');

lt = valid_data(:,8).*valid_data(:,3);
lt(lt==0) = lt(lt==0) +1;
churn = ((valid_data(:,1) + valid_data(:,2)).* lt)/2;

churn_p = log2(churn+1);
valid_data(:,[1,2,6:13]) = valid_data(:,[1,2,6:13])+1;
valid_data(:,1:13) = log(valid_data(:,1:13));
valid_data(:,15:782) = log(valid_data(:,15:782));
A = [valid_data(:,4),valid_data(:,3),valid_data(:,6),lt,valid_data(:,7),valid_data(:,10),valid_data(:,9),valid_data(:,11),valid_data(:,13),churn_p];
%A = test_data(:,15:782);
nbug=valid_data(:,14);
cost=churn;
y=zeros(10,2);
maxpopt=0;
for i = 1:1:size(x,1)-1
    result=A*x(i,2:11)'+x(i,1);
    pred=Logistic(result);

    WPdata(:,1) = valid_data(:,14);
    WPdata(:,2) = churn;
    WPdata(:,3) = ifelse(pred>0.5,1,0);
    WPdata(:,4) = WPdata(:,1)./(WPdata(:,2)+1);
    %WP_POPT_ACC(i,1) = decPopt(WPdata);
    %WP_POPT_ACC(i,2) = decACC(WPdata);
    WP_POPT_ACC(i,2) = decF1(WPdata);
    %WP_POPT_ACC(i,3) = decR20E(WPdata);
    %WP_POPT_ACC(i,4) = decE20R(WPdata);
 
    if(maxpopt<WP_POPT_ACC(i,2) && WP_POPT_ACC(i,2)>0)
        xx=x(i,1:11);
        maxpopt=WP_POPT_ACC(i,2);
    end
    %WP_POPT_ACC(i,4) = decAuc(WPdata);
    %WP_POPT_ACC(i,3) = decR20E(WPdata);
    %WP_POPT_ACC(i,4) = decE20R(WPdata);
    %y(i,1)=(pred>0.5)'*cost;
    %y(i,2)=-(pred>0.5)'*real(nbug>0);
end

lt_test = test_data(:,8).*test_data(:,3);
lt_test(lt_test==0) = lt_test(lt_test==0) +1;
churn_test = ((test_data(:,1) + test_data(:,2)).* lt_test)/2;

churn_p_test = log2(churn_test+1);
test_data(:,[1,2,6:13]) = test_data(:,[1,2,6:13])+1;
test_data(:,1:13) = log(test_data(:,1:13));
test_data(:,15:782) = log(test_data(:,15:782));
A_test = [test_data(:,4),test_data(:,3),test_data(:,6),lt_test,test_data(:,7),test_data(:,10),test_data(:,9),test_data(:,11),test_data(:,13),churn_p_test];
nbug_test=test_data(:,14);
cost_test=churn_test;

    result_test=A_test*xx(1,2:11)'+xx(1,1);
    pred_test=Logistic(result_test);
    WPdata_test(:,1) = test_data(:,14);
    WPdata_test(:,2) = churn_test;%churn
    WPdata_test(:,3) = ifelse(pred_test>0.5,1,0);%ifelse(pred>0.5,1,0);
    WPdata_test(:,4) = WPdata_test(:,1)./(WPdata_test(:,2)+1);
    WP_POPT_ACC(1,1) = decPopt(WPdata_test);

    %WP_POPT_ACC(1,2) = decACC(WPdata_test);
    %WP_POPT_ACC(1,2) = decF1(WPdata_test);
    %WP_POPT_ACC(1,4) = decAuc(WPdata_test);
    WP_POPT_ACC(1,3) = decR20E(WPdata_test);
    WP_POPT_ACC(1,4) = decE20R(WPdata_test);
    WP_POPT_ACC
    y(1,1)=(pred_test>0.5)'*cost_test;
    y(1,2)=-(pred_test>0.5)'*real(nbug_test > 0);


function Output = Logistic(Input)
Output = 1 ./ (1 + exp(-Input));
end
function Output = ifelse(a,b,c)
   Output = (a~=0)*b+(a==0)*c;
end
end