load('13-Feb-2015/rxifcal.mat')

corr = repmat(-10-gains',1,length(cfreqs)) - pow2db(mean(db2pow(res),3));

load('19-Feb-2015/rxif.mat');

ys8(:,:,25) = abs(ms8(:,:,25));
res8 = -10-repmat(gains',1,length(cfreqs),length(ifreqs8))+mag2db(ys8)-mag2db(2^(8-1)-1) + repmat(corr,1,1,length(ifreqs8));
ys825(:,:,25) = abs(ms825(:,:,25));
res825 = -10-repmat(gains',1,length(cfreqs),length(ifreqs16))+mag2db(ys825)-mag2db(2^(8-1)-1) + repmat(corr,1,1,length(ifreqs16));
ys16(:,:,25) = abs(ms16(:,:,25));
res16 = -10-repmat(gains',1,length(cfreqs),length(ifreqs16))+mag2db(ys16)-mag2db(2^(16-1)-1) + repmat(corr,1,1,length(ifreqs16));

basedir = '../tex/data/if/rx/';
mkdir(basedir);

for i = 1:length(gains)
    dlmwrite(sprintf('%smesh16_%2.1f', basedir, gains(i)), [combvec(cfreqs,ifreqs16)' reshape(res16(i,:,:), length(ifreqs16)*length(cfreqs), 1)], 'delimiter', '\t');
    dlmwrite(sprintf('%smesh825_%2.1f', basedir, gains(i)), [combvec(cfreqs,ifreqs16)' reshape(res825(i,:,:), length(ifreqs16)*length(cfreqs), 1)], 'delimiter', '\t');    
    dlmwrite(sprintf('%smesh8_%2.1f', basedir, gains(i)), [combvec(cfreqs,ifreqs8)' reshape(res8(i,:,:), length(ifreqs8)*length(cfreqs), 1)], 'delimiter', '\t');
    for j = 1:length(cfreqs)
        dlmwrite(sprintf('%s16_%.0f_%2.1f', basedir, cfreqs(j)/1e6, gains(i)), [ifreqs16' reshape(res16(i,j,:), length(ifreqs16), 1)], 'delimiter', '\t');
        dlmwrite(sprintf('%s825_%.0f_%2.1f', basedir, cfreqs(j)/1e6, gains(i)), [ifreqs16' reshape(res825(i,j,:), length(ifreqs16), 1)], 'delimiter', '\t');
        dlmwrite(sprintf('%s8_%.0f_%2.1f', basedir, cfreqs(j)/1e6, gains(i)), [ifreqs8' reshape(res8(i,j,:), length(ifreqs8), 1)], 'delimiter', '\t');
    end
end

close all;

surf(ifreqs8, cfreqs, reshape(res8(1,:,:),length(cfreqs),length(ifreqs8)))
figure;
surf(ifreqs16, cfreqs, reshape(res825(1,:,:),length(cfreqs),length(ifreqs16)))
figure;
surf(ifreqs16, cfreqs, reshape(res16(1,:,:),length(cfreqs),length(ifreqs16)))
