ampl = 0.7;
gains = [0 15 31.5];
cfreqs = (400:100:4400)*1e6;
ifreqs8 = (-48:1:48)*1e6;
ifreqs16 = (-17:0.5:17)*1e6;

res8 = zeros(length(gains), length(cfreqs), length(ifreqs8));
res16 = zeros(length(gains), length(cfreqs), length(ifreqs16));

now = datestr(date);
mkdir(now);
savefile = strcat(now, '/txif.mat');

zvl = ZVL('128.131.85.229');
zvl.span = 5e6;
zvl.ref = 0;
zvl.rbw = 100e3;
zvl.att = 10;
zvl.display = 'OFF';
zvl.points = 1001;
zvl.avg_cnt = 20;
zvl.m(1).enable = true;

for i = 1:length(gains)
    for j = 1:length(cfreqs)
        tic
        for k = 1:length(ifreqs8)
            fprintf(1, 'gain: %gdBm cf: %4dMHz if: %3dMHz 8Bit: ', gains(i), cfreqs(j)/1e6, ifreqs8(k)/1e6);
            status = 1;
            while status ~= 0
                [status, y] = txifsingle(zvl, 50e6, 8, ampl, gains(i), cfreqs(j), ifreqs8(k));
                if status ~= 0
                    fprintf(1, 'Error %d!\n', status);
                end
            end
            fprintf(1, '%gdBm\n', y);
            res8(i, j , k) = y;
            save(savefile, 'ampl', 'gains', 'cfreqs', 'ifreqs8', 'ifreqs16', 'res8', 'res16');
        end
        toc
        sendmail(email, sprintf('Messung TXIF gain: %gdBm cf: %4dMHz 8Bit', gains(i), cfreqs(j)/1e6), 'fertig!', {savefile});
        tic
        for k = 1:length(ifreqs16)
            fprintf(1, 'gain: %gdBm cf: %4dMHz if: %3dMHz 16Bit: ', gains(i), cfreqs(j)/1e6, ifreqs16(k)/1e6);
            status = 1;
            while status ~= 0
                [status, y] = txifsingle(zvl, 25e6, 16, ampl, gains(i), cfreqs(j), ifreqs16(k));
                if status ~= 0
                    fprintf(1, 'Error %d!\n', status);
                end
            end
            fprintf(1, '%gdBm\n', y);
            res16(i, j , k) = y;
            save(savefile, 'ampl', 'gains', 'cfreqs', 'ifreqs8', 'ifreqs16', 'res8', 'res16');
        end
        toc
        sendmail(email, sprintf('Messung TXIF gain: %gdBm cf: %4dMHz 16Bit', gains(i), cfreqs(j)/1e6), 'fertig!', {savefile});
    end
end

delete(zvl);