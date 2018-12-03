clear
clc
imagepath='/home/yemingqu/Mingquan/SoCG_2019/Data/MNIST/Gray/';
resTab=zeros(10,6,20);
timTab=zeros(10,6,20);
for ol=1:20
    for iInd=0:9
        for oRat=5:5:30
            [ol,iInd,oRat]
            %% Load data
            load([imagepath,...
                num2str(iInd),'/P_',num2str(oRat),'.mat']);
            load([imagepath,...
                num2str(iInd),'/label_',num2str(oRat),'.mat']);
            Param;
            %% Outlier Recognition---------------------------------------------
            q=javaObject('java.util.LinkedList');
            bestCenter=P(:,randi(N));
            OR;
            resTab(iInd+1,oRat/5,ol)=F1;
            timTab(iInd+1,oRat/5,ol)=tn;
        end
    end
end
save('Res/MNIST/Gray/resTab.mat','resTab');
save('Res/MNIST/Gray/timTab.mat','timTab');