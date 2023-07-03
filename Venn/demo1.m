
num=xlsread('poptcomplementarity.xlsx');
X1=[]
X2=[]
for i=1:5480
    if(num(i,1)==1)
        X1(i)=i;
    end
    if(num(i,2)==1)
        X2(i)=i;
    end
end


VN=venn(X1,X2);
VN=VN.draw();