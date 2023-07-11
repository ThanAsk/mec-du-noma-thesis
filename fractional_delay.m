function [zk,total_delay] = fractional_delay(gi,gj,x)
ni = x(1:8);
nj = x(9:16);
ei = x(17:24);
ej = x(25:32);
pi = x(33:40);
pj = x(41:48);

%gains in non interference terms for k = 1..8
gik = gi([1 1 2 2 1 1 2 2]);
gjk = gj([1 1 2 2 1 1 2 2]);

%log(1+g'*p/1+g*p) terms / gj,pj for k = 1...4 / gi,pi for k = 5...8
gnum =  [gj([1 2 1 2]),gi([1 2 1 2])];
gden =  [gj([1 1 2 2]),gi([1 1 2 2])];
p = [pj(1:4),pi(5:8)];

zk = (ni+nj+ei+ej)./(log2(1+gik.*pi+gjk.*pj)+log2((1+gnum.*p)./(1+gden.*p))+pi + pj);
total_delay = sum(zk);

end

