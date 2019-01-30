clc
clf
close all
clearvars

% H(z)
num = [1, -0.9, 0.81, 0, 0];
den = [1, -2.76, 3.809, -2.654, 0.924];
zero = roots(num);
pole = roots(den);
[r, p, k] = residue(num, den);

% H*(1/z*), or H~
numm = [0.81, -0.9, 1];
denn = [0.924, -2.654, 3.809, -2.76, 1];
zeroo = roots(numm);
polee = roots(denn);
[rr, pp, kk] = residue(numm, denn);

% product of H and H~
nummm = conv(num, numm);
dennn = conv(den, denn);
zerooo = roots(nummm);
poleee = roots(dennn);
[rrr, ppp, kkk] = residuez(nummm, dennn);

% testing residue (partial fraction expansion)
% num = [1, 0, 1];
% den = [1, 0, 3];
% [r, p, k] = residue(num, den)

% testing iztrans (inverse Z-transform, it doesn't work that well with cos)
% syms z
% rrr3 = 2.0177+1j*12.7081;
% p1 = 0.6231+1j*0.7593;
% b1 = -2*real(p1);
% b0 = abs(p1)^2;
% a2 = 2*real(rrr3);
% a1 = -2*real(rrr3*conj(p1));
% a0 = 0;
% F = (a2*z^2+a1*z+a0)/(z^2+b1*z+b0);
% iztrans(F)