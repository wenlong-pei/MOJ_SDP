x=200:200:800;
 a=[0.876,0.942,0.962,0.962]; 
 plot(x,a,'-*b'); 
axis([200,800,0.8,1])  
set(gca,'XTick',[200:200:800]) 
set(gca,'YTick',[0.8:0.05:1]) 
legend('Popt¡ü');   
xlabel('Iteration Number')  
ylabel('Performance') 