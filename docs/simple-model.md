# Simple Model

This page demonstrates how to run a basic macroeconomic model in DynareJulia using a `.mod` file and the `@dynare` macro.

---

## 📄 Dynare Model File (`simple.mod`)

## Download the Model File

[Download `simple.mod`](models/simple.mod)


```mod
var PIE, R, Y;

varexo eps_Y;

model;
  PIE = 0.5*PIE(-1) + 0.5*PIE(+1) + 0.5*Y;
  Y   = 0.5*Y(-1) + 0.5*Y(+1) - 0.2*R + eps_Y;
  R   = 1.5*PIE(+1) + 0.2*Y;
end;

shocks;
  var eps_Y; stderr 0.01;
end;

check;

stoch_simul(order = 1, irf = 25);

```

**Description:**

- `PIE`, `R`, and `Y` are endogenous variables.
- `eps_Y` is an exogenous shock.
- The model has both forward- and backward-looking components.
- We use `stoch_simul` to simulate impulse response functions (IRFs).

## ▶️ Running the Model in Julia

Once you have `Dynare.jl` installed, you can run the model using the `@dynare` macro. This macro handles the entire process of parsing, solving, and simulating the model.

In the terminal run:

```julia
using Dynare

context = @dynare "simple.mod";
```

**This will:**

- Load and solve the model defined in `simple.mod`
- Execute the `stoch_simul` block for impulse response simulation
- Store all output and diagnostics in the `context` variable