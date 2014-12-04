function status = usrp_tx(frequency, gain, v, samples, samp_rate, wire, async)
    narginchk(3, 7);
    if nargin < 4
        samples = 0;
    end
    if nargin < 5
        samp_rate = 50e6;
    end
    if nargin < 6
        wire = 8;
    end
    if nargin < 7
        async = 0;
    end
    tmp = '/run/shm/source';
    store_data(tmp, v);
    cmd = sprintf('./tx_final.py --freq=%g --gain=%g --samples=%d --filename=%s --samp-rate=%g --wire=%d', frequency, gain, samples, tmp, samp_rate, wire);
    if async == 0
        [status, result] = system(cmd);
        result = strsplit(result, '\n');
        result = length(result{end});
        if result == 1
            result = 0;
        end
        status = status + result;
        delete(tmp);
    else
        runtime = java.lang.Runtime.getRuntime();
        status = runtime.exec(cmd);
    end
end