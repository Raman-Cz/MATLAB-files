## Aim
 Simulation of 6-pulse converter using thyristor.
## Theory
A 6-pulse converter is a type of controlled rectifier that uses six thyristors arranged in a bridge configuration to convert three-phase AC power into DC power. It is widely used in industrial applications like motor drives, HVDC systems, and power electronics. Below is an overview of the theoretical aspects of the experiment:

# Working Principle
Three-Phase Supply:

A 6-pulse converter is fed by a three-phase AC supply. Each phase is 120° apart, creating a balanced sinusoidal waveform.
Bridge Configuration:

The six thyristors are arranged in a full-bridge configuration. Each pair of thyristors conducts for 120° during one AC cycle, resulting in a DC output with six pulses per cycle.
Controlled Rectification:

The firing angle (𝛼) of the thyristors determines the output voltage. By controlling 𝛼, the DC output can be regulated. A smaller 𝛼
provides higher DC output voltage, while a larger 𝛼 reduces it.

Commutation:

The thyristors turn off naturally when the AC supply reverses polarity (natural commutation), ensuring a continuous conduction path.
# Waveforms
Input Waveform:

The input is a three-phase AC waveform with a frequency 𝑓

Output Waveform:

The output is a pulsating DC waveform with six pulses per AC cycle. The ripple frequency of the output DC is 6𝑓
, where 𝑓 is the input frequency.

