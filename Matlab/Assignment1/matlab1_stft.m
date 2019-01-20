clc
clf
close all
clearvars
importfile('Sample.wav')

%% (1)
M = 256;
R = 128;
% s1 = spectrogram(data, M, M-R, M);
spectrogram(data, 256, 256-128, 256, 'yaxis')

%% (2)
M = 1024;
R = 512;
% s2 = spectrogram(data, M, M-R, M);
% spectrogram(data, M, M-R, M, 'yaxis')

%% (3)
M = 4096;
R = 2048;
% s3 = spectrogram(data, M, M-R, M);
% spectrogram(data, 4096, 4096-2048, 4096, 'yaxis')