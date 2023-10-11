function [x_opt,f_opt] = fractionalOpt2(gi,gj,K,pmax,N,B,y,c,x0)


%objective function handle
f = @(x)aux_objective2(gi,gj,y,c,x);

%linear inequality constraints
C1 = [ones(1,8),zeros(1,40)];
C2 = [zeros(1,8),ones(1,8),zeros(1,32)];
C3 = [zeros(1,16),ones(1,8),zeros(1,24)];
C4 = [zeros(1,24),ones(1,8),zeros(1,16)];

A = [-C1;-C2;C3;C4];
b = [-N/B,-N/B,K*pmax,K*pmax];

%Bounds
lb = zeros(1,48);
ub = Inf*ones(1,48);

%optimization with interior point method
oldoptions = optimoptions('fmincon','Algorithm','interior-point');
options = optimoptions(oldoptions,'PlotFcns',@optimplotfval);
[x_opt,f_opt] = fmincon(f,x0,A,b,[],[],lb,ub,[],options);

end

