function [z_opt,si_opt] = alternating_Opt_si(K,pmax,N,B,gi,gj,sj,x0)

%vectors to be optimized
% x = [zk,vk] for k = 1...8

%weights for each phase k according to base station 
gi_f = gi([1 1 2 2]);
gj_f = gj([1 1 2 2]);

gi_s = gi([1 2 1 2]);
gj_s = gj([1 2 1 2]);




%objective function
s = @(x)sum(x(1:16));

%linear inequality constraints
c2 = [-log(1+sj),zeros(1,8)];
c3 = [zeros(1,8),1./gi_f + (gj_f.*sj(1:4))./(gi_f.*gj_s),1./gi_s];
c4 = [sj(1:4)./gj_s,sj(5:8)./gj_f,zeros(1,4),(gi_f.*sj(5:8))./(gj_f.*gi_s)];

A = [c2;c3;c4];
b = [-N/B,K*pmax,K*pmax];

%non linear inequality constraints
nonlcon = @(x)deal(N/B - sum(x(1:8).*log2(1+x(9:16)./x(1:8))),[]) ;


%lb = 0.15*ones(1,16);
lb = zeros(1,16);
ub = Inf*ones(1,16);

%solution

%starting point

%x0 = ones(1,16); %change it

oldoptions = optimoptions('fmincon','Algorithm','interior-point');
options = optimoptions(oldoptions,'PlotFcns',@optimplotfval);
[x,~]= fmincon(s,x0,A,b,[],[],lb,ub,nonlcon,options);

z_opt = x(1:8);
si_opt = x(9:16)./z_opt;


end

