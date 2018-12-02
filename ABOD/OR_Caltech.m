clear
clc

filefolder='Caltech/VGGData_New/';
datapath='/home/yemingqu/Mingquan/ICML_2017/ORData/';
namefiles={'airplanes','binoculars','bonsai','cup','faces','ketch',...
    'laptop','motorbikes','sneaker','t-shirt','watch'};
numfiles=numel(namefiles);
timeTab=zeros(11,6);
for xiaoyei=1:numfiles
    for xiaoyej=5:5:30
        [namefiles{xiaoyei},'_',num2str(xiaoyej)]
        t0=cputime;
        load([datapath,filefolder,...
            namefiles{xiaoyei},'/P_',num2str(xiaoyej),'.mat']);
        load([datapath,filefolder,...
            namefiles{xiaoyei},'/label_',num2str(xiaoyej),'.mat']);
        N=size(P,2);% the total number of points
        NumI=sum(label);
        suspicious_index=fastABOD(P',floor(N/100));
        lab=zeros(1,N);
        lab(suspicious_index(1:NumI))=1;
        TP=0;
        for j=1:N
            if lab(j)==1 && label(j)==1
                TP=TP+1;
            end
        end
        Precision=TP/sum(lab);
        Recall=TP/sum(label);
        F1=2*Precision*Recall/(Precision+Recall);
        tn=cputime-t0;
        timeTab(xiaoyei,xiaoyej/5)=tn;
        save(['Results/Caltech_New/',namefiles{xiaoyei},'_',num2str(xiaoyej),'.mat'],'F1');
    end
end
save('Results/Caltech_New/z.mat','timeTab');