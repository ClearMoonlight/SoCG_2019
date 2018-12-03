clear
clc
oriImg='/home/yemingqu/Mingquan/SoCG_2019/Data/MNIST/Gray/';
comImg='/home/yemingqu/Mingquan/SoCG_2019/Data/MNIST/JL/';
title=[4,8,16];
cn=numel(title);
for candn=1:cn
    resTab=zeros(10,6,20);
    timTab=zeros(10,6,20);
    for ol=1:20
        for iInd=0:9
            for oRat=5:5:30
                [candn,ol,iInd,oRat]
                %% Load data
                load([oriImg,num2str(iInd),'/P_',num2str(oRat),'.mat']);
                load([oriImg,num2str(iInd),'/label_',num2str(oRat),'.mat']);
                oriP=P;
                clear P
                load([comImg,'1-',num2str(title(candn)),'/',...
                    num2str(iInd),'/P_',num2str(oRat),'.mat']);
                %% Parameters
                Param;
                %% Outlier Recognition---------------------------------------------
                q=javaObject('java.util.LinkedList');
                firNo=randi(N);
                btCen=P(:,firNo);
                OR_New;
                %% Approximation ratio
                retCen=sum(oriP(:,resNo)*resCom',2);
                difMat=bsxfun(@minus,retCen,oriP);
                eucDis=sqrt(sum(difMat.^2,1));
                [ordDis,~]=sort(eucDis);
                appRad=ordDis(N-num);
                lab=(eucDis<=appRad);
                TP=0;
                for i=1:N
                    if lab(i)==1 && label(i)==1
                        TP=TP+1;
                    end
                end
                Precision=TP/sum(lab);
                Recall=TP/sum(label);
                F1=2*Precision*Recall/(Precision+Recall);
                resTab(iInd+1,oRat/5,ol)=F1;
                timTab(iInd+1,oRat/5,ol)=tn;                
            end
        end
    end
    save(['Res/MNIST/JL/1-',num2str(title(candn)),'/resTab.mat'],'resTab');
    save(['Res/MNIST/JL/1-',num2str(title(candn)),'/timTab.mat'],'timTab');
end