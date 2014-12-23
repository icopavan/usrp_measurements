cable = dlmread('16-Dec-2014/kabel_neu.s2p', '\t', 5, 0);
cable = -20*log10(abs(cable(:,6)+1j*cable(:,7)));

mkdir('data');
mkdir('data/rf');
mkdir('data/rf/tx');
mkdir('data/rf/tx/1.0');
mkdir('data/rf/tx/0.8');

load('16-Dec-2014/tx_50_8_0.8.mat');
powscorr = repmat(cable',8,1)+reshape(mean(pows,2),8,81);

for i = 1:length(gains)
    dlmwrite(sprintf('data/rf/tx/%1.1f/%2.1f', ampl, gains(i)), [rffreqs' powscorr(i,:)'], 'delimiter', '\t');
end

load('16-Dec-2014/tx_50_8_1.0.mat');
powscorr = repmat(cable',8,1)+reshape(mean(pows,2),8,81);

for i = 1:length(gains)
    dlmwrite(sprintf('data/rf/tx/%1.1f/%2.1f', ampl, gains(i)), [rffreqs' powscorr(i,:)'], 'delimiter', '\t');
end

%%
% 
% xlabel('gain/dB');
% ylabel('dBm');
% 
% xlabel('f/Hz');
% ylabel('dBm');