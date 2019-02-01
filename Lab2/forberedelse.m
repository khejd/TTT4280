% Forberedelsesoppgave 1
rawData = raspiAnalyze();

fs = 31250;
fpass = 500;
int_factor = 16;
%%
sound3 = highpass(rawData(:,3),fpass,fs);
sound4 = highpass(rawData(:,4),fpass,fs);
sound5 = highpass(rawData(:,5),fpass,fs);

n=numel(sound3);
n1 = ceil(n*(1/10));
n2 = ceil(n*(9/10));
sound3= sound3(n1:n2);
sound4= sound4(n1:n2);
sound5= sound5(n1:n2);
%%
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
nlen = numel(int_sound3);
r43_max = max(abs(r43));
l43 = nlen - find(r43==r43_max | r43==-r43_max);
dt_43 = l43/(fs*int_factor);

r53_max = max(abs(r53));
l53 = nlen - find(r53==r53_max | r53==-r53_max);
dt_53 = l53/(fs*int_factor);

r54_max = max(abs(r54));
l54 = nlen - find(r54==r54_max | r54==-r54_max);
dt_54 = l54/(fs*int_factor);
%%
timeMatrix = [dt_43;dt_53;dt_54];
a = 5.018;
spos = [[0,1,0]*a;[-sqrt(3)/2,-0.5,0]*a;[sqrt(3)/2,-0.5,0]*a];
x43 = spos(2,:)-spos(1,:);
x53 = spos(3,:)-spos(1,:);
x54 = spos(3,:)-spos(2,:);
xmatrix = [x43;x53;x54];
xvector = -343.4*pinv(xmatrix)*timeMatrix;
theta2 = atan2d(xvector(2),xvector(1));

theta1 = atand(sqrt(3)*(dt_43+dt_53)/(dt_43-dt_53-2*dt_54));

fprintf("Theta avansert = %f\nTheta enkel = %f\n",theta2,theta1)


