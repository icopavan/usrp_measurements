function pows = txmeasuresweep(gains, rffreqs, ampl, N_meas, N_sample, wire, pwr, savefile)
    
    pows = zeros(length(gains), N_meas, length(rffreqs));
    
    v = ones(1, 5000)*127*ampl;
    
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
            save(savefile, 'pows', 'rffreqs', 'gains', 'ampl', 'N_sample', 'wire');
        end
    end
end

