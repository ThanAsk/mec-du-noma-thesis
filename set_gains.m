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
end

