function [yk,ck] = transform_terms2(gi,gj,x)

ni = x(1:8);
nj = x(9:16);
ei = x(17:24);
ej = x(25:32);
pi = x(33:40);
pj = x(41:48);

gnum = [gi([1 1 2 2]),gj([1 1 2 2])];
gden = [gj([1 1 2 2]),gi([1 1 2 2])];
gs = [gj([1 2 1 2]),gi([1 2 1 2])];
pnum = [pi(1:4),pj(5:8)];
pden = [pj(1:4),pi(5:8)];

ck = sqrt(gnum.*pnum)./(1+gden.*pden);
yk = sqrt(log2(1 + 2*ck.* sqrt(gnum.*pnum)-(ck.^2).*(1+gden.*pden))+log2(1 + gs.*pden) + pi + pj)./(ni+nj+ei+ej);
end

