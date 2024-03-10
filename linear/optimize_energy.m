function [min_energy,c1_min,c2_min,z_min] = optimize_energy(Tmax,pmax,B,N,gi,gj,w)

%Initialize min 
 c1_min = 0;
 c2_min = 0;
 min_energy = Inf;
 z_min = zeros(1,8);
 wi = w(1);
 wj = w(2);

 for  c1 = 1:-0.1:0.
     for c2 = 1:-0.1:0.

         p1 = c1*pmax;
         p2 = c2*pmax;
         %Check if SNR is below noise level
         if c1*pmax < 1
         p1 = 1;
         end
         if c2*pmax < 1
         p2 = 1;
         end
         pi = [p1*ones(1,4),p2*ones(1,4)];
         pj = [p2*ones(1,4),p1*ones(1,4)];



         [Ri,Rj] = compute_rates(gi,gj,pi,pj);
%          Ri = R(1:8);
%          Rj = R(8:16);

         %linear optimization
        
         %objective function
         s = wi.*pi + wj.*pj; % sum

         %inequality constraints
         C_1 = B*Ri;
         C_2 = B*Rj;
         C_3 = ones(1,8);
%          C_4 = pi; %Above noise floor
%          C_5 = pj;
%          C = [-C_1;-C_2;C_3;-C_4;-C_5] ;
         C = [-C_1;-C_2;C_3];

%          b = [-N -N Tmax -Tmax -Tmax];
         b = [-N -N Tmax];

         
         %lb = 0.*ones(1,8);
         lb = zeros(1,8);
         ub = Inf*ones(1,8);

         %solution
         %options = optimoptions('linprog','Algorithm','dual-simplex');
         options = optimset('PlotFcns',@optimplotfval);
         [z,energy]= linprog(s,C,b,[],[],lb,ub,options);
         energy = 10*log(energy); %in dB

         if energy <= min_energy
             min_energy = energy;
             z_min = z;
             c1_min = c1;
             c2_min = c2;
              
           
         end

     end
 end


end
       


