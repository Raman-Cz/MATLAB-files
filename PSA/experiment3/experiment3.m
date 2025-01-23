%Raman Singh 2022UEE4518

disp("Transformer");
kva_txr = input("Enter the Nominal Value of Base Power in kVA: ");
freq_txr = input("Enter the Nominal Value of Base Frequency in Hz: ");

% Winding 1 Star Connected
volt1_txr = input("Enter the WINDING 1 RMS Line-to-Line nominal voltage in kV: ");
resis1_txr = input("Enter the WINDING 1 resistance in pu: ");
reactance1_txr = input("Enter the WINDING 1 leakage reactance in pu: ");


% Winding 2 Delta Connected
volt2_txr = input("Enter the WINDING 2 RMS Line-to-Line nominal voltage in kV: ");
resis2_txr = input("Enter the WINDING 2 resistance in pu: ");
reactance2_txr = input("Enter the WINDING 2 leakage reactance in pu: ");


Rloss = input("Enter the Resistive component for Magnetizing losses at nominal voltage in % of nominal current: ");
Xloss = input("Enter the Inductive component for Magnetizing losses at nominal voltage in % of nominal current: ");


% The base values for each single-phase transformer are first calculated:

% Winding 1
basepwr1_txr = (kva_txr * 1000)/3;  % in VA/phase
basevolt1_txr = (volt1_txr * 1000/sqrt(3)); % in V RMS
basecurr1_txr = basepwr1_txr/basevolt1_txr; % in A RMS
baseimp1_txr = basevolt1_txr/basecurr1_txr; % in Ohms
baseiresis1_txr = basevolt1_txr/basecurr1_txr; % in Ohms
baseinduc1_txr = baseimp1_txr/(2*pi*freq_txr); % in Henrys

% Winding 2
basepwr2_txr = (kva_txr * 1000)/3;  % in VA/phase
basevolt2_txr = (volt2_txr * 1000/sqrt(3)); % in V RMS
basecurr2_txr = basepwr2_txr/basevolt2_txr; % in A RMS
baseimp2_txr = basevolt2_txr/basecurr2_txr; % in Ohms
baseiresis2_txr = basevolt2_txr/basecurr2_txr; % in Ohms
baseinduc2_txr = baseimp2_txr/(2*pi*freq_txr); % in Henrys

% Actual Values of winding Resistances and Reactances
R1 = resis1_txr*baseiresis1_txr;
L1 = reactance1_txr*baseinduc1_txr;
R2 = resis2_txr*baseiresis2_txr;
L2 = reactance2_txr*baseinduc2_txr;

% Magnetizing Reactances and Resistances for winding 1

Rm = Rloss*baseimp1_txr;
Lm = Xloss*baseinduc1_txr;

% Displaying result
disp("------------------Result---------------------");
fprintf('Winding 1 Resistance: %.4f Ohms\n', R1);
fprintf('Winding 1 Inductance in Henrys is: %.4f Henrys\n', L1);
fprintf('Winding 2 Resistance: %.4f Ohms\n', R2);
fprintf('Winding 2 Inductance in Henrys is: %.4f Henrys\n', L2);
fprintf('Magnetizing Resistance: %.4f Ohms\n', Rm);
fprintf('Magnetizing Inductance: %.4f Henrys\n', Lm);


