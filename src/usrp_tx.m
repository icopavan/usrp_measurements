function status = usrp_tx(frequency, gain, samples, v)
    tmp = '/run/shm/source';
    store_data(tmp, v);
    cmd = sprintf('./tx.py --freq=%g --gain=%g --samples=%d --filename=%s', frequency, gain, samples, tmp);
    [status, result] = system(cmd);
    result = strsplit(result, '\n');
    result = length(result{end});
    if result == 1
        result = 0;
    end
    status = status + result;
    delete(tmp);
end