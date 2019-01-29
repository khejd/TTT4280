% Forberedelsesoppgave 1
fs = 31250;
sound1 = ;
sound2 = ;
int_sound1 = interp(sound1, 16);
int_sound2 = interp(sound2, 16);
r = xcorr(sound1, sound2);
l_max = max(abs(r));
index = find(r==l_max | r==-l_max);
time = (index-1)/fs;

% Forberedelsesoppgave 2
