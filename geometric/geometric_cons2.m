function [c,ceq] = geometric_cons2(x,K,pmax,N,gi,gj,x0)
%nonlinear constraints for geometricOpt 

z = x(1:8);
ei = x(9:16);
ej = x(17:24);
ri = x(25:32);
rj = x(33:40);

dec_1 = [1 1 2 2 1 2 1 2]; %indices for gains of user i
dec_2 = [1 2 1 2 1 1 2 2];  %indices for gains of user j

%c = zeros(1:20);
ceq = [];

c(1) = -sum(ri) + N;
c(2) =  -sum(rj) + N;

c(3) = log(sum(exp(ei))) - log(K*pmax);
c(4) = log(sum(exp(ej))) - log(K*pmax);

gi_1 = gi(dec_1);
gj_1 = gj(dec_1);

gi_2 = gi(dec_2);
gj_2 = gj(dec_2);

c(5:8) = arrayfun(@(k)approxConstraintFirst(z,ri,ei,ej,gi_1,gj_1,x0,k),[1 2 3 4]);
c(9:12) = arrayfun(@(k)approxConstraintSec(z,ri,ei,gi_1,x0,k),[5 6 7 8]);

c(13:16) = arrayfun(@(k)approxConstraintFirst(z,rj,ej,ei,gj_2,gi_2,x0,k),[5 6 7 8]);
c(17:20) = arrayfun(@(k)approxConstraintSec(z,rj,ej,gj_2,x0,k),[1 2 3 4]);






end

