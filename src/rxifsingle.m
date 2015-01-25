function [ status, res ] = rxifsingle(fsample, wire, gain, cfreq, ifreq, N)
    res = zeros(N, 1);
    for i = 1:N
        status = 1;
        while status ~= 0
            [v, status] = usrp_rx(cfreq, gain, fsample, 0, 0, fsample, wire);
            if (status ~= 0)
                disp('Overflow!');
            end
        end
        res(i) = pow2db(bandpower(v, fsample, [ifreq-50e3, ifreq+50e3]));
        fprintf(1, '%gdBm ', res(i));
    end
    fprintf(1, '\n');
end

