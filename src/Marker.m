classdef Marker < handle
    properties % (Access = protected, Hidden = true)
        comm;
        id;
    end
    
    properties (Dependent)
        enable;
        freq;
        y;
    end
    
    methods
        function obj = Marker(comm)
            if nargin ~= 0
                obj(4) = Marker;
                for i = 1:4
                    obj(i).id = i;
                    obj(i).comm = comm;
                end
            end
        end   
    end
    
    methods
        function set.freq(obj, value)
            obj.comm.waitCommand(sprintf('CALC:MARK%d:X %f\n', obj.id, value));
        end
        function value = get.freq(obj)
            value = obj.comm.queryDouble(sprintf('CALC:MARK%d:X?', obj.id));
        end
        
        function value = get.y(obj)
            value = obj.comm.queryDouble(sprintf('CALC:MARK%d:Y?', obj.id));
        end

        function set.enable(obj, value)
            if value
                value = 'ON';
            else
                value = 'OFF';
            end
             obj.comm.waitCommand(sprintf('CALC:MARK%d %s\n', obj.id, value));
        end
        function value = get.enable(obj)
            value = obj.comm.queryDouble(sprintf('CALC:MARK%d?', obj.id));
        end
    end 
end