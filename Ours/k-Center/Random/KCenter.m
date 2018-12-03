clear
clc
%% Load data
load('Data/inlP.mat');
load('Data/inlArr.mat');
load('Data/kInfo.mat');
load('Data/outlP.mat');
% the number of kinds of inliers
cenN=numel(inlP);
% the number of all the outliers
outTno=size(outlP,2);
% parameters
delta=0.8;
mu=0.8;
%% Main code
for k=2:2
    radApp=zeros(20,5);
    timRes=zeros(20,5);
    inSel=randperm(cenN,k);
    % the inliers matrix
    inlM=[];
    for i=1:k
        inlM=[inlM,inlP{inSel(i)}];
    end
    save(['Data/Original/k=',num2str(k),'/inlM.mat'],'inlM');
    kInfo=kInfo.rad(inSel);
    save(['Data/Original/k=',num2str(k),'/kInfo.mat'],'kInfo');
    % the number of inliers
    inlN=sum(inlArr(inSel));
    for ort=1:5
        gamma=0.1*ort;
        % the number of outliers
        oulN=ceil( gamma*inlN/(1-gamma) );
        Ov=floor( (1+delta/k)*oulN );
        Sv=floor( (1+k/delta)*log(k/mu) );
        % the outliers matrix
        oulM=outlP(:,randperm(outTno,oulN));
        save(['Data/Original/k=',num2str(k),'/oulM_',num2str(ort),'.mat'],'oulM');
        P=[inlM,oulM];
        % the number of total points
        N=inlN+oulN;
        for tno=1:20
            [k,ort,tno]
            firN=randi(N);
            t0=cputime;
            appRad=kTree(P,firN,Ov,Sv,inlN,k);
            tn=cputime-t0;
            radApp(tno,ort)=appRad/max(kInfo);
            timRes(tno,ort)=tn;
        end
    end
    save(['Results/Original/k=',num2str(k),'/radApp.mat'],'radApp');
    save(['Results/Original/k=',num2str(k),'/timRes.mat'],'timRes');
end