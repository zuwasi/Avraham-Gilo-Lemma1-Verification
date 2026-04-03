#!/usr/bin/env wolframscript

Print["=== Deploying Interactive Panel (v2) ==="];

wealth1[ww_, aa_, qq_, pp_, hh_] := ww - aa * qq * pp * hh;
wealth2[ww_, aa_, qq_, pp_, hh_] := ww - aa * qq * pp * hh - (1 - aa) * hh;
crrAutilityPrime[aa_, gg_] := aa^(-gg);
crrArrowPratt[aa_, gg_] := gg / aa;

focCRRA[ww_, aa_, qq_, pp_, hh_, gg_] := Module[{w1, w2},
  w1 = wealth1[ww, aa, qq, pp, hh];
  w2 = wealth2[ww, aa, qq, pp, hh];
  -(1 - pp) * qq * crrAutilityPrime[w1, gg] + (1 - qq * pp) * crrAutilityPrime[w2, gg]
];

solveAlphaCRRA[ww_, qq_, pp_, hh_, gg_] := Module[{sol, aVal, f},
  If[qq * pp >= 1, Return[0.0]];
  f[av_?NumericQ] := focCRRA[ww, av, qq, pp, hh, gg];
  sol = Quiet[Check[FindRoot[f[av], {av, 0.001, 0.999}], $Failed]];
  If[sol =!= $Failed, aVal = av /. sol; Return[N[Max[0, Min[1, aVal]]]]];
  sol = Quiet[Check[FindRoot[f[av], {av, 0.5}], $Failed]];
  If[sol =!= $Failed, aVal = av /. sol; N[Max[0, Min[1, aVal]]], 0.0]
];

numeratorLimitP0CRRA[ww_, aa_, qq_, hh_, gg_] := Module[{raW, raWH, wBottom},
  If[aa < 0.0001, Return[N[qq - 1]]];
  If[aa > 0.9999, Return[N[qq - 1]]];
  wBottom = ww - hh * (1 - aa);
  If[wBottom <= 0, Return[N[-Infinity]]];
  raW = crrArrowPratt[ww, gg];
  raWH = crrArrowPratt[wBottom, gg];
  aa * qq * hh * (raW - raWH) + (qq - 1)
];

gammaCritical[ww_, aa_, qq_, hh_] := Module[{num, den},
  If[aa < 0.0001 || aa > 0.9999, Return[Infinity]];
  num = (qq - 1) * ww * (ww - hh * (1 - aa));
  den = aa * qq * hh^2 * (1 - aa);
  If[Abs[den] < 10^-12, Return[Infinity]];
  N[num / den]
];

Print["Deploying as CloudPublish with interactive permissions..."];

manipulateExpr = Manipulate[
  Module[
    {pVals, alphaVals, pStar, alphaStar, numP0, condText,
     alphaAtP0, critGam, numVal},
    SeedRandom[42];
    pVals = Table[pp, {pp, 0.005, 1/qVal - 0.005, (1/qVal - 0.01) / 80}];
    alphaVals = Map[
      Function[pp, {pp, Quiet[solveAlphaCRRA[wVal, qVal, pp, hVal, gammaVal]]}],
      pVals
    ];
    {pStar, alphaStar} = First[SortBy[alphaVals, -Last[#] &]];
    alphaAtP0 = Quiet[solveAlphaCRRA[wVal, qVal, 0.01, hVal, gammaVal]];
    numP0 = Quiet[numeratorLimitP0CRRA[wVal, alphaAtP0, qVal, hVal, gammaVal]];
    numVal = N[numP0];
    critGam = gammaCritical[wVal, alphaAtP0, qVal, hVal];
    condText = If[NumericQ[numVal] && numVal < 0,
      Style["Lemma 1(i) HOLDS: Single-peaked demand", Bold, Darker[Green]],
      Style["Lemma 1(ii): Monotone decreasing demand", Bold, Red]
    ];
    Column[{
      Style["Authors (2025) - Lemma 1 CRRA Verification", Bold, 16],
      condText,
      Row[{
        StringForm["P* = `1`", Round[pStar, 0.001]],
        Spacer[10],
        StringForm["alpha* = `1`", Round[alphaStar, 0.001]],
        Spacer[10],
        StringForm["gamma-crit = `1`", If[NumericQ[critGam] && critGam < 10^6, Round[critGam, 0.01], "N/A"]]
      }],
      ListLinePlot[alphaVals,
        PlotLabel -> StringForm["alpha*(P) | W=`1`, H=`2`, q=`3`, gamma=`4`", wVal, hVal, qVal, gammaVal],
        PlotStyle -> {Thick, Blue},
        PlotRange -> {{0, 1/qVal}, {0, 1}},
        Epilog -> {Red, PointSize[Large], Point[{pStar, alphaStar}]},
        ImageSize -> 450,
        Frame -> True,
        FrameLabel -> {"Accident Probability P", "Coverage alpha*"},
        GridLines -> Automatic
      ]
    }]
  ],
  {{wVal, 100, "Wealth W"}, 50, 500, 10},
  {{hVal, 40, "Harm H"}, 5, 80, 5},
  {{qVal, 1.3, "Loading q"}, 1.01, 3.0, 0.01},
  {{gammaVal, 2.0, "CRRA gamma"}, 0.1, 15.0, 0.1},
  TrackedSymbols :> {wVal, hVal, qVal, gammaVal},
  SaveDefinitions -> True
];

(* Method 1: CloudDeploy to a specific URL *)
result1 = CloudDeploy[
  manipulateExpr,
  CloudObject["Insurance_Demand_Interactive_v2"],
  Permissions -> "Public"
];
Print["CloudDeploy result: ", result1];

(* Method 2: Also try as a Notebook with the Manipulate *)
nb = CreateNotebook[];
NotebookWrite[nb, Cell[BoxData[ToBoxes[manipulateExpr]], "Output"]];
nbContent = NotebookGet[nb];
NotebookClose[nb];

result2 = CloudDeploy[
  nbContent,
  CloudObject["Insurance_Demand_NB_Interactive_v2"],
  Permissions -> "Public"
];
Print["Notebook deploy result: ", result2];

Print["\n=== LINKS ==="];
Print["Standalone Manipulate: https://www.wolframcloud.com/obj/daniell/Insurance_Demand_Interactive_v2"];
Print["Notebook with Manipulate: https://www.wolframcloud.com/obj/daniell/Insurance_Demand_NB_Interactive_v2"];
Print["\nBoth should have working sliders. Try dragging a slider and wait 2-3 seconds."];
