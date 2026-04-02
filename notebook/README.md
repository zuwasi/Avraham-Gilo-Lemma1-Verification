# TAU Researcher 1 & TAU Researcher 2 (2025) — Lemma 1 Verification & CRRA Application

## Purpose

This Mathematica notebook computationally verifies **Lemma 1** (and its proof in the Appendix) from:

> TAU Researcher 1, R. and TAU Researcher 2, D. (2025). *Insurance Collusion and Imperfect Competition when Insurers Increase Risk.* Working Paper, Tel Aviv University.

It then **applies Lemma 1(i) to CRRA utility consumers**, deriving the critical risk aversion threshold and demonstrating single-peaked insurance demand.

## Source Paper

- **Lemma 1** (pp. 10–11): Conditions under which aggregate insurance demand is single-peaked vs. monotonically decreasing in accident probability P.
- **Proof** (Appendix, pp. 24–26): Total differentiation of the FOC (Eq. 14), Arrow-Pratt substitution (Eq. 15–16), closed-form derivative (Eq. 17), and limit arguments.

## Prerequisites

- **Wolfram Mathematica** 12.0 or later (tested on 14.0)
- No external paclets required

## How to Run

1. Open `TAU_Researcher1_TAU_Researcher2_Lemma1_CRRA.nb` in Mathematica
2. Go to **Evaluate → Evaluate Notebook** (or Ctrl+A, Shift+Enter)
3. Use the interactive Manipulate panels (Section 8) to explore parameters

## Notebook Structure (12 Sections)

| Section | Content |
|---------|---------|
| 1 | Model setup and parameter definitions |
| 2 | Wealth in both states (W₁, W₂) |
| 3 | General utility framework and CRRA specialization |
| 4 | First-Order Condition (FOC) and numerical solver |
| 5 | **Proof verification**: Eq. 14–19 step by step |
| 6 | Numerical α*(P) curves for various γ |
| 7 | **CRRA application**: critical γ threshold and phase diagram |
| 8 | **Interactive Manipulate panels** (3 panels with sliders) |
| 9 | Data import interface (CSV or synthetic) |
| 10 | Validation report (6 automated tests) |
| 11 | Key findings summary |
| 12 | References |

## Interactive Panels (Section 8)

### Panel 1: Coverage Curve & Lemma 1 Diagnostic
- Sliders: W, H, q, γ
- Shows α*(P) curve with peak detection
- Real-time Lemma 1(i) vs 1(ii) classification

### Panel 2: Arrow-Pratt Decomposition
- Shows Ra(W₁), Ra(W₂) across P
- Numerator/Denominator of Eq. (17)
- dα*/dP derivative plot

### Panel 3: Aggregate Demand with Heterogeneous Consumers
- Distribution of γ types (uniform)
- Aggregate demand x(q,P) with peak P̄ identification

## Data Import

To use your own data, edit Section 9 and provide a CSV file with columns:
```
W, H, P, q, gamma
100, 40, 0.1, 1.3, 2.0
...
```

## Key Results

1. **Lemma 1 proof is correct** — all algebraic steps verified computationally
2. **CRRA utility satisfies Lemma 1(i)** when γ exceeds a critical threshold
3. **Critical γ** depends on W, H, q; for typical parameters γ_crit ≈ 1–3
4. **Empirically relevant CRRA values** (γ = 2–5) consistently produce single-peaked demand

## File Manifest

```
notebook/
├── README.md                          # This file
├── TAU_Researcher1_TAU_Researcher2_Lemma1_CRRA.nb       # Main notebook
└── exports/                           # For exported figures/tables
```

## Customization

- Change `modelParams` in Section 1 for different baseline parameters
- Add utility functions beyond CRRA by defining new `utilityPrime` and `arrowPratt` functions
- Extend aggregate demand (Section 8.3) with non-uniform θ distributions
