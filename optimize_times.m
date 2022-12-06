function [min_delay,c1_min,c2_min,z_min] = optimize_times(pmax,K,B,N,gi,gj)

%Initialize min 
 c1_min = 0;
 c2_min = 0;
 min_delay = Inf;
 z_min = zeros(1,8);
 
 for  c1 = 1:-0.1:0
     for c2 = 1:-0.1:0

         pi = [c1*pmax*ones(1,4),c2*pmax*ones(1,4)];
         pj = [c2*pmax*ones(1,4),c1*pmax*ones(1,4)];


         [Ri,Rj] = compute_rates(gi,gj,pi,pj);
%          Ri = R(1:8);
%          Rj = R(8:16);

         %linear optimization
        
         %objective function
         s = ones(1,8); % sum

         %inequality constraints
         C_1 = B*Ri;
         C_2 = B*Rj;
         C_3 = [c1*ones(1,4)*pmax,c2*ones(1,4)*pmax];
         C_4 = [c2*ones(1,4)*pmax,c1*ones(1,4)*pmax];
         C = [-C_1;-C_2;C_3;C_4] ;


         b = [-N -N K*pmax K*pmax];

         lb = 0.15*ones(1,8);
         %lb = zeros(1,8);
         ub = Inf*ones(1,8);

         %solution
         %options = optimoptions('linprog','Algorithm','dual-simplex');
         options = optimset('PlotFcns',@optimplotfval);
         [z,delay]= linprog(s,C,b,[],[],lb,ub,options);
            
         

         if delay <= min_delay
             min_delay = delay;
             z_min = z;
             c1_min = c1;
             c2_min = c2;
              
           
         end

     end
 end


end
       


