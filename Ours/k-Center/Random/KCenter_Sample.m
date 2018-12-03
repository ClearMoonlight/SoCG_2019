clear
clc
%% Parameters
title=[4,8,16];
candNo=numel(title);
delta=0.8;
mu=0.8;
for k=2:2
    % Load inliers (n,d)
    load(['Data/Original/k=',num2str(k),'/inlM.mat']);% inlM
    load(['Data/Original/k=',num2str(k),'/kInfo.mat']);%kInfo
    inlN=size(inlM,2);
    % Load inliers (n,d/8)
    load(['Data/JL/k=',num2str(k),'/1-8/NinlM.mat']);%  NinlM
    for cno=1:candNo
        [k,cno]
        resTab=zeros(20,5);
        timTab=zeros(20,5);
        for ort=1:5
            % Load outliers (n,d)
            load(['Data/Original/k=',num2str(k),'/oulM_',num2str(ort),'.mat']);
            oulN=size(oulM,2);
            N=inlN+oulN;
            oriP=[inlM,oulM];
            % Load outliers (n,d/8)
            load(['Data/JL/k=',num2str(k),'/1-8/NoulM_',num2str(ort),'.mat']);
            tempP=[NinlM,NoulM];
            % Sampled data
            genSeq=randperm(N,ceil(N/title(cno)));
            P=tempP(:,genSeq);
            newN=size(P,2);
            newoulN=ceil(oulN/title(cno));
            newinlN=newN-newoulN;
            Ov=floor( (1+delta/k)*newoulN );
            Sv=floor( (1+k/delta)*log(k/mu) );
            if Sv>Ov
                Sv=Ov;
            end
            for tno=1:20
                firN=randi(newN);
                t0=cputime;
                tempCs=kTree_JL(P,firN,Ov,Sv,newinlN,k);
                candCs=genSeq(tempCs);
                disSeq=sqrt(sum(bsxfun(@minus,oriP(:,candCs(1)),oriP).^2));
                for i=2:k
                    tempDis=sqrt(sum(bsxfun(@minus,oriP(:,candCs(i)),oriP).^2));
                    disSeq=min([disSeq;tempDis]);
                end
                disSeq=sort(disSeq);
                appRad=disSeq(inlN)/max(kInfo);
                tn=cputime-t0;
                resTab(tno,ort)=appRad;
                timTab(tno,ort)=tn;
            end
        end
        save(['Results/Sample/k=',num2str(k),'/1-',num2str(title(cno)),'/resTab.mat'],'resTab');
        save(['Results/Sample/k=',num2str(k),'/1-',num2str(title(cno)),'/timTab.mat'],'timTab');
    end
end