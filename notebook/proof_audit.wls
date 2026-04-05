#!/usr/bin/env wolframscript
(* === PROOF AUDIT SCRIPT — Zero-Day Protection === *)
(* Auto-generated alongside the notebook. Run before delivery. *)
(* Usage: wolframscript -file proof_audit.wls *)

Print["======================================"];
Print["  PROOF AUDIT — Zero-Day Verification  "];
Print["======================================\n"];

passed = 0; failed = 0; warnings = 0;

auditResult[name_, test_, detail_] := If[test,
  Print["  PASS: ", name]; passed++,
  Print["  FAIL: ", name, " -- ", detail]; failed++
];
auditWarn[name_, test_, detail_] := If[!test,
  Print["  WARN: ", name, " -- ", detail]; warnings++
];

(* Model primitives *)
wealth1[w_, a_, q_, p_, h_] := w - a*q*p*h;
wealth2[w_, a_, q_, p_, h_] := w - h*(1 - a) - a*q*p*h;
crraPrime[a_, g_] := a^(-g);

(* ---- AUDIT 1: Equation Spot-Check ---- *)
Print["\n=== AUDIT 1: Equation Spot-Check ==="];

testSets = {
  <|"W" -> 100, "H" -> 40, "q" -> 1.3, "P" -> 0.15, "g" -> 3.0|>,
  <|"W" -> 200, "H" -> 80, "q" -> 1.5, "P" -> 0.10, "g" -> 2.0|>,
  <|"W" -> 50,  "H" -> 20, "q" -> 1.1, "P" -> 0.05, "g" -> 5.0|>
};

Do[
  Module[{w, h, q, p, g, w1, w2, aOpt, lhs, rhs, focFn},
    {w, h, q, p, g} = Lookup[ts, {"W", "H", "q", "P", "g"}];
    focFn[a_?NumericQ] := Module[{ww1, ww2},
      ww1 = wealth1[w, a, q, p, h]; ww2 = wealth2[w, a, q, p, h];
      -(1 - p)*q*crraPrime[ww1, g] + (1 - q*p)*crraPrime[ww2, g]
    ];
    aOpt = a /. FindRoot[focFn[a] == 0, {a, 0.5, 0.01, 0.99}];
    w1 = wealth1[w, aOpt, q, p, h]; w2 = wealth2[w, aOpt, q, p, h];
    (* Verify (W1/W2)^gamma = (1-P)q/(1-qP) *)
    lhs = (w1/w2)^g;
    rhs = (1 - p)*q/(1 - q*p);
    auditResult[
      StringForm["FOC ratio (W1/W2)^g = (1-P)q/(1-qP) for W=``",w],
      Abs[lhs - rhs] < 10^-6,
      StringForm["LHS=``, RHS=``, diff=``", lhs, rhs, Abs[lhs - rhs]]
    ];
  ],
  {ts, testSets}
];

(* ---- AUDIT 2: Domain Bound ---- *)
Print["\n=== AUDIT 2: Domain Bounds ==="];

Module[{q = 1.3, pBound},
  pBound = N[1/q];
  auditResult["P_max = 1/q (not 1.0)",
    pBound < 1,
    StringForm["1/q = `` -- domain is [0, 1/q)", pBound]
  ];
  Print["  Info: For q=1.3, P_max = ", pBound];
];

(* ---- AUDIT 3: Limit at P -> 1/q ---- *)
Print["\n=== AUDIT 3: Limit at P -> 1/q ==="];

Module[{q = 1.3, pNear, numTerm},
  pNear = 1/q - 0.0001;
  numTerm = (q - 1)/(1 - q*pNear);
  auditResult["(q-1)/(1-qP) diverges as P->1/q",
    numTerm > 100,
    StringForm["Value at P=`` is only ``", N[pNear], N[numTerm]]
  ];
  Print["  Info: (q-1)/(1-qP) at P=", N[pNear], " = ", N[numTerm]];
];

(* ---- AUDIT 4: Uniqueness of Peak ---- *)
Print["\n=== AUDIT 4: Uniqueness of Peak ==="];

Module[{w = 100, h = 40, q = 1.3, g = 3.0, pMax, derivs, signChanges},
  pMax = N[1/q] - 0.01;
  derivs = Table[
    Module[{a1, a2, foc1, foc2},
      foc1[a_?NumericQ] := Module[{ww1, ww2},
        ww1 = wealth1[w, a, q, pp, h]; ww2 = wealth2[w, a, q, pp, h];
        -(1 - pp)*q*crraPrime[ww1, g] + (1 - q*pp)*crraPrime[ww2, g]
      ];
      a1 = a /. Quiet[FindRoot[foc1[a] == 0, {a, 0.5, 0.01, 0.99}]];
      foc2[a_?NumericQ] := Module[{ww1, ww2},
        ww1 = wealth1[w, a, q, pp + 0.002, h]; ww2 = wealth2[w, a, q, pp + 0.002, h];
        -(1 - pp - 0.002)*q*crraPrime[ww1, g] + (1 - q*(pp + 0.002))*crraPrime[ww2, g]
      ];
      a2 = a /. Quiet[FindRoot[foc2[a] == 0, {a, 0.5, 0.01, 0.99}]];
      {pp, (a2 - a1)/0.002}
    ],
    {pp, 0.01, pMax, 0.01}
  ];
  signChanges = Count[
    Table[Sign[derivs[[i, 2]]] != Sign[derivs[[i + 1, 2]]], {i, Length[derivs] - 1}],
    True
  ];
  auditResult["d(alpha*)/dP sign changes <= 1",
    signChanges <= 1,
    StringForm["`` crossings detected (expected 0 or 1)", signChanges]
  ];
  Print["  Info: ", signChanges, " zero-crossing(s) of d(alpha*)/dP"];
];

(* ---- AUDIT 5: Self-Consistency ---- *)
Print["\n=== AUDIT 5: Self-Consistency ==="];

Module[{w = 100, h = 40, q = 1.3, naiveGC, alphaFixed = 0.5},
  naiveGC = (q - 1)*w*(w - h*(1 - alphaFixed))/(alphaFixed*q*h^2*(1 - alphaFixed));
  Print["  Naive gamma_crit (alpha=0.5): ", N[naiveGC]];
  Print["  gamma | alpha0  | gamma_crit | gamma > gamma_crit?"];
  Do[
    Module[{a0, w2v, gc},
      a0 = N[1 - (w/h)*(1 - q^(-1/g))];
      If[a0 > 0 && a0 < 1,
        w2v = w - h*(1 - a0);
        gc = (q - 1)*w*w2v/(a0*q*h^2*(1 - a0));
        Print["  ", g, "   | ", NumberForm[a0, {5, 3}], " | ",
          NumberForm[gc, {7, 2}], " | ", If[g > gc, "YES", "No"]],
        Print["  ", g, "   | invalid  | N/A        | N/A"]
      ]
    ],
    {g, {2, 5, 10, 20, 50, 100}}
  ];
  auditWarn["Self-consistent check",
    False,
    "Review table above -- gamma_crit grows faster than gamma for typical H/W"
  ];
];

(* ---- AUDIT 6: Aggregation ---- *)
Print["\n=== AUDIT 6: Individual -> Aggregate ==="];

Module[{w = 100, h = 40, q = 1.3, gammas, pMax, allDecr},
  pMax = N[1/q] - 0.02;
  gammas = {1.5, 2.0, 3.0, 5.0, 8.0};
  allDecr = And @@ Table[
    Module[{derivs},
      derivs = Table[
        Module[{a1, a2, foc},
          foc[a_?NumericQ, pp_] := Module[{ww1, ww2},
            ww1 = wealth1[w, a, q, pp, h]; ww2 = wealth2[w, a, q, pp, h];
            -(1 - pp)*q*crraPrime[ww1, g] + (1 - q*pp)*crraPrime[ww2, g]
          ];
          a1 = a /. Quiet[FindRoot[foc[a, pp] == 0, {a, 0.5, 0.01, 0.99}]];
          a2 = a /. Quiet[FindRoot[foc[a, pp + 0.01] == 0, {a, 0.5, 0.01, 0.99}]];
          (a2 - a1)/0.01
        ],
        {pp, 0.01, pMax, 0.02}
      ];
      And @@ Table[derivs[[i]] >= derivs[[i + 1]] - 10^-6, {i, Length[derivs] - 1}]
    ],
    {g, gammas}
  ];
  auditResult["d(alpha*)/dP decreasing in P for all gamma types",
    allDecr,
    "Non-monotone d(alpha*)/dP -- aggregate single-peak not guaranteed"
  ];
];

(* ---- FINAL REPORT ---- *)
Print["\n======================================"];
Print["         AUDIT REPORT SUMMARY          "];
Print["======================================"];
Print["  Passed:   ", passed];
Print["  Failed:   ", failed];
Print["  Warnings: ", warnings];
Print["--------------------------------------"];
If[failed == 0,
  Print["  OVERALL:  ALL AUDITS PASSED"],
  Print["  OVERALL:  AUDIT FAILURES DETECTED"]
];
Print["======================================"];

Exit[If[failed > 0, 1, 0]]
