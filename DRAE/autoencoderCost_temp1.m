%%第一个autoencoder的辅助测试函数
function cost=autoencoderCost_temp1(theta,AE,data)
% Cost and gradient variables (your code needs to compute these values).
% Here, we initialize them to zeros.
[W1,W2,b1,b2]=theta2parameters(AE,theta);

Num=size(data,2);
lambda=AE.lambda1;
%% Forward propagation
z2=bsxfun(@plus,W1*data,b1);
a2=sigmoid(z2);
z3=bsxfun(@plus,W2*a2,b2);
a3=sigmoid(z3);
%% ----------Cost-------------------------------------
% Loss term
Jcost=1/Num*1/2*sum( sum( (a3-data).^2 ) );
% Regularization term 
Jweight=1/2*lambda*( sum(sum(W1.^2))+sum(sum(W2.^2)) );
% Total cost
cost=Jcost+Jweight;
end
%-------------------------------------------------------------------
%% sigmoid函数
function sigm=sigmoid(x)
sigm=1./(1+exp(-x));
end