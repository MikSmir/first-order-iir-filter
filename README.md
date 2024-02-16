# first-order-iir-filter
This program reads a stereo WAV file and outputs a lowpass filtered result based on a first-order analog RC lowpass filter circuit design.
It also plots the frequency spectrum of both the input and output signals for both channels.

In order to run this code, have a .wav stereo file (default one is provided as "smooth-ac-guitar-loop-93bpm-137706.wav").
Next, run the LPF.m script and specify the .wav file you want filtered. Next, specify the parameters of the filter via the pop-up dialogue window. Lastly, specify the path you would prefer the filtered .wav output file to be saved to. 
The output will be saved as "LPF_output.wav".

--
The lowpass filter was designed from a simple first order RC lowpass filter in which the differential equation in the time domain was discretized via the Backward Euler Method based on sampling time, T. From there, a difference equation was obtained and converted to the z-domain via the z-transform to obtain the final transfer function.

This code filters a WAV file via MATLAB's filter() function based on the coefficients of the transfer function.
