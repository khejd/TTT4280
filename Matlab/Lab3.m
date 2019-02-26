rawData = raspiAnalyze();
Idata = rawData(:,1);
Qdata = rawData(:,2);
Fs = 31250*2;
c = 3e8;
f0 = 24e9;

I = Idata-mean(Idata);
Q = Qdata-mean(Qdata);

a = I + 1j*Q;
a_fft = fftshift(fft(a));

n = length(a);
fshift = (-n/2:n/2-1)*(Fs/n);

% plot(fshift,abs(a_fft));
% plot(abs(a_fft(Fs/2:end)))
% plot(abs(a_fft))

[aMaxY, aMaxX] = max(abs(a_fft));
% aMaxXTrue = ceil(abs(Fs - aMaxX - aMaxX)/2);

newAfft = a_fft;
sides = 40;
newAfft(aMaxX-sides:aMaxX+sides) = 0;
%plot(0:Fs-1,abs(newAfft), 0:Fs-1, abs(a_fft))

[aMaxYNew, aMaxXNew] = max(abs(newAfft));
fd = abs(aMaxXNew - aMaxX)/2;
% 
% [pksThres,locsThres] = findpeaks(abs(a_fft),'Threshold',3e5);
% [pksDist,locsDist] = findpeaks(abs(a_fft),'MinPeakDistance',10);
% 
% locs = intersect(locsThres, locsDist);
% 
% % plot(fshift,abs(a_fft),fshift(locs),abs(a_fft(locs)),'or')
% xvec = 0:Fs-1;
% plot(xvec,abs(a_fft),xvec(locs),abs(a_fft(locs)),'or')
% 
% diff = 1e20;
% for i=1:length(locs)
%     test = abs(locs(i)-aMaxX);
%     if(test < diff && test~=0)
%         diff = test;
%     end
% end
%     
% fd = diff;
v = (fd*c)/(2*f0);




