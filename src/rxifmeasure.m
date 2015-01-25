gains = [0 15 31.5];
cfreqs = (400:100:4400)*1e6;
ifreqs8 = (-24:1:24)*1e6;
ifreqs16 = (-12:0.5:12)*1e6;

res8 = zeros(length(gains), length(cfreqs), length(ifreqs8), N);
res16 = zeros(length(gains), length(cfreqs), length(ifreqs16), N);

now = datestr(date);
mkdir(now);
savefile = strcat(now, '/rxif.mat');

smiq = SMIQ('128.131.85.223', 'gpib0,27');
smiq.pow = -10;
smiq.freq = cfreqs(1);
smiq.rf = true;

for i = 1:length(gains)
    out = -10-gains(i);
    smiq.pow = out;
    for j = 1:length(cfreqs)
        tic
        for k = 1:length(ifreqs8)
            smiq.freq = cfreqs(j) + ifreqs8(k);
            fprintf(1, 'gain: %gdB out: %gdBm cf: %4dMHz if: %3dMHz 8Bit: ', gains(i), out, cfreqs(j)/1e6, ifreqs8(k)/1e6);
            status = 1;
            while status ~= 0
                [status, y] = rxifsingle(50e6, 8, gains(i), cfreqs(j), ifreqs8(k));
                if status ~= 0
                    fprintf(1, 'Error %d!\n', status);
                end
            end
            res8(i, j , k) = y;
            fprintf(1, '%gdBfsc\n ', y);
            save(savefile, 'gains', 'cfreqs', 'ifreqs8', 'ifreqs16', 'res8', 'res16');
        end
        toc
        sendmail(email, sprintf('Messung RXIF gain: %gdB out: %gdBm cf: %4dMHz 8Bit', gains(i), out, cfreqs(j)/1e6), 'fertig!', {savefile});
        tic
        for k = 1:length(ifreqs16)
            smiq.freq = cfreqs(j) + ifreqs8(k);
            fprintf(1, 'gain: %gdB out: %gdBm cf: %4dMHz if: %3dMHz 16Bit: ', gains(i), out, cfreqs(j)/1e6, ifreqs16(k)/1e6);
            status = 1;
            while status ~= 0
                [status, y] = rxifsingle(25e6, 16, gains(i), cfreqs(j), ifreqs16(k));
                if status ~= 0
                    fprintf(1, 'Error %d!\n', status);
                end
            end
            res16(i, j , k) = y;
            fprintf(1, '%gdBfsc\n ', y);
            save(savefile, 'gains', 'cfreqs', 'ifreqs8', 'ifreqs16', 'res8', 'res16');
        end
        toc
        sendmail(email, sprintf('Messung RXIF gain: %gdB out: %gdBm cf: %4dMHz 16Bit', gains(i), out, cfreqs(j)/1e6), 'fertig!', {savefile});
    end
end

delete(smiq);