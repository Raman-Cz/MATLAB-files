
% Example data (should be outside the function)
z = [0 1 0 1.0;
     0 2 0 0.8;
     1 2 0 0.4;
     1 3 0 0.2;
     2 3 0 0.2;
     3 4 0 0.08;
    ];
% Compute the bus admittance matrix
Y = ybus1(z);

% Define bus current vector (should match the number of buses)
Ibus = [-1i*1.1; -1i*1.25; 0; 0;]; % Ensure it has `nbus` elements

% Compute the bus impedance matrix
Zbus = inv(Y);

% Compute bus voltage
Vbus = Zbus * Ibus;

% Display results
disp('Value of Y:');
disp(Y);
disp('Value of Zbus:');
disp(Zbus);
disp('Value of Vbus:');
disp(Vbus);
