# 📖 Glossary

Classifying signals as **power signals** or **energy signals** isn’t just a vocabulary exercise — it tells you *how* the signal behaves over time and *which mathematical tools* you can use to analyze it. Engineers do this because different types of signals require different analysis techniques, different transforms, and even different interpretations in physical systems.

---

# 🔌 Why the classification matters

## 1. **It tells you what kind of system analysis applies**
- **Energy signals** (finite energy, zero average power) are typically *transient* signals — pulses, bursts, wavelets, Gaussian bumps.
- **Power signals** (finite average power, infinite energy) are *persistent* or *periodic* — sinusoids, square waves, random stationary processes.

Different math applies:
- Energy signals → **Parseval’s theorem**, energy spectral density  
- Power signals → **Power spectral density**, autocorrelation, ergodicity

You can’t mix the two without changing the framework.

---

## 2. **It determines which Fourier transform you’re allowed to use**
This is a big one.

- Energy signals → **Fourier Transform (FT)** exists directly  
- Power signals → FT does **not** exist in the usual sense  
  - Instead you use the **Fourier Series** (for periodic signals)  
  - Or the **PSD** (for random/stationary signals)

Example:  
A pure sinusoid has infinite energy, so its FT is not a normal function — it becomes impulses (Dirac deltas). That’s why we treat it as a **power signal**.

---

## 3. **It matches physical intuition**
- Energy signals represent things like pulses, radar chirps, communication packets.  
  You care about **total energy** delivered.

- Power signals represent steady-state sources like AC mains, carriers, clock signals.  
  You care about **average power** delivered.

The classification tells you what the signal *means* physically.

---

## 4. **It prevents mathematical contradictions**
If you try to compute the energy of a sinusoid:

\[
\int_{-\infty}^{\infty} \sin^2(t)\, dt
\]

…it diverges.  
But its **average power**:

\[
P = \frac{1}{2}
\]

…is perfectly finite.

The classification keeps you from applying the wrong integral and getting nonsense.

---

## 5. **It guides system design**
In communication systems:
- Energy signals → used for **symbol detection**, matched filters  
- Power signals → used for **carrier waves**, modulation, spectral shaping

In control systems:
- Energy signals → represent impulses or test inputs  
- Power signals → represent steady-state forcing

In DSP:
- Energy signals → windowed signals, FIR filters  
- Power signals → periodic signals, IIR filters, spectral estimation

---

# 🎯 The one-sentence summary
We classify signals as power or energy because **each class obeys different mathematical rules, uses different transforms, and represents different physical behaviors**, and mixing them leads to incorrect analysis.


# 🌟 What “the Fourier Transform does **not** exist in the usual sense” really means

For **energy signals**, the Fourier Transform is defined by the integral:

\[
X(\omega)=\int_{-\infty}^{\infty} x(t)e^{-j\omega t}\,dt
\]

This integral converges **only if** the signal has **finite energy**:

\[
E=\int_{-\infty}^{\infty} |x(t)|^2 dt < \infty.
\]

But **power signals** (like sinusoids) have **infinite energy**, so the integral above **diverges**.  
That’s why we say:

> The Fourier Transform does not exist as an ordinary function.

It doesn’t mean “no transform exists.”  
It means the transform is **not a regular function** — it becomes a **distribution** (generalized function).

---

# 🎵 Example: Fourier Transform of \( \cos(\omega_0 t) \)

Try the usual FT integral:

\[
\int_{-\infty}^{\infty} \cos(\omega_0 t)e^{-j\omega t} dt
\]

This integral **does not converge**.  
The cosine oscillates forever and never decays, so the area under the curve does not settle to a finite value.

So the FT **cannot** be a normal function.

---

# 🚀 But we *can* represent it using distributions

Using Euler’s identity:

\[
\cos(\omega_0 t)=\frac{1}{2}\left(e^{j\omega_0 t}+e^{-j\omega_0 t}\right)
\]

Each exponential has a “transform” in the distribution sense:

\[
\int_{-\infty}^{\infty} e^{j\omega_0 t} e^{-j\omega t} dt
= 2\pi \delta(\omega - \omega_0)
\]

So the “Fourier Transform” of cosine is:

\[
\mathcal{F}\{\cos(\omega_0 t)\}
= \pi\left[\delta(\omega-\omega_0)+\delta(\omega+\omega_0)\right].
\]

This is **not** a function.  
It is a **pair of impulses**.

That’s what “not in the usual sense” means.

---

# 🧠 Intuition: Why impulses appear

A sinusoid has:
- **infinite duration**
- **constant amplitude**
- **infinite energy**
- **finite average power**

So instead of spreading energy across frequencies, it concentrates all its power at exactly two frequencies.  
That’s why the transform becomes impulses.

