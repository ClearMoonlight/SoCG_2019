function appRad=kTree(P,firN,Ov,Sv,inlN,k)
% P is the point set
% firP is the root node
% Ov=(1+delta/k)*gamma*N
% Sv=(1+k/delta)*ln(k/mu)
% inlN is the number of inliers
q=javaObject('java.util.LinkedList');
rNode=sqrt( sum( bsxfun(@minus,P(:,firN),P).^2 ) );
q.add(rNode);
count=1;
treeSz=(Sv^(k-1)-1)/(Sv-1);
%% Construct the tree
while count<treeSz
    hQ=q.pop();
    [~,pSeq]=sort(hQ);
    OvP=pSeq(end-Ov+1:end);
    SvP=OvP(randperm(Ov,Sv));
    for i=1:Sv
        tempDis=...
            sqrt( sum( bsxfun(@minus,P(:,SvP(i)),P).^2 ) );
        node=min([hQ';tempDis]);
        q.add(node);
    end
    count=count+Sv;
end
appRad=1e+8;
while q.size()>0
    hQ=q.pop();
    [~,pSeq]=sort(hQ);
    OvP=pSeq(end-Ov+1:end);
    SvP=OvP(randperm(Ov,Sv));
    for i=1:Sv
        tempDis=...
            sqrt( sum( bsxfun(@minus,P(:,SvP(i)),P).^2 ) );
        tempDis=sort( min([hQ';tempDis]) );
        if tempDis(inlN)<appRad
            appRad=tempDis(inlN);
        end
    end
end
