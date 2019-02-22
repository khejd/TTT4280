Fs = 1000;                    % Sampling frequency
T = 1/Fs;                     % Sampling period
L = 1000;                     % Length of signal
t = (0:L-1)*T;                % Time vector

x1 = cos(2*pi*50*t);          % First row wave
x2 = cos(2*pi*150*t);         % Second row wave
x3 = cos(2*pi*300*t);         % Third row wave

X = [I; Q; I];

% for i = 1:3
%     subplot(3,1,i)
%     plot(t(1:100),X(i,1:100))
%     title(['Row ',num2str(i),' in the Time Domain'])
% end

n = 2^nextpow2(L);
dim = 2;
Y = fft(X,n,dim);

P2 = abs(Y/L);
P1 = P2(:,1:n/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);

for i=1:3
    subplot(3,1,i)
    plot(0:(Fs/n):(Fs/2-Fs/n),P1(i,1:n/2))
    title(['Row ',num2str(i),' in the Frequency Domain'])
end