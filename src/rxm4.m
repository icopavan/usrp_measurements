function [m1, m2, m3, m4, status] = rxm4(cfreq, gain, fsample, N_samples, wire, df)
    [v, status] = usrp_rx(cfreq, gain, N_samples, 0, 0, fsample, wire);
    m1 = pow2db(bandpower(v, fsample, [-df/2-50e3, -df/2+50e3]));
    m2 = pow2db(bandpower(v, fsample, [df/2-50e3, df/2+50e3]));
    m3 = pow2db(bandpower(v, fsample, [-3*df/2-50e3, -3*df/2+50e3]));
    m4 = pow2db(bandpower(v, fsample, [3*df/2-50e3, 3*df/2+50e3]));
end

