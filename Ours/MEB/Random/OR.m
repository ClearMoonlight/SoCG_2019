t0=cputime;
indI=1+S_v;
[bestR,Sv]=Pv_Sv_Ori(btCen,P,k,S_v);%the radius of the optimal cirlce
nodeIni=zeros(D,2);
for i=1:S_v
    nodeIni(:,1)=btCen;
    nodeIni(:,2)=Sv(:,i);
    q.add(nodeIni);
end
%%
while q.size()>0
    node=q.pop();%the head of the queue q
    testCen=MEB(node,epsilon2);
    [testR,Sv]=Pv_Sv_Ori(testCen,P,k,S_v);
    if testR<bestR
        btCen=testCen;
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
tn=cputime-t0;
clear q;