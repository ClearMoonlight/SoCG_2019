clear
clc

addpath 'genData/'
%% Load data
load('genData/oriData.mat');
load('genData/numOut.mat');
load('genData/cirInfo.mat');
%% Approximated MEB
alpha=40;
beta=40;
oriD=size(oriData{1},1);
RM=randn(ceil(oriD/beta),oriD);
appRes=zeros(6,5,5);
timRes=zeros(6,5,5);
for seqT=1:5
    for h=5:10
        for gaIdx=1:5
            seqT,h,gaIdx
            P=RM*oriData{gaIdx};
            newN=ceil(size(P,2)/alpha);
            sampOrd=randperm(size(P,2),newN);
            P=P(:,sampOrd);
            D=size(P,1);
            N=size(P,2);% the number of total points
            num=ceil(numOut(gaIdx)/alpha);% the number of outliers
            gamma=gaIdx*0.1; % the ratio of outliers
            %epsilon1=0.4;
            epsilon2=0.1;
            delta=0.5;
            mu=0.5;
            %h=ceil(2/epsilon1);
            S_v=5;%floor((1+1/delta)*log(h/mu));
            k=floor((1+delta)*num);
            indicator=(S_v^h-1)/(S_v-1);%judge when to stop adding points to queue q
            indI=1+S_v;
            %% Outlier Recognition---------------------------------------------
            q=javaObject('java.util.LinkedList');
            firNo=randi(N);
            btCen=P(:,firNo);
            OR_1;
            q=javaObject('java.util.LinkedList');
            OR_2;
            %% Approximation ratio
            disp('Radius approximation ratio');
            resNo=[resNo1;resNo2(2:end)];
            resNo=sampOrd(resNo);
            resCom=[resCom1*resCom2(1),resCom2(2:end)];
            retCen=sum(oriData{gaIdx}(:,resNo)*resCom',2);
            difMat=bsxfun(@minus,retCen,oriData{gaIdx});
            eucDis=sqrt(sum(difMat.^2,1));
            [ordDis,~]=sort(eucDis);
            appRad=ordDis(N-num);
            appRat=appRad/cirInfo.rad;
            appRes(h-4,gaIdx,seqT)=appRat;
            timRes(h-4,gaIdx,seqT)=tn;
        end
    end
end
save('Res/Tree/appRes.mat','appRes');
save('Res/Tree/timRes.mat','timRes');