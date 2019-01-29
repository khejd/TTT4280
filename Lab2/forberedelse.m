% Forberedelsesoppgave 1
rawData = raspiAnalyze();

fs = 31250;
fpass = [5,1000];
DC = mean(mean(rawData(:,3:5)));
sound3 = rawData(:,3)-DC;
sound4 = rawData(:,4)-DC;
% int_sound3 = bandpass(interp(sound3, 16),fpass,fs);
% int_sound4 = bandpass(interp(sound4, 16),fpass,fs);
sound3 = bandpass(sound3, fpass, fs);
int_sound3 = interp(sound3, 16);
int_sound4 = interp(sound4, 16);
r = xcorr(int_sound3, int_sound4);
plot(r)
r_max = max(abs(r));
l = find(r==r_max | r==-r_max);
time = (l-1)/fs;

% Forberedelsesoppgave 2
