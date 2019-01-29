% raspiImport takes in a path string and imports a specified binary data file
% from this path. It returns the raw data as a matrix NUM_SAMPLES x
% NUM_CAHNNELS, and the sample period in seconds.
function [rawData, sample_period] = raspiImport(path,channels)

% Input argument handling
if nargin < 2
    channels = 1;   % Assume single channel as nothing was specified
    warning('Number of channels not defined, assuming single...');
end

% Open file
fidAdcData = fopen(path);
% Read binary data to local variables
sample_period = fread(fidAdcData, 1, 'double')*1.0e-06;
adcData = fread(fidAdcData,'uint16');
% Close files properly after import
fclose(fidAdcData);

lenAdcData = length(adcData);       % Total number of ADC data bytes
samples = lenAdcData/channels;      % Total number of samples

%reshape one-dimensional data array into NUM_SAMPLES x NUM_CHANNELS data matrix
rawData = reshape(adcData, channels, samples)';

end
