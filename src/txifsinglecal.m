function [ status, res ] = txifsinglecal(pow, fsample, wire, ampl, gain, cfreq)

    ifreq = 0;
    t = (0 : gcd(fsample, ifreq)-1) / fsample;
    s = exp(1i*(2*pi*ifreq*t));
    s = s./max(abs(s));
    y = s*(2^(wire-1)-1)*ampl;

    usrp = USRPTX(cfreq, gain, y, fsample, wire);

    pause(2);
    pow.freq = cfreq;
    res = pow.pow;
    
    status = usrp.stop();

end

