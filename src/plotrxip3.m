load('13-Jan-2015/rx_ip3.mat');

dbfs = mag2db(2^(wire-1)-1);

La = pow2db(mean(db2pow(res(:,:,2)), 2)) - dbfs;
LIM3 = pow2db(mean(db2pow(res(:,:,4)), 2)) - dbfs;

load('14-Jan-2015/calrx_ip3.mat');
X = pow2db(mean(db2pow(ressmbv), 2));


basedir = '../tex/data/ip3/rx/';

mkdir(basedir);

dlmwrite(sprintf('%sla', basedir), [X La], 'delimiter', '\t');
dlmwrite(sprintf('%sim3', basedir), [X LIM3], 'delimiter', '\t');

f1 = fit(X(end-4:end-1), La(end-4:end-1), 'x+a', 'Start', 0);
pLa = [1 f1.a]
f2 = fit(X(end-4:end-1), LIM3(end-4:end-1), '3*x+a', 'Start', 0);
pLIM3 = [3 f2.a]


pX = linspace(-65, -5);

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