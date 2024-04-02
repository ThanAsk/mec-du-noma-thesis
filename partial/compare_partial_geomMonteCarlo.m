function [] = compare_partial_geomMonteCarlo(params,K,SNRmin,SNRmax,rounds)

tic
%[gi,gj] = set_gains('distant');

SNRrange = SNRmax-SNRmin + 1;  

sum_delays_partial = zeros(1,SNRrange);
sum_delays_geom = zeros(1,SNRrange);
iter = 0;     
N_B = params(2)/params(1);


while iter < rounds
[gi,gj] = set_gains('random'); 

partial_delays = zeros(1,SNRrange);
geom_delays = zeros(1,SNRrange);


for pdb = SNRmin:SNRmax
    
    pmax = 10^(pdb/10);
    [partial_delay,~,~,~] = partialOpt(K,pmax,gi,gj,params);
    [geom_delay,~] = geometricOpt3(K,pmax,N_B,gi,gj);

    partial_delays(pdb-SNRmin+1) = partial_delay;
    geom_delays(pdb-SNRmin+1) = geom_delay;


end

sum_delays_partial = sum_delays_partial + partial_delays;
sum_delays_geom = sum_delays_geom + geom_delays;

iter = iter + 1;
end
sum_delays_partial = (1/rounds)*sum_delays_partial;
sum_delays_geom = (1/rounds)*sum_delays_geom;
        %Delay plot
        hold on;
        plot(SNRmin:SNRmax,sum_delays_partial,"LineStyle","-","Marker",'o',"Color","r");
        plot(SNRmin:SNRmax,sum_delays_geom,"LineStyle","-","Marker",'*',"Color","b"); 
        xlabel('SNR(dB)')
        ylabel('Sum delay(s)')
        
toc            
end

