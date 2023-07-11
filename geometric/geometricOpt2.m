function [min_delay,z_min] = geometricOpt2(K,pmax,N,gi,gj) 

%geometric method
%optimize with interior-point method the transformed variables
%[e^z,e^p,e^r]

%  optimization variables  x = [z,ei,ej,ri,rj]

A = Inf;
tol = 10^-6;
%x0 = [zeros(1,8),(K*pmax/8).*ones(1,8),(K*pmax/8).*ones(1,8),zeros(1,8),zeros(1,8)];
x0 = zeros(1,40);

t = 0;
while A > tol
%objective function
s = @(x)log(sum(exp(x(1:8))));

%non linear inequality constraints
nonlcon = @(x)geometric_cons2(x,K,pmax,N,gi,gj,x0) ;


%lb = 0.15*ones(1,8);
lb = [];
ub = Inf*ones(1,40);

%solution


oldoptions = optimoptions('fmincon','Algorithm','interior-point');
options = optimoptions(oldoptions,'PlotFcns',@optimplotfval);
[x_opt,~]= fmincon(s,x0,[],[],[],[],lb,ub,nonlcon,options);


A = sqrt((x_opt-x0).^2);
x0 = x_opt;

t = t + 1;

end

%min_delay = delay;
z_min = exp(x0(1:8));
min_delay = sum(z_min);


end