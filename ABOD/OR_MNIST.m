clear
clc

datapath='/home/yemingqu/Mingquan/ICML_2017/ORData/MNIST/Gray_New/';
timeTab=zeros(10,6);
for xiaoye=6:9
    for i=5:5:30
        [num2str(xiaoye),'_',num2str(i)]
        t0=cputime;
        load([datapath,'/',num2str(xiaoye),'/P_',num2str(i),'.mat']);
        load([datapath,'/',num2str(xiaoye),'/label_',num2str(i),'.mat']);
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
        timeTab(xiaoye+1,i/5)=tn;
        save(['Results/MNIST_New/',num2str(xiaoye),'_',num2str(i),'.mat'],'F1');
    end
end
save('Results/MNIST_New/z.mat','timeTab');