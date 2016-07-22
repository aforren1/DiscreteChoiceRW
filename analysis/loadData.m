data = dlmread('data/id1_block2_nchoice4.csv',',',1,0); %load data

action = data(:,3); % which actions the subject took
reward = data(:,5); % whether or not a reward was earned

[p_1 p_2 N_1 N_2] = getSwitchPolicy(data(:,3), data(:,5)); % extract the policies

figure(1); clf; hold on
subplot(2,2,1); hold on
title('p(stay) | lose')
bar3(p_2(:,:,1))
xlabel('1=lose, 2=win')
ylabel('1=switch, 2=stay')
axis([.5 2.5 .5 2.5 0 1])

subplot(2,2,2); hold on
title('p(stay) | win')
bar3(p_2(:,:,2))

xlabel('1=lose, 2=win')
ylabel('1=switch, 2=stay')
axis([.5 2.5 .5 2.5 0 1])

subplot(2,2,3); hold on
title('Number of trials of each type')
bar3(N_2(:,:,1))
xlabel('1=lose, 2=win')
ylabel('1=switch, 2=stay')

subplot(2,2,4); hold on
title('Number of trials of each type')
bar3(N_2(:,:,2))
xlabel('1=lose, 2=win')
ylabel('1=switch, 2=stay')