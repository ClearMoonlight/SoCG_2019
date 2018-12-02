function numgrad = computeNumericalGradient(J, theta)
% numgrad = computeNumericalGradient(J, theta)
% theta: a vector of parameters
% J: a function that outputs a real-number. Calling y = J(theta) will return the
% function value at theta. 
  
% Initialize numgrad with zeros
numgrad = zeros(size(theta));
epsilon=1e-4;
Num=size(theta,1);
for i=1:Num
    i
    delta=zeros(size(theta));
    delta(i)=1;
    numgrad(i)=(J(theta+epsilon*delta)-J(theta-epsilon*delta))/(2*epsilon);
end