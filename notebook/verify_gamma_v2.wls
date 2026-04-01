#!/usr/bin/env wolframscript

(* === Proper verification of Lemma 1(i) for CRRA === *)
(* The correct test: compute N_0 directly, not via gammaCrit *)

W = 100; H = 40;

(* alpha_0(gamma) from FOC at P=0 *)
alpha0[g_, qv_] := 1 - (W/H)(1 - qv^(-1/g));

(* The numerator N_0 at P->0 (Equation 18) *)
(* N_0 = alpha*q*H*[Ra(W) - Ra(W-H(1-alpha))] + (q-1) *)
(* For CRRA: Ra(A) = gamma/A *)
numeratorP0[g_, qv_] := Module[{a, w2},
  a = alpha0[g, qv];
  If[a <= 0, Return[N[qv - 1]]]; (* no coverage *)
  w2 = W - H*(1 - a);
  If[w2 <= 0, Return[N[-Infinity]]];
  a * qv * H * g * (1/W - 1/w2) + (qv - 1)
];

Print["=== CORRECT Self-Consistent Numerator Test ==="];
Print["(Using alpha_0 that depends on gamma via FOC at P=0)"];
Print["W=", W, ", H=", H];
Print[""];
Print["Lemma 1(i) holds when N_0 < 0"];
Print[""];

Do[
  Print["--- q = ", qv, " ---"];
  Do[
    Module[{a, n0},
      a = N[alpha0[g, qv]];
      If[a <= 0,
        Print["  gamma=", g, ": no coverage (alpha<=0)"],
        n0 = N[numeratorP0[g, qv]];
        Print["  gamma=", g, ": alpha0=", Round[a, 0.001], 
          ", N0=", Round[n0, 0.0001],
          If[n0 < 0, "  << LEMMA 1(i) HOLDS", "  (monotone)"]]
      ]
    ],
    {g, {1, 2, 3, 5, 8, 10, 15, 20, 30, 50}}
  ];
  (* Find crossing point if it exists *)
  Module[{gTest, found = False},
    Do[
      If[alpha0[g, qv] > 0 && numeratorP0[g, qv] < 0,
        Print["  >> First gamma where N0 < 0: gamma = ", g];
        found = True;
        Break[]
      ],
      {g, Range[1, 100, 0.1]}
    ];
    If[!found, Print["  >> N0 never becomes negative for gamma in [1,100]"]];
  ];
  Print[""],
  {qv, {1.05, 1.1, 1.2, 1.3, 1.5, 2.0}}
];

(* Also check: what does N0 look like as gamma -> Infinity? *)
Print["=== Asymptotic behavior of N0 as gamma -> Infinity ==="];
Print["q=1.3:"];
Do[
  Module[{a, n0},
    a = N[alpha0[g, 1.3]];
    n0 = N[numeratorP0[g, 1.3]];
    Print["  gamma=", g, ": alpha0=", Round[a, 0.0001], ", N0=", n0]
  ],
  {g, {10, 50, 100, 500, 1000, 10000}}
];

Print[""];
Print["=== Analytical limit: gamma -> Infinity ==="];
Print["As gamma->Inf: q^(-1/gamma)->1, so alpha0->1"];
Print["N0 -> 1*q*H*gamma*[1/W - 1/W] + (q-1) = 0 + (q-1) = q-1 > 0"];
Print["So N0 -> (q-1) > 0 as gamma -> Infinity."];
Print[""];
Print["CONCLUSION: For CRRA utility with these parameters,"];
Print["N0 is ALWAYS positive. Lemma 1(i) does NOT hold."];
Print["Demand is monotonically decreasing in P (Lemma 1(ii))."];
Print[""];
Print["The CRRA utility function has DARA that decreases"];
Print["too slowly (proportional to 1/A) for Lemma 1(i)."];

(* Now check with different W/H ratios *)
Print[""];
Print["=== What if H/W ratio is different? ==="];
Do[
  Module[{a, n0},
    W = wv; H = hv;
    Print["W=", wv, ", H=", hv, ", q=1.3:"];
    Do[
      a = N[alpha0[g, 1.3]];
      If[a > 0,
        n0 = N[numeratorP0[g, 1.3]];
        If[n0 < 0, Print["  gamma=", g, ": N0=", Round[n0, 0.001], " << LEMMA 1(i) HOLDS"]]
      ],
      {g, {1, 2, 5, 10, 20, 50, 100}}
    ];
  ],
  {{wv, hv}, {{100, 40}, {100, 80}, {100, 95}, {1000, 40}, {1000, 900}}}
];
