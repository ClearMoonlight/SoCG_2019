function theta = parameters2theta(AE)
inputSz=AE.inputSz;
hiddenSz=AE.hiddenSz;
%% Initialize parameters randomly based on layer sizes.
% we'll choose weights uniformly from the interval [-r, r]
r=sqrt(6)/sqrt(hiddenSz+inputSz+1);   

W1=rand(hiddenSz,inputSz)*2*r-r;
W2=rand(inputSz,hiddenSz)*2*r-r;

b1=zeros(hiddenSz,1);
b2=zeros(inputSz,1);
% Convert weights and bias gradients to the vector form.
% This step will "unroll" (flatten and concatenate together) all 
% your parameters into a vector, which can then be used with minFunc. 
theta = [W1(:);W2(:);b1(:);b2(:)];
end