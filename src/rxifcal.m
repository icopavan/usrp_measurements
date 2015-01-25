ampl = 0.7;
gains = [0 15 31.5];
cfreqs = (400:100:4400)*1e6;
Nsample = 5;

res = zeros(length(gains), length(cfreqs), Nsample);


now = datestr(date);
mkdir(now);
savefile = strcat(now, '/rxifcal.mat');

pow = PWR('128.131.85.239');
smiq = SMIQ('128.131.85.223', 'gpib0,27');
smiq.pow = -10;
smiq.freq = cfreqs(1);
smiq.rf = true;

for i = 1:length(gains)
    out = -10-gains(i);
    smiq.pow = out;
    for j = 1:length(cfreqs)
        smiq.freq = cfreqs(j);
        pow.freq = cfreqs(j);
        tic
        for k = 1:Nsample
            fprintf(1, 'gain: %gdB pow: %gdBm cf: %4.1fMHz 8Bit (%d): ', gains(i), out, cfreqs(j)/1e6, k);
            y = pow.pow;
            fprintf(1, '%gdBm\n', y);
            res(i, j , k) = y;
            save(savefile, 'ampl', 'gains', 'cfreqs', 'res');
        end
        sendmail(email, sprintf('Messung RXIF cal gain: %gdB pow: %gdBm cf: %4dMHz 8Bit', gains(i), out, cfreqs(j)/1e6), 'fertig!', {savefile});
        toc
    end
end

delete(smiq);
delete(pow);