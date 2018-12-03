n=size(resTab,3);
outN=size(resTab,2);
newRes=zeros(n,outN);
newTim=zeros(1,n);
for i=1:n
    tptres=resTab(:,:,i);
    newRes(i,:)=mean(tptres);
    newTim(i)=sum(sum(timTab(:,:,i)));
end
mean(newRes)
std(newRes)
mean(newTim)