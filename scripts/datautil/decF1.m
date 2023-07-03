function [y] = decF1(data)

A= confusionmat(data(:,1),data(:,3));
   A = A';
   precision = diag(A)./(sum(A,2) + 0.0001);  
   recall = diag(A)./(sum(A,1)+0.0001)'; 
   precision = mean(precision);
   recall = mean(recall);
   F1 = 2*precision*recall/(precision + recall);


y=F1;
end
