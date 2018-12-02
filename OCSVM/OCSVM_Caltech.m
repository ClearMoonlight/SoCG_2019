clear
clc
datapath='F:\Matlab\OCSVM\Caltech\VGGData_New\';
namefiles={'airplanes','binoculars','bonsai','cup','faces','ketch',...
    'laptop','motorbikes','sneaker','t-shirt','watch'};
numfiles=numel(namefiles);
timeTab=zeros(11,6);
for xiaoyei=1:numfiles
    for xiaoyej=5:5:30
        conds=['-s 2 -g 0.0000001 -n ',num2str(0.01*xiaoyej)];
        [namefiles{xiaoyei},'_',num2str(xiaoyej)]
        t0=cputime;
        load([datapath,namefiles{xiaoyei},...
            '\P_',num2str(xiaoyej),'.mat']);
        load([datapath,namefiles{xiaoyei},...
            '\label_',num2str(xiaoyej),'.mat']);
        trainingMat=P';
        n=size(trainingMat,1);
        trainingLab=ones(n,1);
        model=svmtrain(trainingLab,trainingMat,conds);
        [predictedLab,accuracy,decVal]=svmpredict(trainingLab,trainingMat,model);
        lab=(predictedLab==1);
        TP=0;
        for i=1:n
            if lab(i)==1 && label(i)==1
                TP=TP+1;
            end
        end
        Precision=TP/sum(lab);
        Recall=TP/sum(label);
        F1=2*Precision*Recall/(Precision+Recall);
        tn=cputime-t0;
        timeTab(xiaoyei,xiaoyej/5)=tn;
        save(['Res\Caltech_New\',namefiles{xiaoyei},'_',num2str(xiaoyej),'.mat'],'F1');
    end
end
save('Res\Caltech_New\z.mat','timeTab');