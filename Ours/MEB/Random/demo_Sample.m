%% (d/8,n/4),(d/8,n/8),(d/8,n/16)
clear
clc
%% Load data
addpath 'genData/'
load('genData/oriData.mat');
load('genData/numOut.mat');
load('genData/cirInfo.mat');
%% Approximated MEB
alpha=[4,8,16];
cn=numel(alpha);
oriD=size(oriData{1},1);
RM=randn(ceil(oriD/8),oriD);
for candn=1:cn
    resTab=zeros(20,5);
    timTab=zeros(20,5);
    for allNo=1:20
        for gaIdx=1:5
            candn,allNo,gaIdx
            P=RM*oriData{gaIdx};
            oriN=size(P,2);
            orinum=numOut(gaIdx);
            newN=ceil(size(P,2)/alpha(candn));
            sampOrd=randperm(size(P,2),newN);
            P=P(:,sampOrd);
            D=size(P,1);
            N=size(P,2);% the number of total points
            num=ceil(numOut(gaIdx)/alpha(candn));% the number of outliers
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
            resNo=sampOrd(resNo);
            resCom=[resCom1*resCom2(1),resCom2(2:end)];
            retCen=sum(oriData{gaIdx}(:,resNo)*resCom',2);
            difMat=bsxfun(@minus,retCen,oriData{gaIdx});
            eucDis=sqrt(sum(difMat.^2,1));
            [ordDis,~]=sort(eucDis);
            appRad=ordDis(oriN-orinum);
            appRat=appRad/cirInfo.rad;
            resTab(allNo,gaIdx)=appRat;
            timTab(allNo,gaIdx)=(t1+t2)/2;
        end
    end
    save(['Res/Sampling/1-',num2str(alpha(candn)),'/resTab.mat'],'resTab');
    save(['Res/Sampling/1-',num2str(alpha(candn)),'/timTab.mat'],'timTab');
end