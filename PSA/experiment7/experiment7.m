% Given data
V = 11.0;   % Terminal voltage (kV)
S = 62.5*acos(0.8);   % Power (MVA)
Ia = conj(S) / (3 * V ) ;

Xd = 1.35;  % Direct axis reactance (Ohms)
Xq = 0.9;  % Quadrature axis reactance (Ohms)
Xs = Xd;   % Approximate synchronous reactance (pu)
E = V + Ia *1i*Xs;   % Internal generated voltage (kV)

% Load angle range (0 to 180 degrees)
delta = linspace(0, pi, 100);  % in radians

% Power-angle equation for salient pole synchronous generator
P_synchronous = (V * E ./ Xs) .* sin(delta) + (V^2 * (Xd - Xq) ./ (2 * Xd * Xq)) .* sin(2 * delta);

% Plotting
figure;
plot(rad2deg(delta), P_synchronous, 'b', 'LineWidth', 2);
xlabel('Load Angle \delta (degrees)');
ylabel('Power P (MW)');
title('Raman Singh 2022UEE4518');
grid on;
hold on;

% Highlighting maximum power points
[maxP, idx] = max(P_synchronous);
plot(rad2deg(delta(idx)), maxP, 'ro', 'MarkerFaceColor', 'r');

legend('Power-Angle Curve', 'Max Power Point');
hold off;