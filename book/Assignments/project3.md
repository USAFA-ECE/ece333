# Demodulation

**NOT READY YET**

### 2.1 Synthesizing the A4 Piano Tone

Before we begin modulating message signals, we will first practice modulation using a simple harmonic signal: a synthesized **A4 piano tone**. A pure A4 note has a fundamental frequency of \(440\) Hz, but real instruments contain many **harmonics** that shape the sound’s timbre. A basic harmonic approximation can be written as

\[
m_{A4}(t) = \sum_{n=1}^{20} a_n \cos(2\pi n f_0 t), \qquad f_0 = 440\ \text{Hz},
\]

where the coefficients \(a_n\) control the tone quality (e.g., \(a_n = 1/n\) for a sawtooth‑like sound or \(a_n = 1/n^2\) for a smoother tone).

However, a realistic piano tone requires more than simply summing harmonics. Real piano strings exhibit two important characteristics:

1. **Inharmonicity:** Harmonics are slightly _stretched_ due to string stiffness.  
2. **Amplitude Envelope:** A piano note has a sharp attack followed by an exponential decay.

To capture these effects, we will synthesize a **10‑second A4 piano tone** by applying an exponential decay envelope to each harmonic. Higher harmonics decay faster than the fundamental, reflecting the physical damping behavior of piano strings.

The MATLAB code below implements this model by assigning each harmonic both a decreasing initial amplitude and a harmonic‑dependent decay constant.

```matlab
%% 1. Parameters
fs = 44100;              % High sampling rate (44.1 kHz)
T = 10;                  % Duration in seconds
t = 0:1/fs:T-1/fs;       % Time vector
f0 = 440;                % Fundamental frequency (A4)

%% 2. Realistic Piano Synthesis (Harmonics + Decay)
m_a4 = zeros(size(t));
num_harmonics = 20;

for n = 1:num_harmonics
    % Fundamental and harmonic frequencies
    fn = n * f0; 
    
    % Amplitude: higher harmonics start quieter
    a_n = 1/(n^1.2); 
    
    % Decay: higher harmonics fade out faster (realistic physics)
    tau_n = 3 / n;   % Decay constant
    envelope = exp(-t / tau_n);
    
    % Accumulate the harmonic
    m_a4 = m_a4 + a_n * envelope .* cos(2*pi*fn*t);
end

% Normalize to +/- 1 to prevent clipping
m_a4 = m_a4 / max(abs(m_a4));

% Listen to the result
soundsc(m_a4, fs); 
```
