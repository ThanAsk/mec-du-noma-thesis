function [values,total_value] = aux_objective(gi,gj,y,c,x)
%objective function involving auxiliary terms y,c
values = zeros(1,8);

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



v =@(k) 2*y(k)*sqrt(ni(k)+nj(k)+ei(k)+ej(k)) + (y(k)^2)*(log2(1+gik(k)*pi(k)+gjk(k)*pj(k)))+log2((1+gnum(k)*p(k))/(1+gden(k)*p(k)))+pi(k)+pj(k);
v_approx = @(k) 2*y(k)*sqrt(ni(k)+nj(k)+ei(k)+ej(k)) + (y(k)^2)*(log2(1+gik(k)*pi(k)+gjk(k)*pj(k)))+log2(2*c(k)*(1+gnum(k)*p(k))-(c(k)^2)*(1+gden(k)*p(k)))+pi(k)+pj(k);
val = arrayfun(v,1:8);
val_app = arrayfun(v_approx,1:8);
values(c==0) = val(c==0);
if ~isempty(find(c, 1))
values(~(c==0))= val_app(~(c==0));
end

total_value = sum(values);
end

