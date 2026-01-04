# Integration by Parts

A Gentle but Thorough Walkthrough

Integration by parts is one of those techniques that shows up everywhere: differential equations, signal processing, probability, and even physics. It’s the calculus equivalent of a Swiss‑army knife. The idea is simple, but using it well takes practice — and that’s exactly what this guide is for.

Below, I’ll walk through the intuition, the formula, and a series of worked examples. These examples come from a set of class notes, but I’ve expanded them with explanations, commentary, and checks so that anyone reading your blog can follow along.

---

# 1. Where Integration by Parts Comes From  
## (Starting from the Product Rule)

Many students memorize the formula:

\[
\int u\,dv = uv - \int v\,du
\]

but have no idea where it comes from. Let’s fix that by starting from something you already know well: **the product rule**.

The product rule says:

\[
\frac{d}{dx}(u(x)v(x)) = u'(x)v(x) + u(x)v'(x)
\]

Now integrate both sides with respect to \(x\):

\[
\int \frac{d}{dx}(uv)\,dx = \int u'v\,dx + \int uv'\,dx
\]

The left side simplifies immediately:

\[
\int \frac{d}{dx}(uv)\,dx = uv
\]



So we have:



\[
uv = \int u'v\,dx + \int uv'\,dx
\]



Rearrange to isolate \(\int uv'\,dx\):



\[
\int uv'\,dx = uv - \int u'v\,dx
\]



Now rename:

- \(dv = v' dx\)
- \(du = u' dx\)

Then:



\[
\int u\,dv = uv - \int v\,du
\]



This is the integration‑by‑parts formula.

### Why this derivation matters for struggling students

- It shows the formula is **not magic** — it’s just the product rule written backwards.
- It explains why the formula always produces **two terms**: a product \(uv\) and a new integral.
- It highlights the goal: make the new integral **simpler** than the original.

---

# 2. A Second Derivation  
## (Using Differentials)

Some students find the differential viewpoint more intuitive.

Start with the differential form of the product rule:



\[
d(uv) = u\,dv + v\,du
\]



Now integrate both sides:



\[
\int d(uv) = \int u\,dv + \int v\,du
\]



The left side simplifies:



\[
\int d(uv) = uv
\]



So:



\[
uv = \int u\,dv + \int v\,du
\]



Rearrange:



\[
\int u\,dv = uv - \int v\,du
\]



Same formula, same meaning — just a different path.

### Why this helps

- It shows that integration by parts is simply “undoing” the differential of a product.
- It reinforces that the formula is a **rearrangement**, not a trick.

---

# 3. How to Choose \(u\) and \(dv\)

Choosing \(u\) and \(dv\) is the hardest part for most students.

A helpful rule of thumb is **LIATE**, which ranks functions by how good they are as \(u\):

1. **L**ogarithmic  
2. **I**nverse trig  
3. **A**lgebraic  
4. **T**rig  
5. **E**xponential  

Choose \(u\) from the earliest category that appears in your integrand.  
The remaining part becomes \(dv\).

### Why LIATE works

- Logarithms and inverse trig functions become **simpler** when differentiated.
- Algebraic functions (like \(x^2\)) shrink when differentiated.
- Trig and exponential functions don’t simplify when differentiated, but they’re easy to integrate.

---

# 4. What Integration by Parts *Actually* Does

When you apply:



\[
\int u\,dv = uv - \int v\,du
\]



you are doing three things:

1. **Differentiating** \(u\) → it should get simpler  
2. **Integrating** \(dv\) → it should be easy  
3. **Trading** the original integral for a new one  
   

\[
   \int v\,du
   \]


   which you hope is easier.

This “trade” is the heart of the technique.

---

# 5. Fully Worked Examples  
## (With Explanations for Students Who Struggle)

---

## Example 1:  
### \(\int x e^x\,dx\)

Choose:



\[
u = x, \qquad dv = e^x dx
\]



Then:



\[
du = dx, \qquad v = e^x
\]



Apply the formula:



\[
\int x e^x dx = x e^x - \int e^x dx
\]





\[
= x e^x - e^x + C
\]



Factor:



\[
= e^x(x - 1) + C
\]



### Why this works

- Differentiating \(x\) simplifies it.
- Integrating \(e^x\) is easy.
- The new integral \(\int e^x dx\) is much simpler.

---

## Example 2:  
### \(\int x\cos x\,dx\)

Choose:



\[
u = x, \qquad dv = \cos x\,dx
\]



Then:



\[
du = dx, \qquad v = \sin x
\]



Apply:



\[
\int x\cos x\,dx = x\sin x - \int \sin x\,dx
\]





\[
= x\sin x + \cos x + C
\]



---

## Example 3:  
### \(\int \ln x\,dx\)

Rewrite:



\[
\int \ln x\,dx = \int \ln x \cdot 1\,dx
\]



Choose:



\[
u = \ln x, \qquad dv = dx
\]



Then:



\[
du = \frac{1}{x}dx, \qquad v = x
\]



Apply:



\[
\int \ln x\,dx = x\ln x - \int x\cdot \frac{1}{x}\,dx
\]





\[
= x\ln x - x + C
\]



### Why substitution fails here

- There is no simple \(u\)-substitution.
- Integration by parts works because \(\ln x\) becomes simpler when differentiated.

---

## Example 4:  
### \(\int \ln(x+2)\,dx\)

Rewrite:



\[
\int \ln(x+2)\,dx = \int \ln(x+2)\cdot 1\,dx
\]



Choose:



\[
u = \ln(x+2), \qquad dv = dx
\]



Then:



\[
du = \frac{1}{x+2}dx, \qquad v = x
\]



Apply:



\[
\int \ln(x+2)\,dx = x\ln(x+2) - \int x\frac{1}{x+2}\,dx
\]



Rewrite the integrand:



\[
\frac{x}{x+2} = 1 - \frac{2}{x+2}
\]



So:



\[
\int \ln(x+2)\,dx = x\ln(x+2) - x + 2\ln(x+2) + C
\]



Factor:



\[
= (x+2)\ln(x+2) - x + C
\]



---

## Example 5:  
### \(\int x^2 e^x\,dx\)

Choose:



\[
u = x^2, \qquad dv = e^x dx
\]



Then:



\[
du = 2x dx, \qquad v = e^x
\]



Apply:



\[
\int x^2 e^x dx = x^2 e^x - \int 2x e^x dx
\]



We already know:



\[
\int x e^x dx = e^x(x - 1)
\]



So:



\[
\int x^2 e^x dx = x^2 e^x - 2e^x(x - 1)
\]





\[
= e^x(x^2 - 2x + 2) + C
\]



### Pattern

Each application reduces the power of \(x\) by 1.

---

## Example 6:  
### \(\int e^x \cos x\,dx\)

Let:



\[
I = \int e^x \cos x\,dx
\]



Choose:



\[
u = \cos x, \qquad dv = e^x dx
\]



Then:



\[
du = -\sin x dx, \qquad v = e^x
\]



Apply:



\[
I = e^x\cos x + \int e^x \sin x\,dx
\]



Let:



\[
J = \int e^x \sin x\,dx
\]



Now integrate \(J\) by parts:

Choose:



\[
u = \sin x, \qquad dv = e^x dx
\]



Then:



\[
du = \cos x dx, \qquad v = e^x
\]



Apply:



\[
J = e^x\sin x - I
\]



Substitute back:



\[
I = e^x\cos x + e^x\sin x - I
\]



Solve:



\[
2I = e^x(\sin x + \cos x)
\]





\[
\boxed{I = \frac{e^x}{2}(\sin x + \cos x) + C}
\]



### Why this matters

- Some integrals “loop back” to themselves.
- You solve them algebraically.

---

# 6. Final Thoughts

Integration by parts is one of the most flexible tools in calculus. Once you understand:

- where the formula comes from,  
- how to choose \(u\) and \(dv\),  
- and what the formula is *trying* to do,  

the technique becomes far less intimidating.

The examples above cover the most common patterns you’ll see in homework, exams, and real applications.

If you’d like, I can add:

- a “common mistakes” section  
- a practice problem set  
- diagrams or graphs  
- a printable PDF version  

Just let me know.
