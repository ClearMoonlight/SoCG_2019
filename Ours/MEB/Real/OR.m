t0=cputime;
[bestR,Sv]=Pv_Sv(bestCenter,P,k,RP,S_v);%the radius of the optimal cirlce
nodeIni=zeros(D,2);
for i=1:S_v
    nodeIni(:,1)=bestCenter;
    nodeIni(:,2)=Sv(:,i);
    q.add(nodeIni);
end
%% 
while q.size()>0
    node=q.pop();%the head of the queue q 
    testCenter=MEB_App(node,epsilon2);
    [testR,Sv]=Pv_Sv(testCenter,P,k,RP,S_v);
    if testR<bestR
        bestCenter=testCenter;
        bestR=testR;
    end
    if indI<indicator
        for i=1:S_v
            nodeTemp=cat(2,node,Sv(:,i));
            q.add(nodeTemp);
        end
        indI=indI+S_v;
    end
end
dis=bsxfun(@minus,bestCenter,P);
eucliDis=sqrt(sum(dis.^2,1));
[seqDis,indx]=sort(eucliDis);
resultR=seqDis(N-num);

lab=(eucliDis<=resultR);
TP=0;
for i=1:N
    if lab(i)==1 && label(i)==1
        TP=TP+1;
    end
end
Precision=TP/sum(lab);
Recall=TP/sum(label);
F1=2*Precision*Recall/(Precision+Recall);
tn=cputime-t0;
clear q;