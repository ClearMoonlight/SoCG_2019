function [V,Sv]=Pv_Sv(p,P,k,RP,s)
dis=bsxfun(@minus,p,P);
eucliDis=sqrt(sum(dis.^2,1));
[~,index]=sort(eucliDis,'descend');

seqP=P(:,index);
Pin=seqP(:,RP+1:end);
PinMean=bsxfun(@minus,Pin,mean(Pin,2));
V=sum(sum(PinMean.^2,1));%/(n-K)%Var

Pv=seqP(:,1:k);%the set Pv
Sv=Pv(:,randperm(k,s));%the set Sv