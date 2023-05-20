function [c,ceq] = delay_cons_geomCons(x,Tmax,N,B,gi,gj,x0)

z = x(1:8);
pi = x(9:16);
pj = x(17:24);
ri = x(25:32);
rj = x(33:40);

%initial [z0,r0] = x0 for each user 
xi0 = [x0(1:8),x0(25:32)];
xj0 = [x0(1:8),x0(33:40)];

dec_1 = [1 1 2 2 1 2 1 2]; %indices for gains of user i
dec_2 = [1 2 1 2 1 1 2 2];  %indices for gains of user j

%c = zeros(1:20);
ceq = [];

% Diffrerence of Convex constraints

c(1) = delay_cons_approxConstraint([z,ri],xi0,N,B);
c(2) = delay_cons_approxConstraint([z,rj],xj0,N,B); 

c(3) = log(sum(exp(z))) - log(Tmax);


gi_1 = gi(dec_1);
gj_1 = gj(dec_1);

gi_2 = gi(dec_2);
gj_2 = gj(dec_2);

c(4:7) = arrayfun(@(k)log((1/gi_1(k))*exp(-pi(k))+(gj_1(k)/gi_1(k))*exp(pj(k)-pi(k)))+log(2^(exp(ri(k)))-1),[1 2 3 4]);
c(8:11) = arrayfun(@(k)log(2^(exp(ri(k)))-1)-pi(k)-log(gi_1(k)),[5 6 7 8]);

c(12:15) = arrayfun(@(k)log((1/gj_2(k))*exp(-pj(k))+(gi_2(k)/gj_2(k))*exp(pi(k)-pj(k)))+log(2^(exp(rj(k)))-1),[5 6 7 8]);
c(16:19) = arrayfun(@(k)log(2^(exp(rj(k)))-1)-pj(k)-log(gj_2(k)),[1 2 3 4]);






end

