clc
clf
close all
clearvars

% half of true autocorr, implemented with cascaded systems H and H~
num = [1, -0.9, 0.81];
den = [1, -2.76, 3.809, -2.654, 0.924];
H = filt(num, den);

numtilde = [0, 0, 0.81, -0.9, 1];
dentilde = [0.924, -2.654, 3.809, -2.76, 1];
Htilde = filt(numtilde, dentilde);

% cascade H and H~
HH = H*Htilde;

% impulse response
impulse(HH)