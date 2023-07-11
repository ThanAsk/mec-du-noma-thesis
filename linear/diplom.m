
clear; 
B = 1; %MHz (important?)
N = 0.5 ; %Mbit

%Set size based on SNR or K range (rewrite..)
 rounds = 0;
 average_delay = zeros(1,29);
 average_c1 =  zeros(1,29);
 average_c2 = zeros(1,29);

tic


%channel weights / RRH(a): first col, RRH(b):second

%  while rounds <= 1 % 100

 [gi,gj] = set_gains('constant');
  
% SNR = p (pmax?) db , K = (E/B*No)/p seconds

%Keep one parameter fixed , vary the other
%fix = 'K';
fix = 'SNR';

switch fix

    case 'K'
        %Set K
        K = 0.3;

        %Set SNR range
        SNRmin = 2;
        SNRmax = 30;
        SNRrange = SNRmax-SNRmin + 1;
        
        opt_delays = zeros(1,SNRrange);
        opt_c1 = zeros(1,SNRrange);
        opt_c2 = zeros(1,SNRrange);

        %delays of each time sharing phase
        opt_z = zeros(SNRrange,8);


        for pdb = SNRmin:SNRmax
            
            pmax = 10^(pdb/10);
            [min_delay,c1_min,c2_min,z_min] = optimize_times(pmax,K,B,N,gi,gj);

            %[min_delay,c1_min,c2_min,z_min] = optimize_times_multi(pmax,K,B,N,gi,gj);
            %[min_delay,c1_min,c2_min,z_min] = optimize_times_aug(pmax,K,B,N,gi,gj);
            %[min_delay,c1_min,c2_min] = optimize_times_nonlin(pmax,K,B,N,gi,gj);

            


            opt_delays(pdb-SNRmin+1) = min_delay;
            opt_c1(pdb-SNRmin+1) = c1_min;
            opt_c2(pdb-SNRmin+1) = c2_min;
            opt_z(pdb-SNRmin+1,:) = z_min';


        end

        tiledlayout(3,1)
        %tiledlayout(2,1)
        nexttile;
        plot(SNRmin:SNRmax,opt_delays,'--.','MarkerIndices',1:2:length(opt_delays))
        title(['K = ',num2str(K),'s'])
        xlabel('SNR(dB)')
        ylabel('sum delay')
        %axis([SNRmin SNRmax min(opt_delays) Inf])
        nexttile;
        plot(SNRmin:SNRmax,opt_c1,'LineWidth',0.7)
        xlabel('SNR(dB)')
        ylabel('c')
        hold on
        plot(SNRmin:SNRmax,opt_c2,'r')
        legend({'c1','c2'},'Location','southwest')
        %axis padded
        axis([SNRmin SNRmax 0.1 1.1])
        %yticks(min(opt_c2):0.1:max(opt_c2))



        nexttile
        %plot(1:size(zk,2),zk')
        bar(1:size(opt_z,2),opt_z')
        title('Time Sharing Schedule')
        xlabel('phase')
        ylabel('Time')

        

    case 'SNR'

        %SNR fixed , vary K
        %Set SNR
        pdb = 10;
        pmax = 10^(pdb/10);

        %Set K range
%         Kmin = 2;
%         Kmax = 20;
%         Krange = Kmax-Kmin + 1;
         Kmin = 0.12;
         Kmax = 0.2;
         Krange = int8(100*(Kmax-Kmin) + 1);
        


        opt_delays = zeros(1,Krange);
        opt_c1 = zeros(1,Krange);
        opt_c2 = zeros(1,Krange);

        %delays of each time sharing phase
        opt_z = zeros(Krange,8);

        for K = Kmin:0.01:Kmax

            [min_delay,c1_min,c2_min,z_min] = optimize_times(pmax,K,B,N,gi,gj);
            %[min_delay,c1_min,c2_min,z_min] = optimize_times_aug(pmax,K,B,N,gi,gj);
            %[min_delay,c1_min,c2_min] = optimize_times_nonlin(pmax,K,B,N,gi,gj);
            

%             opt_delays(K-Kmin+1) = min_delay;
%             opt_c1(K-Kmin+1) = c1_min;
%             opt_c2(K-Kmin+1) = c2_min;
%             opt_z(K-Kmin+1,:) = z_min';
       
            K_idx = int8(100*(K-Kmin)+1);
            opt_delays(K_idx) = min_delay;
            opt_c1(K_idx) = c1_min;
            opt_c2(K_idx) = c2_min;
            opt_z(K_idx,:) = z_min';


        end

        tiledlayout(3,1)
        %tiledlayout(2,1)
        nexttile;
        plot(Kmin:0.01:Kmax,opt_delays,'--.') %,'MarkerIndices',1:2:length(opt_delays))
        title(['SNR = ',num2str(pdb),'dB'])
        xlabel('K(s)')
        ylabel('Sum Delay')
        %axis([Kmin Kmax 0 max(opt_delays)+0.2])
        nexttile
        plot(Kmin:0.01:Kmax,opt_c1,'LineWidth',0.7)
        xlabel('K(s)')
        ylabel('c')
        hold on
        plot(Kmin:0.01:Kmax,opt_c2,'r')
        legend({'c1','c2'},'Location','southwest')
        %axis padded
        % axis([Kmin Kmax 0.5 1.1])
        %yticks(min(opt_c2):0.1:max(opt_c2))



        nexttile
        %plot(1:size(zk,2),zk')
        bar(1:size(opt_z,2),opt_z')
        title('Time Sharing Schedule')
        xlabel('phase')
        ylabel('Time')
     
        

end

% average_delay = average_delay + opt_delays;
% average_c1 = average_c1 + opt_c1;
% average_c2 = average_c2 + opt_c2;
% 
% rounds = rounds + 1 ;
% 
% end

% average_delay = average_delay/rounds;
% average_c1 = average_c1/rounds;
% average_c2 = average_c2/rounds;
% 
% tiledlayout(2,1)
% nexttile;
% plot(SNRmin:SNRmax,average_delay,'--.') %,'MarkerIndices',1:2:length(opt_delays))
% title(['K = ',num2str(K),'s'])
% xlabel('SNR(dB)')
% ylabel('sum_delay')
% % axis([SNRmin SNRmax 0 Inf])
% nexttile;
% plot(SNRmin:SNRmax,average_c1,'LineWidth',0.7)
% xlabel('SNR(dB)')
% ylabel('c')
% hold on
% plot(SNRmin:SNRmax,average_c2,'LineWidth',0.7)
% legend({'c1','c2'},'Location','southwest')
%  

% 
% tiledlayout(2,1)
% nexttile;
% plot(Kmin:0.01:Kmax,average_delay,'--.') %,'MarkerIndices',1:2:length(opt_delays))
% title(['SNR = ',num2str(pdb),'dB'])
% xlabel('K(s)')
% ylabel('sum_delay')
% % axis([SNRmin SNRmax 0 Inf])
% nexttile;
% plot(Kmin:0.01:Kmax,average_c1,'LineWidth',0.7)
% xlabel('K(s)')
% ylabel('c')
% hold on
% plot(Kmin:0.01:Kmax,average_c2,'LineWidth',0.7)
% legend({'c1','c2'},'Location','southwest')
 

toc

