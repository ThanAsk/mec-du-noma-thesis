function [c,ceq] = partial_cons(x,K,pmax,gi,gj,params,x0)
%nonlinear constraints for geometricOpt 

%optimization vector x = [z,pi,pj,ri,rj,Li,Lj,fi,fj,y]
z = x(1:8);
pi = x(9:16);
pj = x(17:24);
ri = x(25:32);
rj = x(33:40);
Li = x(41);
Lj = x(42);
fi = x(43);
fj = x(44);
y = x(45);


%simulatio parameters vector [B,N,Xi,Xj,ki,kj,fmax]
B = params(1);
N = params(2);
Xi = params(3);
Xj = params(4);
ki = params(5);
kj = params(6);
fmax = params(7);
N_o = params(8); 

xi0 = [x0(1:8),x0(25:32),x0(41)];
xj0 = [x0(1:8),x0(33:40),x0(42)];

dec_1 = [1 1 2 2 1 2 1 2]; %indices for gains of user i
dec_2 = [1 2 1 2 1 1 2 2];  %indices for gains of user j

%c = zeros(1:20);
ceq = [];

% DC

c(1) = approxConstraint_partial([z,ri,Li],xi0,B,N);
c(2) = approxConstraint_partial([z,rj,Lj],xj0,B,N); 

c(3) = log(sum(exp(z + pi)) + (ki*Xi/B*N_o)*exp(Li)) - log(K*pmax);
c(4) = log(sum(exp(z + pj)) + (kj*Xj/B*N_o)*exp(Lj)) - log(K*pmax);

gi_1 = gi(dec_1);
gj_1 = gj(dec_1);

gi_2 = gi(dec_2);
gj_2 = gj(dec_2);

c(5:8) = arrayfun(@(k)log((1/gi_1(k))*exp(-pi(k))+(gj_1(k)/gi_1(k))*exp(pj(k)-pi(k)))+log(2^(exp(ri(k)))-1),[1 2 3 4]);
c(9:12) = arrayfun(@(k)log(2^(exp(ri(k)))-1)-pi(k)-log(gi_1(k)),[5 6 7 8]);

c(13:16) = arrayfun(@(k)log((1/gj_2(k))*exp(-pj(k))+(gi_2(k)/gj_2(k))*exp(pi(k)-pj(k)))+log(2^(exp(rj(k)))-1),[5 6 7 8]);
c(17:20) = arrayfun(@(k)log(2^(exp(rj(k)))-1)-pj(k)-log(gj_2(k)),[1 2 3 4]);

c(21) = 0;





end

