function SNR = calculate_SNR(channels, pulse_bin, start_noise_bin, should_plot)
% Calculate SNR of pulse signals in all color channels using FFT, as sum(bins
% of interest)/sum(noise bins).
%
% Note: This function takes in bin indices instead of frequencies.  You'll
% either need to supply these manually and fine-tune for each measurement, or
% modify the script so that you instead take in frequencies in frequency units
% and then convert to appropriate bin indices. (Or construct your own SNR
% script which is much better than this one. If you know of a better definition
% or way to do this, feel free to use that instead.)
%
% (Tip: write a script where you call this function on specific data loaded
% from file, e.g.
%
% data_1 = load('pulse_measurement_1.txt');
% (preprocessing?)
% SNR_1 = calculate_SNR(data_1, 12, 60, false)
%
% data_2 = load('pulse_measurement_2.txt');
% (preprocessing?)
% SNR_2 = calculate_SNR(data_1, 30, 60, false)
%
% (...)
%
% In this way, it gets a bit more reproducable.)
%
% Parameters
% ----------
%
% channels: Matrix of size (NUM_SAMPLES x 3)
% 	Sampled signal in red, green and blue channels, as obtained from
% 	read_video_and_extract_roi.m.
%
% pulse_bin: integer
% 	Assumed frequency bin of interest, corresponding to the pulse signal.
%
%	(Note: It might turn out that this should be a range rather than a
%	single peak value, or that the peak value should be interpolated, like
%	in https://www.la1k.no/wp-content/uploads/2018/07/interpolation.png.)
%
% start_noise_bin: integer
%	Assumed start bin of noise frequencies. All frequencies above this bin
%	are assumed to be the noise of the signal.
%
% should_plot: boolean
%	Whether the FFT should be plotted or not. Use this to fine-tune. Will
%	show assumed signal and noise parts.
%
% Returns
% -------
%
% SNR: Array of doubles, length 3
%	Calculated SNR of the input channels.

%get shifted fft spectrum
fft_spectrum = abs(fftshift(fft(channels), 1));
L = size(fft_spectrum, 1);

%calculate digital frequency axis
freqs = (-L/2:L/2-1)/L;

%use only positive part
fft_spectrum = fft_spectrum(freqs >= 0, :);
freqs = freqs(freqs >= 0);    

%get signal bin
pulse_bin_amplitude = fft_spectrum(pulse_bin,:);

%get noise bins
noise_bin_amplitudes = fft_spectrum(start_noise_bin:end, :);
disp(pulse_bin_amplitude)

%calculate SNR
SNR = pulse_bin_amplitude./sum(noise_bin_amplitudes, 1);

if should_plot
	clf;
	axes = [];
	for channel=1:size(channels,2)
		axes(channel) = subplot(1, 3, channel);

		%plot FFT
		semilogy(abs(fft_spectrum(:,channel)))
		hold on;

		%mark signal bin
		semilogy(pulse_bin, fft_spectrum(pulse_bin, channel), 'o')

		%mark noise bins
		semilogy(start_noise_bin:size(fft_spectrum, 1), fft_spectrum(start_noise_bin:end, channel))

		title(['Channel ', num2str(channel), ' (calculated SNR = ', num2str(SNR(channel))])
		xlabel('Frequency bin')
		ylabel('FFT amplitude')
	end
	legend('FFT', 'Signal of interest', 'Noise bins')
	linkaxes(axes,'x')
	linkaxes(axes,'y')
end

end
