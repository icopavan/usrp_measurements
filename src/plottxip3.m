load('29-Jan-2015/tx_ip3.mat');

X = 20*log10(res(1,:,1));
La = log10(mean(10.^res(:,:,2))) - gain;
LIM3 = log10(mean(10.^res(:,:,4)));

load('29-Jan-2015/caltx_ip3.mat');
realLa = log10(mean(reshape(mean(10.^res, 3), 50, 20))) - 10*log10(2) - gain;
mErr = La - realLa;
LIM3 = LIM3 - mErr;
La = realLa;


basedir = '../tex/data/ip3/tx/';

mkdir(basedir);

dlmwrite(sprintf('%sla', basedir), [X' La'], 'delimiter', '\t');
dlmwrite(sprintf('%sim3', basedir), [X' LIM3'], 'delimiter', '\t');

pLa = polyfit(X(1:end), La(1:end), 1)
pLIM3 = polyfit(X(11:end), LIM3(11:end), 1)

pX = linspace(-20, 15);

yLa = polyval(pLa, pX);
yLIM3 = polyval(pLIM3, pX);

[IM3x, IM3y] = polyxpoly(pX, yLa, pX, yLIM3);
dlmwrite(sprintf('%spim3', basedir), [IM3x, IM3y], 'delimiter', '\t');

hold off;
plot(X,La,'x');
hold on;
plot(X,LIM3,'*');
plot(pX,yLa);
plot(pX,yLIM3);
plot(IM3x, IM3y, '+');