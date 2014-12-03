function [v, status] = usrp_rx(frequency, gain, samples, lo, dc, samp_rate, wire)
    narginchk(3, 7);
    if nargin < 4
        lo = 0;
    end
    if nargin < 5
        dc = 0;
    end
    if nargin < 6
        samp_rate = 50e6;
    end
    if nargin < 7
        wire = 8;
    end
    tmp = '/run/shm/sink';
    cmd = sprintf('./rx_final.py --freq=%g --gain=%g --samples=%d --filename=%s --lo-off=%g --dc=%d --samp-rate=%g --wire=%d', frequency, gain, samples, tmp, lo, dc, samp_rate, wire);
    [status, result] = system(cmd);
    result = strsplit(result, '\n');
    status = status + length(result{end});
    v = load_data(tmp, samples, wire);
    delete(tmp);
end