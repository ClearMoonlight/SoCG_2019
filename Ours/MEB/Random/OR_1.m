t0=cputime;
indI=1+S_v;
[bestR,Sv,pCh]=Pv_Sv(btCen,P,k,S_v);%the radius of the optimal cirlce
nodeIni=zeros(D,2);
firNode=cell(2,1);
for i=1:S_v
    nodeIni(:,1)=btCen;
    nodeIni(:,2)=Sv(:,i);
    firNode{1}=nodeIni;
    firNode{2}=[firNo,pCh(i)];
    q.add(firNode);
end
%% 
resNo1=firNo;
resCom1=1;
while q.size()>0
    node=q.pop();%the head of the queue q 
    [canCen,coeCom,~]=MEB_App(node(1),epsilon2);
    [testR,Sv,pCh]=Pv_Sv(canCen,P,k,S_v);
    if testR<bestR
        bestR=testR;
        btCen=canCen;
        resNo1=node(2);
        resCom1=coeCom;
    end
    if indI<indicator
        for i=1:S_v
            nodeTemp{1}=cat(2,node(1),Sv(:,i));
            nodeTemp{2}=[node(2);pCh(i)];
            q.add(nodeTemp);
        end
        indI=indI+S_v;
    end
end
t1=cputime-t0;
clear q