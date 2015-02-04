load('24-Jan-2015/txifcal.mat')

corr16 = log10(mean(10.^res16,3));
corr8 = log10(mean(10.^res8,3));

load('24-Jan-2015/txif.mat');

corr16 = repmat(res16(:,:,round(length(ifreqs16)/2)+1) - corr16,1,1,length(ifreqs16));
corr8 = repmat(res16(:,:,round(length(ifreqs8)/2)+1) - corr8,1,1,length(ifreqs8));

res16 = res16 - corr16;
res8 = res8 - corr8;

basedir = '../tex/data/if/tx/';

mkdir(basedir);

for i = 1:length(gains)
    dlmwrite(sprintf('%smesh16_%2.1f', basedir, gains(i)), [combvec(cfreqs,ifreqs16)' reshape(res16(i,:,:), length(ifreqs16)*length(cfreqs), 1)], 'delimiter', '\t');
    dlmwrite(sprintf('%smesh8_%2.1f', basedir, gains(i)), [combvec(cfreqs,ifreqs8)' reshape(res8(i,:,:), length(ifreqs8)*length(cfreqs), 1)], 'delimiter', '\t');
    for j = 1:length(cfreqs)
        dlmwrite(sprintf('%s16_%.0f_%2.1f', basedir, cfreqs(j)/1e6, gains(i)), [ifreqs16' reshape(res16(i,j,:), length(ifreqs16), 1)], 'delimiter', '\t');
        dlmwrite(sprintf('%s8_%.0f_%2.1f', basedir, cfreqs(j)/1e6, gains(i)), [ifreqs8' reshape(res8(i,j,:), length(ifreqs8), 1)], 'delimiter', '\t');
    end
end


surf(ifreqs8, cfreqs, reshape(res8(1,:,:),length(cfreqs),length(ifreqs8)))
hold on
surf(ifreqs16, cfreqs, reshape(res16(1,:,:),length(cfreqs),length(ifreqs16)))