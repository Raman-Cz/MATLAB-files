% Example 6.10 Newton-Raphson method
V = [1.05; 1.0; 1.04];
d = [0; 0; 0]; %Angle of voltages
Ps = [-4; 2.0];
Qs = -2.5;
% From To R X
z = [ 1 2 0.02 0.04 ;
      2 3 0.012 0.025;
      1 3 0.01 0.03;
];
[YB] = ybus1(z) % bus admittance matrix
Y = abs(YB); t = angle(YB);
iter=0;
pwracur = 0.00025; % Power accuracy
DC = 10; % Set the maximum power residual to a high value
%% Newton Raphson
while max(abs(DC)) > pwracur
iter = iter +1;
P=[V(2)*V(1)*Y(2,1)*cos(t(2,1)-d(2)+d(1))+V(2)^2*Y(2,2)*cos(t(2,2))+ ...
V(2)*V(3)*Y(2,3)*cos(t(2,3)-d(2)+d(3));
V(3)*V(1)*Y(3,1)*cos(t(3,1)-d(3)+d(1))+V(3)^2*Y(3,3)*cos(t(3,3))+ ...
V(3)*V(2)*Y(3,2)*cos(t(3,2)-d(3)+d(2))];
Q= -V(2)*V(1)*Y(2,1)*sin(t(2,1)-d(2)+d(1))-V(2)^2*Y(2,2)*sin(t(2,2))- ...
V(2)*V(3)*Y(2,3)*sin(t(2,3)-d(2)+d(3));
% Jacobian
J(1,1)=V(2)*V(1)*Y(2,1)*sin(t(2,1)-d(2)+d(1))+...
V(2)*V(3)*Y(2,3)*sin(t(2,3)-d(2)+d(3));
J(1,2)=-V(2)*V(3)*Y(2,3)*sin(t(2,3)-d(2)+d(3));
J(1,3)=V(1)*Y(2,1)*cos(t(2,1)-d(2)+d(1))+2*V(2)*Y(2,2)*cos(t(2,2))+...
V(3)*Y(2,3)*cos(t(2,3)-d(2)+d(3));
J(2,1)=-V(3)*V(2)*Y(3,2)*sin(t(3,2)-d(3)+d(2));
J(2,2)=V(3)*V(1)*Y(3,1)*sin(t(3,1)-d(3)+d(1))+...
V(3)*V(2)*Y(3,2)*sin(t(3,2)-d(3)+d(2));
J(2,3)=V(3)*Y(2,3)*cos(t(3,2)-d(3)+d(2));
J(3,1)=V(2)*V(1)*Y(2,1)*cos(t(2,1)-d(2)+d(1))+... 
V(2)*V(3)*Y(2,3)*cos(t(2,3)-d(2)+d(3));
J(3,2)=-V(2)*V(3)*Y(2,3)*cos(t(2,3)-d(2)+d(3));
J(3,3)=-V(1)*Y(2,1)*sin(t(2,1)-d(2)+d(1))-2*V(2)*Y(2,2)*sin(t(2,2))-...
V(3)*Y(2,3)*sin(t(2,3)-d(2)+d(3));
% Power Residual
DP = Ps - P;
DQ = Qs - Q;
DC = [DP; DQ]
J
DX = inv(J)*DC;
%% Unknown quantities
d(2) =d(2)+DX(1);
d(3)=d(3) +DX(2);
V(2)= V(2)+DX(3);
delta =180/pi*d;
end
%% Unknown quantities
P1= V(1)^2*Y(1,1)*cos(t(1,1))+V(1)*V(2)*Y(1,2)*cos(t(1,2)-d(1)+d(2))+...
V(1)*V(3)*Y(1,3)*cos(t(1,3)-d(1)+d(3))
Q1=-V(1)^2*Y(1,1)*sin(t(1,1))-V(1)*V(2)*Y(1,2)*sin(t(1,2)-d(1)+d(2))-...
V(1)*V(3)*Y(1,3)*sin(t(1,3)-d(1)+d(3))
Q3=-V(3)*V(1)*Y(3,1)*sin(t(3,1)-d(3)+d(1))-V(3)*V(2)*Y(3,2)*...
sin(t(3,2)-d(3)+d(2))-V(3)^2*Y(3,3)*sin(t(3,3))

