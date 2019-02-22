rawData = raspiAnalyze();
Idata = rawData(:,1);
Qdata = rawData(:,2);
Fs = 31250;
c = 3e8;
f0 = 24e9;

I = Idata-mean(Idata);
Q = Qdata-mean(Qdata);

a = I + 1j*Q;
a_fft = fftshift(fft(a));

n = length(a);
fshift = (-n/2:n/2-1)*(Fs/n);

plot(fshift,abs(a_fft));
plot(abs(a_fft(Fs/2:end)))
plot(abs(a_fft))

[aMaxY, aMaxX] = max(abs(a_fft));
aMaxXTrue = ceil(abs(Fs - aMaxX - aMaxX)/2);

[pks, locs, w, p] = findpeaks(abs(a_fft),Fs,'MinPeakProminence',1e6);

% v = (fd*c)/(2*f0);




