%Simulations 
tic
% for K = [0.2 0.5 1 5 12]
% geomKfull(0.5,'constant',K,20,30);
% geomKfull(0.5,'distant_constant',K,20,30); %l = 3 , d = 2
% geomKfull(0.5,'close_constant',K,20,30); %l = 1, da/db = 0.2
% end




w = [0.5 0.5]; %wrong
delay_geom(10^6,0.5*(10^6),'constant',w,0.2,1);
delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);


w = [0.1 0.1]; %wrong
delay_geom(10^6,0.5*(10^6),'constant',w,0.2,1);
delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);

w = [0.1 0.9]; %wrong
delay_geom(10^6,0.5*(10^6),'constant',w,0.2,1);
delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);

w = [0.4 0.7]; %wrong
delay_geom(10^6,0.5*(10^6),'constant',w,0.2,1);
delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);
delay_geom(10^6,0.5*(10^6),'distant_constant',w,0.2,1);

toc
%add more gain parameters in file names
%add geomSNR
%add linearopt
%add comparative plots all K / all SNR / distance changes (l or d)
%add progress bar