load('13-Jan-2015/rx_ip3.mat');

X = pows';
La = log10(mean(10.^res(:,:,2), 2)) - gain;
LIM3 = log10(mean(10.^res(:,:,4), 2)) - gain;

load('14-Jan-2015/calrx_ip3.mat');
realLa = log10(mean(10.^ressmbv, 2));
X = realLa;
%LIM3 = LIM3 - mErr;
%La = realLa;


basedir = '../tex/data/ip3/rx/';

mkdir(basedir);

dlmwrite(sprintf('%sla', basedir), [X La], 'delimiter', '\t');
dlmwrite(sprintf('%sim3', basedir), [X LIM3], 'delimiter', '\t');

pLa = polyfit(X(1:end), La(1:end), 1)
pLIM3 = polyfit(X(end-4:end-1), LIM3(end-4:end-1), 1)

pX = linspace(-60, -5);

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