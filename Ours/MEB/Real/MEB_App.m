function [c,r]=MEB_App(P,epsilon)
% P is a point set
% epsilon is the threshold
% c is the approximate center of the MEB of P
num1=floor(1/(epsilon^2));% the number of iterations
num2=size(P,2);% the number of points in P
c=P(:,randi(num2));
for i=1:num1
    dif_M=bsxfun(@minus,c,P);
    dis=sqrt(sum(dif_M.^2,1));
    [r,ind]=max(dis);
    p=P(:,ind);
    c=c+(p-c)/(i+1);
end

