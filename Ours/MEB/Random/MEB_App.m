function [c,coeCom,r]=MEB_App(P,epsilon)
% P is a point set
% epsilon is the threshold
% c is the approximate center of the MEB of P
num1=floor(1/(epsilon^2));% the number of iterations
num2=size(P,2);% the number of points in P
firRnd=randi(num2);
c=P(:,firRnd);
coeCom=zeros(1,num2);
coeCom(firRnd)=1;
for i=1:num1
    dif_M=bsxfun(@minus,c,P);
    dis=sqrt(sum(dif_M.^2,1));
    [r,ind]=max(dis);
    p=P(:,ind);
    c=c+(p-c)/(i+1);
    coeCom=coeCom*(1-1/(i+1));
    coeCom(ind)=coeCom(ind)+1/(i+1);
end