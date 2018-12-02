clear
clc
datapath='F:\Matlab\OCSVM\MNIST\Gray_New\';
namefiles=dir(datapath);
numfiles=numel(namefiles);
timeTab=zeros(10,6);
for xiaoyei=3:numfiles
    for xiaoyej=5:5:30
        conds=['-s 2 -g 0.0001 -n ',num2str(0.01*xiaoyej)];
        [namefiles(xiaoyei).name,'_',num2str(xiaoyej)]
        t0=cputime;
        load([datapath,namefiles(xiaoyei).name,'\P_',num2str(xiaoyej),'.mat']);
        load([datapath,namefiles(xiaoyei).name,'\label_',num2str(xiaoyej),'.mat']);
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
        timeTab(xiaoyei-2,xiaoyej/5)=tn;
        save(['Res\MNIST_New\',namefiles(xiaoyei).name,'_',num2str(xiaoyej),'.mat'],'F1');
    end
end
save('Res\MNIST_New\z.mat','timeTab');