function [feasible,Wsolution] = HW_TEST2(H,gammavar)

% This is the source code for HW2 of ELEC 5470. It is refered to the
% following source code on GitHub.
% https://github.com/emilbjornson/optimal-beamforming/blob/master/functionFeasibilityProblem_cvx.m
% The related paper can be found on arXiv: https://arxiv.org/pdf/1404.0408.pdf


Kr = size(H,1); %Number of users
N = size(H,2); %Number of transmit antennas (in total)
D = repmat(eye(N),[1 1 Kr]);

%Solve the power minimization under QoS requirements problem using CVX
cvx_begin
cvx_quiet(true); % This suppresses screen output from the solver

variable W(N,Kr) complex;  %Variable for N x Kr beamforming matrix
variable POWER %Scaling parameter for power constraints

minimize POWER %Minimize the power indirectly by scaling power constraints

subject to

%SINR constraints (Kr constraints)
for k = 1:Kr
    
    %Channels of the signal intended for user i when it reaches user k
    hkD = zeros(Kr,N);
    for i = 1:Kr
        hkD(i,:) = H(k,:)*D(:,:,i);
    end
    
    imag(hkD(k,:)*W(:,k)) == 0; %Useful link is assumed to be real-valued
    
    %SOCP formulation for the SINR constraint of user k
    real(hkD(k,:)*W(:,k)) >= sqrt(gammavar)*norm([1 hkD(k,:)*W(:,[1:k-1 k+1:Kr])  ]);
end

%Power constraints (L constraints) scaled by the variable betavar
norm(W,'fro') <= POWER;
POWER >= 0; %Power constraints must be positive

cvx_end


%Analyze result and prepare the output variables.
if isempty(strfind(cvx_status,'Solved')) %Both power minimization problem and feasibility problem are infeasible.
    feasible = false;
    Wsolution = [];
else %Both power minimization problem and feasibility problem are feasible.
    feasible = true;
    Wsolution = W;
    POWER
end
