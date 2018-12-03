clear
clc
imagepath='/home/yemingqu/Mingquan/SoCG_2019/Data/Caltech/VGG/';
filenames={'airplanes','binoculars','bonsai','cup','faces','ketch',...
    'laptop','motorbikes','sneaker','t-shirt','watch'};
resTab=zeros(11,6,20);
timTab=zeros(11,6,20);
for ol=1:20
    for iInd=1:11
        for oRat=5:5:30
            tempStr=filenames{iInd};
            [ol,iInd,oRat]
            %% Load data
            load([imagepath,tempStr,'/P_',...
                num2str(oRat),'.mat']);
            load([imagepath,tempStr,'/label_',...
                num2str(oRat),'.mat']);
            %% Parameters------------------------------------------------------
            Param;
            %% Outlier Recognition---------------------------------------------
            q=javaObject('java.util.LinkedList');
            bestCenter=P(:,randi(N));
            OR;
            resTab(iInd,oRat/5,ol)=F1;
            timTab(iInd,oRat/5,ol)=tn;
        end
    end
end
save('Res/Caltech/VGG/resTab.mat','resTab');
save('Res/Caltech/VGG/timTab.mat','timTab');