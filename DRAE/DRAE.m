clear
clc
%% Load all the paramters
addpath minFunc/
Params;
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
        numIter
        indRecerr=diffSeq(k);
        lab=(diff<=indRecerr);
        TP=0;
        for i=1:AE.Num
            if lab(i)==1 && label(i)==1
                TP=TP+1;
            end
        end
        Precision=TP/sum(lab)
        Recall=TP/k
        F1=2*Precision*Recall/(Precision+Recall)
    end
    
    dataSeq=data(:,indx);
    [opttheta2,cost]=minFunc(@(p)autoencoderCost2(p,AE,dataSeq),opttheta,options);
    numIter=numIter-1;
    
    theta=opttheta2;
end