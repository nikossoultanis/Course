function [quantized_signal, centers, distortion] = Lloyd_Max(signal, NoB, min_value, max_value)
error = 10^(-6);

stages = 2^NoB; % NoB = number of bits.
range = max_value - min_value;
delta = range/stages; %delta step
centers = [min_value:delta:max_value];

distortion = [0 1];
k = 2;
s = size(signal);
s = s(1);
%removing outliers.
if min(signal) < min_value
    for i=1:s
        if signal(i) < min_value
            signal(i) = min_value;
        end
    end
end
if max(signal) > max_value
    for i=1:s
        if signal(i) > max_value
            signal(i) = max_value;
        end
    end
end

while abs(distortion(k) - distortion(k-1)) >= error
    quantized_signal = [];
    total = 0;
    counted   = zeros(length(centers));
    cond_mean = zeros(length(centers));
    
    %Quantization zones.
    T = [];
    T(1) = min_value;
        for i=2:(length(centers)-2)
            T(i) = (centers(i) + centers(i+1))/2;
        end
    T(i+1) = max_value;
    
    for i=1:s
        for j=1:(length(T)-1)
            if T(j) < signal(i) && signal(i) <= T(j+1)
                quantized_signal(i) = j;
                %mean  distance for center
                total = total + abs(centers(j+1) - signal(i));
                %cond mean for next center.
                cond_mean(j) = cond_mean(j) + signal(i);
                counted(j)   = counted(j) + 1;
            end
        end
    end
    avg_distortion = total/s;
    distortion = [distortion avg_distortion];
    k = k + 1;
    
    %new centers
    for j=2:(length(centers)-1)
        if counted(j-1) ~= 0
            centers(j) = cond_mean(j-1)/counted(j-1);
        end
    end
end

distortion(1) = [];
distortion(2) = [];
centers(1) = [];
centers(length(centers)) = [];

end