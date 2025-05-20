# ENDOCRED Model Simulations

ENDOCRED is a monetary policy model with endogenous policy credibility. It is widely used at central banks around the world, and in particulat, at the central banks that adopted prudent risk-management approach to monetary policy (FPAS MARK II) for forecasting and policy analysis.

---

## Brief Introduction to ENDOCRED

# ENDOCRED – Modeling Credibility in Monetary Policy

ENDOCRED (Endogenous Credibility) is a macroeconomic modeling framework that explicitly incorporates **credibility dynamics** into monetary policy decisions.

---

## Brief Introduction to ENDOCRED

**Why ENDOCRED?**

- Traditional FPAS models assume **fixed policy credibility**, often unrealistic during uncertain periods.
- ENDOCRED addresses this by allowing **public trust in the central bank to evolve endogenously** over time.
- It is especially relevant in contexts like **post-pandemic inflation**, where expectations, communication, and policy strength interact nonlinearly.

---

## Key Features of the ENDOCRED Framework

- **Endogenous Credibility Process**: Expectations react dynamically to how well the central bank achieves its objectives.
- **Two Inflation Regimes**:
  - A credible regime (expectations anchored at 2%)
  - A high-inflation regime (persistent, drifting expectations)
- **Nonlinear Phillips Curve**: The effect of output gaps on inflation intensifies in high-pressure economies.
- **Loss Function Approach**: The model minimizes a central bank’s loss function instead of assuming a fixed interest rate rule.
- **DynareJulia Implementation**: Fully implemented in open-source tools for fast policy simulation and transparency.

---

## Policy Simulations and Scenarios

The model supports scenario-based decision-making using cases such as:

- **Case A (Hawkish)**: Persistent inflation, requires strong policy tightening.
- **Case B (Dovish)**: Inflation is transitory, calls for mild adjustment.
- **Case X (Tail Risk)**: Stagflation or geopolitical shocks.

### Alternative Paths for the Policy Rate
![Scenario Simulation Output](images/scenarios.png)


---

## Credibility Metrics

The framework introduces two empirical indicators:

- **CBSPII**: Central Bank Sticky Price Inflation Indicator (e.g., based on Atlanta Fed sticky CPI)
- **CBCSI**: Central Bank Credibility Stock Index

These help calibrate credibility loss and track its macroeconomic effects.

---

## 🔑 Key Takeaways

- **Credibility is a dynamic asset**, not a fixed assumption.
- **Delays in tightening** can lead to **self-fulfilling inflation traps**.
- Models must account for **expectation shifts** in response to communication and action.
- ENDOCRED helps to think about and model “dark corners” of monetary policy — such as stagflation, delayed disinflation, or excessive tightening.

---

> 📖 _"In times of incredible uncertainty... a failure to act quickly, aggressively, and flexibly can lead to a very costly loss of credibility."_  
> — _Kostanyan et al., 2022_

---


## Model Codes in DynareJulia

These are the model and script files:

- [`MARKET_2025Q1.mod`](models/MARKET_2025Q1.mod)
- [`Case_A_2025Q1.mod`](models/Case_A_2025Q1.mod)
- [`Case_B_2025Q1.mod`](models/Case_B_2025Q1.mod)
- [`SCENARIOS_2025Q1.jl`](models/SCENARIOS_2025Q1.jl)

Download them and place all four in the same project directory.

---

## ▶️ How to Run

1. Activate your project environment (or create one):

```julia
using Pkg
Pkg.activate("venv")  # or your preferred environment path
```
