clc
clf
close all
clearvars

% autocorr
M1 = 2; % backward
M2 = 2; % forward
r = [1,0.8,0.6,0.4,0.3];

% optimal symmetric smoothing
Rbb = [r(1),r(2);r(2),r(1)];
Rbf = [r(4),r(5);r(3),r(4)];
Rfb = Rbf';
Rff = Rbb;
rb = [r(3);r(2)];
rf = flipud(rb);

Cf = inv(Rff-Rfb*inv(Rbb)*Rbf)*(Rfb*inv(Rbb)*rb-rf);
Cb = inv(Rbb)*(-rb-Rbf*Cf);
PMs = rb'*Cb+r(1)+rf'*Cf;

% sanity check
a1 = Rbb*Cb+rb+Rbf*Cf;
a2 = Rfb*Cb+rf+Rff*Cf;