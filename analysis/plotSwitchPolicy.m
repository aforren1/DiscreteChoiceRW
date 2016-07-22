function plotSwitchPolicy(p,N,varargin)
% plots a visualization of the switch policy for a sequential discrete
% choice task
%
% inputs: p - second-order policy
%         N - number of trials in each case
%         figure number (optional)
%
% NB - need to use 'Rotate 3D' tool to view these properly
if(length(varargin{1})>0)
    ifig = varargin{1};
else
    ifig = 1;
end
figure(ifig); clf; hold on
subplot(2,2,1); hold on
title('p(stay) | lose')
bar3(p(:,:,1))
xlabel('1=lose, 2=win')
ylabel('1=switch, 2=stay')
axis([.5 2.5 .5 2.5 0 1])

subplot(2,2,2); hold on
title('p(stay) | win')
bar3(p(:,:,2))

xlabel('1=lose, 2=win')
ylabel('1=switch, 2=stay')
axis([.5 2.5 .5 2.5 0 1])

subplot(2,2,3); hold on
title('Number of trials of each type')
bar3(N(:,:,1))
xlabel('1=lose, 2=win')
ylabel('1=switch, 2=stay')

subplot(2,2,4); hold on
title('Number of trials of each type')
bar3(N(:,:,2))
xlabel('1=lose, 2=win')
ylabel('1=switch, 2=stay')
