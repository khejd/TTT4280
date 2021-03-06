clear
filename = 'mt4';
%save_roi(filename)
load(strcat(filename,'.mat'))

%data = highpass(output_channels,1/sample_rate);
data = bandpass(output_channels,[1 3],sample_rate);
% plot(data)
for i=1:3
    [autocorrelation(:,i),lags(:,i)] = xcorr(data(:,i), length(data(:,i)));
    subplot(3,1,i)
    [pks,locs] = findpeaks(autocorrelation(:,i),'MinPeakHeight',autocorrelation((length(autocorrelation)+1)/2,i)*0.04);
    plot(lags(:,i), autocorrelation(:,i), lags(locs,i), pks,'or')
    
    middle(i) = (length(locs)+1)/2;
    n = 5;
    totalSum(i) = 0;
    for j=0:n-1
        totalSum(i) = totalSum(i) + abs(lags(locs(middle(i)+j)) - lags(locs(middle(i)+j+1)));
    end
end

pulsPeriode = totalSum/n;
puls = sample_rate./pulsPeriode.*60;

SNR = calculate_SNR(output_channels, 34, 90, true);