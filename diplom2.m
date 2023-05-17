tic
clear; 
B = 1; %MHz (important?)
N = 0.5 ; %Mbit

[gi,gj] = set_gains('close_constant');
%[gi,gj] = set_gains('constant');


%Keep K fixed , vary SNR
fix = 'K';
%fix = 'SNR';

switch fix

    case 'K'
        %Set K
        K = 5;

        %Set SNR range
        SNRmin = 20;
        SNRmax = 30;
        SNRrange = SNRmax-SNRmin + 1;

        opt_delays = zeros(1,SNRrange);

        %delays of each time sharing phase
        opt_z = zeros(SNRrange,8);

        r = 0;
        for pmax = SNRmin:SNRmax
               

            %[min_delay,z_min] = geometricOpt4(K,pmax,N,gi,gj);
            [min_delay,z_min,Ax,Af] = geometricOpt3(K,pmax,N,gi,gj);
            
            Ax
            Af
            opt_delays(pmax-SNRmin+1) = min_delay;
            opt_z(pmax-SNRmin+1,:) = z_min';
            
            r = r + 1
        end

        tiledlayout(2,1)
        nexttile;
        plot(SNRmin:SNRmax,opt_delays,'--.','MarkerIndices',1:2:length(opt_delays))
        title(['K = ',num2str(K),'s'])
        xlabel('SNR(dB)')
        ylabel('sum delay')
        %axis([SNRmin SNRmax 0.1 1.1])
        nexttile      
        bar(1:size(opt_z,2),opt_z')
        title('Time Sharing Schedule')
        xlabel('phase')
        ylabel('Time')
        
        figure
        
        

    case 'SNR'

        %SNR fixed , vary K
        %Set SNR
        pmax = 20;

        %Set K range
         Kmin = 0.1;
         Kmax = 2;
         Krange = int8(10*(Kmax-Kmin) + 1);        

        opt_delays = zeros(1,Krange);
       
        %delays of each time sharing phase
        opt_z = zeros(Krange,8);

        for K = Kmin:0.1:Kmax

                    
            [min_delay,z_min] = geometricOpt3(K,pmax,N,gi,gj); 

            K_idx = int8(10*(K-Kmin)+1);
            opt_delays(K_idx) = min_delay;           
            opt_z(K_idx,:) = z_min';


        end


        tiledlayout(2,1)
        nexttile;
        plot(Kmin:0.1:Kmax,opt_delays,'--.') %,'MarkerIndices',1:2:length(opt_delays))
        title(['SNR = ',num2str(pmax),'dB'])
        xlabel('K(s)')
        ylabel('Sum Delay')
      
        nexttile
        bar(1:size(opt_z,2),opt_z')
        title('Time Sharing Schedule')
        xlabel('phase')
        ylabel('Time')
     
        

end
toc