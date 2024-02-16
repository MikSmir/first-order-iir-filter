% Converts output of FFT to Single-Sided Spectrum

function [resultSS] = convertSS(fft_output)

L = length(fft_output);
rescaled = abs(fft_output / L); % Rescale FFT by /L
resultSS = rescaled(1:L/2+1); % Take negative half of spectrum
resultSS(2:end-1) = 2*resultSS(2:end-1); % Multiply by 2 due to half-peak amplitudes

end