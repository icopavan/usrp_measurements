cable = dlmread('16-Dec-2014/kabel_neu.s2p', '\t', 5, 0);
cable = -20*log10(abs(cable(:,6)+1j*cable(:,7)));

basedir = '../tex/data/rf/tx/';

mkdir(strcat(basedir, '1.0'));
mkdir(strcat(basedir, '0.8'));
mkdir(strcat(basedir, '0.821.0'));
mkdir(strcat(basedir, '1db'));

load('16-Dec-2014/tx_50_8_0.8.mat');
powscorr = repmat(cable',8,1)+reshape(log10(mean(10.^pows,2)),8,81);

for i = 1:length(gains)
    dlmwrite(sprintf('%s/%1.1f/%2.1f', basedir, ampl, gains(i)), [rffreqs' powscorr(i,:)'], 'delimiter', '\t');
end

load('16-Dec-2014/tx_50_8_0.8.mat');
powscorr = repmat(cable',8,1)+reshape(log10(mean(10.^pows,2)),8,81);

powscorr = mag2db(db2mag(powscorr) / 0.8);

for i = 1:length(gains)
    dlmwrite(sprintf('%s/%1.1f21.0/%2.1f', basedir, ampl, gains(i)), [rffreqs' powscorr(i,:)'], 'delimiter', '\t');
end

for i = 1:length(rffreqs)
    dlmwrite(sprintf('%s/1db/%1.2f', basedir, rffreqs(i)/1e9), [gains' powscorr(:,i)], 'delimiter', '\t');
end

load('16-Dec-2014/tx_50_8_1.0.mat');
powscorr = repmat(cable',8,1)+reshape(log10(mean(10.^pows,2)),8,81);

for i = 1:length(gains)
    dlmwrite(sprintf('%s/%1.1f/%2.1f', basedir, ampl, gains(i)), [rffreqs' powscorr(i,:)'], 'delimiter', '\t');
end

%%
% 
% xlabel('gain/dB');
% ylabel('dBm');
% 
% xlabel('f/Hz');
% ylabel('dBm');