clear
clc
% Parameters
title=[4,8,16];
candNo=numel(title);
delta=0.8;
mu=0.8;
%% Main code
for k=2:5
    % Load inliers
    load(['Data/Caltech/Original/k=',num2str(k),'/inlM.mat']);
    % Load groundtruth
    load(['Data/Caltech/Original/k=',num2str(k),'/kIf.mat']);
    D=size(inlM,1);
    inlN=size(inlM,2);
    for cno=1:candNo
        [k,cno]
        PM=randn(ceil(D/title(cno)),D);
        NinlM=PM*inlM;
        save(['Data/Caltech/JL/k=',num2str(k),'/1-',...
            num2str(title(cno)),'/NinlM.mat'],'NinlM');
        resTab=zeros(20,5);
        timTab=zeros(20,5);
        for ort=1:5
            % Load outliers
            load(['Data/Caltech/Original/k=',num2str(k),'/oulM_',num2str(ort),'.mat']);
            NoulM=PM*oulM;
            save(['Data/Caltech/JL/k=',num2str(k),'/1-',...
                num2str(title(cno)),'/NoulM_',num2str(ort),'.mat'],'NoulM');
            % the number of outliers
            oulN=size(oulM,2);
            % the total number of points
            Ov=floor( (1+delta/k)*oulN );
            Sv=floor( (1+k/delta)*log(k/mu) );
            oriP=[inlM,oulM];
            P=[NinlM,NoulM];
            N=inlN+oulN;
            for tno=1:20
                firN=randi(N);
                t0=cputime;
                candCs=kTree_JL(P,firN,Ov,Sv,inlN,k);
                disSeq=sqrt(sum(bsxfun(@minus,oriP(:,candCs(1)),oriP).^2));
                for i=2:k
                    tempDis=sqrt(sum(bsxfun(@minus,oriP(:,candCs(i)),oriP).^2));
                    disSeq=min([disSeq;tempDis]);
                end
                disSeq=sort(disSeq);
                appRad=disSeq(inlN)/max(kIf);
                tn=cputime-t0;
                resTab(tno,ort)=appRad;
                timTab(tno,ort)=tn;
            end
        end
        save(['Results/Caltech/JL/k=',num2str(k),'/1-',...
            num2str(title(cno)),'/resTab.mat'],'resTab');
        save(['Results/Caltech/JL/k=',num2str(k),'/1-',...
            num2str(title(cno)),'/timTab.mat'],'timTab');
    end
end