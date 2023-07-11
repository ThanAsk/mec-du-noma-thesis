function [x_opt,f_opt] = fractionalOpt(gi,gj,K,pmax,N,B,y,c,x0)

% gik = gi([1 1 2 2 1 1 2 2]);
% gjk = gj([1 1 2 2 1 1 2 2]);
% gf = [gj([1 1 2 2]),gi([1 1 2 2])];
% gs = [gj([1 2 1 2]),gi([1 2 1 2])];

%objective function
%d = @(x)sum(2*y.*sqrt(x(1:8) + x(9:16) + x(17:24) + x(25:32)) + (y.^2).*(log2(1+gik.*x(33:40)+gjk.*x(41:48))+x(33:40)+x(41:48)+max(0,log2(2*c.*(1+gs.*[x(41:44),x(37:40)])-(c.^2).*(1+gf.*[x(41:44),x(37:40)]))))); 
f = @(x)aux_objective(gi,gj,y,c,x);

%linear inequality constraints
C1 = [ones(1,8),zeros(1,40)];
C2 = [zeros(1,8),ones(1,8),zeros(1,32)];
C3 = [zeros(1,16),ones(1,8),zeros(1,24)];
C4 = [zeros(1,24),ones(1,8),zeros(1,16)];

A = [C1;C2;C3;C4];
b = [N/B,N/B,K*pmax,K*pmax];

%Bounds
lb = zeros(1,48);
ub = Inf*ones(1,48);

%optimization with interior point method
oldoptions = optimoptions('fmincon','Algorithm','interior-point');
options = optimoptions(oldoptions,'PlotFcns',@optimplotfval);
[x_opt,f_opt] = fmincon(f,x0,A,b,[],[],lb,ub,[],options);

end

