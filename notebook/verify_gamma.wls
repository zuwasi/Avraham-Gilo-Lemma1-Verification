#!/usr/bin/env wolframscript

W = 100; H = 40; q = 1.3;
alpha0[g_] := 1 - (W/H)(1 - q^(-1/g));
gammaCrit[g_] := Module[{a = alpha0[g], b = q^(-1/g)},
  If[a <= 0, Infinity, (q-1)*W*b / ((H - W + W*b)*q*(1 - b))]
];

Print["=== Self-Consistent Critical Gamma Computation ==="];
Print["W=", W, ", H=", H, ", q=", q];
Print[""];
Print["gamma | alpha0(gamma) | gammaCrit(gamma) | Lemma1(i)?"];
Do[
  Module[{a = alpha0[g], gc},
    If[a <= 0,
      Print[g, " | no coverage | N/A | N/A"],
      gc = N[gammaCrit[g]];
      Print[g, " | ", NumberForm[N[a], {4,3}], " | ", NumberForm[gc, {4,2}], " | ", If[g > gc, "YES", "No"]]
    ]
  ],
  {g, {0.5, 1, 2, 3, 5, 6, 6.5, 6.8, 6.9, 7, 8, 10}}
];

Print[""];
Print["Solving gamma = gammaCrit(gamma) numerically..."];
sol = FindRoot[g - gammaCrit[g], {g, 6.5}];
gStar = g /. sol;
Print["Self-consistent critical gamma* = ", N[gStar, 6]];
Print["Verification: alpha0(gamma*) = ", N[alpha0[gStar], 6]];
Print["Verification: gammaCrit(gamma*) = ", N[gammaCrit[gStar], 6]];

Print[""];
Print["=== Sensitivity to q ==="];
Do[
  Module[{gS},
    W = 100; H = 40;
    alpha0q[g_] := 1 - (W/H)(1 - qv^(-1/g));
    gammaCritQ[g_] := Module[{a = alpha0q[g], b = qv^(-1/g)},
      If[a <= 0, Infinity, (qv-1)*W*b / ((H - W + W*b)*qv*(1 - b))]
    ];
    gS = g /. Quiet[FindRoot[g - gammaCritQ[g], {g, 6}]];
    Print["q=", qv, " => gamma* = ", NumberForm[N[gS], {4,2}]]
  ],
  {qv, {1.05, 1.1, 1.2, 1.3, 1.5, 2.0}}
];
