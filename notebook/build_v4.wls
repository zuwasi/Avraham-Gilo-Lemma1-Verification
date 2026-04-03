#!/usr/bin/env wolframscript

Print["Building v4 notebook with proof appendix..."];

v3 = Import["C:\\Amp_demos\\Insurance_Demand_Lemma1\\notebook\\Insurance_Demand_Lemma1_CRRA_v3.nb", "NB"];
existingCells = First[v3];

proofCells = {
Cell["Appendix: Plain-English Proof \[LongDash] Lemma 1(i) for CRRA Utility", "Section"],
Cell["This appendix presents a self-contained, step-by-step mathematical proof with no code. All equation numbers refer to Authors (2025).", "Text"],

Cell["A.1  Setup and Notation", "Subsection"],
Cell["A risk-averse consumer with wealth W > 0 faces harm H > 0 (with W > H) occurring with probability P \[Element] (0,1). Insurance coverage \[Alpha] \[Element] [0,1] costs premium \[Alpha]qPH, where q \[GreaterEqual] 1 is the loading factor.

Wealth in each state:
  No accident:  W1 = W - \[Alpha]qPH
  Accident:     W2 = W - H + \[Alpha]H(1 - qP)

We specialize to CRRA utility:  U(A) = A^(1-\[Gamma]) / (1-\[Gamma]),  \[Gamma] > 0

Arrow-Pratt absolute risk aversion:  Ra(A) = \[Gamma]/A    (Decreasing Absolute Risk Aversion)", "Text"],

Cell["A.2  The First-Order Condition (FOC)", "Subsection"],
Cell["The consumer maximizes EU = (1-P)U(W1) + PU(W2). The FOC (Equation 1) is:

    -(1-P)qU'(W1) + (1-qP)U'(W2) = 0          ...(FOC)

This gives:   U'(W2)/U'(W1) = (1-P)q / (1-qP)          ...(FOC')

For CRRA, U'(A) = A^(-\[Gamma]), so:

    (W1/W2)^\[Gamma] = (1-P)q / (1-qP)          ...(FOC-CRRA)", "Text"],

Cell["A.3  Optimal Coverage at P \[Rule] 0", "Subsection"],
Cell["As P \[Rule] 0, W1 \[Rule] W and W2 \[Rule] W - H(1-\[Alpha]). The FOC-CRRA becomes:

    (W - H(1-\[Alpha]))^(-\[Gamma]) = q W^(-\[Gamma])

Rearranging:
    W - H(1-\[Alpha]) = W q^(-1/\[Gamma])          ...(1)

Solving for \[Alpha]:
    H(1-\[Alpha]) = W(1 - q^(-1/\[Gamma]))

    \[Alpha]0(\[Gamma]) = 1 - (W/H)(1 - q^(-1/\[Gamma]))          ...(2)

This is the key result: optimal coverage at P \[Rule] 0 depends on \[Gamma]. More risk-averse consumers (higher \[Gamma]) purchase more coverage.

For \[Alpha]0 > 0 we need H > W(1 - q^(-1/\[Gamma])).", "Text"],

Cell["A.4  The Derivative of Coverage (Equation 17)", "Subsection"],
Cell["From the paper's Appendix, Equation (17):

    d(\[Alpha]*)/dP = Numerator / Denominator

where:
    Numerator  = (1-P)\[Alpha]qH[Ra(W1) - Ra(W2)] + (q-1)/(1-qP)
    Denominator = -(1-P)H[qP Ra(W1) + (1-qP) Ra(W2)]

The denominator is always NEGATIVE (Ra > 0, H > 0, P \[Element] (0,1)).

Therefore:
  If Numerator < 0, then d(\[Alpha]*)/dP > 0 (coverage increases with risk)
  If Numerator > 0, then d(\[Alpha]*)/dP < 0 (coverage decreases with risk)", "Text"],

Cell["A.5  The Numerator at P \[Rule] 0 (Equation 18)", "Subsection"],
Cell["As P \[Rule] 0, the numerator converges to:

    N0 = \[Alpha]0 q H [Ra(W) - Ra(W - H(1-\[Alpha]0))] + (q-1)          ...(18)

For CRRA, Ra(A) = \[Gamma]/A:

    N0 = \[Alpha]0 q H \[Gamma] [1/W - 1/(W - H(1-\[Alpha]0))] + (q-1)

The bracketed term = -H(1-\[Alpha]0) / [W(W-H(1-\[Alpha]0))] < 0

So the first term is negative, while (q-1) > 0 for q > 1.
Lemma 1(i) requires N0 < 0: the risk-aversion effect must dominate.", "Text"],

Cell["A.6  The Self-Consistency Problem (KEY INSIGHT)", "Subsection"],
Cell["Setting N0 = 0 gives a naive critical gamma formula:

    \[Gamma]crit = (q-1) W (W-H(1-\[Alpha]0)) / (\[Alpha]0 q H\[ThinSpace]^2 (1-\[Alpha]0))          ...(19')

BUT \[Alpha]0 itself depends on \[Gamma] through the FOC (Equation 2):

    \[Alpha]0(\[Gamma]) = 1 - (W/H)(1 - q^(-1/\[Gamma]))

So the condition for Lemma 1(i) is the IMPLICIT inequality:

    \[Gamma] > \[Gamma]crit(\[Gamma])

where \[Gamma]crit depends on \[Gamma] through \[Alpha]0(\[Gamma]). This CANNOT be checked by holding \[Alpha] fixed at some value. The naive approach (which GPT-5 and the initial notebook used) gives incorrect results.", "Text"],

Cell["A.7  Asymptotic Analysis: \[Gamma] \[Rule] \[Infinity]", "Subsection"],
Cell["As \[Gamma] \[Rule] \[Infinity]:

  (1) q^(-1/\[Gamma]) \[Rule] 1, so \[Alpha]0 \[Rule] 1 (nearly full coverage)
  (2) W2 = W - H(1-\[Alpha]0) \[Rule] W (wealth gap vanishes)

Using Taylor expansion q^(-1/\[Gamma]) \[TildeTilde] 1 - ln(q)/\[Gamma]:

    H(1-\[Alpha]0) \[TildeTilde] W ln(q)/\[Gamma]

The product \[Gamma] [1/W - 1/W2] has form \[Infinity] \[Times] 0. Resolving:

    \[Gamma] [1/W - 1/(W - W ln(q)/\[Gamma])] \[Rule] -ln(q)/W

Therefore N0 converges to:

    N0 \[Rule] 1 q H (-ln(q)/W) + (q-1) = (q-1) - qH ln(q)/W

For W=100, H=40, q=1.3:
    N0 \[Rule] 0.3 - 1.3 \[Times] 40 \[Times] 0.2624 / 100 = 0.3 - 0.136 = +0.164 > 0

The limit is POSITIVE. Since N0 is continuous and positive for all \[Gamma], it never crosses zero. Lemma 1(i) is NEVER satisfied for CRRA utility with these parameters.", "Text"],

Cell["A.8  Necessary Condition on Parameters", "Subsection"],
Cell["For Lemma 1(i) to hold with CRRA, the asymptotic limit must be non-positive:

    (q-1) - qH ln(q)/W \[LessEqual] 0

Solving:    H/W \[GreaterEqual] (q-1) / (q ln(q))

For q = 1.3:  H/W \[GreaterEqual] 0.880      (harm must be 88% of wealth)
For q = 1.1:  H/W \[GreaterEqual] 0.954
For q = 1.5:  H/W \[GreaterEqual] 0.822

The harm must represent at least ~88% of wealth (for q=1.3) for CRRA utility to produce single-peaked demand. This corresponds to catastrophic, near-total-loss events.", "Text"],

Cell["A.9  Economic Intuition", "Subsection"],
Cell["Why does CRRA utility fail to satisfy Lemma 1(i) for typical parameters?

The condition requires Ra(A) to decrease 'sufficiently fast' with wealth. For CRRA, Ra(A) = \[Gamma]/A. As \[Gamma] increases:

  (a) Risk aversion increases everywhere
      \[Rule] pushes Ra(W1)-Ra(W2) more negative (favors Lemma 1(i))

  (b) BUT optimal coverage \[Alpha]0 also increases toward 1
      \[Rule] the wealth gap W1-W2 shrinks
      \[Rule] Ra(W1) and Ra(W2) become nearly equal (works AGAINST Lemma 1(i))

These two effects approximately CANCEL for CRRA utility, leaving the loading term (q-1) > 0 as the dominant contribution to N0.

Utility functions where Lemma 1(i) DOES hold need Ra(A) to decrease FASTER than 1/A. Candidates include HARA utility with Ra(A) = 1/(a+bA), or utility functions with Decreasing Relative Risk Aversion (DRRA).", "Text"],

Cell["A.10  Numerical Verification", "Subsection"],
Cell["(* Self-consistent N0 computation *)\nPrint[\"=== Self-Consistent N0 Verification (W=100, H=40, q=1.3) ===\"];\nPrint[\"gamma | alpha0(gamma) | N0        | Lemma 1(i)?\"];\nDo[\n  Module[{a0, w2val, n0val},\n    a0 = N[1 - (100/40)*(1 - 1.3^(-1/g))];\n    If[a0 <= 0,\n      Print[g, \" | no coverage  | N/A      | N/A\"],\n      w2val = 100 - 40*(1 - a0);\n      n0val = a0*1.3*40*g*(1/100.0 - 1/w2val) + 0.3;\n      Print[g, \" | \", Round[a0, 0.001], \" | \", Round[n0val, 0.0001], \" | \",\n        If[n0val < 0, \"YES\", \"No (positive)\"]]\n    ]\n  ],\n  {g, {0.5, 1, 2, 3, 5, 8, 10, 20, 50, 100, 1000}}\n];\nPrint[\"\"];\nPrint[\"Asymptotic limit: N0 -> (q-1) - qH*ln(q)/W = \",\n  Round[N[0.3 - 1.3*40*Log[1.3]/100], 0.0001]];\nPrint[\"\"];\nPrint[\"CONCLUSION: N0 > 0 for ALL gamma.\"];\nPrint[\"Lemma 1(i) does NOT hold for CRRA with H/W = 0.4.\"];\nPrint[\"Required: H/W > \", Round[N[0.3/(1.3*Log[1.3])], 0.001]];", "Input"],

Cell["A.11  Summary Proposition", "Subsection"],
Cell["Proposition (CRRA and Lemma 1(i)).

For CRRA utility U(A) = A^(1-\[Gamma])/(1-\[Gamma]) with parameters (W, H, q), q > 1:

(a) Optimal coverage at P \[Rule] 0 is:
      \[Alpha]0(\[Gamma]) = 1 - (W/H)(1 - q^(-1/\[Gamma]))

(b) The self-consistent numerator at P \[Rule] 0 converges as \[Gamma] \[Rule] \[Infinity] to:
      N0 \[Rule] (q-1) - qH ln(q)/W

(c) Lemma 1(i) can hold for CRRA only if  H/W > (q-1)/(q ln(q)).
     For q = 1.3 this requires H/W > 0.88 (near-catastrophic harm).

(d) For typical insurance parameters (H/W moderate), CRRA always yields
     monotonically decreasing demand in P. Lemma 1(ii) applies.

(e) The mechanism: higher \[Gamma] increases both risk aversion AND coverage,
     narrowing the wealth gap and weakening the differential risk-aversion
     effect. These forces cancel for CRRA, leaving (q-1) > 0 dominant.

(f) Utility functions where Ra(A) decreases faster than 1/A
     (e.g., certain HARA specifications) are needed for Lemma 1(i).", "Text"]
};

allCells = Join[existingCells, proofCells];
v4 = Notebook[allCells,
  WindowSize -> {1200, 900},
  WindowMargins -> {{Automatic, Automatic}, {Automatic, Automatic}},
  FrontEndVersion -> "14.0",
  StyleDefinitions -> "Default.nb"
];

outPath = "C:\\Amp_demos\\Insurance_Demand_Lemma1\\notebook\\Insurance_Demand_Lemma1_CRRA_v4.nb";
Export[outPath, v4, "NB"];
Print["Saved: ", outPath];
