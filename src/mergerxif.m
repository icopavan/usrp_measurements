load('18-Feb-2015/rxifrest.mat')

ys825rest = ys825;
ys8rest = ys8;
ys16rest = ys16;
ms825rest = ms825;
ms8rest = ms8;
ms16rest = ms16;
ps825rest = ps825;
ps8rest = ps8;
ps16rest = ps16;

load('17-Feb-2015/rxif.mat')

ys825(3,33:end,:) = ys825rest(3,33:end,:);
ys8(3,33:end,:) = ys8rest(3,33:end,:);
ys16(3,33:end,:) = ys16rest(3,33:end,:);
ms825(3,33:end,:) = ms825rest(3,33:end,:);
ms8(3,33:end,:) = ms8rest(3,33:end,:);
ms16(3,33:end,:) = ms16rest(3,33:end,:);
ps825(3,33:end,:) = ps825rest(3,33:end,:);
ps8(3,33:end,:) = ps8rest(3,33:end,:);
ps16(3,33:end,:) = ps16rest(3,33:end,:);

clear *rest
now = datestr(date);
mkdir(now);
savefile = strcat(now, '/rxif.mat');
save(savefile, 'gains', 'cfreqs', 'ifreqs8', 'ifreqs16', 'ys8', 'ys16', 'ps8', 'ps16', 'ys825', 'ps825', 'ms8', 'ms16', 'ms825');