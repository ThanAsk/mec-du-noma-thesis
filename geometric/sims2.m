tic
% for SNR = [20 25 30]
% geom_compareDistSNR(0.5,0.1,2,SNR) %1.7 hours
% end


for K = [0.2 0.5 1 5 12]
geom_compareDistK(0.5,K,20,30)
end



w = [0.5 0.5]; %wrong
delay_geom_compareDist(10^6,0.5*(10^6),w,0.2,1)
% delay_geom(10^6,0.5*(10^6),'constant',w,0.2,1);
% delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
% delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
% 
% 
w = [0.1 0.1]; %wrong
delay_geom_compareDist(10^6,0.5*(10^6),w,0.2,1)
% delay_geom(10^6,0.5*(10^6),'constant',w,0.2,1);
% delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
% delay_geom(10^6,0.5*(10^6),'close_constant',w,0.2,1);
% 
w = [0.1 0.9]; %wrong
delay_geom_compareDist(10^6,0.5*(10^6),w,0.2,1)
% delay_geom(10^6,0.5*(10^6),'constant',w,0.2,1);
% delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
% delay_geom(10^6,0.5*(10^6),'close_constant',w,0.2,1);
% 
w = [0.4 0.7]; %wrong
delay_geom_compareDist(10^6,0.5*(10^6),w,0.2,1)
% delay_geom(10^6,0.5*(10^6),'constant',w,0.2,1);
% delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
% delay_geom(10^6,0.5*(10^6),'close_constant',w,0.2,1);
toc