function [] = compare_linear_geomSNR(B,N,Kmin,Kmax)

[gi,gj] = set_gains('distant');
  
N_B = (N/B);
marker = {'o','square','diamond'};
i = 1;

%Krange = int8(10*(Kmax-Kmin) + 1);
Krange = Kmax - Kmin;

for p_db = [10 20 30]
pmax = 10^(p_db/10);


lin_delays = zeros(1,Krange);
geom_delays = zeros(1,Krange);

for K = Kmin:Kmax %Kmin:0.1:Kmax 

    [lin_delay,~,~,~] = optimize_times(pmax,K,B,N,gi,gj);
    [geom_delay,~] = geometricOpt3(K,pmax,N_B,gi,gj);

    %K_idx = int8(10*(K-Kmin)+1);
    K_idx = K - Kmin + 1 ;
    lin_delays(K_idx) = lin_delay;
    geom_delays(K_idx) = geom_delay;

end

hold on;
label = strcat('SNR = ',num2str(p_db));

%Kmin:Kmax ,Kmin:0.1:Kmax
plot(Kmin:Kmax,lin_delays,"LineStyle","-","Marker",marker{i},"Color","r","DisplayName",label);
plot(Kmin:Kmax,geom_delays,"LineStyle","--","Marker",marker{i},"Color","b","DisplayName",label);
%fig = plot(ax,SNRmin:SNRmax,geom_delays,:,'MarkerIndices',1:2:length(geom_delays),'Color','blue','DisplayName',label);

xlabel('K(s)')
ylabel('Sum delay(s)')
legend
%axis([SNRmin SNRmax min(opt_delays) Inf])
i = i + 1;
end
% path='C:\Users\askht\Desktop\autofigs4';
%         saveas(fig,fullfile(path,['compare_lin_geom' append(num2str(SNRmin),num2str(SNRmax)) '.jpeg']));
%         saveas(fig,fullfile(path,['compare_lin_geom' append(num2str(SNRmin),num2str(SNRmax)) '.eps']));
%         hold off;
%         figure;

end




