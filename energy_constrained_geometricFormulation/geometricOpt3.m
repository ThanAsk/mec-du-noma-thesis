function [min_delay,z_min,Ax,Af] = geometricOpt3(K,pmax,N,gi,gj) 

%geometric method
%optimize with interior-point method the transformed variables
%[e^z,e^p,e^r]

%  optimization variables  x = [z,ei,ej,ri,rj]

Ax = Inf;
Af = Inf;
tolx = 10^-6;
tolf = 10^-6;
%x0 = [zeros(1,8),(K*pmax/8).*ones(1,8),(K*pmax/8).*ones(1,8),zeros(1,8),zeros(1,8)];
x0 = zeros(1,40);


t = 0;
while Ax > tolx && Af > tolf 
%objective function
s = @(x)log(sum(exp(x(1:8))));

%non linear inequality constraints
nonlcon = @(x)geometric_cons3(x,K,pmax,N,gi,gj,x0) ;


%lb = 0.15*ones(1,8);
lb = [];
%ub = Inf*ones(1,40);
ub = [Inf*ones(1,8),pmax*ones(1,8),pmax*ones(1,8),Inf*ones(1,16)];

%solution

options = optimoptions('fmincon','Algorithm','interior-point');
%Display objective value progression
% oldoptions = optimoptions('fmincon','Algorithm','interior-point');
% options = optimoptions(oldoptions,'PlotFcns',@optimplotfval);
[x_opt,~]= fmincon(s,x0,[],[],[],[],lb,ub,nonlcon,options);

z_opt = x_opt(1:8);
ri_opt = x_opt(25:32);
rj_opt = x_opt(33:40);

Ax = sqrt(sum((exp([z_opt,ri_opt,rj_opt])-exp([x0(1:8),x0(25:32),x0(33:40)])).^2));
%A = sqrt((x_opt-x0).^2);
Af = abs(sum(exp(z_opt)) - sum(exp(x0(1:8))));
x0 = x_opt;

t = t + 1

end

%min_delay = delay;
z_min = exp(x_opt(1:8));
min_delay = sum(z_min);





end