% Forberedelsesoppgave 1
rawData = raspiAnalyze();

fs = 31250;
fpass = 500;
int_factor = 16;

sound3 = highpass(rawData(:,3),fpass,fs);
sound4 = highpass(rawData(:,4),fpass,fs);
sound5 = highpass(rawData(:,5),fpass,fs);

% int_sound3 = bandpass(interp(sound3, int_factor),fpass,fs*int_factor);
% int_sound4 = bandpass(interp(sound4, int_factor),fpass,fs*int_factor);
% int_sound5 = bandpass(interp(sound5, int_factor),fpass,fs*int_factor);

int_sound3 = interp(sound3, int_factor);
int_sound4 = interp(sound4, int_factor);
int_sound5 = interp(sound5, int_factor);

[r43,lags43] = xcorr(int_sound4, int_sound3);
[r53,lags53] = xcorr(int_sound5, int_sound3);
[r54,lags54] = xcorr(int_sound5, int_sound4);

% plot(lags43,r43,'-o');

r43_max = max(abs(r43));
l43 = find(r43==r43_max | r43==-r43_max);
dt_43 = abs((l43-max(lags43))/(fs*int_factor));

r53_max = max(abs(r53));
l53 = find(r53==r53_max | r53==-r53_max);
dt_53 = abs((l53-max(lags53))/(fs*int_factor));

r54_max = max(abs(r54));
l54 = find(r54==r54_max | r54==-r54_max);
dt_54 = abs((l54-max(lags54))/(fs*int_factor));

theta = atand(sqrt(3)*(dt_43+dt_53)/(dt_43-dt_53-2*dt_54));
fprintf("Theta = %f\n",theta)


