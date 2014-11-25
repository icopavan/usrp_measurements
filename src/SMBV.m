classdef SMBV < handle
    properties (Access = protected, Hidden = true)
        comm;
    end
    
    properties (Dependent)
        freq;
        pow;
        rf;
    end
    
    methods
        function obj = SMBV(address, preset, limit)
            obj.comm = tcpip(address, 5025);
            fopen(obj.comm);

            if (nargin == 1) || preset
                fprintf(obj.comm, '*RST\n');
            end
            if (nargin == 3)
                fprintf(obj.comm, ':POW:LIM %f\n', limit);
            end
        end
        
        function delete(obj)
            obj.rf = false;
            fclose(obj.comm);
        end
    end
    
    methods
        function value = get.freq(obj)
            fprintf(obj.comm, ':FREQ?');
            value = str2double(fgetl(obj.comm));
        end
        function set.freq(obj, value)
            fprintf(obj.comm, ':FREQ %f\n', value);
        end
        
        function set.pow(obj, p)
            fprintf(obj.comm, ':POW %f\n', p);
        end
        function value = get.pow(obj)
            fprintf(obj.comm, ':POW?');
            value = str2double(fgetl(obj.comm));
        end
    
        function set.rf(obj, value)
            if value
                value = 'ON';
            else
                value = 'OFF';
            end
            fprintf(obj.comm ,':OUTP %s\n', value);
        end
        function value = get.rf(obj)
            fprintf(obj.comm, ':OUTP?');
            value = str2double(fgetl(obj.comm));
        end
    end 
end