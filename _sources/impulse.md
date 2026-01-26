# Impulse Response

This section develops one of the most important ideas in signals and systems: **the impulse response**. The impulse response provides a complete description of a **linear time-invariant (LTI)** system. Once it is known, the system’s response to *any* input can be determined using **convolution**.

The goal of this section is not only to present the formulas, but to build strong intuition for *why* convolution arises naturally from linearity and time invariance.

---

## 1. Why the Impulse Response Is Fundamental

In many engineering systems—electrical circuits, mechanical systems, control systems, and signal processing algorithms—we are interested in understanding how an output signal depends on an input signal.

For a general system, this relationship can be very complicated. However, for **linear time-invariant (LTI)** systems, there is a remarkable simplification:

```{important}
An LTI system is completely characterized by its impulse response.
```

This means that if we know how the system responds to a single, idealized input called an *impulse*, then we can determine how the system responds to *any* input signal.

To understand why this is true, we will:

1. Define impulse signals
2. Show how arbitrary signals can be built from impulses
3. Use linearity and time invariance to compute the output

---

## 2. Discrete-Time Impulse Response

We begin with discrete-time systems, since impulses and summations are easier to visualize. 

### 2.1 The Unit Impulse (Kronecker Delta)

Consider a discrete-time LTI system with input $x(k)$ and output $y(k)$.

```{figure} ./figures/LTI_System.png
:name: fig-lti-system
:width: 580px
:align: center
Block diagram of a discrete-time LTI system showing input $x(k)$, output $y(k)$, impulse input $\delta(k)$, and impulse response $h(k)$.
```

{numref}`fig-lti-system` illustrates the basic input–output relationship of a discrete-time LTI system. It emphasizes that the impulse response $h(k)$ is defined as the system output when the input is the unit impulse $\delta(k)$. This figure sets the foundation for all later analysis.

The **unit impulse**, also called the **Kronecker delta**, is defined as

$$
\delta(k) =
\begin{cases}
1, & k = 0 \\
0, & k \neq 0
\end{cases}
$$

The impulse is nonzero at only one time index. Although this signal may seem artificial, it plays a role similar to a **basis vector** in linear algebra.

When the input to the system is $\delta(k)$, the output is called the **impulse response**:

$$
\delta(k) \longrightarrow h(k).
$$

The impulse response tells us how the system behaves when excited at a single instant in time.

---

### 2.2 Time Invariance: Shifting the Impulse

A system is **time-invariant** if delaying the input by some amount produces an identical delay in the output.

If

$$
\delta(k) \longrightarrow h(k),
$$

then for any integer $n$,

$$
\delta(k-n) \longrightarrow h(k-n).
$$

This property ensures that the system's behavior does not depend on *when* the input is applied—only on its shape.

```{figure} ./figures/DelayedImpulseResponse.png
:name: fig-delayed-impulse-response
:width: 520px
:align: center
Illustration showing that a delayed impulse input $\delta(k−n)$ produces a delayed output $h(k−n)$.
```

{numref}`fig-delayed-impulse-response` demonstrates the time-invariance property. When the impulse is shifted in time, the output shifts by the same amount, showing that the system response does not depend on absolute time.

---

### 2.3 Linearity: Scaling the Impulse

A system is **linear** if it satisfies two properties:

- **Scaling:** Scaling the input scales the output
- **Additivity:** The response to a sum of inputs is the sum of the responses

For scaling,

$$
a\delta(k) \longrightarrow ah(k).
$$

This means that the system responds proportionally to the strength of the input.

```{figure} ./figures/ScaledImpulseResponse.png
:name: fig-scaled-impulse-response
:width: 520px
:align: center
Illustration demonstrating scaling: input $a\delta(k)$ produces output $ah(k)$.
```

{numref}`fig-scaled-impulse-response` illustrates linearity through scaling. Increasing the amplitude of the impulse increases the amplitude of the response by the same factor, reinforcing the proportional nature of linear systems.

---

## 3. Decomposition of Discrete-Time Signals

```{figure} ./figures/ImpulseDecomposition.png
:name: fig-impulse-decomposition
:width: 640px
:align: center
Example discrete-time signal decomposed into scaled and shifted impulse signals.
```

{numref}`fig-impulse-decomposition` shows how an arbitrary discrete-time signal can be expressed as a sum of weighted and shifted impulses. Each impulse corresponds to one sample of the signal, making the decomposition visually concrete.

The key insight that leads to convolution is that **any discrete-time signal can be constructed from shifted impulses**.

Let $x(k)$ be an arbitrary discrete-time signal. Then it can be written as

$$
x(k) = \sum_{n=-\infty}^{\infty} x(n) \delta(k-n).
$$

This expression may look strange at first, since it rewrites a signal in a more complicated form. However, it has a very clear interpretation:

* Each impulse $\delta(k-n)$ is located at time $n$
* Each impulse is weighted by the signal value $x(n)$

The impulse acts as a *sampling operator*, selecting the value of the signal at a single time index.


```{figure} ./figures/BasisVectors.png
:name: fig-basis-vectors
:width: 160px
:align: center
Basis vectors
```

This idea is closely related to expressing a vector as a linear combination of basis vectors. For example, consider a vector $\begin{bmatrix} 3 & 2 \end{bmatrix}^\top$ as illustrusted in {numref}`fig-basis-vectors`. This vector can be decomposed as

$$
\begin{bmatrix} 3 \\ 2 \end{bmatrix}
=3\begin{bmatrix} 1 \\ 0 \end{bmatrix}
+
2\begin{bmatrix} 0 \\ 1 \end{bmatrix}.
$$


Here, the unit vectors form a basis for $\mathbb{R}^2$. Similarly, shifted impulse signals form a **basis for discrete-time signals**.

---

## 4. Discrete-Time Convolution

```{figure} ./figures/DiscreteConvolution.png
:name: fig-discrete-convolution
:width: 680px
:align: center
Block-diagram interpretation showing summation of scaled and shifted impulse responses forming the output.
```

{numref}`fig-discrete-convolution` visualizes convolution as a superposition process. The output signal is formed by summing multiple shifted copies of the impulse response, each weighted by the input signal values. Once the input signal has been decomposed into impulses, computing the output becomes straightforward.

From the definition of the impulse response,

$$
\delta(k-n) \longrightarrow h(k-n).
$$

Using linearity, the response to $x(n)\delta(k-n)$ is $x(n)h(k-n)$. Because the system is linear, the total output is the sum of all such responses:

$$
y(k) = \sum_{n=-\infty}^{\infty} x(n)h(k-n).
$$

This summation is called **discrete-time convolution**, written compactly as

$$
y(k) = (x * h)(k) = x(k)*h(k).
$$

```{important}
The output is formed by adding together many shifted copies of the impulse response, each weighted by the input signal.
```

---

## 5. Continuous-Time Impulse Response


```{figure} ./figures/LTI_System_CT.png
:name: fig-cont-lti-system
:width: 520px
:align: center
Continuous-time LTI system responding to a Dirac delta input $\delta(t)$ with impulse response $h(t)$
```

{numref}`fig-cont-lti-system` introduces the impulse response in continuous time. It mirrors the discrete-time case and shows that $h(t)$ is defined as the system output due to a delta-function input.

The same reasoning applies to continuous-time systems, with sums replaced by integrals.

### 5.1 The Dirac Delta Function

The **Dirac delta function** $\delta(t)$ is an idealized impulse with the defining property

$$
\int_{-\infty}^{\infty} \delta(t)dt = 1.
$$

Although the delta function is not a function in the traditional sense, it is an extremely useful mathematical tool for analyzing LTI systems.

When the input to a continuous-time LTI system is $\delta(t)$, the output is the **impulse response** $h(t)$.

---

### 5.2 Decomposition of Continuous-Time Signals

Any continuous-time signal ( x(t) ) can be expressed as a superposition of infinitely many shifted impulses:

$$
x(t) = \int_{-\infty}^{\infty} x(\tau)\delta(t-\tau),d\tau.
$$

```{figure} ./figures/ImpulseDecompositionCT.png
:name: fig-impulse-decomposition-ct
:width: 680px
:align: center
Continuous-time signal represented as a superposition of shifted impulses.
```

{numref}`fig-impulse-decomposition-ct` illustrates how a continuous-time signal can be viewed as an infinite collection of impulses, each weighted by the signal value at time $\tau$.


Each impulse at time $\tau$ contributes independently to the output.

---

## 6. Continuous-Time Convolution

Using linearity and time invariance, the output of a continuous-time LTI system is

$$
y(t) = \int_{-\infty}^{\infty} x(\tau),h(t-\tau),d\tau.
$$

This expression is called the **convolution integral**, and is written as

$$
y(t) = (x * h)(t).
$$


```{figure} ./figures/ContinuousConvolution.png
:name: fig-continuous-convolution
:width: 580px
:align: center
Graphical depiction of convolution as integration of shifted impulse responses weighted by the input signal.
```

{numref}`fig-continuous-convolution` connects the convolution integral to physical intuition. It shows how the output is obtained by integrating weighted, shifted versions of the impulse response over all time.

```{note}
Convolution provides a universal input–output relationship for all continuous-time LTI systems.
```

---

## 7. Discrete-Time vs. Continuous-Time

| Concept              | Discrete Time   | Continuous Time      |
| -------------------- | --------------- | -------------------- |
| Impulse              | $\delta(k)$     | $\delta(t)$          |
| Signal decomposition | Summation       | Integral             |
| Impulse response     | $h(k)$          | $h(t)$               |
| System output        | Convolution sum | Convolution integral |

---

## 8. Key Takeaways

* The impulse response completely characterizes an LTI system.
* Any signal can be decomposed into weighted and shifted impulses.
* Linearity and time invariance lead directly to convolution.
* Convolution describes how inputs are transformed into outputs in LTI systems.

```{important}
If you know the impulse response, you know the system.
```