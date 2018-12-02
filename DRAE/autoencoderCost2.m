function [cost,grad]=autoencoderCost2(theta,AE,data)
Num=AE.Num;     % the number of points in P
numPos=AE.Ni;% the number of positive samples
numNeg=AE.No;    % the number of negative samples
[W1,W2,b1,b2]=theta2parameters(AE,theta);
W1grad=zeros(size(W1));
W2grad=zeros(size(W2));
b1grad=zeros(size(b1));
b2grad=zeros(size(b2));

lambda=AE.lambda2;
%% Forward propagation
dataPos=data(:,1:numPos);
dataNeg=data(:,numPos+1:end);
z2=bsxfun(@plus,W1*data,b1);
z2Pos=z2(:,1:numPos);
z2Neg=z2(:,numPos+1:end);
a2=sigmoid(z2);
a2Pos=a2(:,1:numPos);
a2Neg=a2(:,numPos+1:end);
z3=bsxfun(@plus,W2*a2,b2);
z3Pos=z3(:,1:numPos);
z3Neg=z3(:,numPos+1:end);
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
temp1=sum((a3Pos-dataPos).^2,1)-cPlus*ones(1,numPos);
temp2=sum((a3Neg-dataNeg).^2,1)-cSubs*ones(1,numNeg);
temp3=sum((a3-data).^2,1)-c*ones(1,Num);
A=norm( temp1 )^2;
B=norm( temp2 )^2;
C=norm( temp3 )^2;
h=1/2*lambda*(A+B)/C;
% Total cost
cost=Jcost+h;
%-------------------W2,b2-------------------
cols_data=size(data,1);
delta3Pos=(a3Pos-dataPos).*sigmoidDer(z3Pos);
delta3Neg=(a3Neg-dataNeg).*sigmoidDer(z3Neg);
delta3=(a3-data).*sigmoidDer(z3);
%------------------------
b2_A1=sum(delta3Pos,2);
b2_A2=ones(cols_data,1)*temp1;
b2_A3=2*delta3Pos-2/numPos*b2_A1*ones(1,numPos);
hb2A=sum(b2_A2.*b2_A3,2);
%------------------------
b2_B1=sum(delta3Neg,2);
b2_B2=ones(cols_data,1)*temp2;
b2_B3=2*delta3Neg-2/numNeg*b2_B1*ones(1,numNeg);
hb2B=sum(b2_B2.*b2_B3,2);
%------------------------
b2_C1=sum(delta3,2);
b2_C2=ones(cols_data,1)*temp3;
b2_C3=2*delta3-2/Num*b2_C1*ones(1,Num);
hb2C=sum(b2_C2.*b2_C3,2);
%------------------------
hb2=lambda/C*hb2A+lambda/C*hb2B-lambda*(A+B)/(C^2)*hb2C;
%------------------------
W2_A1=2*b2_A2.*delta3Pos*a2Pos';
W2_A2=2/numPos*sum(temp1)*delta3Pos*a2Pos';
hW2A=W2_A1-W2_A2;
%------------------------
W2_B1=2*b2_B2.*delta3Neg*a2Neg';
W2_B2=2/numNeg*sum(temp2)*delta3Neg*a2Neg';
hW2B=W2_B1-W2_B2;
%------------------------
W2_C1=2*b2_C2.*delta3*a2';
W2_C2=2/Num*sum(temp3)*delta3*a2';
hW2C=W2_C1-W2_C2;
hW2=lambda/C*hW2A+lambda/C*hW2B-lambda*(A+B)/(C^2)*hW2C;

b2grad=1/numPos*sum(delta3Pos,2)+hb2;
W2grad=1/numPos*delta3Pos*(a2Pos')+hW2;
%-------------------W1,b1-------------------
cols_hidden=size(a2,1);
delta2Pos=W2'*delta3Pos.*sigmoidDer(z2Pos);
delta2Neg=W2'*delta3Neg.*sigmoidDer(z2Neg);
delta2=W2'*delta3.*sigmoidDer(z2);
%------------------------
b1_A1=sum(delta2Pos,2);
b1_A2=ones(cols_hidden,1)*temp1;
b1_A3=2*delta2Pos-2/numPos*b1_A1*ones(1,numPos);
hb1A=sum(b1_A2.*b1_A3,2);
%------------------------
b1_B1=sum(delta2Neg,2);
b1_B2=ones(cols_hidden,1)*temp2;
b1_B3=2*delta2Neg-2/numNeg*b1_B1*ones(1,numNeg);
hb1B=sum(b1_B2.*b1_B3,2);
%------------------------
b1_C1=sum(delta2,2);
b1_C2=ones(cols_hidden,1)*temp3;
b1_C3=2*delta2-2/Num*b1_C1*ones(1,Num);
hb1C=sum(b1_C2.*b1_C3,2);
%------------------------
hb1=lambda/C*hb1A+lambda/C*hb1B-lambda*(A+B)/(C^2)*hb1C;
%------------------------
W1_A1=2*b1_A2.*delta2Pos*dataPos';
W1_A2=2/numPos*sum(temp1)*delta2Pos*dataPos';
hW1A=W1_A1-W1_A2;
%------------------------
W1_B1=2*b1_B2.*delta2Neg*dataNeg';
W1_B2=2/numNeg*sum(temp2)*delta2Neg*dataNeg';
hW1B=W1_B1-W1_B2;
%------------------------
W1_C1=2*b1_C2.*delta2*data';
W1_C2=2/Num*sum(temp3)*delta2*data';
hW1C=W1_C1-W1_C2;
%------------------------
hW1=lambda/C*hW1A+lambda/C*hW1B-lambda*(A+B)/(C^2)*hW1C;
%------------------------
b1grad=1/numPos*sum(delta2Pos,2)+hb1;
W1grad=1/numPos*delta2Pos*(dataPos')+hW1;
%-------------------------------------------------------------------
grad=[W1grad(:);W2grad(:);b1grad(:);b2grad(:)];
end
%-------------------------------------------------------------------
%% sigmoid����
function sigm=sigmoid(x)
sigm=1./(1+exp(-x));
end
%% sigmoid����ĵ�����
function sigmDer=sigmoidDer(x)
sigmDer=sigmoid(x).*(1-sigmoid(x));
end