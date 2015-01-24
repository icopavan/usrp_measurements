ampl = 0.7;
gains = [0 15 31.5];
cfreqs = (400:100:4400)*1e6;
Nsample = 5;

res8 = zeros(length(gains), length(cfreqs), Nsample);
res16 = zeros(length(gains), length(cfreqs), Nsample);


now = datestr(date);
mkdir(now);
savefile = strcat(now, '/txifcal.mat');

pow = PWR('128.131.85.239');

for i = 1:length(gains)
    for j = 1:length(cfreqs)
        tic
        for k = 1:Nsample
            fprintf(1, 'gain: %gdB cf: %4dMHz 8Bit (%d): ', gains(i), cfreqs(j)/1e6, k);
            status = 1;
            while status ~= 0
                [status, y] = txifsinglecal(pow, 50e6, 8, ampl, gains(i), cfreqs(j));
                if status ~= 0
                    fprintf(1, 'Error %d!\n', status);
                end
            end
            fprintf(1, '%gdBm\n', y);
            res8(i, j , k) = y;
            save(savefile, 'ampl', 'gains', 'cfreqs', 'res8', 'res16');
        end
        sendmail(email, sprintf('Messung TXIF cal gain: %gdB cf: %4dMHz 8Bit', gains(i), cfreqs(j)/1e6), 'fertig!', {savefile});
        for k = 1:Nsample
            fprintf(1, 'gain: %gdB cf: %4dMHz 16Bit (%d): ', gains(i), cfreqs(j)/1e6, k);
            status = 1;
            while status ~= 0
                [status, y] = txifsinglecal(pow, 25e6, 16, ampl, gains(i), cfreqs(j));
                if status ~= 0
                    fprintf(1, 'Error %d!\n', status);
                end
            end
            fprintf(1, '%gdBm\n', y);
            res16(i, j , k) = y;
            save(savefile, 'ampl', 'gains', 'cfreqs', 'res8', 'res16');
        end
        sendmail(email, sprintf('Messung TXIF cal gain: %gdBm cf: %4dMHz 16Bit', gains(i), cfreqs(j)/1e6), 'fertig!', {savefile});
        toc
    end
end

delete(pow);