function [gi,gj] = set_gains(method)

switch method

    case 'constant'

        constant = 1; %0.8 close to results
        gi = constant*ones(1,2);
        gj = constant*ones(1,2);

    case 'random'

        variance = 1;
        h = sqrt(variance/2)*(randn(1,4)+1i*randn(1,4));
        h = abs(h).^2;
        gi = [h(1) h(2)];
        gj = [h(3) h(4)];

    case 'distant'  %distant_constant

        constant = 1; %0.8 close to linear results
        l = 3;
        d = 0.2;
        gi = constant*[1 d^(l)];
        gj = constant*[d^(l) 1];

%         gi = flip(gi);
%         gj = flip(gj);
    case 'distant_random'

        variance = 1; % E[g] = Ε[γ]/(pk*B) 
        l = 3; % path loss exponent
        vars = variance*[1 (0.2)^l 0.2^l 1];
        h = arrayfun(@(v)abs(sqrt(v/2)*(randn(1,1)+1i*randn(1,1))^2),vars);
        gi = [h(1) h(2)];
        gj = [h(3) h(4)];

    case 'close'
        %users close --> distances to stations almost the same
        l = 3;
        da = 1; %distance to base station a
        gi = [da (0.2*da)^l];
        gj = [da (0.2*da)^l];

%         gi = flip(gi);
%         gj = flip(gj);

end

