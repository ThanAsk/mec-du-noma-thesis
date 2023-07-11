
B = 1;
N = 0.5;
[gi,gj] = set_gains('random');

K = 1;
pmax = 30;

%Initialize x = [ni,nj,ei,ej,pi,pj]

%(heuristic) feasible values 
ni0 = (N/8*B)*ones(1,8);
nj0 = (N/8*B)*ones(1,8);
ei0 = (K*pmax/8)*ones(1,8);
ej0 = (K*pmax/8)*ones(1,8);
pi0 = 5*ones(1,8);
pj0 = 5*ones(1,8);

x0 =[ni0,nj0,ei0,ej0,pi0,pj0];

%iteration number
l = 0;

%Tolerances for convergence check
ex = 10^-4;
ef = 10^-4;

Ax = Inf;
Af = Inf;

%Auxiliary variables for quadratic transform
[y,c] = transform_terms(gi,gj,x0);

xk = x0;
fk = sum(ei0./pi0);

while Ax > ex && Af >ef


%optimize with y,c fixed
[x_min,f_min] = fractionalOpt(gi,gj,K,pmax,N,B,y,c,xk);

%update auxiliary variables optimally

[y,c] = transform_terms(gi,gj,x_min);
Ax = sqrt(sum((x_min-xk).^2));
Af = abs(f_min-fk);

xk = x_min;
fk = f_min;
[z,min_delay] = fractional_delay(gi,gj,xk); 

end









