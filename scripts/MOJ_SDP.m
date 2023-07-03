addpath('datautil')
addpath('MODEP')
addpath('Project')
load fisheriris
%features-train-muti'commons-lang''commons-math''opennlp''commons-beanutils''commons-becl''commons-codec''commons-collections''commons-compress''commons-configuration''commons-dbcp''commons-digester''commons-gora''commons-io''commons-jcs''commons-net''commons-scxml''commons-validator''commons-vfx''giraph''parquet-mr'
train_projects = {'features-train-muti'};
test_projects = {'features-test-muti'};
valid_projects = {'features-valid-muti'};

for i=1:1:length(train_projects)
    project_train=train_projects{i};
    disp(project_train);
    
    project_test=test_projects{i};
    disp(project_test);
    
    project_valid=valid_projects{i};
    disp(project_valid);
    
    train_data = csvread(['..//dataset_train//',project_train,'.csv'],1);
    test_data = csvread(['..//dataset_test//',project_test,'.csv'],1);
    valid_data = csvread(['..//dataset_valid//',project_valid,'.csv'],1);
    
    %-----------------------------------------------------------------------
    Recall_Churn=zeros(50,2);
    project_P_A = [1:99]';
    indices = crossvalind('Kfold',length(train_data),10);

        wp_popt_acc=[1,1,1,1,1,1];
 
              data_train=train_data;
              data_test=test_data;
              data_valid=valid_data;



              save('training_data.mat','data_train','-mat');
              save('testing_data.mat','data_test','-mat');
              save('valid_data.mat','data_valid','-mat');
 
              [X,FVAL,POPULATION,SCORE,OUTPUT]=MODEP('logistic','nclasses');

              [y,popt_acc] = muti_testLogistic_nclasses(X);

              wp_popt_acc = popt_acc;

        project_P_A = [project_P_A,wp_popt_acc;];

    csvwrite(['..//dataoutput_cv//',project_train,'.csv'],project_P_A);
end
clear max;
clear median;
clear min;
clear result;

popt_max_sum = 0;
%acc_max_sum = 0;
f1_max_sum = 0;
%auc_max_sum = 0;
r20e_max_sum = 0;
e20r_min_sum = 0;
%popt_median_sum = 0;
%acc_median_sum = 0;
%f1_median_sum = 0;
%auc_median_sum = 0;
%r20e_median_sum = 0;
%e20r_median_sum = 0;


    popt_max_sum = wp_popt_acc(1,1);
    %acc_max_sum = acc_max_sum + max(i+1);
    f1_max_sum = max(wp_popt_acc(1,2));
    %auc_max_sum = auc_max_sum + max(i+3);
    r20e_max_sum = wp_popt_acc(1,3);
    e20r_min_sum = wp_popt_acc(1,4);

%for i=1:6:length(median)
    %popt_median_sum = popt_median_sum + median(i);
    %acc_median_sum = acc_median_sum + median(i+1);
    %f1_median_sum = f1_median_sum + median(i+2);
    %auc_median_sum = auc_median_sum + median(i+3);
    %r20e_median_sum = r20e_median_sum + median(i+4);
    %e20r_median_sum = e20r_median_sum + median(i+5);
%end
popt_max = [{'popt_max'}; num2cell(popt_max_sum)];
%acc_max = [{'acc_max'}; num2cell(acc_max_sum)];
f1_max = [{'f1_max'}; num2cell(f1_max_sum)];
%auc_max = [{'auc_max'}; num2cell(auc_max_sum)];
r20e_max = [{'r20e_max'}; num2cell(r20e_max_sum)];
e20r_min = [{'e20r_min'}; num2cell(e20r_min_sum)];
%popt_median = [{'popt_median'}; num2cell(popt_median_sum)];
%acc_median = [{'acc_median'}; num2cell(acc_median_sum)];
%f1_median = [{'f1_median'}; num2cell(f1_median_sum)];
%auc_median = [{'auc_median'}; num2cell(auc_median_sum)];
%r20e_median = [{'r20e_median'}; num2cell(r20e_median_sum)];
%e20r_median = [{'e20r_median'}; num2cell(e20r_median_sum)];
result = cat(2,popt_max,f1_max,r20e_max,e20r_min);

%result = cat(2,popt_max,popt_median,acc_max,acc_median,f1_max,f1_median,auc_max,auc_median,r20e_max,r20e_median,e20r_min,e20r_median);
xlswrite(['..//dataoutput_pa//',project_train,'****.xlsx'],result);
