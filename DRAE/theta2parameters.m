function [W1,W2,b1,b2]=theta2parameters(AE,theta)
inputSz=AE.inputSz;%输入尺寸48*48
hiddenSz=AE.hiddenSz;%第一个隐层的结点数576

bound1=hiddenSz*inputSz;
bound2=bound1+inputSz*hiddenSz;
bound3=bound2+hiddenSz;

W1=reshape(theta(1:bound1),hiddenSz,inputSz);
W2=reshape(theta(bound1+1:bound2),inputSz,hiddenSz);
b1=theta(bound2+1:bound3);
b2=theta(bound3+1:end);