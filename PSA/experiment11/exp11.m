% Simulink Model for Hydroelectric Power System with Synchronous Generator

% Open Simulink
open_system(new_system('HydroPowerSystem'));

% Add Hydraulic Turbine and Governor Block
add_block('powerlib/Power Electronics/Hydraulic Turbine and Governor', 'HydroPowerSystem/Hydraulic Turbine and Governor', 'Position', [50, 50, 150, 150]);

% Add Excitation System
add_block('powerlib/Power Electronics/Excitation System', 'HydroPowerSystem/Excitation System', 'Position', [50, 200, 150, 300]);

% Add Synchronous Machine
add_block('powerlib/Machines/Synchronous Machine pu Fundamental', 'HydroPowerSystem/Synchronous Machine', 'Position', [200, 100, 300, 200]);

% Add Transformer
add_block('powerlib/Elements/Three-Phase Transformer (Two Windings)', 'HydroPowerSystem/Transformer', 'Position', [350, 100, 450, 200]);

% Add Three-Phase PI Section Line
add_block('powerlib/Elements/Three-Phase PI Section Line', 'HydroPowerSystem/Transmission Line', 'Position', [500, 100, 600, 200]);

% Add Three-Phase Bus
add_block('powerlib/Elements/Three-Phase Bus', 'HydroPowerSystem/Three-Phase Bus', 'Position', [650, 100, 750, 200]);

% Add Three-Phase Fault
add_block('powerlib/Elements/Three-Phase Fault', 'HydroPowerSystem/Three-Phase Fault', 'Position', [800, 100, 900, 200]);

% Add Results Display
add_block('simulink/Sinks/Display', 'HydroPowerSystem/Results', 'Position', [950, 100, 1050, 200]);

% Save the Model
save_system('HydroPowerSystem');
close_system('HydroPowerSystem', 0);
