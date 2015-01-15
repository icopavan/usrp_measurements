function [ pow, status ] = caltxm4(pwr, cfreq, gain, y, fsample, wire)
    process = USRPTX(cfreq, gain, y, fsample, wire);
    
    pause(2);

    pow = pwr.pow;

    status = process.stop();
end
