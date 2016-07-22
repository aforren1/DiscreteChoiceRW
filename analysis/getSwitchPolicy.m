function [p_stay1 p_stay2 N_stay1 N_stay2] = getSwitchPolicy(u,reward)
% figures out first and second-order switching policies
%
% inputs:   u - sequence of actions
%           reward - sequence of associated rewards
%
% outputs:  p_stay1 - first order policy p(stay|[win lose]);
%           p_stay2 - second order policy:
%                       p(stay|i,j,k), i = win on previous trial
%                                      j = stay after prev trial
%                                      k = win on current trial
%
%           N_stay1, N_Stay2 - Number of trials contributing to policy estimates
%           

%% second-order policy
win = reward(2:end-1);
win_prev = reward(1:end-2);
stay = (u(2:end-1)==u(3:end));
stay_prev = (u(1:end-2)==u(2:end-1));

B = [0 1];

for i = 1:2
    for j = 1:2
        for k = 1:2
            % find all trials that meet this criterion
            i_meet{i,j,k} = find(win_prev==B(i) & stay_prev==B(j) & win==B(k));
            p_stay2(i,j,k) = mean(stay(i_meet{i,j,k}));
            N_stay2(i,j,k) = length(i_meet{i,j,k});
        end
    end
    i_win{i} = find(win==B(i));
    p_stay1(i) = mean(stay(i_win{i}));
    N_stay1(i) = length(i_win{i});
end