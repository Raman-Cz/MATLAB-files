%% EEEEC18 PSA Practical #1
%Power-Flow of a two-bus system
V1 = input('Source # 1 Voltage Mag. = ');
delta1 = input('Source # 1 Phase Angle = ');
V2 = input('Source # 2 Voltage Mag. = ');
delta2 = input('Source # 2 Phase Angle = ');
R = input('Line Resistance = ');
X = input('Line Reactance = ');
Z= R + 1i*X; % line impedance
delta1 = (-30+delta1:5:30+delta1)'; % change a1 by +/- 30 deg.,col. array
a1r = delta1*pi/180; % convert degree to radian
k = length(delta1);
delta2 = ones(k,1)*delta2; % create col. array of same length for a2
a2r = delta2*pi/180; % convert degree toradian
V11 = V1.*cos(a1r) + 1i*V1.*sin(a1r);
V22 = V2.*cos(a2r) + 1i*V2.*sin(a2r);
I12 = (V11 - V22)./Z;
I21=-I12;
S1 = V11.*conj(I12);
P1 = real(S1);
Q1 = imag(S1);

S2 = V22.*conj(I21);
P2 = real(S2);
Q2 = imag(S2);
SLoss = S1+S2;
PLoss = real(SLoss);
QLoss = imag(SLoss);
Result1=[delta1, P1, P2, PLoss];
disp(' Delta 1 P-1 P-2 P-L ')
disp(Result1)
plot(delta1, P1, DisplayName="P1");
hold on ;
plot(delta1, P2, DisplayName="P2");
plot(delta1, PLoss, DisplayName="PL"); 
grid on;
legend;
xlabel('Source #1 Voltage Phase Angle');
ylabel('P, Watts');
