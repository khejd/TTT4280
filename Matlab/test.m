rawData = raspiAnalyze();
Idata = rawData(:,1);
Qdata = rawData(:,2);
I = Idata-mean(Idata);
Q = Qdata-mean(Qdata);

Fs = 31250;
L = length(I);
n = 2^nextpow2(L);
a = I + 1j*Q;
a_fft = fftshift(fft(a,n));

P2 = abs(a_fft/L);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1);
xvec = 0:(Fs/2*n):(Fs/2-Fs/n);
plot(P2)
plot(0:(Fs/n):(Fs/2-Fs/n),P1(1:n/2))

