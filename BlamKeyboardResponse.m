classdef BlamKeyboardResponse < handle
    properties
        timing_tolerance;
        valid_indices;
        valid_keys;
        force_min;
        force_max;
    end

    methods
        function obj = BlamKeyboardResponse(valid_indices, varargin)
            KbName('UnifyKeyNames');

            if ~exist('valid_indices', 'var')
                error('Need valid indices!');
            end

            opts = struct('possible_keys', {{'a','w','e','f','v','b','h','u','i','l'}},...
                          'timing_tolerance', 0.075,...
                          'force_min', 1,...
                          'force_max', 100);
            opts = CheckInputs(opts, varargin{:});
            obj.timing_tolerance = opts.timing_tolerance;
            obj.force_min = opts.force_min;
            obj.force_max = opts.force_max;
            obj.valid_keys = opts.possible_keys{1}(valid_indices);
            obj.valid_indices = valid_indices;

            keys = zeros(1, 256);
            keys(KbName(obj.valid_keys)) = 1;
            KbQueueCreate(-1, keys);
        end

        function StartKeyResponse(obj)
            KbQueueStart;
        end

        function StopKeyResponse(obj)
            KbQueueStop;
        end

        function DeleteKeyResponse(obj)
            KbQueueRelease;
            delete(obj);
        end

        function new_press = CheckKeyResponse(obj)

            [~, pressed, released] = KbQueueCheck;
            if any(pressed > 0)
                press_key = KbName(find(pressed > 0));
                if iscell(press_key)
                    %press_key = cell2mat(press_key);
                    press_key = press_key{1}; % incorrect, but how to fix?
                end
                press_index = obj.valid_indices(find(new_screen_press));
                time_press = min(pressed(pressed > 0));
                new_press = [press_index, time_press];
            else % no new presses
                new_press = [-1, -1];
            end
            KbQueueFlush;
        end % end CheckKeyResponse

    end % end methods
end % end classdef
