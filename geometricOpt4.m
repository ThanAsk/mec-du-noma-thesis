function [min_delay,z_min] = geometricOpt4(K,pmax,N,gi,gj) 

%geometric method
%optimize with interior-point method the transformed variables
%[e^z,e^p,e^r]

%  optimization variables  x = [z,pi,pj,ri,rj,ni,nj]

A = Inf;
tol = 10^-6;
x0 = [zeros(1,8),(pmax/8).*ones(1,8),(pmax/8).*ones(1,8),zeros(1,8),zeros(1,8),N*ones(1,8),N*ones(1,8)];
%x0 = zeros(1,56);

t = 0;
while A > tol
%objective function
s = @(x)log(sum(exp(x(1:8))));

%equality constraints

Aeq = [[zeros(1,40),-ones(1,8),zeros(1,8)];[zeros(1,40),-ones(1,8),zeros(1,8)]];
% Aeq = @(x)[N-sum(x(41:48)),N-sum(x(49:56))];
beq = N*[1,1];

%non linear inequality constraints
nonlcon = @(x)geometric_cons4(x,K,pmax,N,gi,gj,x0) ;



lb = [];
%ub = Inf*ones(1,56);
ub = [Inf*ones(1,8),pmax*ones(1,8),pmax*ones(1,8),Inf*ones(1,16),Inf*ones(1,16)];

%solution


oldoptions = optimoptions('fmincon','Algorithm','interior-point');
options = optimoptions(oldoptions,'PlotFcns',@optimplotfval);
[x_opt,~]= fmincon(s,x0,[],[],Aeq,beq,lb,ub,nonlcon,options);


A = sqrt(sum((x_opt-x0).^2));
x0 = x_opt;

t = t + 1

end

%min_delay = delay;
z_min = exp(x0(1:8));
min_delay = sum(z_min);





end