function [] = geom_compareDistSNR(N,Kmin,Kmax,p_db)

 gains = {'constant','distant','close'};

for idx = 1:length(gains)    
[gi,gj] = set_gains(gains{idx});

%SNR fixed , vary K

%Set SNR

pmax = 10^(p_db/10);

%Set K range
Krange = int8(10*(Kmax-Kmin) + 1);

%Initialize delays and time interval vectors
opt_delays = zeros(1,Krange);

%time intervals of each time sharing phase
opt_z = zeros(Krange,8);

for K = Kmin:0.1:Kmax

    [min_delay,z_min] = geometricOpt3(K,pmax,N,gi,gj);

    K_idx = int8(10*(K-Kmin)+1);
    opt_delays(K_idx) = min_delay;
    opt_z(K_idx,:) = z_min';

end

hold on;
fig = plot(Kmin:0.1:Kmax,opt_delays,'--.','DisplayName',gains{idx}); %,'MarkerIndices',1:2:length(opt_delays));
title(['SNR = ',num2str(p_db),'dB'])
xlabel('K(s)')
ylabel('Sum Delay')
legend
end

path='C:\Users\askht\Desktop\autofigs2';
saveas(fig,fullfile(path,['geomcompSNR' append(num2str(p_db),'K',num2str(Kmin),num2str(Kmax)) '.jpeg']));
hold off;
figure;


% 
%         tiledlayout(2,1)
%         nexttile;
%         plot(Kmin:0.1:Kmax,opt_delays,'--.') %,'MarkerIndices',1:2:length(opt_delays))
%         title(['SNR = ',num2str(pdb),'dB'])
%         xlabel('K(s)')
%         ylabel('Sum Delay')
%       
%         nexttile
%         bar(1:size(opt_z,2),opt_z')
%         title('Time Sharing Schedule')
%         xlabel('phase')
%         ylabel('Time')
%      
        

%        
%        
%      saveas(t,fullfile(path,['fullgeomK' append(num2str(K),'SNR',num2str(SNRmin),num2str(SNRmax),gains) '.jpeg']));
     
end 

