%% Parameters------------------------------------------------------
D=size(P,1);
N=size(P,2);% the number of total points
num=N-sum(label);% the number of outliers
gamma=oRat*0.01; % the ratio of outliers
if gamma<=0.2
    deltaP=0.1;
elseif gamma==0.3
    deltaP=0.2;
else
    deltaP=0.5;
end
epsilon1=0.5;
epsilon2=0.15;
delta=0.4;
mu=0.4;
h=ceil(2/epsilon1);
S_v=floor((1+1/delta)*log(h/mu));
k=floor((1+delta)*num);
RP=floor((1+deltaP)*num);
indicator=(S_v^h-1)/(S_v-1);%judge when to stop adding points to queue q
indI=1+S_v;