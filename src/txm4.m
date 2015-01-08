function [ m1, m2, m3, m4, status ] = txm4(zvl, cfreq, gain, y, fsample, wire)
    process = USRPTX(cfreq, gain, y, fsample, wire);
    
    pause(2);

    status = zvl.sweep();
    if status ~= 1
        status = 1;
        return
    end

    m1 = zvl.m(1).y;
    m2 = zvl.m(2).y;
    m3 = zvl.m(3).y;
    m4 = zvl.m(4).y;

    status = process.stop();
end
