function [ status, p, y, m ] = rxifsingle(fsample, wire, gain, cfreq, ifreq)
    status = 1;
    while status ~= 0
        [v, status] = usrp_rx(cfreq, gain, fsample, 0, 0, fsample, wire);
        if (status ~= 0)
            disp('Overflow!');
        end
    end
    p = pow2db(bandpower(v, fsample, [ifreq-50e3, ifreq+50e3]));
    m = mean(abs(v));
    y = sqrt(mean(abs((v-mean(v)).^2)));
end

