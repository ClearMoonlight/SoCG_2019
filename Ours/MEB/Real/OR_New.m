t0=cputime;
[bestR,Sv,pCh]=Pv_Sv_New(btCen,P,RP,k,S_v);
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
resNo=firNo;
resCom=1;
while q.size()>0
    node=q.pop();%the head of the queue q 
    [canCen,coeCom,~]=MEB_App_New(node(1),epsilon2);
    [testR,Sv,pCh]=Pv_Sv_New(canCen,P,RP,k,S_v);
    if testR<bestR
        bestR=testR;
        btCen=canCen;
        resNo=node(2);
        resCom=coeCom;
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
tn=cputime-t0;
clear q