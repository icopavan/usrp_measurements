function [ status, res ] = txifsingle(zvl, fsample, wire, ampl, gain, cfreq, ifreq)

    t = (0 : gcd(fsample, ifreq)-1) / fsample;
    s = exp(1i*(2*pi*ifreq*t));
    s = s./max(abs(s));
    y = s*(2^(wire-1)-1)*ampl;

    usrp = USRPTX(cfreq, gain, y, fsample, wire);

    pause(2);
    zvl.cfreq = cfreq + ifreq;
    zvl.m(1).freq = cfreq + ifreq;
    zvl.sweep();
    res = zvl.m(1).y;
    
    status = usrp.stop();

end

