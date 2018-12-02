clear
clc
title=[4,8,16];
orRt='/home/yemingqu/Mingquan/SoCG_2019/Data/Caltech/VGGData/';
deRt='/home/yemingqu/Mingquan/SoCG_2019/Data/Caltech/JL/';
files=dir(orRt);

Num=numel(files);
num=numel(title);
for candn=1:num
    for i=3:Num
        for j=5:5:30
            load([orRt,files(i).name,'/P_',num2str(j),'.mat']);
            load([orRt,files(i).name,'/label_',num2str(j),'.mat']);
            d=size(P,1);
            k=ceil(1/title(candn)*d);
            P=randn(k,d)*P;
            save([deRt,'1-',num2str(title(candn)),'/',files(i).name,...
                '/P_',num2str(j),'.mat'],'P');
            save([deRt,'1-',num2str(title(candn)),'/',files(i).name,...
                '/label_',num2str(j),'.mat'],'label');
        end
    end
end