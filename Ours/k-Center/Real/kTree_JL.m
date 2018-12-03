function candCs=kTree_JL(P,firN,Ov,Sv,inlN,k)
% P is the point set
% firP is the root node
% Ov=(1+delta/k)*gamma*N
% Sv=(1+k/delta)*ln(k/mu)
% inlN is the number of inliers
% candCs are the returned k candidate centers
q=javaObject('java.util.LinkedList');
% root node
rNode{1}=sqrt( sum( bsxfun(@minus,P(:,firN),P).^2 ) );
rNode{2}=firN;
q.add(rNode);
count=1;
treeSz=(Sv^(k-1)-1)/(Sv-1);
%% Construct the tree
while count<treeSz
    hQ=q.pop();
    [~,pSeq]=sort(hQ(1));
    OvP=pSeq(end-Ov+1:end);
    SvP=OvP(randperm(Ov,Sv));
    for i=1:Sv
        tempDis=...
            sqrt( sum( bsxfun(@minus,P(:,SvP(i)),P).^2 ) );
        node{1}=min([hQ(1)';tempDis]);
        node{2}=[hQ(2);SvP(i)];
        q.add(node);
    end
    count=count+Sv;
end
appRad=1e+8;
while q.size()>0
    hQ=q.pop();
    [~,pSeq]=sort(hQ(1));
    OvP=pSeq(end-Ov+1:end);
    SvP=OvP(randperm(Ov,Sv));
    for i=1:Sv
        tempDis=...
            sqrt( sum( bsxfun(@minus,P(:,SvP(i)),P).^2 ) );
        tempDis=sort( min([hQ(1)';tempDis]) );
        if tempDis(inlN)<appRad
            appRad=tempDis(inlN);
            candCs=[hQ(2);SvP(i)];
        end
    end
end