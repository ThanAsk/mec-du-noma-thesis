function [min_delay,c1_min,c2_min,z_min] = optimize_times_multi(pmax,K,B,N,gi,gj) 

%function handles
pi = @(c1,c2)[c1*pmax*ones(1,4),c2*pmax*ones(1,4)];
pj = @(c1,c2)[c2*pmax*ones(1,4),c1*pmax*ones(1,4)];

R = @(c1,c2)compute_rate_vec(gi,gj,pi(c1,c2),pj(c1,c2));
Ri = @(r)r(1:8);
Rj = @(r)r(8:16);

%nonlinear optimization

%objective function
s = @(x)[sum(x(1:8)),x(9),x(10)];
weight = 0.1*ones(1,3);
goal   = zeros(1,3);

%s = @(x)sum(x);


%non linear inequality constraints
C_1 = @(x)-B*Ri(R(x(9),x(10)))'*x(1:8)+N;
C_2 = @(x)-B*Rj(R(x(9),x(10)))'*x(1:8)+N;
C_3 = @(x)pi(x(9),x(10))'*x(1:8)-K*pmax;
C_4 = @(x)pj(x(9),x(10))'*x(1:8)-K*pmax;
C = @(x)[C_1(x);C_2(x);C_3(x);C_4(x)] ;
ceq = @(x)[];
nonlcon = @(x)deal(C(x),ceq(x));

%lb = 0.15*ones(1,8);
lb = zeros(1,10);
ub = [Inf*ones(1,8),1,1];

%solution
%options = optimoptions('linprog','Algorithm','dual-simplex');
options = optimset('PlotFcns',@optimplotfval);
[z,delay]= fgoalattain(s,[zeros(1,8),1,1],goal,weight,[],[],[],[],lb,ub,nonlcon,options);

min_delay = delay(1);
z_min = z(1:8);
c1_min = delay(2); %z(9);
c2_min = delay(3); %z(10);


end


