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

%x0



c(5:8) = arrayfun(@(k)approxConstraintFirst(z,ri,ei,ej,gi(dec_1(k)),gj(dec_1(k)),f0,k),[1 2 3 4]);
c(9:12) = arrayfun(@(k)approxConstraintSec(z,ri,ei,gi(dec_1(k)),s0,k),[5 6 7 8]);

c(13:16) = arrayfun(@(k)approxConstraintFirst(z,rj,ej,ei,gj(dec_2(k)),gi(dec_2(k)),f1,k),[5 6 7 8]);
c(17:20) = arrayfun(@(k)approxConstraintSec(z,rj,ej,gj(dec_2(k)),s1,k),[1 2 3 4]);






end
