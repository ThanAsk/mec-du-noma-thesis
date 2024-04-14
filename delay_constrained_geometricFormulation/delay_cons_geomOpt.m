function [min_energy,ei_min,ej_min,Ax,Af] = delay_cons_geomOpt(Tmax,N,B,gi,gj,w)
%geometric method for the delay constraint minimization

%optimize the weighted sum of energies with respect to the transformed variables
%[e^z,e^p,e^r]

%  optimization variables  x = [z,ei,ej,ri,rj]

%Tolerances in range of variable (Ax) or objective function value(Af) for
%iteration 

Ax = Inf;
Af = Inf;
tolx = 10^-6;
tolf = 10^-6;

%Initial point for interior point method
x0 = zeros(1,40);

%Weights related to energy usage for each user
wi = w(1);
wj =w(2);

t = 0;
while Ax > tolx && Af > tolf 
%objective function
s = @(x)log(wi*sum(exp(x(9:16)+x(1:8)))+wj*sum(exp(x(17:24)+x(1:8))));

%non linear inequality constraints
nonlcon = @(x)delay_cons_geomCons(x,Tmax,N,B,gi,gj,x0) ;


%lb = 0.15*ones(1,8);
lb = [];
ub = Inf*ones(1,40);


%solution

options = optimoptions('fmincon','Algorithm','interior-point');
% oldoptions = optimoptions('fmincon','Algorithm','interior-point');
% options = optimoptions(oldoptions,'PlotFcns',@optimplotfval);
[x_opt,~]= fmincon(s,x0,[],[],[],[],lb,ub,nonlcon,options);


ei_opt = x_opt(9:16)+x_opt(1:8);
ej_opt = x_opt(17:24)+x_opt(1:8);
% ri_opt = x_opt(25:32);
% rj_opt = x_opt(33:40);

%Ax = sqrt(sum((exp([ei_opt,ej_opt])-exp([x0(9:16),x0(17:24)])).^2));
Ax = sqrt(sum((exp(x_opt))-exp(x0)).^2);
Af = abs(wi*sum(exp(ei_opt))+wj*sum(exp(ej_opt)) - wi*sum(exp(x0(9:16)+x0(1:8)))-wj*sum(exp(x0(17:24)+x0(1:8))));
x0 = x_opt;

t = t + 1

end

%min_delay = delay;
ei_min = exp(x0(9:16)+x0(1:8));
ej_min = exp(x0(17:24)+x0(1:8));
min_energy = wi*sum(ei_min)+wj*sum(ej_min);
min_energy = 10*log(min_energy); %in dB

end

