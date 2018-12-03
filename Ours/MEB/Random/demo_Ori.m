clear
clc
addpath 'genData/'
%% Load data
load('genData/oriData.mat');
load('genData/numOut.mat');
load('genData/cirInfo.mat');
%% Approximated MEB
appRes=zeros(20,5);
timRes=zeros(20,5);
for seqT=1:20
    for gaIdx=1:5
        seqT,gaIdx
        P=oriData{gaIdx};
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
        OR;
        q=javaObject('java.util.LinkedList');
        OR;
        %% Approximation ratio
        difMat=bsxfun(@minus,btCen,P);
        clear P
        eucDis=sqrt(sum(difMat.^2,1));
        [ordDis,~]=sort(eucDis);
        appRad=ordDis(N-num);
        appRat=appRad/cirInfo.rad;
        
        appRes(seqT,gaIdx)=appRat;
        timRes(seqT,gaIdx)=tn;
    end
end
save('Res/Ori/appRes.mat','appRes');
save('Res/Ori/timRes.mat','timRes');