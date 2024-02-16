% Mikhail Smirnov

% Reads stereo WAV file and feeds it through a Low Pass Filter.
% Based on an analog RC first order LPF circuit design.
% The z transfer function was obtained by Backward Euler discretization
% H(z) =       T                      1 
%        ------------  *   -------------------------
%          T + tau          1 - tau/(T+tau)*z^(-1)
% where tau is the time constant (RC)

% Importing stereo audio wav file (2 columns)
[fileIN, pathIN] = uigetfile('*.wav');
if isequal(fileIN, 0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(pathIN, fileIN)]);
end
fullFileNameIN = fullfile(pathIN, fileIN);
[stereoWav, Fs] = audioread(fullFileNameIN);

% Input filter parameters UI
prompt = {'Cutoff frequency','Output signal gain (WARNING: Gain more than 2 may cause clipping):'};
dlgtitle = 'Filter Parameters';
fieldsize = [1 45; 1 45];
definput = {'100','1'}; % Default input (fc, Gain)
parameters = inputdlg(prompt, dlgtitle, fieldsize, definput);
%---------------------------------------------------
% Parameters
Gain = str2double(cell2mat(parameters(2))); % Gain for LPF signal
T = 1/Fs; % Sampling period
fc = str2double(cell2mat(parameters(1))); % Cutoff freq (Hz)
tau = 1/(2*pi*fc); % RC Time Constant
L = length(stereoWav); % Length of signal
time = L/Fs; % Audio duration [s]
f = Fs/L*(0:(L/2)); % Single-sided frequency axis

% Filtering ---------------------------------------
% Coefficients of z-transfer function:
b = T/(T+tau);
a = [1 -tau/(T+tau)];

% Applying filter
LPF_resultL = filter(b, a, stereoWav(:,1)); % Left channel
LPF_resultR = filter(b, a, stereoWav(:, 2)); % Right channel
LPF_result = Gain * [LPF_resultL LPF_resultR];
%--------------------------------------------------

% Writing output to directory
prompt = 'Specify output file path';
dlgtitle = 'Save file to';
filePathOUT = inputdlg(prompt, dlgtitle, fieldsize(1,:));
fileNameOUT = 'LPF_output.wav';
pathOUT = fullfile(char(filePathOUT), fileNameOUT);
audiowrite(pathOUT, LPF_result, Fs);
disp(['File saved to ', pathOUT]);

% -------------------------------------------------
% Frequency domain
FFT_audio_ogL = fft(stereoWav(:, 1)); % Left channel
FFT_audio_ogR = fft(stereoWav(:, 2)); % Right channel
FFT_audio_LPFL = fft(LPF_resultL);
FFT_audio_LPFR = fft(LPF_resultR);

% Convert to single-sided amplitude spectrum
SS_FFT_ogL = convertSS(FFT_audio_ogL);
SS_FFT_ogR = convertSS(FFT_audio_ogR);
SS_FFT_LPFL = convertSS(FFT_audio_LPFL);
SS_FFT_LPFR = convertSS(FFT_audio_LPFR);

% Plotting-----------------------------------------
figure(1)
subplot(1, 2, 1)
plot(f, mag2db(SS_FFT_ogL))
xlabel("f [Hz])", "Interpreter",'latex')
ylabel("Magnitude [dB]", "Interpreter",'latex')
title("Original Signal Spectrum (Left Stereo)")
%xlim([0 2000])
%ylim([-160 0])
subplot(1, 2, 2)
plot(f, mag2db(SS_FFT_ogR))
xlabel("f [Hz])", "Interpreter",'latex')
ylabel("Magnitude [dB]", "Interpreter",'latex')
title("Original Signal Spectrum (Right Stereo)")
%xlim([0 2000])
%ylim([-160 0])

figure(2)
subplot(1, 2, 1)
plot(f, mag2db(SS_FFT_LPFL))
xlabel("f [Hz]", "Interpreter",'latex')
ylabel("Magnitude [dB]", "Interpreter",'latex')
title("Filtered Signal Spectrum (Left Stereo)")
%xlim([0 2000])
%ylim([-160 0])
subplot(1, 2, 2)
plot(f, mag2db(SS_FFT_LPFR))
xlabel("f [Hz]", "Interpreter",'latex')
ylabel("Magnitude [dB]", "Interpreter",'latex')
title("Filtered Signal Spectrum (Right Stereo)")
%xlim([0 2000])
%ylim([-160 0])



















% COMMENTS_________________________________________________________________
% Improvements:
% DONE - Play/filter stereo back instead of mono
% Seems like the filtered signal is quieter, maybe balance the volume as original?
% Make one channel LPF and other channel HPF
% Transform into 2nd order filter
% DONE - Make GUI that allows you to import other audio files
% DONE - Make cutoff freq adjustable
% Make compatible with mono audio

% GUI variables:
% DONE - Make gain be adjustable
% DONE - Make path be adjustable and create LPF file
% - Make length of signal be adjustable and convert into seconds

