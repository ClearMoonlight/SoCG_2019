function [cost,grad]=autoencoderCost1(theta,AE,data)
% Cost and gradient variables (your code needs to compute these values).
% Here, we initialize them to zeros.
[W1,W2,b1,b2]=theta2parameters(AE,theta);
W1grad=zeros(size(W1));
W2grad=zeros(size(W2));
b1grad=zeros(size(b1));
b2grad=zeros(size(b2));

Num=size(data,2);
lambda=AE.lambda1;
%% Forward propagation
z2=bsxfun(@plus,W1*data,b1);
a2=sigmoid(z2);
z3=bsxfun(@plus,W2*a2,b2);
a3=sigmoid(z3);
clear b1 b2 %%%%%%%%%%%%%%%%%%%
%% ----------Cost-------------------------------------
% Loss term
Jcost=1/Num*1/2*sum( sum( (a3-data).^2 ) );
% Regularization term 
Jweight=1/2*lambda*( sum(sum(W1.^2))+sum(sum(W2.^2)) );
% Total cost
cost=Jcost+Jweight;
%-------------------W2,b2-------------------
delta3=(a3-data).*sigmoidDer(z3);
b2grad=sum(delta3,2);
W2grad=delta3*(a2');
%-------------------W1,b1-------------------
delta2=W2'*delta3.*sigmoidDer(z2);
b1grad=sum(delta2,2);
W1grad=delta2*(data');
clear delta3 delta2 z2 data %%%%%%%%%%%%%%%%%%%

W2grad=W2grad/Num+lambda*W2;
W1grad=W1grad/Num+lambda*W1;
b2grad=b2grad/Num;
b1grad=b1grad/Num;
clear W1 W2 %%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------
grad=[W1grad(:);W2grad(:);b1grad(:);b2grad(:)];
clear W1grad W2grad %%%%%%%%%%%%%%%%%%%
clear b1grad b2grad %%%%%%%%%%%%%%%%%%%
end
%-------------------------------------------------------------------
%% sigmoid函数
function sigm=sigmoid(x)
sigm=1./(1+exp(-x));
end
%% sigmoid函数的导函数
function sigmDer=sigmoidDer(x)
sigmDer=sigmoid(x).*(1-sigmoid(x));
end