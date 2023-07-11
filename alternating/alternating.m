tic
B = 1; %MHz (important?)
N = 0.5 ; %Mbit

K = 1;
 %Set SNR range
 SNRmin = 20;
 SNRmax = 25;
 SNRrange = SNRmax-SNRmin + 1;

 opt_delays = zeros(1,SNRrange);

 opt_z = zeros(SNRrange,8);

 r = 0;      
for pmax = SNRmin:SNRmax

%[gi,gj] = set_gains('distant_constant');
[gi,gj] = set_gains('constant');
A = Inf;

x0 = zeros(1,16);
sj_opt = ((2^(N/B)-1)^(1/8))*ones(1,8);

while A > 10^-6

[z_opt1,si_opt] = alternating_Opt_si(K,pmax,N,B,gi,gj,sj_opt,x0);
x0 = [z_opt1,si_opt.*z_opt1];
[z_opt2,sj_opt] = alternating_Opt_sj(K,pmax,N,B,gi,gj,si_opt,x0);
x0 = [z_opt2,sj_opt.*z_opt2];


%A = sqrt(sum((z_opt2-z_opt1).^2));
%A = sum(abs(z_opt2 - z_opt1)); %l1 norm
A = abs(sum(z_opt2)-sum(z_opt1));
end

opt_delays(pmax-SNRmin+1) = sum(z_opt2);
opt_z(pmax-SNRmin+1,:) = z_opt2';
r = r + 1
end


tiledlayout(2,1)
nexttile;
plot(SNRmin:SNRmax,opt_delays,'--.','MarkerIndices',1:2:length(opt_delays))
title(['K = ',num2str(K),'s'])
xlabel('SNR(dB)')
ylabel('sum delay')

nexttile      
bar(1:size(opt_z,2),opt_z')
title('Time Sharing Schedule')
xlabel('phase')
ylabel('Time')

toc
