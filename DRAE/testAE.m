%%��������autoencoder�����Ƿ���ȷ
clear
clc
addpath minFunc/
Params;
theta=parameters2theta1(AE);
[cost,grad]=autoencoderCost1(theta,AE,data);
numgrad=computeNumericalGradient(@(x)autoencoderCost_temp1(x,AE,data),theta);
diff=norm(numgrad-grad)/norm(numgrad+grad);
disp(diff);