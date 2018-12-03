clear
clc
oriImg='/home/yemingqu/Mingquan/SoCG_2019/Data/MNIST/Gray/';
imgpath='/home/yemingqu/Mingquan/SoCG_2019/Data/MNIST/JL/1-8/';
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
                load([oriImg,...
                    num2str(iInd),'/P_',num2str(oRat),'.mat']);
                load([oriImg,...
                    num2str(iInd),'/label_',num2str(oRat),'.mat']);
                oriP=P;% the original point set
                oriN=size(oriP,2);% the number of points
                orin=oriN-sum(label);% the number of outliers
                clear P
                load([imgpath,...
                    num2str(iInd),'/P_',num2str(oRat),'.mat']);
                newN=ceil(oriN/title(candn));
                samNo=randperm(oriN,newN);
                P=P(:,samNo);
                %% Parameters------------------------------------------------------
                D=size(P,1);
                N=size(P,2);
                num=ceil(orin/title(candn));
                gamma=oRat*0.01; 
                if gamma<=0.2
                    deltaP=0.1;
                elseif gamma==0.3
                    deltaP=0.2;
                else
                    deltaP=0.5;
                end
                epsilon1=0.5;
                epsilon2=0.15;
                delta=0.4;
                mu=0.4;
                h=ceil(2/epsilon1);
                S_v=floor((1+1/delta)*log(h/mu));
                k=floor((1+delta)*num);
                RP=floor((1+deltaP)*num);
                indicator=(S_v^h-1)/(S_v-1);%judge when to stop adding points to queue q
                indI=1+S_v;
                %% Outlier Recognition---------------------------------------------
                q=javaObject('java.util.LinkedList');
                firNo=randi(N);
                btCen=P(:,firNo);
                OR_New;
                %% Result
                resNo=samNo(resNo);
                retCen=sum(oriP(:,resNo)*resCom',2);
                difMat=bsxfun(@minus,retCen,oriP);
                eucDis=sqrt(sum(difMat.^2,1));
                [ordDis,~]=sort(eucDis);
                appRad=ordDis(oriN-orin);
                lab=(eucDis<=appRad);
                TP=0;
                for il=1:oriN
                    if lab(il)==1 && label(il)==1
                        TP=TP+1;
                    end
                end
                Precision=TP/sum(lab);
                Recall=TP/sum(label);
                F1=2*Precision*Recall/(Precision+Recall);      
                timTab(iInd+1,oRat/5,ol)=tn;
                resTab(iInd+1,oRat/5,ol)=F1;
            end
        end
    end
    save(['Res/MNIST/Sample/1-',num2str(title(candn)),'/resTab.mat'],'resTab');
    save(['Res/MNIST/Sample/1-',num2str(title(candn)),'/timTab.mat'],'timTab');
end