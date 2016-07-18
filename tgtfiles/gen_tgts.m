
num_choices = 2;
scale = 0.2;
num_trials = 100;
lower = 0.1;
upper = 0.9;

for ii = 1:10
    rand('seed', ii);
    output = DiscreteRandomWalk(num_choices, scale, num_trials, lower, upper);
    csvwrite(['block', num2str(ii), '_nchoice', num2str(num_choices), '.csv'], output);
end
