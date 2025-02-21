%Gauss siedel method
clc;clear;close all;
% Given data (Admittance values)
y12 = 1/(0.02 + 1i*0.04);
y13 = 1/(0.01 + 1i*0.03);
y23 = 1/(0.0125 + 1i*0.025);
y33 = y13 + y23; 

% Slack Bus Voltage (Reference Bus)
V1 = 1.05 + 1j*0; 

% Initial Guess for Bus Voltages
V2 = 1 + 1j*0; 
Vm3 = 1.04;  % Voltage magnitude constraint for bus 3
V3 = 1.04 + 1j*0; 

% Given Power Values
S2 = -4.0 - 1j*2.5;  % Load at bus 2
P3 = 2;  % Active power at bus 3

% Iteration parameters
format long;
max_iter = 10; % Maximum iterations
tol = 1e-6; % Convergence tolerance
iter = 0;

disp('Iter  |  V2 (p.u.)  |  V3 (p.u.) ');

for I = 1:max_iter
    iter = iter + 1;
    
    % Store old values
    E2 = V2;
    E3 = V3;
    
    % Update V2
    V2 = (conj(S2)/conj(V2) + y12*V1 + y23*V3) / (y12 + y23);
    DV2 = abs(V2 - E2);  % Change in voltage magnitude

    % Compute reactive power at bus 3
    Q3 = -imag(conj(V3) * (y33*V3 - y13*V1 - y23*V2));
    S3 = P3 + 1j*Q3;
    
    % Update V3
    Vc3 = (conj(S3)/conj(V3) + y13*V1 + y23*V2) / (y13 + y23);
    Vi3 = imag(Vc3);
    Vr3 = sqrt(Vm3^2 - Vi3^2);
    V3 = Vr3 + 1j*Vi3;
    DV3 = abs(V3 - E3);
    
    % Display iteration results
    fprintf('%3d  |  %8.6f + j%8.6f  |  %8.6f + j%8.6f \n', iter, real(V2), imag(V2), real(V3), imag(V3));

    % Convergence check
    if DV2 < tol && DV3 < tol
        disp('Converged!');
        break;
    end
end

% Display final voltages
disp('Final Voltages:');
disp(['V2 = ', num2str(V2)]);
disp(['V3 = ', num2str(V3)]);

% Compute Line Currents
I12 = y12 * (V1 - V2);   I21 = -I12;
I13 = y13 * (V1 - V3);   I31 = -I13;
I23 = y23 * (V2 - V3);   I32 = -I23;

% Compute Power Flow
S12 = V1 * conj(I12);   S21 = V2 * conj(I21);
S13 = V1 * conj(I13);   S31 = V3 * conj(I31);
S23 = V2 * conj(I23);   S32 = V3 * conj(I32);

% Display Power Flow
disp('Power Flow:');
disp(['S12 = ', num2str(S12), ' p.u.']);
disp(['S21 = ', num2str(S21), ' p.u.']);
disp(['S13 = ', num2str(S13), ' p.u.']);
disp(['S31 = ', num2str(S31), ' p.u.']);
disp(['S23 = ', num2str(S23), ' p.u.']);
disp(['S32 = ', num2str(S32), ' p.u.']);