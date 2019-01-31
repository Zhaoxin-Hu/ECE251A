clc
clf
close all
clearvars

% generate system transfer function
num = [1, -0.9, 0.81];
den = [1, -2.76, 3.809, -2.654, 0.924];
sys = filt(num, den);
[h, nh] = impz(num, den);
hh = flipud(h);

% true autocorr
rHatx = conv(h, flipud(h));

% plot
figure
plot(rHatx)