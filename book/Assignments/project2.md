# Demodulation

**NOT READY YET**

## 1. Intoduction

In modern communication, baseband signals (like voice or music) are rarely transmitted directly. Instead, they are shifted to higher frequencies to allow for efficient transmission and to enable multiple signals to share the same medium without interference—a process called **Frequency Division Multiplexing (FDM)**.

However, a speaker or a digital audio player cannot use the high-frequency modulated signal directly. We must perform **demodulation** to shift the spectrum of the signal back to the baseband.

In this project, we explore the process of extracting original information from a modulated carrier—a fundamental operation in communication systems known as **demodulation**. The goal is to develop an intuition for frequency shifting and filtering by successfully recovering three distinct audio files from a single composite signal.

## 1. Signal Specifications

For this project, we are working with high-fidelity signals:

* **Sampling Frequency ($f_s$):** $44,100$ Hz
* **Message Duration:** $10$ seconds
* **Message Bandwidth:** $5$ kHz (All original audio is band-limited to $5$ kHz)

## 2. Part I: Walkthrough — Filter Design and Modulation

The following steps demonstrate how to synthesize a A4 piano tone, design a Butterworth low-pass filter (LPF), and modulate the signal.

This section provides a detailed walkthrough of designing and testing a continuous-time filter. In this curriculum, we treat filters not as algorithms, but as physical LTI systems characterized by their **Laplace Transfer Function** $H(s)$.

---

### 2.1 Analog Filter Design and Testing

To restrict our signal's bandwidth, we use a **Butterworth filter**, known for its "maximally flat" response. This means it maintains a very consistent gain across the frequencies we want to keep (the passband) before rolling off at the cutoff.

#### Step 1: Defining the Transfer Function

We begin by designing a **4th-order Analog Butterworth Filter** with a cutoff frequency $f_co = 5$ Hz. We translate this frequency into radians per second ($\Omega_{co} = 2\pi f_c$) to work within the Laplace domain.

```matlab
%% 1. Analog Filter Design Configuration
fco = 5;                  % Cutoff frequency in Hz
Wco = 2 * pi * fco;       % Convert Cutoff to radians/second (approx 31.4 rad/s)

% Design the filter: 's' indicates an analog (Laplace) design rather than digital
[b, a] = butter(4, Wco, 's'); 

% Create the Transfer Function H(s) = B(s)/A(s)
H = tf(b, a);

%% 2. Visualizing the System Characteristics
figure;
freqs(b, a);              % Plots magnitude and phase on log-scales
grid on;
title('Frequency Response of 4th-Order 5 Hz Butterworth Filter');
```

{numref}`fig-lowpass-filter-5hz` illustrates the magnitude and phase response. By inspecting the curve at $5$ Hz ($31.415$ rad/s), you will observe a gain of approximately **$-3.0$ dB**. In linear terms, this is $|H(j\Omega_{co})| = 1/\sqrt{2} \approx 0.707$, which is defined as the point where the signal power is halved.

```{figure} ./figures/lpf_5hz.png
:name: fig-lowpass-filter-5hz
:width: 580px
:align: center
Magnitude and Phase response of a 4th-order analog Butterworth filter with a 5 Hz (-3 dB) cutoff frequency.
```

#### Step 2: Synthesizing a Test Signal

To verify the filter's performance, we create an input signal $x(t)$ consisting of three distinct frequencies: one well within the passband ($2$ Hz), one exactly at the cutoff ($5$ Hz), and one in the stopband ($15$ Hz).

$$x(t) = \cos(2\pi\cdot2t) + \cos(2\pi\cdot5t) + \cos(2\pi\cdot15t)$$

```matlab
%% 3. Signal Synthesis and Spectral Analysis

fs = 441000;              % High sampling rate for continuous-time simulation
T = 10;                   % 10-second duration
t = 0:1/fs:T-1/fs;        % Time vector
L = length(t);            % Length of signal
f = (0:L-1)*(fs/L);       % Frequency vector for plotting

% Create a signal with three distinct frequency components
x = cos(2*pi*2*t) + cos(2*pi*5*t) + cos(2*pi*15*t);

% Compute the Magnitude Spectrum using the Fast Fourier Transform (FFT)
X = abs(fft(x));

figure;
subplot(2,1,1); plot(t, x);
title('Input Signal x(t) in Time Domain');
xlabel('Time (s)'); ylabel('Amplitude');
grid on; xlim([0 2]); % Zoom in to see the individual oscillations

subplot(2,1,2); plot(f(1:floor(L/2)), X(1:floor(L/2))/L*2);
title('Magnitude Spectrum X(f)');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
xlim([0 20]); % Focus on our area of interest
grid on;
```

As shown in {numref}`signal_2_5_15_hz`, the input spectrum shows three equal spikes. Note that even though we are using the `fft` (a tool often used in digital contexts), we use a very high sampling rate ($441$ kHz) to accurately approximate the behavior of the continuous-time signal.

```{figure} ./figures/signal_2_5_15_hz.png
:name: signal_2_5_15_hz
:width: 580px
:align: center
Time-domain waveform and magnitude spectrum of the composite input signal showing components at 2 Hz, 5 Hz, and 15 Hz.
```

#### Step 3: Simulating the LTI System Response

Finally, we pass our signal through the filter. Since $H(s)$ represents a continuous-time system (often implemented physically with resistors, capacitors, and op-amps), we use the `lsim` function to simulate the output $y(t)$.

```matlab
%% 4. LTI System Simulation
% lsim simulates the time-response of an analog system (H) to an arbitrary input (x)
y = lsim(H, x, t);

% Compute the Spectrum of the filtered output
Y = abs(fft(y));

figure;
subplot(2,1,1); plot(t, y);
title('Filtered Output Signal y(t)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on; xlim([0 2]);

subplot(2,1,2); plot(f(1:floor(L/2)), Y(1:floor(L/2))/L*2);
title('Magnitude Spectrum Y(f) After Filtering');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
xlim([0 20]);
grid on;
```

#### Step 4: Observations and Analysis

The results in {numref}`filtered_signal_2_5_15_hz` confirm the filter's performance:

1. **Passband:** The $2$ Hz component is almost entirely preserved.
2. **Cutoff:** The $5$ Hz component has been scaled by $0.707$ (the $-3$ dB point).
3. **Stopband:** The $15$ Hz component has been significantly attenuated, effectively removed from the output.

```{figure} ./figures/filtered_signal_2_5_15_hz.png
:name: filtered_signal_2_5_15_hz
:width: 580px
:align: center
Filtered output showing the preservation of the 2 Hz signal, the 3 dB attenuation of the 5 Hz signal, and the removal of the 15 Hz component.
```

### 2.2 Double-Sideband Suppressed Carrier (DSB-SC) Modulation

Once the message signal $m(t)$ has been appropriately band-limited by a low-pass filter, the next stage in the communication chain is **modulation**. Modulation is the process of shifting the message spectrum to a higher frequency range, allowing for efficient transmission over physical media.

In this project, we focus on **Double-Sideband Suppressed Carrier (DSB-SC)** modulation. This is achieved by multiplying the filtered message $m(t)$ by a high-frequency sinusoidal carrier $\cos(2\pi f_c t)$.

#### Step 1: Theoretical Foundation

The Modulation Theorem (or Frequency Shifting Property) of the Fourier Transform states that multiplication by a cosine in the time domain results in a shift in the frequency domain:

$$x(t) = m(t) \cos(2\pi f_c t) \stackrel{\mathcal{F}}{\longleftrightarrow} X(f) = \frac{1}{2} [M(f - f_c) + M(f + f_c)]$$

This mathematical operation creates two "sidebands"—one above the carrier frequency and one below—while the carrier itself is "suppressed" because it does not appear as a standalone impulse in the spectrum unless explicitly added.

#### Step 2: Implementation in MATLAB

To visualize this effect clearly, we will use the filtered output $y(t)$ from Subsection 2.1 as our message signal and modulate it using a carrier frequency $f_c = 50$ Hz.

```matlab
%% 1. Modulation Configuration
fc = 50;                  % Carrier frequency (50 Hz) for clear visualization
carrier = cos(2*pi*fc*t); % Generate the continuous-time carrier wave

% Perform modulation via element-wise multiplication
x_modulated = y' .* carrier; 

%% 2. Spectral Analysis of the Modulated Signal
% Compute the magnitude spectrum of the modulated signal
% Use fftshift to center the spectrum at 0 Hz for easier interpretation
X_mod_freq = abs(fftshift(fft(x_modulated)));
f_shifted = (-L/2:L/2-1)*(fs/L); % Centered frequency axis

%% 3. Visualizing the Modulation Results
figure;

% Time Domain Plot
subplot(2,1,1);
plot(t, x_modulated);
hold on;
plot(t, y, 'r--', 'LineWidth', 1.5); % Plot original message as the envelope
title('Modulated Signal x(t) (DSB-SC) in Time Domain');
xlabel('Time (s)'); ylabel('Amplitude');
legend('Modulated Signal', 'Message Envelope');
grid on; xlim([0 1]); % Zoom in to see the carrier oscillations

% Frequency Domain Plot
subplot(2,1,2);
plot(f_shifted, X_mod_freq/L*2);
title('Magnitude Spectrum X(f) of Modulated Signal');
xlabel('Frequency (Hz)'); ylabel('Magnitude');
xlim([-75 75]); % Focus on the shifted sidebands around +/- 50 Hz
grid on;
```

```{note}
In MATLAB, the `fft` function returns a spectrum where the frequency components are ordered starting from 0 Hz up to the sampling frequency fs​. This places the _negative_ frequencies at the end of the array. The `fftshift` function is necessary to swap the left and right halves of the data, centering the 0 Hz component. This allows us to plot a standard double-sided spectrum that matches the mathematical convention of being centered at the origin.
```

#### Step 3: Observations and Analysis

{numref}`fig-modulated-signal` illustrates the transformation. In the time domain, the high-frequency carrier is "shaped" by the amplitude of the message. In the frequency domain, you can observe that the original 2 Hz and 5 Hz components no longer reside near 0 Hz; they have been shifted and are now centered at $\pm 50$ Hz.

```{figure} ./figures/modulated_signal.png
:name: fig-modulated-signal
:width: 580px
:align: center
Time-domain modulated waveform and the corresponding magnitude spectrum showing the message shifted to the 50 Hz carrier frequency.
```


The modulation process provides several key insights:
1.  **Spectrum Centering:** The baseband signal (originally $0 \pm 5$ Hz) now occupies the frequency band from $45$ Hz to $55$ Hz (and a mirror image in the negative frequencies).
2.  **Bandwidth Doubling:** While the original message was band-limited to $5$ Hz, the modulated signal occupies a total bandwidth of $10$ Hz ($55 - 45 = 10$). This is a fundamental characteristic of double-sideband modulation.
3.  **Phase Reversal:** Notice in the time domain that whenever the message $m(t)$ crosses zero and becomes negative, the carrier undergoes a $180^\circ$ phase reversal. This "suppressed carrier" feature is why coherent detection is required at the receiver.













## 3. Part II: Deliverables — The Demodulation Challenge

Using the filtering and modulation logic from the walkthrough, students must complete the following:

### 3.1 Recovery Tasks

Download `signal1.wav`, `signal2.wav`, and `signal3.wav`.

1. **Demodulate Signal 1 & 2 (DSB-SC):**

* Use $f_{c1} = 15$ kHz and $f_{c2} = 30$ kHz.
* Perform coherent detection (Multiply $\to$ Filter).

1. **Demodulate Signal 3 (DSB with Carrier):**

* Use $f_{c3} = 50$ kHz.
* Perform envelope detection: $y(t) = \text{LPF}\{ |x(t)| \}$.
* **Observation:** Compare the sound quality of the envelope detector versus coherent detection for this signal.

### 3.2 Submission Requirements

* **Comparison Plot:** Show the time-domain envelope of the original piano sound versus the recovered sound.
* **Spectrum Verification:** Provide the magnitude spectrum of the three recovered signals, showing that the high-frequency carrier has been successfully removed.
* **Audio Identification:** State the contents of the three audio files.

---

## 3. Part II: Deliverables — The Demodulation Challenge

Now that you understand the signal chain, you are tasked with recovering three different audio messages from the provided files: `signal1.wav`, `signal2.wav`, and `signal3.wav`.

### 3.1 Provided Signal Specs

| Signal | Modulation Type | Carrier Frequency ($f_c$) |
| --- | --- | --- |
| **Signal 1** | DSB-SC | 12 kHz |
| **Signal 2** | DSB-SC | 25 kHz |
| **Signal 3** | DSB (with Carrier) | 40 kHz |

### 3.2 Your Tasks

1. **Coherent Demodulation (Signals 1 & 2):** * Multiply the received signal by a local carrier $\cos(2\pi f_c t)$.

* Apply the 5 kHz Butterworth LPF you designed in Part I.
* Play the audio using `sound(y, fs)`.

### 3.3 Required Submission

* **Plots:** Magnitude spectra for all three signals _before_ and _after_ demodulation.
* **Verification:** Identify the hidden audio message in each file (e.g., "The message in Signal 1 is a person speaking about...").
* **Discussion:** Explain what happens if your local carrier frequency in Part 3.1 is slightly off (e.g., 12.1 kHz instead of 12 kHz). Use the properties of the Fourier Transform to justify your answer.

---

## 6. Deliverables

1. **Filter Analysis:** A plot of the Butterworth filter's frequency response (Magnitude in dB).
2. **Spectrum Plots:** Magnitude spectra of the modulated C4 tone versus the original.
3. **Audio Recovery:** Successful demodulation of the three provided 10-second files.
4. **Discussion:** Explain why the $441$ kHz sampling rate is necessary when dealing with carriers in the $15$–$20$ kHz range, referencing the Nyquist criterion.

## 3. The Demodulation Process: Mixing and Filtering

To recover the signal $m(t)$, we use a **coherent detector**. This process consists of two primary stages that rely on the concepts of linearity and filtering you studied in Project 1.

### 3.1 Step 1: Mixing (Frequency Shifting)

By multiplying the received signal $x(t)$ by the same carrier frequency $\cos(2\pi f_c t)$, we create a new signal $z(t)$:

$$z(t) = x(t) \cos(2\pi f_c t) = m(t) \cos^2(2\pi f_c t)$$

Using the trigonometric identity $\cos^2(\theta) = \frac{1}{2}(1 + \cos(2\theta))$, we get:

$$z(t) = \frac{1}{2}m(t) + \frac{1}{2}m(t) \cos(4\pi f_c t)$$

This operation results in two components:

1. A copy of the original message $m(t)$ scaled by $0.5$ at **baseband** (centered at $0$ Hz).
2. A high-frequency component centered at **$2f_c$**.

### 3.2 Step 2: Low-Pass Filtering (The LTI System)

To isolate $m(t)$, we pass $z(t)$ through a **Low-Pass Filter (LPF)**. As you learned in Project 1, this LTI system can be characterized by its impulse response $h(t)$. The output $y(t)$ is the convolution:

$$y(t) = z(t) * h(t)$$

The filter is designed to reject the high-frequency component at $2f_c$ and pass the baseband signal $m(t)$ unchanged.

---

## 4. Project Task: Recovering the Audio

You are provided with three modulated `.wav` files. Each file contains an audio message modulated at a different carrier frequency $f_c$. Your objective is to implement a demodulator in Python or MATLAB to recover and play the original audio.

### 4.1 Specifications

The composite signals use the following carrier frequencies:

* **Signal 1:** $f_{c1} = 5$ kHz
* **Signal 2:** $f_{c2} = 10$ kHz
* **Signal 3:** $f_{c3} = 15$ kHz

### 4.2 Implementation Steps

1. **Load the Data:** Read the `.wav` files and determine the sampling frequency $f_s$.
2. **Multiply:** Generate a local carrier $\cos(2\pi f_c t)$ and multiply it by the received signal.
3. **Filter:** Design a Butterworth or Ideal LPF with a cutoff frequency appropriate for human speech/music (typically around $3$–$4$ kHz).
4. **Normalize and Play:** Scale the resulting signal to prevent clipping and use the system's audio output to verify the result.

---

## 5. Key Takeaways

* Demodulation relies on the **Frequency Shifting property** of the Fourier Transform.
* A **multiplier (mixer)** moves the signal spectrum, while a **low-pass filter** isolates the desired information.
* Success in this project requires applying the **LTI system concepts** from Project 1—specifically, understanding how a filter's impulse response removes unwanted high-frequency noise.
