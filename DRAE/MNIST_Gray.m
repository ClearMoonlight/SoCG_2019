clear
clc
%% Load all the paramters
addpath minFunc/
AE.lambda1=0.0005;
AE.lambda2=0.2;

options.Method = 'lbfgs';
options.maxIter = 20;
options.display = 'off';
timeTab=zeros(10,6);
for xiaoyei=0:9
    for xiaoyej=5:5:30
        [xiaoyei,xiaoyej]
        t0=cputime;
        load(['/home/yemingqu/Mingquan/ICML_2017/ORData/MNIST/Gray_New/',...
            num2str(xiaoyei),'/P_',num2str(xiaoyej),'.mat']);
        load(['/home/yemingqu/Mingquan/ICML_2017/ORData/MNIST/Gray_New/',...
            num2str(xiaoyei),'/label_',num2str(xiaoyej),'.mat']);
        AE.inputSz=size(P,1);
        AE.hiddenSz=ceil(AE.inputSz/3);
        %data=P;
        data=mapminmax(P,0,1);
        AE.Num=size(P,2);% the number of total points
        AE.Ni=sum(label);% the number of inliers
        AE.No=AE.Num-AE.Ni;% the number of outliers
        
        theta=parameters2theta(AE);% initialize the parameters
        k=AE.Ni; % the number of inliers
        numIter=20; % the number of iterations
        while numIter>0
            [opttheta,~]=minFunc(@(p)autoencoderCost1(p,AE,data),theta,options);
            [W1,W2,b1,b2]=theta2parameters(AE,opttheta);
            
            z2=bsxfun(@plus,W1*data,b1);
            a2=sigmoid(z2);
            z3=bsxfun(@plus,W2*a2,b2);
            dataOpt=sigmoid(z3);
            
            diff=sum( (dataOpt-data).^2,1 );
            [diffSeq,indx]=sort(diff);
            
            if mod(numIter,10)==0 || numIter==1
                indRecerr=diffSeq(k);
                lab=(diff<=indRecerr);
                TP=0;
                for i=1:AE.Num
                    if lab(i)==1 && label(i)==1
                        TP=TP+1;
                    end
                end
                Precision=TP/sum(lab);
                Recall=TP/k;
                F1=2*Precision*Recall/(Precision+Recall);
            end
            
            dataSeq=data(:,indx);
            [opttheta2,cost]=minFunc(@(p)autoencoderCost2(p,AE,dataSeq),opttheta,options);
            numIter=numIter-1;
            theta=opttheta2;
        end
        tn=cputime-t0;
        timeTab(xiaoyei+1,xiaoyej/5)=tn;
        save(['Res/MNIST/Gray_New/',num2str(xiaoyei),'_',num2str(xiaoyej),'.mat'],'F1');
    end
end
save('Res/MNIST/Gray_New/z.mat','timeTab');