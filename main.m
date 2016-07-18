function output = main(subject_id, tgtfile, fullscreen)

    addpath(genpath('Psychoobox'));
    addpath('tgtfiles');

    rand('seed', block);
    tgt = csvread(tgtfile);
    num_choices = size(tgt, 2);
    num_trials = size(tgt, 1);
    points = 0;

    block = str2num(regexprep(tgtfile(6:8), '\D', ''));
    output = zeros(num_trials, 6 + num_choices);
    output(:, 7:end) = tgt;
    output(:, 1) = subject_id;
    output(:, 2) = block;

    % Set up keyboard
    potential_keys = {{'a', 's', 'd', 'f', 'h', 'j', 'k', 'l'}};
    mykeys = BlamKeyboardResponse(1:num_choices, 'possible_keys', potential_keys);

    if fullscreen
        rect_size = [];
    else
        rect_size = [30 30 400 400];
    end
    Screen('Preference', 'Verbosity', 1);
    win = PsychWindow(0, true, 'color', [0 0 0], 'rect', rect_size);
    points_txt = PsychText('val', ['Points: +', num2str(points)],...
                           'color', [82 242 50], 'x', 'center', 'y', 'center');
    for nn = 1:num_trials

        mykeys.StartKeyResponse;

        while new_press(1) == -1
            [new_press, press_time] = mykeys.CheckKeyResponse;
            WaitSecs(0.1);
        end

        mykeys.StopKeyResponse;
        KbQueueFlush;
        output(nn, 3) = new_press;
        output(nn, 4) = press_time;

        reward = binornd(1, tgt(nn, ind_choice));
        output(nn, 5) = reward;
        if reward

        else

        end

        output(nn, 6) = points;
    end

    mykeys.DeleteKeyResponse;
    % write header and data to file
    header = {'id', 'block', 'response', 'time_response', 'reward', 'points'};
    for nn = 1:num_choices
        header = [header, {['key_', potential_keys{nn}]}];
    end

    header = sprintf('%s,' ,header{:});
    header = header(1:end-1);
    filename = ['data/id', num2str(subject_id), '_block', num2str(block), '_nchoice', num2str(num_choices), '.csv'];
    dlmwrite(filename, header);
    dlmwrite(filename, output, '-append', 'delimiter', ',', 'precision', '%.3f');

end
