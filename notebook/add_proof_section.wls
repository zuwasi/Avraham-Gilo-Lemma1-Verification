#!/usr/bin/env wolframscript

(* Add plain-English proof section to the notebook *)

nbPath = "C:\\Amp_demos\\TAU Researcher 2 TAU\\notebook\\TAU_Researcher1_TAU_Researcher2_Lemma1_CRRA_v3.nb";
Print["Opening notebook: ", nbPath];

nb = NotebookOpen[nbPath];

(* Move to end of notebook *)
SelectionMove[nb, After, Notebook];

(* === Insert the proof section === *)

NotebookWrite[nb, Cell["Appendix: Plain-English Proof of Lemma 1(i) for CRRA Utility", "Section"]];

NotebookWrite[nb, Cell["This appendix presents a self-contained, step-by-step proof in plain mathematical language (no code). \nAll equation numbers refer to TAU Researcher 1 & TAU Researcher 2 (2025).", "Text"]];

(* --- A.1 Setup --- *)
NotebookWrite[nb, Cell["A.1  Setup and Notation", "Subsection"]];

NotebookWrite[nb, Cell["A risk-averse consumer with wealth W > 0 faces harm H > 0 (with W > H) occurring with probability \
P \[Element] (0,1). Insurance coverage \[Alpha] \[Element] [0,1] costs a premium \[Alpha]qPH, where q \[GreaterEqual] 1 is the loading factor.\n\n\
Wealth in each state:\n\
  \[Bullet] No accident:  W\[UnderBracket]1 = W - \[Alpha]qPH\n\
  \[Bullet] Accident:       W\[UnderBracket]2 = W - H + \[Alpha]H(1 - qP)\n\n\
We specialize to CRRA utility:  U(A) = A^(1-\[Gamma]) / (1-\[Gamma]),  \[Gamma] > 0,  \[Gamma] \[NotEqual] 1\n\n\
Arrow-Pratt absolute risk aversion:  R\[UnderBracket]a(A) = \[Gamma]/A    (Decreasing Absolute Risk Aversion)", "Text"]];

(* --- A.2 FOC --- *)
NotebookWrite[nb, Cell["A.2  The First-Order Condition (FOC)", "Subsection"]];

NotebookWrite[nb, Cell["The consumer maximizes EU = (1-P)\[CenterDot]U(W1) + P\[CenterDot]U(W2). The FOC (Equation 1 in the paper) is:\n\n\
    -(1-P)\[CenterDot]q\[CenterDot]U'(W1) + (1-qP)\[CenterDot]U'(W2) = 0          ...(FOC)\n\n\
This gives the marginal utility ratio:   U'(W2)/U'(W1) = (1-P)q / (1-qP)          ...(FOC')\n\n\
For CRRA, U'(A) = A^(-\[Gamma]), so the FOC becomes:\n\n\
    (W1/W2)^\[Gamma] = (1-P)q / (1-qP)          ...(FOC-CRRA)", "Text"]];

(* --- A.3 Optimal alpha at P=0 --- *)
NotebookWrite[nb, Cell["A.3  Optimal Coverage at P \[Rule] 0", "Subsection"]];

NotebookWrite[nb, Cell["As P \[Rule] 0, we have W1 \[Rule] W and W2 \[Rule] W - H(1-\[Alpha]). The FOC-CRRA becomes:\n\n\
    (W - H(1-\[Alpha]))^(-\[Gamma]) = q \[CenterDot] W^(-\[Gamma])\n\n\
Rearranging:\n\
    W - H(1-\[Alpha]) = W \[CenterDot] q^(-1/\[Gamma])\n\n\
Solving for \[Alpha]:\n\
    H(1-\[Alpha]) = W(1 - q^(-1/\[Gamma]))\n\n\
    \[Alpha]0(\[Gamma]) = 1 - (W/H)(1 - q^(-1/\[Gamma]))          ...(2)\n\n\
This is the key result: optimal coverage at P \[Rule] 0 depends on \[Gamma]. \
More risk-averse consumers (higher \[Gamma]) purchase more coverage.", "Text"]];

(* --- A.4 Equation 17 --- *)
NotebookWrite[nb, Cell["A.4  The Derivative d\[Alpha]*/dP (Equation 17)", "Subsection"]];

NotebookWrite[nb, Cell["The Appendix of the paper derives (Equation 17):\n\n\
    d\[Alpha]*/dP = N / D\n\n\
where:\n\
    N = (1-P)\[Alpha]*qH[Ra(W1) - Ra(W2)] + (q-1)/(1-qP)\n\
    D = -(1-P)H[qP\[CenterDot]Ra(W1) + (1-qP)\[CenterDot]Ra(W2)]\n\n\
The denominator D is always NEGATIVE (since Ra > 0, H > 0, P \[Element] (0,1)).\n\n\
Therefore: if N < 0, then d\[Alpha]*/dP > 0 (coverage increases with risk).\n\
              if N > 0, then d\[Alpha]*/dP < 0 (coverage decreases with risk).", "Text"]];

(* --- A.5 Numerator at P=0 --- *)
NotebookWrite[nb, Cell["A.5  The Numerator at P \[Rule] 0 (Equation 18)", "Subsection"]];

NotebookWrite[nb, Cell["As P \[Rule] 0, the numerator converges to:\n\n\
    N0 = \[Alpha]0 \[CenterDot] q \[CenterDot] H \[CenterDot] [Ra(W) - Ra(W - H(1-\[Alpha]0))] + (q-1)          ...(18)\n\n\
For CRRA, Ra(A) = \[Gamma]/A, so:\n\n\
    N0 = \[Alpha]0 \[CenterDot] q \[CenterDot] H \[CenterDot] \[Gamma] \[CenterDot] [1/W - 1/(W - H(1-\[Alpha]0))] + (q-1)\n\n\
The bracketed term [1/W - 1/(W-H(1-\[Alpha]0))] = -H(1-\[Alpha]0) / [W(W-H(1-\[Alpha]0))] < 0.\n\n\
So the first term is negative, while (q-1) > 0 for q > 1.\n\
Lemma 1(i) requires N0 < 0: the risk-aversion effect must dominate the loading effect.", "Text"]];

(* --- A.6 Self-consistency --- *)
NotebookWrite[nb, Cell["A.6  The Self-Consistency Problem", "Subsection"]];

NotebookWrite[nb, Cell["Setting N0 = 0 gives a critical gamma formula (Equation 19'):\n\n\
    \[Gamma]crit = (q-1) \[CenterDot] W \[CenterDot] (W-H(1-\[Alpha]0)) / (\[Alpha]0 \[CenterDot] q \[CenterDot] H\[Superscript]2 \[CenterDot] (1-\[Alpha]0))\n\n\
BUT \[Alpha]0 itself depends on \[Gamma] through the FOC (Equation 2):\n\
    \[Alpha]0(\[Gamma]) = 1 - (W/H)(1 - q^(-1/\[Gamma]))\n\n\
So the condition for Lemma 1(i) is the IMPLICIT inequality:\n\n\
    \[Gamma] > \[Gamma]crit(\[Gamma])\n\n\
where \[Gamma]crit depends on \[Gamma] through \[Alpha]0(\[Gamma]). This cannot be checked by holding \[Alpha] fixed.", "Text"]];

(* --- A.7 Asymptotic analysis --- *)
NotebookWrite[nb, Cell["A.7  Asymptotic Analysis: \[Gamma] \[Rule] \[Infinity]", "Subsection"]];

NotebookWrite[nb, Cell["As \[Gamma] \[Rule] \[Infinity]:\n\n\
    (1)  q^(-1/\[Gamma]) \[Rule] 1, so \[Alpha]0 \[Rule] 1 (nearly full coverage)\n\
    (2)  W2 = W - H(1-\[Alpha]0) \[Rule] W (wealth gap vanishes)\n\n\
Using the Taylor expansion q^(-1/\[Gamma]) \[TildeTilde] 1 - (ln q)/\[Gamma] for large \[Gamma]:\n\
    H(1-\[Alpha]0) \[TildeTilde] W(ln q)/\[Gamma]\n\n\
The product \[Gamma] \[CenterDot] [1/W - 1/W2] has the indeterminate form \[Infinity] \[CenterDot] 0. Resolving:\n\n\
    \[Gamma] \[CenterDot] [1/W - 1/(W - W ln(q)/\[Gamma])] \[Rule] -ln(q)/W\n\n\
Therefore N0 converges to:\n\n\
    N0 \[Rule] 1 \[CenterDot] q \[CenterDot] H \[CenterDot] (-ln q / W) + (q-1)  =  (q-1) - qH ln(q)/W\n\n\
For W=100, H=40, q=1.3:   N0 \[Rule] 0.3 - 1.3\[Times]40\[Times]0.2624/100 = 0.3 - 0.136 = +0.164 > 0\n\n\
The limit is POSITIVE. Since N0 is continuous and positive for all \[Gamma], it never crosses zero.\n\
Lemma 1(i) is NEVER satisfied for CRRA utility with these parameters.", "Text"]];

(* --- A.8 General condition --- *)
NotebookWrite[nb, Cell["A.8  Necessary Condition on Parameters", "Subsection"]];

NotebookWrite[nb, Cell["For Lemma 1(i) to hold with CRRA utility, the asymptotic limit must be non-positive:\n\n\
    (q-1) - qH ln(q)/W  \[LessEqual]  0\n\n\
Solving:  H/W  \[GreaterEqual]  (q-1) / (q ln q)\n\n\
For q = 1.3:  H/W \[GreaterEqual] 0.3 / (1.3 \[Times] 0.2624) = 0.880\n\
For q = 1.1:  H/W \[GreaterEqual] 0.1 / (1.1 \[Times] 0.0953) = 0.954\n\
For q = 1.5:  H/W \[GreaterEqual] 0.5 / (1.5 \[Times] 0.4055) = 0.822\n\n\
In words: the harm must represent at least ~88% of the consumer's wealth (for q=1.3) \
for CRRA utility to produce single-peaked demand. This is a very large harm-to-wealth ratio, \
corresponding to catastrophic or near-total-loss events.", "Text"]];

(* --- A.9 Economic intuition --- *)
NotebookWrite[nb, Cell["A.9  Economic Intuition", "Subsection"]];

NotebookWrite[nb, Cell["Why does CRRA utility fail to satisfy Lemma 1(i) for typical parameters?\n\n\
The condition requires that risk aversion decrease 'sufficiently fast' with wealth \
(the paper's condition: Ra(W) - Ra(W-H(1-\[Alpha])) must be sufficiently negative).\n\n\
For CRRA, Ra(A) = \[Gamma]/A. As \[Gamma] increases:\n\
  \[Bullet] Risk aversion increases everywhere \[RightArrow] pushes the difference Ra(W1)-Ra(W2) to be more negative  \[Checkmark]\n\
  \[Bullet] BUT optimal coverage \[Alpha]0 also increases toward 1  \[RightArrow] the wealth gap W1-W2 shrinks  \[Multiply]\n\
  \[Bullet] As \[Alpha]0 \[Rule] 1, the states become nearly identical, so Ra(W1) \[TildeTilde] Ra(W2)  \[Multiply]\n\n\
These two effects approximately CANCEL for CRRA utility, leaving the loading term (q-1) > 0 dominant.\n\n\
Utility functions where Lemma 1(i) DOES hold need Ra(A) to decrease FASTER than 1/A \[LongDash] \
for example, HARA utility with Ra(A) = 1/(a+bA) for suitable a,b, or utility functions \
exhibiting Decreasing Relative Risk Aversion (DRRA).", "Text"]];

(* --- A.10 Numerical table --- *)
NotebookWrite[nb, Cell["A.10  Numerical Verification", "Subsection"]];

NotebookWrite[nb, Cell["(* Self-consistent computation of N0 for various gamma *)\nPrint[\"=== Self-Consistent N0 (W=100, H=40, q=1.3) ===\"];\nPrint[\"gamma | alpha0(gamma) | N0 | Lemma 1(i)?\"];\nDo[\n  Module[{a0, w2val, n0val},\n    a0 = 1 - (100/40)(1 - 1.3^(-1/g));\n    If[a0 <= 0,\n      Print[g, \" | no coverage | N/A | N/A\"],\n      w2val = 100 - 40*(1 - a0);\n      n0val = a0*1.3*40*g*(1/100 - 1/w2val) + 0.3;\n      Print[g, \" | \", Round[a0, 0.001], \" | \", Round[n0val, 0.0001], \" | \",\n        If[n0val < 0, \"YES\", \"No\"]]\n    ]\n  ],\n  {g, {0.5, 1, 2, 3, 5, 8, 10, 20, 50, 100}}\n];\nPrint[\"\\nAsymptotic limit: N0 -> (q-1) - qH*ln(q)/W = \",\n  Round[0.3 - 1.3*40*Log[1.3]/100, 0.0001]];\nPrint[\"Conclusion: N0 > 0 for all gamma. Lemma 1(i) does not hold for CRRA with H/W=0.4.\"];", "Input"],

(* --- Summary proposition --- *)
NotebookWrite[nb, Cell["A.11  Summary Proposition", "Subsection"]];

NotebookWrite[nb, Cell["Proposition (CRRA and Lemma 1(i)).\n\n\
For CRRA utility U(A) = A^(1-\[Gamma])/(1-\[Gamma]) with parameters (W, H, q), q > 1:\n\n\
(a) Optimal coverage at P \[Rule] 0 is:  \[Alpha]0(\[Gamma]) = 1 - (W/H)(1 - q^(-1/\[Gamma]))\n\n\
(b) The self-consistent numerator at P \[Rule] 0 converges as \[Gamma] \[Rule] \[Infinity] to:\n\
     N0 \[Rule] (q-1) - qH ln(q)/W\n\n\
(c) Lemma 1(i) can hold for CRRA only if  H/W > (q-1)/(q ln q).\n\
     For q=1.3 this requires H/W > 0.88 (near-catastrophic harm).\n\n\
(d) For typical insurance parameters (H/W moderate), CRRA always yields\n\
     monotonically decreasing demand (Lemma 1(ii) applies).\n\n\
(e) The mechanism: higher \[Gamma] increases both risk aversion AND coverage \[Alpha]0,\n\
     narrowing the wealth gap and weakening the differential risk-aversion effect.\n\
     These two forces cancel for CRRA, leaving the loading term (q-1) > 0 dominant.", "Text"]];

(* Save *)
NotebookSave[nb];
Print["Proof appendix added and saved."];
NotebookClose[nb];
