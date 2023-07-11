function [c,ceq] = geometric_cons4(x,K,pmax,gi,gj,x0)
%nonlinear constraints for geometricOpt 

z = x(1:8);
pi = x(9:16);
pj = x(17:24);
ri = x(25:32);
rj = x(33:40);
ni = x(41:48);
nj = x(49:56);

ni0 = x0(41:48);
nj0 = x0(49:56);

dec_1 = [1 1 2 2 1 2 1 2]; %indices for gains of user i
dec_2 = [1 2 1 2 1 1 2 2];  %indices for gains of user j

%c = zeros(1:20);
ceq = [];

% DC

c(1:8) = approxConstraint([z,ri,ni],ni0);
c(9:16) = approxConstraint([z,rj,nj],nj0); 

c(17) = log(sum(exp(z + pi))) - log(K*pmax);
c(18) = log(sum(exp(z + pj))) - log(K*pmax);

gi_1 = gi(dec_1);
gj_1 = gj(dec_1);

gi_2 = gi(dec_2);
gj_2 = gj(dec_2);

c(19:22) = arrayfun(@(k)log((1/gi_1(k))*exp(-pi(k))+(gj_1(k)/gi_1(k))*exp(pj(k)-pi(k)))+log(2^(exp(ri(k)))-1),[1 2 3 4]);
c(23:26) = arrayfun(@(k)log(2^(exp(ri(k)))-1)-pi(k)-log(gi_1(k)),[5 6 7 8]);

c(27:30) = arrayfun(@(k)log((1/gj_2(k))*exp(-pj(k))+(gi_2(k)/gj_2(k))*exp(pi(k)-pj(k)))+log(2^(exp(rj(k)))-1),[5 6 7 8]);
c(31:34) = arrayfun(@(k)log(2^(exp(rj(k)))-1)-pj(k)-log(gj_2(k)),[1 2 3 4]);






end
