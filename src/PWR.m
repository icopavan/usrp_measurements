classdef PWR < handle
    properties % (Access = protected, Hidden = true)
        comm;
    end
    
    properties (Dependent)
        freq;
        pow;
    end
    
    methods
        function obj = PWR(address, preset)
            obj.comm = tcpip(address, 5025);
            set(obj.comm, 'Timeout', 30);
            fopen(obj.comm);
            fprintf(obj.comm, '*CLS\n');
            if (nargin == 1) || preset
                fprintf(obj.comm, '*RST\n');
                fprintf(obj.comm, '*OPC?');
                fgetl(obj.comm);
            end
        end
        
        function delete(obj)
            fclose(obj.comm);
        end
        
        function waitComplete(obj)
            obj.query('*OPC?');
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
            value = fgetl(obj.comm);
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
        
        function value = get.pow(obj)
            value = obj.queryDouble('MEAS?\n');
        end
    end 
end