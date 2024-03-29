function [c,ceq] = geometric_cons(x,K,pmax,N,gi,gj)
%nonlinear constraints for geometricOpt 

z = x(1:8);
pi = x(9:16);
pj = x(17:24);
ri = x(25:32);
rj = x(33:40);

dec_1 = [1 1 2 2 1 2 1 2]; %indices for gains of user i
dec_2 = [1 2 1 2 1 1 2 2];  %indices for gains of user j

%c = zeros(1:20);
ceq = [];

c(1) = -sum(exp(z+ri)) + N;
c(2) =  -sum(exp(z+rj)) + N;

c(3) = sum(exp(z+pi)) - K*pmax;
c(4) = sum(exp(z+pj)) - K*pmax;

% tempc_1 = zeros(1,8);
% tempc_2 = zeros(1,8);

% k = 1;
% while k <= 3
%     if k<5
%        tempc_1(1,k) = log(2^exp(ri(1,k))-1) + log(1 + gj(decf(1,k))*exp(pj(1,k))) - pi(1,k) - log(gi(decf(1,k)));
%        tempc_2(1,k) = log(2^exp(rj(1,k))-1) - pj(1,k) - log(gj(decs(1,k)));
%     else
%        tempc_1(1,k) = log(2^exp(ri(1,k))-1) - pj(1,k) - log(gi(decs(1,k)));
%        tempc_2(1,k) = log(2^exp(rj(1,k))-1) + log(1 + gi(decf(1,k))*exp(pi(1,k))) - pj(1,k) - log(gj(decf(1,k)));
%     end
% 
%     k = k + 1;
% end
% 
% c(5:12) = tempc_1;
% c(13:20) = tempc_2;

c(5:8) = arrayfun(@(k)log(2^exp(ri(1,k))-1) + log(1 + gj(dec_1(1,k))*exp(pj(1,k))) - pi(1,k) - log(gi(dec_1(1,k))),[1 2 3 4]);
c(9:12) = arrayfun(@(k)log(2^exp(ri(1,k))-1) - pj(1,k) - log(gi(dec_1(1,k))),[5 6 7 8]);

c(13:16) = arrayfun(@(k)log(2^exp(rj(1,k))-1) - pj(1,k) - log(gj(dec_2(1,k))),[1 2 3 4]);
c(17:20) = arrayfun(@(k) log(2^exp(rj(1,k))-1) + log(1 + gi(dec_2(1,k))*exp(pi(1,k))) - pj(1,k) - log(gj(dec_2(1,k))),[5 6 7 8]);





end

