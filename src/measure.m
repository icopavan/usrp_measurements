function [ps, ys] = measure( smbv, gain, freqs, N_samples, N_meas, offset)
    ps = zeros(N_meas, length(freqs));
    ys = zeros(N_meas, length(freqs));
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
            p = pow2db(bandpower(v, 50e6, [off-0.5e6, off+0.5e6]));
            ps(j,i) = p;
            y = sqrt(mean(abs((v-mean(v)).^2)));
            ys(j,i) = y;
            fprintf(1, '%d. %g (%g): %gdB %gfsc\n', j, f, o, p, y);
        end
    end
end

