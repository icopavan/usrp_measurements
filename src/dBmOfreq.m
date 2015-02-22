function vals = dBmOfreq(gain, ys, wire, delta)
    switch wire
        case 8
            m = 127;
        case 16
            m = 32767;
    end
        
    g = gain/5 + 1;
    ys = reshape(mean(ys,2),11,81);
    vals = -14-gain+mag2db(m./ys(g,:))-delta;

end

