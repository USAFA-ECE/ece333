# Integration by Parts

**A Gentle but Thorough Walkthrough**

Integration by parts is one of those techniques that shows up everywhere: differential equations, signal processing, probability, and even physics. It’s the calculus equivalent of a Swiss‑army knife. The idea is simple, but using it well takes practice — and that’s exactly what this guide is for.

Below, I’ll walk through the intuition, the formula, and a series of worked examples. These examples come from a set of class notes in ECE 346, but I’ve expanded them with explanations, commentary, and checks so that anyone reading your blog can follow along.

---

## 1. Where Integration by Parts Comes From  
### (Starting from the Product Rule)

Most students memorize the formula

$$\int u\,dv = uv - \int v\,du$$

without ever seeing where it comes from. But it’s nothing more than the **product rule** written in reverse. Start with the product rule:

$$\frac{d}{dx}(uv) = u'v + uv'$$

Integrate both sides:

$$\int \frac{d}{dx}(uv)\,dx = \int u'v\,dx + \int uv'\,dx$$

The left side simplifies:

$$\int \frac{d}{dx}(uv)\,dx = \int d(uv)\,\frac{dx}{dx}= \int d(uv) =  uv$$

So we have:

$$uv = \int u'v\,dx + \int uv'\,dx$$

Rearrange:

$$\int uv'\,dx = uv - \int u'v\,dx$$

Now rewrite:

$$v'\,dx = \frac{dv}{dx}dx = dv, \qquad u'\, dx = \frac{du}{dx} dx = du$$

Then:

$$\int u\,dv = uv - \int v\,du$$

This is the integration‑by‑parts formula.

---

## 2. A Second Derivation  
### (Using Differentials)

The product rule can also be written as:

$$d(uv) = u\,dv + v\,du$$

Integrate both sides:

$$\int d(uv) = \int u\,dv + \int v\,du$$

The left side simplifies:

$$\int d(uv) = uv$$

So:

$$uv = \int u\,dv + \int v\,du$$

Rearrange:

$$\int u\,dv = uv - \int v\,du$$

Same formula, different viewpoint.

---

## 3. What Integration by Parts Actually Does

When you apply:

$$\int u\,dv = uv - \int v\,du$$

you are:

1. **Differentiating** $u$ → it should get simpler  
2. **Integrating** $dv$ → it should be easy  
3. **Trading** the original integral for a new one  

The whole technique is about making the new integral **easier**.

---

## 4. Fully Worked Examples  
## (With Explanations for Students Who Struggle)

---

### Example 1  
#### $\int x e^x\,dx$

Choose:

- $u = x$
- $dv = e^x dx$

Then:

- $du = dx$
- $v = e^x$

Apply:

$$\int x e^x dx = x e^x - \int e^x dx$$

$$= x e^x - e^x + C$$

Factor:

$$= e^x(x - 1) + C$$

---

### Example 2  
#### $\int x\cos x\,dx$

Choose:

- $u = x$
- $dv = \cos x\,dx$

Then:

- $du = dx$
- $v = \sin x$

Apply:

$$\int x\cos x\,dx = x\sin x - \int \sin x\,dx$$

$$= x\sin x + \cos x + C$$

---

### Example 3: 
#### $\int \ln x\,dx$

Rewrite:

$$\int \ln x\,dx = \int \ln x \cdot 1\,dx$$

Choose:

- $u = \ln x$
- $dv = dx$

Then:

- $du = \frac{1}{x}dx$
- $v = x$

Apply:

$$\int \ln x\,dx = x\ln x - \int x\cdot \frac{1}{x}\,dx$$

$$= x\ln x - x + C$$

---

### Example 4  
#### $\int \ln(x+2)\,dx$

Rewrite:

$$\int \ln(x+2)\,dx = \int \ln(x+2)\cdot 1\,dx$$

Choose:

- $u = \ln(x+2)$
- $dv = dx$

Then:

- $du = \frac{1}{x+2}dx$
- $v = x$

Apply:

$$\int \ln(x+2)\,dx = x\ln(x+2) - \int x\frac{1}{x+2}\,dx$$

Rewrite:

$$\frac{x}{x+2} = 1 - \frac{2}{x+2}$$

So:

$$\int \ln(x+2)\,dx = x\ln(x+2) - x + 2\ln(x+2) + C$$

Factor:

$$= (x+2)\ln(x+2) - x + C$$

---

### Example 5  
#### $\int x^2 e^x\,dx$

Choose:

- $u = x^2$
- $dv = e^x dx$

Then:

- $du = 2x dx$
- $v = e^x$

Apply:

$$\int x^2 e^x dx = x^2 e^x - \int 2x e^x dx$$

We already know:

$$\int x e^x dx = e^x(x - 1)$$

So:

$$\int x^2 e^x dx = x^2 e^x - 2e^x(x - 1)$$

$$= e^x(x^2 - 2x + 2) + C$$

---

### Example 6  
#### $\int e^x \cos x\,dx$

Let:

$$I = \int e^x \cos x\,dx$$

Choose:

- $u = \cos x$
- $dv = e^x dx$

Then:

- $du = -\sin x dx$
- $v = e^x$

Apply:

$$I = e^x\cos x + \int e^x \sin x\,dx$$

Let:

$$J = \int e^x \sin x\,dx$$

Now integrate $J$ by parts:

Choose:

- $u = \sin x$
- $dv = e^x dx$

Then:

- $du = \cos x dx$
- $v = e^x$

Apply:

$$J = e^x\sin x - I$$

Substitute back:

$$I = e^x\cos x + e^x\sin x - I$$

Solve:

$$2I = e^x(\sin x + \cos x)$$

$$I = \frac{e^x}{2}(\sin x + \cos x) + C$$

---

## 5. Final Thoughts

Integration by parts becomes much easier once you understand:

- where the formula comes from,  
- how to choose $u$ and $dv$,  
- and what the formula is *trying* to do.


## 6. Practice Problem Set

### Part A — Basic Integration by Parts

1. $\int x e^{2x}\,dx$

2. $\int x\sin x\,dx$

3. $\int \ln x\,dx$

4. $\int x\cos(3x)\,dx$

5. $\int e^x (x+1)\,dx$

---

### Part B — Repeated Integration by Parts

6. $\int x^2 e^x\,dx$

7. $\int x^3 \cos x\,dx$

8. $\int x^2 \ln x\,dx$

---
### Part C — Looping Integrals

9. $\int e^x \sin x\,dx$

10. $\int e^{2x}\cos(3x)\,dx$

---

### Part D — Simplify First

11. $\int \frac{x}{x+1}\,dx$

12. $\int x\ln(x^2+1)\,dx$

13. $\int \frac{\ln x}{x}\,dx$

---

### Part E — Challenge Problems

14. $\int x e^{-x^2}\,dx$

15. $\int x^2 e^{-x^2}\,dx$

16. $\int \ln(\sin x)\,dx$

