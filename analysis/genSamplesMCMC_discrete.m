function [u reward] = genSamplesMCMC_discrete(params,varargin)
% generate MCMC samples in a discrete action task
%
% u = genSamplesMCMC_discrete(params,pRwd,Nsamp,accfun)
%
%  params = [q,beta];
%       q = proposal stick probability; proposal transition matrix = [q (1-q); (1-q) q];
%       beta = acceptance temperature
%  pRwd = [number of actions X number of trials] vector of reward probabilities
%  Nsamp = number of samples
%  accfun = acceptance function
%       'boltzmann' or 'metropolis'

if(length(varargin)>0)
    Nu = size(varargin{1},1); % number of actions available
    %pRwd = [repmat(.5*ones(Nu,1),1,40) varargin{1}];
    pRwd = varargin{1};
else % default
    Nu = 2;
    pRwd = [repmat([1 0]',1,40) repmat([.7 .3]',1,40) repmat([.3 .7]',1,40)];
end
Nt = size(pRwd,2); % number of timesteps

if(length(varargin)>1)
    Nsamp = varargin{2};
else % default
    Nsamp = 500;
end

if(length(varargin)>2)
    accfun = varargin{3};
    if(strcmp(accfun,'metropolis') || strcmp(accfun,'boltzmann'))
        
    else
        error('acceptance function type must be "metropolis" or "boltzmann"')
    end
else
    accfun = 'boltzmann';
end



u = zeros(Nsamp,Nt); % actions taken
u(:,1) = (rand(Nsamp,1)<.5)+1; % random initial action
%u(:,1) = ones(Nsamp,1);
uc = u(:,1); % current accepted action

Vu = zeros(Nsamp,Nt); % outcome value
Vu(:,1) = rand(Nsamp,1)<pRwd(u(:,1),1); % reward
%Vu(:,1) = ones(Nsamp,1);
Vc = Vu(:,1);


q = params(1); % proposal distribution stay probability
qq = (1-q)/(Nu-1); % prob of switching to each other target

P = qq*ones(Nu);
P(eye(Nu)>0)=q; % proposal transition matrix

beta = params(2); % selection temperature


for i=2:Nt
    [xx uu] = find(mnrnd(ones(Nsamp,1),P(uc,:))); % select action
    [yy jj] = sort(xx);
    u(:,i) = uu(jj);
    
    %for j = 1:Nsamp
    %    u(j,i) = find(mnrnd(1,P(uc(j),:)));
    %end
    Vu(:,i) = rand(Nsamp,1)<pRwd(u(:,i),i); % sample value of that action (i.e. reward)
    
    % determine acceptance probability
    switch accfun
        case 'boltzmann'
            a(:,i) = exp(beta*Vu(:,i))./(exp(beta*Vu(:,i))+exp(beta*Vc));
            
        case 'metropolis'
            a(:,i) = min(ones(Nsamp,1),exp(beta*(Vu(:,i)-Vc)));
    end
    accept(:,i) = rand(Nsamp,1)<a(:,i);
    
    uc(accept(:,i)) = u(accept(:,i),i);
    Vc(accept(:,i)) = Vu(accept(:,i),i);
end

%keyboard
u = u-1;
reward = Vu;












