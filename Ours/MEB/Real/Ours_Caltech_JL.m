clear
clc
oriImg='/home/yemingqu/Mingquan/SoCG_2019/Data/Caltech/VGG/';
comImg='/home/yemingqu/Mingquan/SoCG_2019/Data/Caltech/JL/1-';
filenames={'airplanes','binoculars','bonsai','cup','faces','ketch',...
    'laptop','motorbikes','sneaker','t-shirt','watch'};
title=[4,8,16];
cn=numel(title);
for candn=1:cn
    resTab=zeros(11,6,20);
    timTab=zeros(11,6,20);
    for ol=1:20
        for iInd=1:11
            tempStr=filenames{iInd};
            for oRat=5:5:30
                [candn,ol,iInd,oRat]
                %% Load data                
                load([oriImg,tempStr,'/P_',num2str(oRat),'.mat']);
                load([oriImg,tempStr,'/label_',num2str(oRat),'.mat']);
                oriP=P;
                clear P
                load([comImg,num2str(title(candn)),'/',tempStr,'/P_',...
                    num2str(oRat),'.mat']);
                %% Parameters------------------------------------------------------
                Param;
                %% Outlier Recognition---------------------------------------------
                q=javaObject('java.util.LinkedList');
                firNo=randi(N);
                btCen=P(:,firNo);
                OR_New;
                %% F1 and Time
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
                timTab(iInd,oRat/5,ol)=tn;
                resTab(iInd,oRat/5,ol)=F1;
            end
        end
    end
    save(['Res/Caltech/JL/1-',num2str(title(candn)),'/resTab.mat'],'resTab');
    save(['Res/Caltech/JL/1-',num2str(title(candn)),'/timTab.mat'],'timTab');
end