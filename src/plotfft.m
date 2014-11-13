function plotfft( data, sample_rate )
    len = length(data);
    s = fft(data.*kaiser(len, 5));
    
    incr = sample_rate/len;
    min_x = -sample_rate/2;
    max_x = sample_rate/2 - incr;
    plot(min_x:incr:max_x, mag2db(abs(fftshift(s))));

end

