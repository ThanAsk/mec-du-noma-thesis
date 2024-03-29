function [min_delay,z_min] = geometricOpt(K,pmax,N,gi,gj) 

%geometric method
%optimize with interior-point method the transformed variables
%[e^z,e^p,e^r]

%  optimization variables  x = [z,pi,pj,ri,rj]


%objective function
s = @(x)sum(exp(x(1:8)));

%non linear inequality constraints
nonlcon = @(x)geometric_cons(x,K,pmax,N,gi,gj) ;


%lb = 0.15*ones(1,8);
lb = zeros(1,40);
ub = Inf*ones(1,40);

%solution

%starting point

x0 = ones(1,40); %change it

%options = optimoptions('linprog','Algorithm','dual-simplex');
options = optimset('PlotFcns',@optimplotfval);
[x,delay]= fmincon(s,x0,[],[],[],[],lb,ub,nonlcon,options);

min_delay = delay;
z_min = exp(x(1:8));



end