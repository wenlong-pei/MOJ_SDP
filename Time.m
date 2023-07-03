x=200:200:800;
a=[80,110,163,287];
plot(x,a,'-or'); 
axis([200,800,0,400])  
set(gca,'XTick',[200:200:800])
set(gca,'YTick',[0:100:400])
legend('minute');   
xlabel('Iteration Number')  
ylabel('Time Cost') 
