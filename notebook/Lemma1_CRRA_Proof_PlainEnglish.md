# Lemma 1(i) Applied to CRRA Utility: A Step-by-Step Proof

**Based on:** Author A. and Author B. (2025), *Insurance Collusion and Imperfect Competition when Insurers Increase Risk*

**Prepared for:** the lead author

---

## 1. Setup and Notation

We adopt the model from the paper. A risk-averse consumer with initial wealth $W > 0$ faces a potential harm $H > 0$ (with $W > H$) that occurs with probability $P \in (0,1)$. The consumer can purchase insurance coverage $\alpha \in [0,1]$ at a premium of $\alpha q P H$, where $q \geq 1$ is the loading factor ($q = 1$ is actuarially fair; $q > 1$ is supra-competitive).

The consumer's wealth in each state is:

- **No accident:** $W_1 = W - \alpha q P H$
- **Accident:** $W_2 = W - \alpha q P H - (1-\alpha)H = W - H + \alpha H(1 - qP)$

Note that for $q > 1$ and $P < 1/q$, we have $W_1 > W_2$ (the consumer is wealthier in the no-accident state).

We specialize to **CRRA (Constant Relative Risk Aversion) utility**:

$$U(A) = \frac{A^{1-\gamma}}{1-\gamma}, \quad \gamma > 0, \quad \gamma \neq 1$$

with the Arrow-Pratt absolute risk aversion coefficient:

$$R_a(A) = -\frac{U''(A)}{U'(A)} = \frac{\gamma}{A}$$

This is a **Decreasing Absolute Risk Aversion (DARA)** utility: $R_a(A)$ decreases as wealth $A$ increases.

---

## 2. The First-Order Condition (FOC)

The consumer maximizes expected utility $EU = (1-P) \cdot U(W_1) + P \cdot U(W_2)$ with respect to $\alpha$. The first-order condition is (Equation 1 in the paper):

$$-(1-P) \cdot q \cdot U'(W_1) + (1-qP) \cdot U'(W_2) = 0 \tag{FOC}$$

This can be rearranged to express the marginal utility ratio:

$$\frac{U'(W_2)}{U'(W_1)} = \frac{(1-P)q}{1-qP} \tag{FOC'}$$

For CRRA utility, $U'(A) = A^{-\gamma}$, so the FOC becomes:

$$\frac{W_1^{-\gamma}}{W_2^{-\gamma}} = \frac{(1-P)q}{1-qP}$$

which simplifies to:

$$\left(\frac{W_2}{W_1}\right)^{\gamma} = \frac{(1-P)q}{1-qP} \tag{FOC-CRRA}$$

---

## 3. Optimal Coverage at P → 0

As $P \to 0$:
- $W_1 \to W$ (no premium is paid)
- $W_2 \to W - H(1-\alpha)$

The FOC-CRRA at $P \to 0$ becomes:

$$\left(\frac{W - H(1-\alpha)}{W}\right)^{\gamma} = q \cdot 1 = q$$

Wait — let us be more careful. The FOC is $-(1-P)q \cdot U'(W_1) + (1-qP) \cdot U'(W_2) = 0$. At $P = 0$ this gives $-q \cdot U'(W) + U'(W - H(1-\alpha)) = 0$, i.e.:

$$U'(W - H(1-\alpha)) = q \cdot U'(W)$$

For CRRA:

$$(W - H(1-\alpha))^{-\gamma} = q \cdot W^{-\gamma}$$

Rearranging:

$$W - H(1-\alpha) = W \cdot q^{-1/\gamma} \tag{1}$$

Solving for $\alpha$:

$$H(1-\alpha) = W(1 - q^{-1/\gamma})$$

$$\boxed{\alpha_0(\gamma) = 1 - \frac{W}{H}\left(1 - q^{-1/\gamma}\right)} \tag{2}$$

**This is the optimal coverage at $P \to 0$ for a CRRA consumer with coefficient $\gamma$.** Note that $\alpha_0$ depends on $\gamma$: more risk-averse consumers (higher $\gamma$) purchase more coverage.

**Remark.** For $\alpha_0 > 0$ we need $W(1 - q^{-1/\gamma}) < H$, i.e., $H > W(1 - q^{-1/\gamma})$. For our baseline parameters ($W = 100$, $H = 40$, $q = 1.3$), this holds for all $\gamma \gtrsim 0.8$.

---

## 4. Equation (17): The Derivative of Coverage with Respect to P

The key result from the Appendix (Equation 17) gives the derivative of optimal coverage with respect to accident probability:

$$\frac{\partial \alpha^*}{\partial P} = \frac{(1-P)\alpha^* q H \left[R_a(W_1) - R_a(W_2)\right] + \frac{q-1}{1-qP}}{-(1-P)H\left[qP \cdot R_a(W_1) + (1-qP) \cdot R_a(W_2)\right]} \tag{17}$$

**Analysis of the denominator.** Since $R_a > 0$, $H > 0$, and $P \in (0,1)$, the denominator is always **negative**.

**Therefore, the sign of $\partial \alpha^*/\partial P$ is determined by the sign of the numerator with a sign flip** (negative divided by negative is positive, and so on).

Specifically:
- If the **numerator < 0**, then $\partial \alpha^*/\partial P > 0$ (coverage increases with risk)
- If the **numerator > 0**, then $\partial \alpha^*/\partial P < 0$ (coverage decreases with risk)

---

## 5. The Numerator at P → 0 (Equation 18)

As $P \to 0$, the numerator of Equation (17) converges to:

$$N_0 = \alpha_0 \cdot q \cdot H \cdot \left[R_a(W) - R_a(W - H(1-\alpha_0))\right] + (q-1) \tag{18}$$

For CRRA utility, substituting $R_a(A) = \gamma/A$:

$$N_0 = \alpha_0 \cdot q \cdot H \cdot \gamma \cdot \left[\frac{1}{W} - \frac{1}{W - H(1-\alpha_0)}\right] + (q-1)$$

Since $W > W - H(1-\alpha_0)$ (for $\alpha_0 < 1$), the bracketed term is **negative**:

$$\frac{1}{W} - \frac{1}{W - H(1-\alpha_0)} = \frac{-H(1-\alpha_0)}{W \cdot (W - H(1-\alpha_0))} < 0$$

So the first term of $N_0$ is negative, while the second term $(q-1) > 0$ for $q > 1$.

**Lemma 1(i) requires $N_0 < 0$**, meaning the risk-aversion effect must dominate the loading effect.

---

## 6. Derivation of the Critical Gamma

Setting $N_0 = 0$ and solving for $\gamma$:

$$\alpha_0 \cdot q \cdot H^2 \cdot \gamma_{\text{crit}} \cdot \frac{(1-\alpha_0)}{W \cdot (W - H(1-\alpha_0))} = q - 1$$

$$\boxed{\gamma_{\text{crit}} = \frac{(q-1) \cdot W \cdot (W - H(1-\alpha_0))}{\alpha_0 \cdot q \cdot H^2 \cdot (1-\alpha_0)}} \tag{19'}$$

**For $\gamma > \gamma_{\text{crit}}$:** the numerator $N_0 < 0$, so $\partial \alpha^*/\partial P > 0$ near $P = 0$, and **Lemma 1(i) holds** (single-peaked demand).

**For $\gamma < \gamma_{\text{crit}}$:** the numerator $N_0 > 0$, so coverage decreases with $P$ even near $P = 0$.

---

## 7. The Self-Consistency Problem: α₀ Depends on γ

**This is the key subtlety.** The critical gamma formula (19') contains $\alpha_0$, but $\alpha_0$ itself depends on $\gamma$ through the FOC (Equation 2):

$$\alpha_0(\gamma) = 1 - \frac{W}{H}\left(1 - q^{-1/\gamma}\right)$$

So $\gamma_{\text{crit}}$ is not a simple closed-form number — it is defined by a **self-consistency condition**: we need $\gamma > \gamma_{\text{crit}}(\gamma)$, where $\gamma_{\text{crit}}$ depends on $\gamma$ through $\alpha_0(\gamma)$.

### Substituting α₀(γ) into the Critical Gamma Formula

From Equation (1), we know that at $P = 0$:

$$W - H(1-\alpha_0) = W \cdot q^{-1/\gamma}$$

and

$$H(1-\alpha_0) = W(1 - q^{-1/\gamma})$$

Substituting into (19'):

$$\gamma_{\text{crit}} = \frac{(q-1) \cdot W \cdot W q^{-1/\gamma}}{\alpha_0(\gamma) \cdot q \cdot H^2 \cdot \frac{W(1 - q^{-1/\gamma})}{H}}$$

$$= \frac{(q-1) \cdot W^2 \cdot q^{-1/\gamma}}{\alpha_0(\gamma) \cdot q \cdot H \cdot W \cdot (1 - q^{-1/\gamma})}$$

$$= \frac{(q-1) \cdot W \cdot q^{-1/\gamma}}{\alpha_0(\gamma) \cdot q \cdot H \cdot (1 - q^{-1/\gamma})}$$

where $\alpha_0(\gamma) = 1 - \frac{W}{H}(1 - q^{-1/\gamma})$.

Let us introduce $\beta \equiv q^{-1/\gamma} \in (0,1)$ for clarity. Then:

- $\alpha_0 = 1 - \frac{W}{H}(1-\beta) = \frac{H - W + W\beta}{H} = \frac{H - W(1-\beta)}{H}$
- $\gamma = -\frac{\ln q}{\ln \beta}$ (since $\beta = q^{-1/\gamma}$)

The critical gamma formula becomes:

$$\gamma_{\text{crit}} = \frac{(q-1) \cdot W \cdot \beta}{\frac{H - W(1-\beta)}{H} \cdot q \cdot H \cdot (1-\beta)} = \frac{(q-1) \cdot W \cdot \beta}{(H - W + W\beta) \cdot q \cdot (1-\beta)} \tag{20}$$

### The Self-Consistent Condition

**Lemma 1(i) holds for CRRA utility if and only if:**

$$\gamma > \frac{(q-1) \cdot W \cdot q^{-1/\gamma}}{(H - W + W \cdot q^{-1/\gamma}) \cdot q \cdot (1 - q^{-1/\gamma})} \tag{SC}$$

This is an **implicit inequality** in $\gamma$. It cannot be solved in closed form but is easily solved numerically for any given $(W, H, q)$.

---

## 8. Numerical Verification — The Surprising Result

### Baseline Parameters: W = 100, H = 40, q = 1.3

Computing $N_0$ using the **self-consistent** $\alpha_0(\gamma)$ from the FOC:

| $\gamma$ | $\alpha_0(\gamma)$ | $N_0$ | Lemma 1(i)? |
|-----------|-------------------|-------|-------------|
| 0.5 | ≤ 0 (no coverage) | N/A | N/A |
| 1.0 | 0.423 | +0.234 | No |
| 2.0 | 0.693 | +0.199 | No |
| 3.0 | 0.791 | +0.187 | No |
| 5.0 | 0.872 | +0.178 | No |
| 8.0 | 0.919 | +0.173 | No |
| 10.0 | 0.935 | +0.171 | No |
| 50.0 | 0.987 | +0.165 | No |
| 1000 | 0.999 | +0.164 | No |

**The numerator $N_0$ is always positive and converges to $(q-1) > 0$ as $\gamma \to \infty$.** It never becomes negative.

### Why This Happens: The Asymptotic Argument

As $\gamma \to \infty$:

1. $q^{-1/\gamma} \to 1$, so $\alpha_0 \to 1$ (nearly full coverage)
2. $W_2 = W - H(1-\alpha_0) \to W$ (wealth gap vanishes)
3. The risk-aversion term in $N_0$ is $\alpha_0 \cdot q \cdot H \cdot \gamma \cdot [1/W - 1/W_2]$

The product $\gamma \cdot [1/W - 1/W_2]$ has an indeterminate form ($\infty \cdot 0$) as $\gamma \to \infty$. Applying L'Hôpital's rule (or direct Taylor expansion of $q^{-1/\gamma}$ around $1/\gamma = 0$):

$$q^{-1/\gamma} \approx 1 - \frac{\ln q}{\gamma} + O(1/\gamma^2)$$

So:

$$H(1-\alpha_0) = W(1 - q^{-1/\gamma}) \approx \frac{W \ln q}{\gamma}$$

$$W_2 = W - H(1-\alpha_0) \approx W - \frac{W \ln q}{\gamma}$$

Therefore:

$$\gamma \cdot \left[\frac{1}{W} - \frac{1}{W_2}\right] = \gamma \cdot \frac{-(W - W_2)}{W \cdot W_2} \approx \gamma \cdot \frac{-W\ln q / \gamma}{W \cdot W} = \frac{-\ln q}{W}$$

Substituting into $N_0$ (with $\alpha_0 \to 1$):

$$N_0 \to 1 \cdot q \cdot H \cdot \frac{-\ln q}{W} + (q-1) = (q-1) - \frac{qH \ln q}{W}$$

For our parameters ($W = 100$, $H = 40$, $q = 1.3$):

$$N_0 \to 0.3 - \frac{1.3 \times 40 \times 0.2624}{100} = 0.3 - 0.1364 = 0.1636 > 0$$

**The limit is positive.** This means $N_0$ remains positive for all $\gamma$, and the self-consistent condition for Lemma 1(i) is never satisfied.

### The General Condition on Parameters

Setting the asymptotic limit to zero:

$$(q-1) - \frac{qH \ln q}{W} = 0$$

$$\frac{H}{W} = \frac{q-1}{q \ln q}$$

For $q = 1.3$: $H/W$ must exceed $\frac{0.3}{1.3 \times 0.2624} = 0.880$. That is, $H > 0.880 \cdot W$.

**Lemma 1(i) can hold for CRRA consumers only when the harm-to-wealth ratio is sufficiently large** (the accident must be financially devastating relative to total wealth).

### Verification with Large H/W Ratios

| $W$ | $H$ | $H/W$ | $q$ | Does $N_0 < 0$ for some $\gamma$? |
|-----|-----|-------|-----|----------------------------------|
| 100 | 40  | 0.40  | 1.3 | **No** — always positive |
| 100 | 80  | 0.80  | 1.3 | **No** — still positive (threshold is 0.88) |
| 100 | 95  | 0.95  | 1.3 | **Yes** — $N_0 < 0$ for $\gamma \gtrsim 5$ |

### Implication for the Paper

**This is an important negative result for CRRA utility.** The condition in Lemma 1(i) requires that absolute risk aversion $R_a(A) = \gamma/A$ decrease "sufficiently fast" (Equation 19 in the paper). For CRRA, the rate of decrease is governed by $R_a'(A) = -\gamma/A^2$, which — despite being proportional to $\gamma$ — becomes arbitrarily slow in relative terms as $\alpha_0 \to 1$ and the wealth gap $W_1 - W_2$ closes.

In economic terms: as $\gamma$ increases, the consumer buys more coverage, which *narrows the wealth gap between states*, which *reduces the difference in risk aversion across states*, which *weakens the very mechanism that Lemma 1(i) relies on*. The coverage effect and the risk-aversion effect approximately cancel each other out for CRRA utility, leaving the loading term $(q-1) > 0$ dominant.

**Utility functions where Lemma 1(i) does hold** would need $R_a(A)$ to decrease faster than $1/A$ — for example, utility functions with *Hyperbolic Absolute Risk Aversion (HARA)* where $R_a(A) = 1/(a + bA)$ with appropriate parameters, or utility functions exhibiting *Decreasing Relative Risk Aversion (DRRA)*.

---

## 9. The P → 1 Argument (Completing the Proof)

Even when $\gamma > \gamma^*$ so that coverage *increases* with $P$ near $P = 0$, we must verify that coverage eventually *decreases* as $P \to 1$ to establish the single-peaked shape.

As $P \to 1$:

1. **$\alpha^* \to 0$**: When accidents are nearly certain, the insurance premium approaches $\alpha q H$ (essentially paying $q$ times the harm), making insurance unattractive for $q > 1$.

2. **The bracket on the LHS of Equation (14)** converges to $H(1-q)^2 U''(W_2) < 0$ (since $U'' < 0$ and $(1-q)^2 > 0$).

3. **The RHS of Equation (14)** converges to $q[U'(W_2) - U'(W_1)]$. Since $\alpha^* \to 0$ means $W_1 \approx W - qH$ and $W_2 \approx W - H$, and because $q > 1$ implies $W_1 < W_2$, concavity gives $U'(W_1) > U'(W_2)$, so the RHS is **negative**... 

Actually, let us reconsider. As $P \to 1$ with $\alpha^* \to 0$: $W_1 = W - \alpha^* q P H \to W$ and $W_2 = W - H + \alpha^* H(1-qP) \to W - H$. So $W_1 > W_2$, hence $U'(W_1) < U'(W_2)$ (by concavity), and the RHS converges to $q[U'(W_2) - U'(W_1)] > 0$.

4. **Dividing a positive RHS by a negative LHS bracket** gives $\partial \alpha^*/\partial P < 0$.

**Conclusion:** Since $\partial \alpha^*/\partial P > 0$ near $P = 0$ (by our condition) and $\partial \alpha^*/\partial P < 0$ near $P = 1$, by continuity there exists some $\bar{P} \in (0,1)$ that maximizes $\alpha^*(P)$. This establishes the single-peaked structure of Lemma 1(i). $\blacksquare$

---

## 10. Summary of Results

**Theorem (CRRA and Lemma 1(i)).** *For CRRA utility $U(A) = A^{1-\gamma}/(1-\gamma)$ with parameters $(W, H, q)$ where $q > 1$:*

*(a) The optimal coverage at $P \to 0$ is $\alpha_0(\gamma) = 1 - \frac{W}{H}(1 - q^{-1/\gamma})$.*

*(b) The self-consistent numerator at $P \to 0$ converges as $\gamma \to \infty$ to:*

$$N_0 \to (q-1) - \frac{qH\ln q}{W}$$

*(c) Lemma 1(i) can hold for CRRA utility only if $\frac{H}{W} > \frac{q-1}{q\ln q}$, i.e., only when the harm is a sufficiently large fraction of wealth. For $q = 1.3$, this requires $H/W > 0.88$.*

*(d) For typical insurance parameters where $H/W$ is moderate (e.g., $H/W = 0.4$), the CRRA utility always produces monotonically decreasing demand (Lemma 1(ii) applies). The DARA property of CRRA ($R_a = \gamma/A$) decreases too slowly to satisfy the condition in Lemma 1(i).*

*(e) The economic mechanism: higher $\gamma$ simultaneously increases risk aversion AND increases coverage $\alpha_0$, which narrows the wealth gap $W_1 - W_2$ and weakens the differential risk-aversion effect. These two forces approximately cancel for CRRA utility.*

*(f) Utility functions where $R_a(A)$ decreases faster than $1/A$ — such as certain HARA specifications or DRRA preferences — are candidates where Lemma 1(i) would hold.*

---

## References

1. Author A. and Author B. (2025). Insurance Collusion and Imperfect Competition when Insurers Increase Risk. Working Paper.
2. Arrow, K.J. (1965). Aspects of the Theory of Risk-Bearing. Yrjö Jahnsson Lectures.
3. Pratt, J.W. (1964). Risk Aversion in the Small and in the Large. *Econometrica*, 32(1-2), 122–136.
4. Friend, I. and Blume, M.E. (1975). The Demand for Risky Assets. *American Economic Review*, 65(5), 900–922.
5. Mehra, R. and Prescott, E.C. (1985). The Equity Premium: A Puzzle. *Journal of Monetary Economics*, 15(2), 145–161.
