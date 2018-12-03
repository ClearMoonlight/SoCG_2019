%% (n,d/4),(n,d/8),(n,d/16)
clear
clc
%% Load data
addpath 'genData/'
load('genData/oriData.mat');
load('genData/numOut.mat');
load('genData/cirInfo.mat');
%% Approximated MEB
title=[4,8,16];
cn=numel(title);
oriD=size(oriData{1},1);
for candn=1:cn
    appRes=zeros(20,5);
    timRes=zeros(20,5);
    RM=randn(ceil(oriD/title(candn)),oriD);
    for seqT=1:20
        for gaIdx=1:5
            candn,seqT,gaIdx
            P=RM*oriData{gaIdx};
            D=size(P,1);
            N=size(P,2);% the number of total points
            num=numOut(gaIdx);% the number of outliers
            gamma=gaIdx*0.1; % the ratio of outliers
            epsilon1=0.5;
            epsilon2=0.15;
            delta=0.4;
            mu=0.4;
            h=ceil(2/epsilon1);
            S_v=floor((1+1/delta)*log(h/mu));
            k=floor((1+delta)*num);
            indicator=(S_v^h-1)/(S_v-1);%judge when to stop adding points to queue q
            %% Outlier Recognition---------------------------------------------
            q=javaObject('java.util.LinkedList');
            firNo=randi(N);
            btCen=P(:,firNo);
            OR_1;
            q=javaObject('java.util.LinkedList');
            OR_2;
            %% Approximation ratio
            resNo=[resNo1;resNo2(2:end)];
            resCom=[resCom1*resCom2(1),resCom2(2:end)];
            retCen=sum(oriData{gaIdx}(:,resNo)*resCom',2);
            difMat=bsxfun(@minus,retCen,oriData{gaIdx});
            eucDis=sqrt(sum(difMat.^2,1));
            [ordDis,~]=sort(eucDis);
            appRad=ordDis(N-num);
            appRat=appRad/cirInfo.rad;
            %% Save
            appRes(seqT,gaIdx)=appRat;
            timRes(seqT,gaIdx)=(t1+t2)/2;
        end
    end
    save(['Res/JL/1-',num2str(title(candn)),'/appRes.mat'],'appRes');
    save(['Res/JL/1-',num2str(title(candn)),'/timRes.mat'],'timRes');
end