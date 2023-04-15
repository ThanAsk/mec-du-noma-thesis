function [c,ceq] = geometric_cons3(x,K,pmax,N,gi,gj,x0)
%nonlinear constraints for geometricOpt 

z = x(1:8);
pi = x(9:16);
pj = x(17:24);
ri = x(25:32);
rj = x(33:40);

xi0 = [x0(1:8),x0(25:32)];
xj0 = [x0(1:8),x0(33:40)];

dec_1 = [1 1 2 2 1 2 1 2]; %indices for gains of user i
dec_2 = [1 2 1 2 1 1 2 2];  %indices for gains of user j

%c = zeros(1:20);
ceq = [];

% DC

c(1) = approxConstraint([z,ri],xi0,N);
c(2) = approxConstraint([z,rj],xj0,N); 

c(3) = log(sum(exp(z + pi))) - log(K*pmax);
c(4) = log(sum(exp(z + pj))) - log(K*pmax);

gi_1 = gi(dec_1);
gj_1 = gj(dec_1);

gi_2 = gi(dec_2);
gj_2 = gj(dec_2);

c(5:8) = arrayfun(@(k)log((1/gi_1(k))*exp(-pi(k))+(gj_1(k)/gi_1(k))*exp(pj(k)-pi(k)))+log(2^(exp(ri(k)))-1),[1 2 3 4]);
c(9:12) = arrayfun(@(k)log(2^(exp(ri(k)))-1)-pi(k)-log(gi_1(k)),[5 6 7 8]);

c(13:16) = arrayfun(@(k)log((1/gj_2(k))*exp(-pj(k))+(gi_2(k)/gj_2(k))*exp(pi(k)-pj(k)))+log(2^(exp(rj(k)))-1),[5 6 7 8]);
c(17:20) = arrayfun(@(k)log(2^(exp(rj(k)))-1)-pj(k)-log(gj_2(k)),[1 2 3 4]);






end

