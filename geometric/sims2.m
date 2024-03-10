tic
% for SNR = [20 25 30]
% geom_compareDistSNR(0.5,0.1,2,SNR) %1.7 hours
% end

% for SNR = 20
% geom_MonteCarloSNR(0.5,0.1,2,SNR,10) 
% end

%geom_comparefullK(0.5,20,30)
%geom_comparefullSNR(0.5,0.2,0.3)

%delay_geom_compareWeights(10^6,0.5*(10^6),0.2,1)

%compare_linear_geomK(10^6,0.5*(10^6),20,30)
compare_linear_geomSNR(10^6,0.5*(10^6),1,12)

% weights = [0.5 0.5];
% delay_geom_compare_lin_geom(10^6,0.5*(10^6),weights,0.2,1)


% for K = [0.2 0.5 1 5 12]
% geom_compareDistK(0.5,K,20,30)
% end

% K = 0.5;
% geom_MonteCarloK(0.5,K,20,30,50)

% w = [0.5 0.5];
% delay_geom_MonteCarlo(10^6,0.5*(10^6),w,0.2,1,10)


% 
% w = [0.5 0.5]; %wrong
% delay_geom_compareDist(10^6,0.5*(10^6),w,0.2,1)
% % delay_geom(10^6,0.5*(10^6),'constant',w,0.2,1);
% % delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
% % delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
% % 
% % 
% w = [0.1 0.1]; %wrong
% delay_geom_compareDist(10^6,0.5*(10^6),w,0.2,1)
% % delay_geom(10^6,0.5*(10^6),'constant',w,0.2,1);
% % delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
% % delay_geom(10^6,0.5*(10^6),'close_constant',w,0.2,1);
% % 
% w = [0.1 0.9]; %wrong
% delay_geom_compareDist(10^6,0.5*(10^6),w,0.2,1)
% % delay_geom(10^6,0.5*(10^6),'constant',w,0.2,1);
% % delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
% % delay_geom(10^6,0.5*(10^6),'close_constant',w,0.2,1);
% % 
% w = [0.4 0.7]; %wrong
% delay_geom_compareDist(10^6,0.5*(10^6),w,0.2,1)
% % delay_geom(10^6,0.5*(10^6),'constant',w,0.2,1);
% % delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
% % delay_geom(10^6,0.5*(10^6),'close_constant',w,0.2,1);
toc