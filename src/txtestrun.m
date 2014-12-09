N_sample = 50e6;
N_meas = 10;
wire = 8;
rffreqs = 400e6:50e6:4.4e9;
ampl = 0.8;
gains = 0:5:30;
gains(end+1) = 31.5;

mkdir(datestr(date));
savefile = strcat(datestr(date), sprintf('/tx_%d_%d_%1.1f.mat', N_sample/1e6, wire, ampl));

pwr = PWR('128.131.85.239');
v = ones(1, 5000)*ampl;

pows = zeros(length(gains), N_meas, length(rffreqs));

for i = 1:length(gains)
    fprintf(1, '---------------------\n');
    fprintf(1, 'gain %d\n', gains(i)); 
    fprintf(1, '=====================\n');
    for j = 1:length(rffreqs)
        tic
            for k = 1:N_meas
                status = 1;
                while status ~= 0
                    [pow, status] = txmeasure(pwr, rffreqs(j), gains(i), v, N_sample, wire);
                end
                pows(i, k, j) = pow;
                fprintf(1, '%d. %g: %gdB\n', k, rffreqs(j), pow);
            end
        toc
        save(savefile, 'pows');
    end
end

delete(pwr);