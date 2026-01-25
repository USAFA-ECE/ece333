# Impulse Response and Convolution

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


% > **Figure 2.1 (insert here):** *Block diagram of a discrete-time LTI system showing % input x(k), output y(k), and impulse input δ(k).*



```{figure} ./figures/GradeDistribution.png
:width: 660px
:align: center
:name: fig-lti-system

Block diagram of a discrete-time LTI system showing input $x(k)$, output $y(k)$, and impulse input $\delta(k)$.


{numref}fig-lti-system illustrates the basic input–output relationship of a discrete-time LTI system. It emphasizes that the impulse response h(k) is defined as the system output when the input is the unit impulse δ(k). This figure sets the foundation for all later analysis.

We begin with discrete-time systems, since impulses and summations are easier to visualize. {ref}fig-lti-system 




Consider a discrete-time LTI system with input ( x(k) ) and output ( y(k) ).

### 2.1 The Unit Impulse (Kronecker Delta)

> **Figure 2.2 (insert here):** *Stem plot of the discrete-time unit impulse δ(k).*

Figure 2.2 visualizes the unit impulse as a signal that is nonzero at only one time index. This highlights why impulses are useful building blocks: they isolate behavior at a single instant in time.

The **unit impulse**, also called the **Kronecker delta**, is defined as

[
\delta(k) =
\begin{cases}
1, & k = 0 \
0, & k \neq 0
\end{cases}
]

The impulse is nonzero at only one time index. Although this signal may seem artificial, it plays a role similar to a **basis vector** in linear algebra.

When the input to the system is ( \delta(k) ), the output is called the **impulse response**:

[
\delta(k) \longrightarrow h(k).
]

The impulse response tells us how the system behaves when excited at a single instant in time.

---

### 2.2 Time Invariance: Shifting the Impulse

> **Figure 2.3 (insert here):** *Illustration showing that a delayed impulse input δ(k−n) produces a delayed output h(k−n).*

Figure 2.3 demonstrates the time-invariance property. When the impulse is shifted in time, the output shifts by the same amount, showing that the system response does not depend on absolute time.

A system is **time-invariant** if delaying the input by some amount produces an identical delay in the output.

If
[
\delta(k) \longrightarrow h(k),
]

then for any integer ( n ),
[
\delta(k-n) \longrightarrow h(k-n).
]

This property ensures that the system’s behavior does not depend on *when* the input is applied—only on its shape.

---

### 2.3 Linearity: Scaling the Impulse

> **Figure 2.4 (insert here):** *Illustration demonstrating scaling: input aδ(k) produces output a·h(k).*

Figure 2.4 illustrates linearity through scaling. Increasing the amplitude of the impulse increases the amplitude of the response by the same factor, reinforcing the proportional nature of linear systems.

A system is **linear** if it satisfies two properties:

* **Scaling:** Scaling the input scales the output
* **Additivity:** The response to a sum of inputs is the sum of the responses

For scaling,
[
a,\delta(k) \longrightarrow a,h(k).
]

This means that the system responds proportionally to the strength of the input.

---

## 3. Decomposition of Discrete-Time Signals

> **Figure 3.1 (insert here):** *Example discrete-time signal decomposed into scaled and shifted impulse signals.*

Figure 3.1 shows how an arbitrary discrete-time signal can be expressed as a sum of weighted impulses. Each impulse corresponds to one sample of the signal, making the decomposition visually concrete.

The key insight that leads to convolution is that **any discrete-time signal can be constructed from shifted impulses**.

### 3.1 Impulse Decomposition

> **Figure 3.2 (insert here):** *Visualization showing how each impulse δ(k−n) isolates the sample value x(n).*

Figure 3.2 emphasizes the sampling property of the impulse. The impulse "picks out" the value of the signal at a specific time index, which is why the impulse decomposition works.

Let ( x(k) ) be an arbitrary discrete-time signal. Then it can be written as

[
x(k) = \sum_{n=-\infty}^{\infty} x(n),\delta(k-n).
]

This expression may look strange at first, since it rewrites a signal in a more complicated form. However, it has a very clear interpretation:

* Each impulse ( \delta(k-n) ) is located at time ( n )
* Each impulse is weighted by the signal value ( x(n) )

The impulse acts as a *sampling operator*, selecting the value of the signal at a single time index.

---

### 3.2 Analogy: Basis Vectors in Linear Algebra

This idea is closely related to expressing a vector as a linear combination of basis vectors. For example,

[
\begin{bmatrix} 3 \ 2 \end{bmatrix}
===================================

3\begin{bmatrix} 1 \ 0 \end{bmatrix}
+
2\begin{bmatrix} 0 \ 1 \end{bmatrix}.
]

Here, the unit vectors form a basis for ( \mathbb{R}^2 ). Similarly, shifted impulse signals form a **basis for discrete-time signals**.

---

## 4. Discrete-Time Convolution

> **Figure 4.1 (insert here):** *Block-diagram interpretation showing summation of scaled and shifted impulse responses forming the output.*

Figure 4.1 visualizes convolution as a superposition process. The output signal is formed by summing multiple shifted copies of the impulse response, each weighted by the input signal values.

Once the input signal has been decomposed into impulses, computing the output becomes straightforward.

### 4.1 Response to a Single Impulse

From the definition of the impulse response,
[
\delta(k-n) \longrightarrow h(k-n).
]

### 4.2 Response to a Weighted Sum of Impulses

Using linearity, the response to
[
x(n),\delta(k-n)
]

is
[
x(n),h(k-n).
]

Because the system is linear, the total output is the sum of all such responses:

[
y(k) = \sum_{n=-\infty}^{\infty} x(n),h(k-n).
]

This summation is called **discrete-time convolution**, written compactly as

[
y(k) = (x * h)(k).
]

> **Interpretation:** The output is formed by adding together many shifted copies of the impulse response, each weighted by the input signal.

---

## 5. Continuous-Time Impulse Response

> **Figure 5.1 (insert here):** *Continuous-time LTI system responding to a Dirac delta input δ(t) with impulse response h(t).*

Figure 5.1 introduces the impulse response in continuous time. It mirrors the discrete-time case and shows that h(t) is defined as the system output due to a delta-function input.

The same reasoning applies to continuous-time systems, with sums replaced by integrals.

### 5.1 The Dirac Delta Function

> **Figure 5.2 (insert here):** *Conceptual illustration of the Dirac delta function as a unit-area impulse.*

Figure 5.2 provides intuition for the Dirac delta by emphasizing its unit-area property. Although infinitely narrow and tall, the delta function contributes a finite amount when integrated.

The **Dirac delta function** ( \delta(t) ) is an idealized impulse with the defining property

[
\int_{-\infty}^{\infty} \delta(t),dt = 1.
]

Although the delta function is not a function in the traditional sense, it is an extremely useful mathematical tool for analyzing LTI systems.

When the input to a continuous-time LTI system is ( \delta(t) ), the output is the **impulse response** ( h(t) ).

---

### 5.2 Decomposition of Continuous-Time Signals

> **Figure 5.3 (insert here):** *Continuous-time signal represented as a superposition of shifted impulses.*

Figure 5.3 illustrates how a continuous-time signal can be viewed as an infinite collection of impulses, each weighted by the signal value at time τ.

Any continuous-time signal ( x(t) ) can be expressed as a superposition of infinitely many shifted impulses:

[
x(t) = \int_{-\infty}^{\infty} x(\tau),\delta(t-\tau),d\tau.
]

Each impulse at time ( \tau ) contributes independently to the output.

---

## 6. Continuous-Time Convolution

> **Figure 6.1 (insert here):** *Graphical depiction of convolution as integration of shifted impulse responses weighted by the input signal.*

Figure 6.1 connects the convolution integral to physical intuition. It shows how the output is obtained by integrating weighted, shifted versions of the impulse response over all time.

Using linearity and time invariance, the output of a continuous-time LTI system is

[
y(t) = \int_{-\infty}^{\infty} x(\tau),h(t-\tau),d\tau.
]

This expression is called the **convolution integral**, and is written as

[
y(t) = (x * h)(t).
]

Convolution provides a universal input–output relationship for all continuous-time LTI systems.

---

## 7. Discrete-Time vs. Continuous-Time

| Concept              | Discrete Time   | Continuous Time      |
| -------------------- | --------------- | -------------------- |
| Impulse              | ( \delta(k) )   | ( \delta(t) )        |
| Signal decomposition | Summation       | Integral             |
| Impulse response     | ( h(k) )        | ( h(t) )             |
| System output        | Convolution sum | Convolution integral |

---

## 8. Key Takeaways

* The impulse response completely characterizes an LTI system.
* Any signal can be decomposed into shifted impulses.
* Linearity and time invariance lead directly to convolution.
* Convolution describes how inputs are transformed into outputs in LTI systems.

> **If you know the impulse response, you know the system.**
