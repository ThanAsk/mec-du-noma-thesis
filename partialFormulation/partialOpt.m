function [min_delay,z_min,Ax,Af,Li_opt,ni] = partialOpt(K,pmax,gi,gj,params)
%geometric method
%optimize with interior-point method the transformed variables
%[e^z,e^p,e^r]
%pmax: SNR in watt(!)
%params: vector of simulation parameters (all scalars), [B,N,Xi,Xj,ki,kj,fmax]


%  optimization variables  x = [z,ei,ej,ri,rj]

Ax = Inf;
Af = Inf;
tolx = 10^-6;
tolf = 10^-6;
%x0 = [zeros(1,8),(K*pmax/8).*ones(1,8),(K*pmax/8).*ones(1,8),zeros(1,8),zeros(1,8)];
x0 = zeros(1,45);


t = 0;
while Ax > tolx && Af > tolf 

%objective function
%s = @(x)log(sum(exp(x(1:8))));
s = @(x)x(45);

%non linear inequality constraints
nonlcon = @(x)partial_cons(x,K,pmax,gi,gj,params,x0) ;


%lb = 0.15*ones(1,8);
lb = [];
%ub = Inf*ones(1,40);
%ub = [Inf*ones(1,8),pmax*ones(1,8),pmax*ones(1,8),Inf*ones(1,20)];
ub = [];

%solution

options = optimoptions('fmincon','Algorithm','interior-point');
%Display objective value progression
% oldoptions = optimoptions('fmincon','Algorithm','interior-point');
% options = optimoptions(oldoptions,'PlotFcns',@optimplotfval);
[x_opt,~]= fmincon(s,x0,[],[],[],[],lb,ub,nonlcon,options);

z_opt = x_opt(1:8);
ri_opt = x_opt(25:32);
rj_opt = x_opt(33:40);
Li_opt = x_opt(41);
Lj_opt = x_opt(42);
y_opt = x_opt(45);

Ax = sqrt(sum((exp([z_opt,ri_opt,rj_opt,Li_opt,Lj_opt])-exp([x0(1:8),x0(25:32),x0(33:40),x0(41),x0(42)])).^2));
%A = sqrt((x_opt-x0).^2);
Af = abs(y_opt - x0(45));
x0 = x_opt;

t = t + 1

end

%min_delay = delay;
z_min = exp(x_opt(45));
min_delay = z_min;


ni = sum(exp(z_opt).*exp(ri_opt));


end

