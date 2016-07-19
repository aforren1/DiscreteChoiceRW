
function output = DiscreteRandomWalk(num_choices, scale, num_trials, lower, upper)
% output = DISCRETERANDOMWALK(num_choices, scale, num_trials, lower, upper)
%     num_choices - The number of options (button pushes, ...)
%     scale - The value to scale the normal draw by (0.05 seems ok)
%     num_trials - The total number of trials
%     lower - lower bound (if the walk hits this bound, it reflects)
%     upper - upper bound (as above)
%
% Output is a num_trials by num_choices matrix.
%
% NB: Set seed before! e.g. `rng(1)` for deterministic behavior

% The probability of reward follows the random walk

% Pick initial state
output = unifrnd(lower, upper, 1, num_choices);

% doing loop version -- don't quite know how to make the vectorized way
% work
    for ii = 2:num_trials
        for jj = 1:num_choices
            % if the proposal is "out of bounds", reflect the proposal
            proposal = (randn(1, 1) * scale);
            if (proposal + output((ii - 1), jj)) > upper || ...
               (proposal + output((ii - 1), jj)) < lower

                proposal = -proposal; % flip sign of proposal to reflect
            end
            % add to the output matrix
            output(ii, jj) = output((ii - 1), jj) + proposal;
        end
    end

end
