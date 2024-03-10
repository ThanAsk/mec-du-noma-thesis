function [] = geom_comparefullSNR(N,Kmin,Kmax)
   
[gi,gj] = set_gains('distant');

for p_db = [20 25 30]
pmax = 10^(p_db/10);

%Set K range
Krange = int8(10*(Kmax-Kmin) + 1);

%Initialize delays and time interval vectors
opt_delays = zeros(1,Krange);


for K = Kmin:0.1:Kmax

    [min_delay,~] = geometricOpt3(K,pmax,N,gi,gj);

    K_idx = int8(10*(K-Kmin)+1);
    opt_delays(K_idx) = min_delay;
    

end

hold on;
label = strcat('SNR =',num2str(p_db));
fig = plot(Kmin:0.1:Kmax,opt_delays,'-*','DisplayName',label); %,'MarkerIndices',1:2:length(opt_delays));

xlabel('K(s)')
ylabel('Sum Delay')
legend
end

path='C:\Users\askht\Desktop\autofigs4';
saveas(fig,fullfile(path,['geomcomparefullSNR' append('K',num2str(Kmin),num2str(Kmax)) '.jpeg']));
hold off;
figure;

     
end 

