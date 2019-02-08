function rawData = raspiAnalyze()
% This script will import the binary data from files written by the C
% program on Raspberry Pi.
%
% The script uses the function raspiImport to do the actual import and
% conversion from binary data to numerical values. Make sure you have
% downloaded it as well.
%
% After the import function is finished, the data are written to the
% variable rawData. The number of samples is returned in a variable samples



% Open, import and close binary data file produced by Raspberry Pi
%% FIXME: Change this.

path = 'W:/lab1/micTest.dat';

% Definitions
channels = 5;   % Number of ADC channels used

% Run function to import all data from the binary file. If you change the
% name or want to read more files, you must change the function
% accordingly.

[rawData, nomTp] = raspiImport(path,channels);
% plot(abs(fft(rawData,31250)))
% xlabel('Frequency [Hz]');
% ylabel('Magnitude');

% Plot all raw data and corresponding amplitude response
% fh_raw = figure;    % fig handle
% plot(rawData,'-o');
% ylim([0, 4095]) % 12 bit ADC gives values in range [0, 4095]
% xlabel('sample');
% ylabel('conversion value');
% legendStr = cell(1,channels);
% for i = 1:channels
%     legendStr{1,i} = ['ch. ' num2str(i)];
% end
% legend(legendStr,'location','best');
% title('Raw ADC data');

end