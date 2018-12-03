function appRad=kTree_Re(P,firN,Ov,Sv,inlN,k)
% P is the point set
% firP is the root node
% Ov=(1+delta/k)*gamma*N
% Sv=(1+k/delta)*ln(k/mu)
% inlN is the number of inliers
q=javaObject('java.util.LinkedList');
rNode{1}=sqrt( sum( bsxfun(@minus,P(:,firN),P).^2 ) );
rNode{2}=[];
q.add(rNode);
count=1;
treeSz=(Sv^(k-1)-1)/(Sv-1);
%% Construct the tree
while count<treeSz
    hQ=q.pop();
    dis=hQ(1)';
    [~,pSeq]=sort(dis);
    OvP=pSeq(end-Ov+1:end);
    SvP=OvP(randperm(Ov,Sv));
    for i=1:Sv
        tempDis=...
            sqrt( sum( bsxfun(@minus,P(:,SvP(i)),P).^2 ) );
        node{1}=min([dis;tempDis]);
        node{2}=[hQ(2),P(:,SvP(i))];
        q.add(node);
    end
    count=count+Sv;
end
maxV=1e+8;
while q.size()>0
    hQ=q.pop();
    dis=hQ(1)';
    [~,pSeq]=sort(dis);
    OvP=pSeq(end-Ov+1:end);
    SvP=OvP(randperm(Ov,Sv));
    for i=1:Sv
        tempDis=...
            sqrt( sum( bsxfun(@minus,P(:,SvP(i)),P).^2 ) );
        tempDis=sort( min([dis;tempDis]) );
        if tempDis(inlN)<maxV
            maxV=tempDis(inlN);
            PIV=[hQ(2),P(:,SvP(i))];
        end
    end
end
%% Refinement
N=size(P,2);
finDis=zeros(1,N);
for i=1:N
    finDis(i)=min( sqrt(sum(bsxfun(@minus,P(:,i),PIV).^2)) );
end
[~,pSeq]=sort(finDis);
OvP=pSeq(end-Ov+1:end);
SvP=OvP(randperm(Ov,Sv));
appRad=1e+8;
for i=1:Sv
    tempDis=...
        sqrt( sum( bsxfun(@minus,P(:,SvP(i)),P).^2 ) );
    tempDis=sort(min([finDis;tempDis]));
    if tempDis(inlN)<appRad
        appRad=tempDis(inlN);
    end
end