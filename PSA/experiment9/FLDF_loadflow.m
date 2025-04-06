

V = [1.05; 1.0; 1.04];
d = [0; 0; 0]; % Angle of voltages (radians)
Ps = [-4; 2.0]; % P2 and P3
Qs = -2.5; % Q2

% Impedance Data: From, To, R, X
z = [1 2 0.02 0.04;
     2 3 0.0125 0.025;
     1 3 0.01 0.03];

% Calculate Bus Admittance Matrix
YB = ybus1(z) % Function to compute Y-Bus matrix
Y = abs(YB); 
t = angle(YB);

% Compute B' and B'' matrices for FDLF
n = 3; % Number of buses
non_slack = [2, 3]; % Non-slack buses
pq_bus = 2; % PQ bus (bus 2)

% Initialize B_prime matrix (for buses 2 and 3)
B_prime = [52, -32 ;
            -32, 62];


% B'' matrix (for PQ bus 2)
B_doubleprime = [52] ;

% Precompute inverses
inv_B_prime = inv(B_prime);
inv_B_doubleprime = 1 / B_doubleprime;
% Newton-Raphson Parameters
iter = 0;
pwracur = 0.00025; % Power accuracy threshold
DC = 10; % Initial large power residual

%% Fast Decoupled Load Flow Iteration
while max(abs(DC)) > pwracur
    iter = iter + 1;
    
    % Power Calculations
    P2 = V(2)*V(1)*Y(2,1)*cos(t(2,1)-d(2)+d(1)) + V(2)^2*Y(2,2)*cos(t(2,2)) + V(2)*V(3)*Y(2,3)*cos(t(2,3)-d(2)+d(3));
    P3 = V(3)*V(1)*Y(3,1)*cos(t(3,1)-d(3)+d(1)) + V(3)^2*Y(3,3)*cos(t(3,3)) + V(3)*V(2)*Y(3,2)*cos(t(3,2)-d(3)+d(2));
    P = [P2; P3];
    
    Q2 = -V(2)*V(1)*Y(2,1)*sin(t(2,1)-d(2)+d(1)) - V(2)^2*Y(2,2)*sin(t(2,2)) - V(2)*V(3)*Y(2,3)*sin(t(2,3)-d(2)+d(3));
    Q = Q2;
    
    % Power Residual Calculation
    DP = Ps - P;
    DQ = Qs - Q;
    DC = [DP; DQ];
    
    % Compute ΔP/V and ΔQ/V
    DeltaP_over_V = DP ./ V(non_slack);
    DeltaQ_over_V = DQ / V(pq_bus);
    
    % Solve for Δδ and ΔV
    Delta_delta = inv_B_prime * DeltaP_over_V;
    Delta_V = inv_B_doubleprime * DeltaQ_over_V;
    
    % Update angles and voltage
    d(2) = d(2) + Delta_delta(1);
    d(3) = d(3) + Delta_delta(2);
    V(2) = V(2) + Delta_V;
    
    % Convert to degrees for reporting
    delta_deg = rad2deg(d);
end

%% Compute Final Power Values
P1 = V(1)^2*Y(1,1)*cos(t(1,1)) + V(1)*V(2)*Y(1,2)*cos(t(1,2)-d(1)+d(2)) + ...
     V(1)*V(3)*Y(1,3)*cos(t(1,3)-d(1)+d(3));
 
Q1 = -V(1)^2*Y(1,1)*sin(t(1,1)) - V(1)*V(2)*Y(1,2)*sin(t(1,2)-d(1)+d(2)) - ...
     V(1)*V(3)*Y(1,3)*sin(t(1,3)-d(1)+d(3));
 
Q3 = -V(3)*V(1)*Y(3,1)*sin(t(3,1)-d(3)+d(1)) - V(3)*V(2)*Y(3,2)*sin(t(3,2)-d(3)+d(2)) - ...
     V(3)^2*Y(3,3)*sin(t(3,3));

% Display Results
disp('Experiment 9 result using Fast Decoupled Load Flow');
disp('Final Voltages and Angles (Degrees):');
disp([V, delta_deg]);
disp('Final Power Values:');
disp(['P1 = ', num2str(P1)]);
disp(['Q1 = ', num2str(Q1)]);
disp(['Q3 = ', num2str(Q3)]);
disp(['Number of iterations: ', num2str(iter)]);