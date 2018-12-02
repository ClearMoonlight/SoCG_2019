AE.inputSz=100;
AE.hiddenSz=50;

AE.lambda1=0.0005;
AE.lambda2=0.2;

options.Method = 'lbfgs';
options.maxIter = 20;
options.display = 'on';

load('High-Dimensional/P_0.5.mat');
load('High-Dimensional/label_0.5.mat');

data=mapminmax(P,0,1);
%data=P;
AE.Num=size(P,2);% the number of total points
AE.Ni=sum(label);% the number of inliers
AE.No=AE.Num-AE.Ni;% the number of outliers