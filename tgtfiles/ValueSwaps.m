function output = ValueSwaps(num_trials, value_vector, swap_points)
    % at swap_points, shuffle the value vector
    for ii = 1:num_trials
        if any(ii == swap_points)
            original_val = value_vector;
            % enforce new permutation
            while all(original_val == value_vector)
                value_vector = value_vector(randperm(length(value_vector)));
            end
        end
        output(ii,:) = value_vector;
    end
end
