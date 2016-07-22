value_vector = [.8 .3];
num_trials = 10;
swap_points = [2, 6];
num_blocks = 3;

for ii = 1:num_blocks
    rand('seed', 100 * ii * 3);
    output = ValueSwaps(num_trials, value_vector, swap_points);
    csvwrite(['tgtfiles/', 'block', num2str(ii), '_nchoice',...
             num2str(length(value_vector)), '_fixed.csv'], output);
end
