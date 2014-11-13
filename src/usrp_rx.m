function [v, status] = usrp_rx(frequency, gain, lo, samples)
    tmp = '/run/shm/sink';
    cmd = sprintf('./rx.py --freq=%g --gain=%g --samples=%d --filename=%s --lo-off=%g', frequency, gain, samples, tmp, lo);
    [status, result] = system(cmd);
    result = strsplit(result, '\n');
    status = status + length(result{end});
    v = load_data(tmp, samples);
    delete(tmp);
end