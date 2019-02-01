% Forberedelsesoppgave 1
rawData = raspiAnalyze();

fs = 31250;
fpass = [5,1000];
int_factor = 16;
DC = mean(mean(rawData(:,3:5)));
sound3 = rawData(:,3)-DC;
sound4 = rawData(:,4)-DC;
sound5 = rawData(:,5)-DC;

% int_sound3 = bandpass(interp(sound3, int_factor),fpass,fs*int_factor);
% int_sound4 = bandpass(interp(sound4, int_factor),fpass,fs*int_factor);
% int_sound5 = bandpass(interp(sound5, int_factor),fpass,fs*int_factor);

int_sound3 = interp(sound3, int_factor);
int_sound4 = interp(sound4, int_factor);
int_sound5 = interp(sound5, int_factor);

[r34,lags34] = xcorr(int_sound3, int_sound4);
[r35,lags35] = xcorr(int_sound3, int_sound5);
[r45,lags45] = xcorr(int_sound4, int_sound5);

plot(lags34,r34,'-o')

r34_max = max(abs(r34));
l34 = find(r34==r34_max | r34==-r34_max);
dt_34 = abs((l34-max(lags34))/(fs*int_factor));

r35_max = max(abs(r35));
l35 = find(r35==r35_max | r35==-r35_max);
dt_35 = abs((l35-max(lags35))/(fs*int_factor));

r45_max = max(abs(r45));
l45 = find(r45==r45_max | r45==-r45_max);
dt_45 = abs((l45-max(lags45))/(fs*int_factor));

theta = atand(sqrt(3)*(dt_34+dt_35)/(dt_34-dt_35-2*dt_45));
fprintf("Theta = %f\n",theta)


