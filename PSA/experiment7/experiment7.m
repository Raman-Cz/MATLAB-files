% Given data
V3p = 11.0;  % Terminal voltage (kV)
V = V3p * 1e3 / sqrt(3);  % Line-to-neutral voltage (V)
S = 62.5* 1e6 * (0.8 + 1i * 0.6);  % Apparent power (VA)
Ia = conj(S) / (3 * V);  % Current (A)

Xd = 1.35;  % Direct axis reactance (Ohms)
Xq = 0.9;  % Quadrature axis reactance (Ohms)
Xs = Xd;   % Approximate synchronous reactance (Ohms)

% Internal generated voltage (E)
E = V + Ia * (1i * Xs);  % Internal voltage (V)

% Load angle range (0 to 180 degrees)
delta = linspace(0, pi, 100);  % 100 points between 0 and 180 degrees (radians)

% Power-angle equation for salient pole synchronous generator
P_synchronous = ((V * abs(E)) ./ Xs) .* sin(delta) + (V^2 * (Xd - Xq) ./ (2 * Xd * Xq)) .* sin(2 * delta);

% Plotting
figure;
plot(rad2deg(delta), P_synchronous, 'b', 'LineWidth', 2); % Convert power to MW
xlabel('Load Angle \delta (degrees)');
ylabel('Power P (MW)');
title('Raman Singh 2022UEE4518');
grid on;
hold on;

% Highlighting maximum power points
[maxP, idx] = max(P_synchronous);
plot(rad2deg(delta(idx)), maxP, 'ro', 'MarkerFaceColor', 'r'); % Convert to MW

legend('Power-Angle Curve', 'Max Power Point');
hold off;
