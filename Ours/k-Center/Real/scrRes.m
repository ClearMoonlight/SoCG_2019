new_resTab=zeros(10,5);
new_timTab=zeros(10,5);
for i=1:2:20
    new_resTab((i+1)/2,:)=min([resTab(i,:);resTab(i+1,:)]);
    new_timTab((i+1)/2,:)=sum([timTab(i,:);timTab(i+1,:)]);
end
mean(new_resTab)
std(new_resTab)
mean(sum(new_timTab,2))