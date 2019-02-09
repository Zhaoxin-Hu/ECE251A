clc
clf
close all
clearvars

numa = [0, 1];
dena = [-1/2, 5/4, -1/2];
[ra,pa,ka] = residuez(numa, dena);

numb = [0, 0, 1];
denb = [0.6, -2.4, 3.61, -2.4, 0.6];
[rb,pb,kb] = residuez(numb, denb);