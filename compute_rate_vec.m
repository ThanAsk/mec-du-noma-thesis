function R = compute_rate_vec(gi,gj,pi,pj)
%COMPUTE_RATES  computes rates for each time sharing phase given channel
%gains(G) and power of each user at each phase
%   Ui, Uj  to RRHa ,RRHb  --> 8 transmit phases 

 %rates for each phase
 Ri = zeros(1,8);
 Rj = zeros(1,8);


 %user i decoded first
 %{(i,a),(j,a)}
 Ri(1) = log2(1 + (gi(1)*pi(1))/(1+gj(1)*pj(1)));
 Rj(1) = log2(1 + gj(1)*pj(1));

 %{(i,a),(j,b)}
 Ri(2) = log2(1 + (gi(1)*pi(2))/(1+gj(1)*pj(2)));
 Rj(2) = log2(1 + gj(2)*pj(2));

 %{(i,b),(j,a)}
 Ri(3) = log2(1 + (gi(2)*pi(3))/(1+gj(2)*pj(3)));
 Rj(3) = log2(1 + gj(1)*pj(3));

 %{(i,b),(j,b)}
 Ri(4) = log2(1 + (gi(2)*pi(4))/(1+gj(2)*pj(4)));
 Rj(4) = log2(1 + gj(2)*pj(4));


 %User j decoded first
 %{(j,a),(i,a)}
 Rj(5) = log2(1 + (gj(1)*pj(5))/(1+gi(1)*pi(5)));
 Ri(5) = log2(1 + gi(1)*pi(5));

 %{(j,a),(i,b)}
 Rj(6) = log2(1 + (gj(1)*pj(6))/(1+gi(1)*pi(6)));
 Ri(6) = log2(1 + gi(2)*pi(6));

 %{(j,b),(i,a)}
 Rj(7) = log2(1 + (gj(2)*pj(7))/(1+gi(2)*pi(7)));
 Ri(7) = log2(1 + gi(1)*pi(7));

 %{(j,b),(i,b)}
 Rj(8) = log2(1 + (gj(2)*pj(8))/(1+gi(2)*pi(8)));
 Ri(8) = log2(1 + gi(2)*pi(8));


R = [Ri,Rj];
end

