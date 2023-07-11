function [delay,c1_min,c2_min] = optimize_times_nonlin(pmax,K,B,N,gi,gj)
          
options = optimset('PlotFcns',@optimplotfval);
%options = optimset('outputfcn',@(x,optimValues,state)outfun(x,optimValues,state,extraArg),'display','iter',... 
%'Algorithm','active-set');

[c,d] = fmincon(@(x)min_delay(x,pmax,K,B,N,gi,gj),[0,0],[],[],[],[],zeros(1,2),ones(1,2),[],options);
        
c1_min = c(1);
c2_min = c(2);
delay = d;

end
       

