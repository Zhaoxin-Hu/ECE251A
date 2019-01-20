clc
clf
close all
clearvars

filename = 'flute-C4.wav';
[x2 sr2] = wavread(filename);

% Get the time axis right.
t2 = linspace(0, length(x2) / sr2, length(x2));
plot(t2, x2)
xlabel('Time (sec)')