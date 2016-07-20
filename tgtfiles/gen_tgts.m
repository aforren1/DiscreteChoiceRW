
num_choices = 8;
scale = 0.075;
num_trials = 200;
lower = 0.25;
upper = 0.75;
num_blocks = 4 ;

for ii = 1:num_blocks
    rand('seed', 100*ii*num_choices);
    output = DiscreteRandomWalk(num_choices, scale, num_trials, lower, upper);
    csvwrite(['tgtfiles/', 'block', num2str(ii), '_nchoice', num2str(num_choices), '.csv'], output);
end
