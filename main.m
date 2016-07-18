function output = main(subject_id, tgtfile, fullscreen)

    addpath(genpath('Psychoobox'));
    addpath('tgtfiles');

    rand('seed', block);
    tgt = csvread(tgtfile);
    block = str2num(regexprep(tgtfile(6:8), '\D', ''));
    output = zeros(size(tgt, 1), 6 + size(tgt, 2));
    output(:, 7:end) = tgt;
    output(:, 1) = subject_id;
    output(:, 2) = block;

    % Set up keyboard
    potential_keys = {'a', 's', 'd', 'f', 'h', 'j', 'k', 'l'};
    mykeys = BlamKeyboardResponse(1:size(tgt, 2), ...
                                  'possible_keys', potential_keys);

    if fullscreen
        rect_size = [];
    else
        rect_size = [30 30 400 400];
    end

    win = PsychWindow(0, true, 'color', [0 0 0], 'rect', rect_size);
    points = 0;

    for nn = 1:size(tgt, 1)

        mykeys.StartKeyResponse;

        while new_press(1) == -1
            new_press = mykeys.CheckKeyResponse;
            WaitSecs(0.1);
        end

        mykeys.StopKeyResponse;
        KbQueueFlush;

        reward = binornd(1, tgt(nn, ind_choice));
        output(nn, 4) = reward;
        if reward

        else

        end

    mykeys.DeleteKeyResponse;
    % write header and data to file
    header = {'id', 'block', 'response', 'time_response', 'reward', 'points'};
    for nn = 1:size(tgt, 2)
        header = [header, {['key_', potential_keys{nn}]}];
    end

    header = sprintf('%s,' ,header{:});
    header = header(1:end-1);
    filename = ['data/id', num2str(subject_id), '_block', num2str(block), '_nchoice', num2str(size(tgt, 2)), '.csv'];
    dlmwrite(filename, header);
    dlmwrite(filename, output, '-append', 'delimiter', ',', 'precision', '%.3f');

end
