Power = [30,40,50];%Active Power in MW
color=['r','b','g'];

for i = 1:3
    P = Power(i);
    c = color(i);
    V = 11/sqrt(3)+ 1i*0;  %Terminal Phase Voltage in kv
    Xs = 1.21; % reactance;
    Zs = 0+ 1i*Xs; %Synchronous Impedance
    angle = acos(0.5);%angle = cosine inverse(0.5) 
    theta=angle:-0.01:-angle;%Angle 0.4 leading to 0.4 lagging pf 
    P = P*ones(1,length(theta));%generates array of same size 
    I_arm = P./(3*abs(V)*cos(theta)); % current magnitude kA 
    Ia = I_arm.*(cos(theta) + 1i*sin(theta)); 
    E = V + Zs.*Ia; 
    Em = abs(E); 
    If = Em*1000/200; % current phasor excitation voltage phasor
    hold on;
    plot(If, I_arm,c);
    grid on;
end
title("2022UEE4518");
ylabel("Armature Current Ia(kA)");
xlabel("Field Current If(A)");
