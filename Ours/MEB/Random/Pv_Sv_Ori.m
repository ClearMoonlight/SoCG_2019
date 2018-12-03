function [V,Sv]=Pv_Sv_Ori(p,P,k,s)
% construct the point set Pv and Sv
% p is the center, and P is the point set
% k=(1+delta)*gamma*n is the size of Pv
% s=floor((1+1/delta)*log(h/mu)) is the size of Sv

dis=bsxfun(@minus,p,P);
eucliDis=sqrt(sum(dis.^2,1));
[~,index]=sort(eucliDis,'descend');

seqP=P(:,index);
V=norm(p-seqP(:,k));

Pv=seqP(:,1:k);%the set Pv
genNo=randperm(k,s);
Sv=Pv(:,genNo);%the set Sv