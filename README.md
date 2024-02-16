# first-order-iir-filter
This code reads a stereo WAV file and outputs a lowpass filtered result based on a first-order analog RC lowpass filter circuit design.
It also plots the frequency spectrum of both the input and output signals for both channels.

The lowpass filter was designed from a simple first order RC lowpass filter in which the differential equation in the time domain was discretized via the Backward Euler Method based on sampling time, T. From there, a difference equation was obtained and converted to the z-domain via the z-transform to obtain the final transfer function.

This code filters a WAV file via MATLAB's filter() function based on the coefficients of the transfer function.
