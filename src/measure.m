function y = measure( smbv, gain, freqs, N_samples, N_meas, offset)
    y = zeros(N_meas, length(freqs));
    for i = 1:length(freqs)
        f = freqs(i);
        off = offset;
        o = f + off;
        if (o > 4.4e9)
            off = -offset;
            o = f + off;
        end
        smbv.freq = o;
        for j = 1:N_meas
            status = 1;
            while (status ~= 0)
                smbv.rf = 1;
                [v, status] = usrp_rx(f, gain, 0, N_samples);
                smbv.rf = 0;
                if (status ~= 0)
                    disp('Overflow!');
                end
            end
            db = pow2db(bandpower(v, 50e6, [off-0.5e6, off+0.5e6]));
            y(j,i) = db;
            fprintf(1, '%d. %g (%g): %gdB\n', j, f, o, db);
        end
    end
end

