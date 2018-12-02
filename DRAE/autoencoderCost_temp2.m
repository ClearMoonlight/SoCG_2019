%%第二个autoencoder的辅助测试函数
function cost=autoencoderCost_temp2(theta,AE,data)
Num=AE.Num;     % the number of points in P
gamma=AE.gamma; % the ratio of outliers 
numPos=Num*(1-gamma);% the number of positive samples
numNeg=Num*gamma;    % the number of negative samples
[W1,W2,b1,b2]=theta2parameters(AE,theta);

lambda=AE.lambda2;
%% Forward propagation
dataPos=data(:,1:numPos);
dataNeg=data(:,numPos+1:end);
z2=bsxfun(@plus,W1*data,b1);
a2=sigmoid(z2);
z3=bsxfun(@plus,W2*a2,b2);
a3=sigmoid(z3);
a3Pos=a3(:,1:numPos);
a3Neg=a3(:,numPos+1:end);
%% ----------Cost-------------------------------------
cPlus=1/numPos*sum( sum( (a3Pos-dataPos).^2 ) );
cSubs=1/numNeg*sum( sum( (a3Neg-dataNeg).^2 ) );
c=1/Num*sum(sum((a3-data).^2));
% Loss term
Jcost=1/numPos*1/2*sum( sum( (a3Pos-dataPos).^2 ) );
% h
temp_1=sum((a3Pos-dataPos).^2,1)-cPlus*ones(1,numPos);
temp_2=sum((a3Neg-dataNeg).^2,1)-cSubs*ones(1,numNeg);
temp_3=sum((a3-data).^2,1)-c*ones(1,Num);
A=norm( temp_1 )^2;
B=norm( temp_2 )^2;
C=norm( temp_3 )^2;
h=1/2*lambda*(A+B)/C;
% Total cost
cost=Jcost+h;
end
%-------------------------------------------------------------------
%% sigmoid函数
function sigm=sigmoid(x)
sigm=1./(1+exp(-x));
end