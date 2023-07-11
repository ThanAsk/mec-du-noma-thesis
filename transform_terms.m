function [yk,ck] = transform_terms(gi,gj,x)
%helper function to choose which terms to transform with quadratic
%transform ,based on the values of gains
ck =zeros(1,8);
ni = x(1:8);
nj = x(9:16);
ei = x(17:24);
ej = x(25:32);
pi = x(33:40);
pj = x(41:48);
gik = gi([1 1 2 2 1 1 2 2]);
gjk = gj([1 1 2 2 1 1 2 2]);
term = zeros(1,8);


if gj(1) > gj(2)
    ck(2) = sqrt(1+gj(2)*pj(2))/(1+gj(1)*pj(2));
    term(2) = log2(2*ck(2)*(1+gj(2)*pj(2))-(ck(2)^2)*(1+gj(1)*pj(2)));
    term(3) = log2((1+gj(1)*pj(3))/(1+gj(2)*pj(3)));
elseif gj(1) < gj(2)
    ck(3) = sqrt(1+gj(2)*pj(3))/(1+gj(1)*pj(3));
    term(3) = log2(2*ck(3)*(1+gj(1)*pj(3))-(ck(3)^2)*(1+gj(2)*pj(3)));
    term(2) = log2((1+gj(2)*pj(2))/(1+gj(1)*pj(2)));
else
    term(2) = 0;
    term(3) = 0;
end

if gi(1) > gi(2)
    ck(7) = sqrt(1+gi(2)*pi(7))/(1+gi(1)*pj(7));
    term(7) = log2(2*ck(7)*(1+gi(2)*pi(7))-(ck(7)^2)*(1+gi(1)*pi(7)));
    term(6) = log2((1+gi(1)*pi(6))/(1+gi(2)*pi(6)));

elseif gi(1) < gi(2)
    ck(6) = sqrt(1+gi(2)*pi(6))/(1+gi(1)*pj(6));
    term(6) = log2(2*ck(6)*(1+gi(1)*pi(6))-(ck(6)^2)*(1+gi(2)*pi(6)));
    term(7) = log2((1+gi(2)*pi(7))/(1+gi(1)*pi(7)));
else
    term(6) = 0;
    term(7) = 0;
end

yk = sqrt(ni+nj+ei+ej)./(-log2(1 + gik.*pi + gjk.*pj) - pi - pj - term);



end

