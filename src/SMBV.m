classdef SMBV < handle
    properties % (Access = protected, Hidden = true)
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
            fprintf(obj.comm, '*ESE 1\n');         
        end
        
        function delete(obj)
            obj.rf = false;
            fclose(obj.comm);
        end
        
        function waitComplete(obj)
            status = 0;
            while status ~= 1
                fprintf(obj.comm, '*OPC;*ESR?');
                status = str2double(fgetl(obj.comm));
            end
        end
        
        function sendCommand(obj, varargin)
            fprintf(obj.comm, varargin{:});
        end
        
        function waitCommand(obj, varargin)
            obj.sendCommand(varargin{:});
            obj.waitComplete();
        end
        
        function value = query(obj, varargin)
            obj.sendCommand(varargin{:});
            value = str2double(fgetl(obj.comm));
        end
        
        function value = queryDouble(obj, varargin)
            value = str2double(obj.query(varargin{:}));
        end
    end
    
    methods
        function set.freq(obj, value)
            obj.waitCommand(':FREQ %f\n', value);
        end
        function value = get.freq(obj)
            value = obj.queryDouble(':FREQ?');
        end
        
        function set.pow(obj, p)
            obj.waitCommand(':POW %f\n', p);
        end
        function value = get.pow(obj)
            value = obj.queryDouble(':POW?');
        end
    
        function set.rf(obj, value)
            if value
                value = 'ON';
            else
                value = 'OFF';
            end
            obj.waitCommand(':OUTP %s\n', value);
        end
        function value = get.rf(obj)
            value = obj.queryDouble(':OUTP?');
        end
    end 
end