clc
clf
close all
clearvars

% autocorr
M1 = 2; % backward
M2 = 2; % forward
r0 = 1;
r1 = 0.8;
r2 = 0.6;
r3 = 0.4;
r4 = 0.3;

% optimal symmetric smoothing
Rbb = [r0,r1;r1,r0];
Rbf = [r3,r4;r2,r3];
Rfb = Rbf';
Rff = Rbb;
rb = [r2;r1];
rf = flipud(rb);

Cf = inv(Rff-Rfb*inv(Rbb)*Rbf)*(Rfb*inv(Rbb)*rb-rf);
Cb = inv(Rbb)*(-rb-Rbf*Cf);
PMs = rb'*Cb+r0+rf'*Cf;

% sanity check
a1 = Rbb*Cb+rb+Rbf*Cf;
a2 = Rfb*Cb+rf+Rff*Cf;