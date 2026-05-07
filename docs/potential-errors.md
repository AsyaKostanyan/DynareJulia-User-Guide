# Potential Errors

Common errors you may run into when setting up DynareJulia on Windows, and how to fix them. Click any error message below to expand the diagnosis and fix.

---

<details>
<summary><strong>UndefVarError: <code>GeneralizedFirstOrderAlgorithm</code> not defined</strong></summary>

**You see something like this when loading Dynare:**

```
ERROR: LoadError: UndefVarError: `GeneralizedFirstOrderAlgorithm` not defined
   @ C:\Users\<you>\.julia\packages\Dynare\<hash>\src\global\types.jl:150
in expression starting at .../Dynare.jl:1
ERROR: Failed to precompile Dynare ...
```

**Why it happens.** Dynare 0.10.0 referenced a symbol (<code>GeneralizedFirstOrderAlgorithm</code>) that the <code>NonlinearSolve</code> package later renamed. If your <code>Manifest.toml</code> pins Dynare 0.10.0 but Pkg resolves the rest of the dependency tree against the newest <code>NonlinearSolve</code>, the symbol is gone and Dynare fails to precompile.

This usually happens when a <code>Manifest.toml</code> was generated against an older Julia version (e.g. 1.9) and is now being used under Julia 1.10 or later.

**Fix.** Wipe the lockfile and let Pkg re-resolve from the <code>Project.toml</code>. This pulls Dynare 0.10.4 (or whatever the latest compatible version is) with a matching set of dependencies.

In a PowerShell terminal at the project root:

```powershell
# 1. Activate the project (sets JULIA_PROJECT to .\venv)
. .\activate.ps1

# 2. Delete the lockfile
Remove-Item .\venv\Manifest.toml

# 3. Re-resolve and precompile
julia -e "using Pkg; Pkg.instantiate(); Pkg.precompile(); Pkg.status()"
```

After this finishes, <code>Pkg.status()</code> should report:

```
[a93c6f00] DataFrames v1.8.2
[5203de40] Dynare v0.10.4    <-- was 0.10.0 before the fix
[91a5bcdd] Plots v1.41.6
[bd369af6] Tables v1.12.1
```

If Dynare is still listed as 0.10.0, your <code>Project.toml</code> has a hard pin — remove the <code>[compat]</code> Dynare line and try again.

</details>

---

<details>
<summary><strong>cannot remove ... Access is denied [stockflow/model/json]</strong></summary>

**You see this when running a model:**

```
Starting preprocessing of the model file ...
terminate called after throwing an instance of 'std::filesystem::__cxx11::filesystem_error'
  what():  filesystem error: cannot remove: Access is denied [stockflow/model/json]
ERROR: LoadError: type Array has no field results
```

**Why it happens.** Two things together:

<ul>
  <li>The Dynare preprocessor wants to delete the output folder from a previous run before writing fresh output.</li>
  <li>Dropbox or OneDrive holds file locks on those files while syncing them. The "Access is denied" is the sync client refusing to let go.</li>
</ul>

When the preprocessor crashes, <code>@dynare</code> returns an empty <code>Vector{Any}</code> instead of a <code>Context</code> — that's why the next line errors with <em>"type Array has no field results"</em>.

**Fix.** Two options, in order of preference:

<strong>Move the project out of Dropbox.</strong> Put your <code>Codes\</code> folder somewhere like <code>C:\dev\thailand2026\</code>. Keep slides and PDFs in Dropbox; keep the code out. DSGE solver output churns hundreds of small files per run, and Dropbox sync hates that.

<strong>Or pause Dropbox before running.</strong> Right-click the Dropbox tray icon → Pause syncing → run your model → resume.

If you control the driver script, you can also add a <code>safe_rm()</code> helper that retries with backoff — it papers over transient locks but not persistent ones.

</details>

---

<details>
<summary><strong>Failed to precompile GR_jll / Plots / Dynare</strong></summary>

**You see a cascade of precompile failures:**

```
Precompiling project...
  ✗ GR_jll
  ✗ Qt6ShaderTools_jll
  ✗ GR
  ✗ Plots
  ✗ StatsPlots
  ✗ Dynare
  N dependencies errored.
```

Notice the cascade: <code>GR_jll</code> is the root failure; everything else fails because it depends on <code>Plots</code> which depends on <code>GR</code>.

**Why it happens.** Almost always Windows long-path limits. The default <code>MAX_PATH</code> is 260 characters. A depot path like:

```
C:\Users\asyak\Dropbox\Work\The Better Policy Project\Courses\Thailand 2026\DSGE - Week 2\Codes\.julia\artifacts\<40-char-hash>\bin\gr\fonts\...
```

is already 165 characters before GR's nested folder structure starts. GR routinely overflows it.

**Fix.** Use a short depot path that lives outside Dropbox.

<ol>
  <li>Edit <code>activate.ps1</code> to set:</li>
</ol>

```powershell
$env:JULIA_DEPOT_PATH = "C:\jl-depots\thailand2026"
```

<ol start="2">
  <li>Re-activate and re-instantiate:</li>
</ol>

```powershell
. .\activate.ps1
julia -e "using Pkg; Pkg.instantiate(); Pkg.precompile()"
```

The <code>Project.toml</code> and <code>Manifest.toml</code> stay in <code>venv\</code> (small text files, fine in Dropbox). Only the multi-GB depot moves to a short path on the system drive.

<strong>Alternative:</strong> enable Windows long-path support globally. Open <code>gpedit.msc</code> → Computer Configuration → Administrative Templates → System → Filesystem → "Enable Win32 long paths" → Enabled. Requires admin and a reboot.

</details>

---

<details>
<summary><strong>ArgumentError: invalid index <code>!</code> when extracting IRFs</strong></summary>

**You see one of these when plotting impulse responses:**

```
ERROR: ArgumentError: invalid index: ! of type typeof(!)
```

or:

```
MethodError: no method matching expand_extrema!(::Plots.Axis,
  ::AxisArrayTables.AxisArrayTable{Float64, ...})
```

**Why it happens.** DynareJulia returns IRFs as <code>AxisArrayTable</code>, <strong>not</strong> <code>DataFrame</code>. DataFrame indexing syntax (<code>tbl[!, :col]</code> or <code>tbl[:, :col]</code>) does not work — <code>!</code> is a function, and <code>:</code> returns a one-column 2D table that <code>Plots</code> can't accept as a y-series.

**Fix.** Use the Tables.jl column accessor and convert to a plain vector:

```julia
using Tables
series = collect(Float64, Tables.getcolumn(irfs[shock], :b))
```

This works whether the underlying type is <code>DataFrame</code>, <code>AxisArrayTable</code>, or anything else implementing the Tables.jl interface — so the script stays robust across Dynare versions.

</details>

---

<details>
<summary><strong>activate.ps1 : The term '.\activate.ps1' is not recognized</strong></summary>

**You see this in PowerShell:**

```
activate.ps1 : The term 'activate.ps1' is not recognized as the name of a
cmdlet, function, script file, or operable program.
```

**Why it happens.** PowerShell will not run a script in the current folder unless you prefix it with <code>.\</code>. And to keep the environment variables in your shell (rather than throwing them away in a child process), you also need to <em>dot-source</em> the script with a leading <code>.&nbsp;</code> (period + space).

**Fix.** Run it with both prefixes:

```powershell
. .\activate.ps1
```

That is: <em>period — space — period — backslash — <code>activate.ps1</code></em>. Four characters before the filename.

If you also see <em>"running scripts is disabled on this system"</em>, run this once per machine:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

</details>

---

## Perfect-foresight simulation (Dynare.jl 0.10.x)

A few rough edges in the perfect-foresight subsystem of Dynare.jl 0.10.x. These bite if you port a model from MATLAB Dynare or follow older tutorials.

<details>
<summary><strong>perfect_foresight_setup / _solver run silently and produce no simulation</strong></summary>

**You see this:** the model parses, the steady state computes correctly, no obvious error is thrown — but `context.results.model_results[1].simulations` is an **empty** <code>Vector{Simulation}</code>, and any attempt to read `simulations[1]` blows up with <code>BoundsError</code>. Earlier in the log, hidden in the parser output, you may also spot a stray:

```
MethodError(convert, (Float64, nothing), 0x...)
```

**Why it happens.** The legacy MATLAB-Dynare two-step pattern in the `.mod` file —

```dynare
perfect_foresight_setup(periods = 200);
perfect_foresight_solver;
```

— is not parsed correctly in Dynare.jl 0.10.x. The keyword option `(periods = 200)` round-trips through a code path that produces `nothing` where a `Float64` is expected, the parser swallows the `MethodError`, and nothing populates the simulations vector.

**Fix.** Use the modern single statement, with the trailing <code>!</code>:

```dynare
perfect_foresight!(periods = 200);
```

Drop both `perfect_foresight_setup` and `perfect_foresight_solver` from the `.mod` file. Same applies if you call from Julia — use <code>Dynare.perfect_foresight!(; context, periods = 200)</code>, not <code>Dynare.perfect_foresight_setup!</code> + <code>Dynare.perfect_foresight_solver!</code>.

</details>

---

<details>
<summary><strong>UndefVarError: <code>guess_values</code> not defined when using linearinterpolation</strong></summary>

**You see this when calling <code>perfect_foresight!</code> with a non-default initialization:**

```
ERROR: LoadError: UndefVarError: `guess_values` not defined
Stacktrace:
 [1] perfect_foresight_initialization!(...)
   @ Dynare .../perfectforesight/perfectforesight.jl:504
```

**Why it happens.** `Dynare.linearinterpolation` is declared as a value of the <code>InitializationAlgo</code> enum, but the corresponding branch in <code>perfect_foresight_initialization!</code> is empty — the local variable <code>guess_values</code> never gets assigned. Same story for <code>Dynare.firstorder</code>: it dispatches to <code>simul_first_order!</code>, which calls <code>compute_first_order_solution!</code> with the wrong number of arguments and crashes with <code>MethodError</code>.

**Fix.** Of the four enum values — <code>initvalfile</code>, <code>steadystate</code>, <code>firstorder</code>, <code>linearinterpolation</code> — only <code>steadystate</code> (the default) actually works in 0.10.x. Don't pass <code>initialization_algo</code> at all, or pass <code>Dynare.steadystate</code> explicitly.

If your problem is a long transition where the steady-state initial guess is too far from the true path, you can usually rescue convergence by setting the initial state with a <code>histval</code> block instead of trying to interpolate by hand:

```dynare
initval;
    K = K_SS;       // guess for steady state, refined by `steady;` below
    ...
end;

steady;

histval;
    K(0) = K_SS/2;  // initial state: K(-1) at half the steady-state level
end;

perfect_foresight!(periods = 200);
```

This pattern is also what Dynare.jl's own test models use (see <code>test/models/initialization/neoclassical1.mod</code> in the package).

</details>

---

<details>
<summary><strong>MethodError: Cannot <code>convert</code> an object of type Missing to an object of type Float64 (when plotting)</strong></summary>

**You see this when extracting a simulation column for plotting:**

```
ERROR: LoadError: MethodError: Cannot `convert` an object of type Missing
       to an object of type Float64
Stacktrace:
 [1] setindex!(A::Vector{Float64}, x::Missing, i1::Int64)
 [2] copyto_unaliased!(...)
 ...
 [5] collect(::Type{Float64}, itr::AxisArrays.AxisVector{Union{Missing, Float64}, ...})
```

**Why it happens.** Perfect-foresight simulation tables in Dynare.jl come back typed as <code>Union{Missing, Float64}</code>: the boundary rows (period 0 and the period after the simulation horizon) can hold <code>missing</code> values for variables that aren't pinned at those points. <code>collect(Float64, ...)</code> can't convert <code>missing</code>, so it errors out.

**Fix.** Replace <code>missing</code> with <code>NaN</code> before passing the column to Plots — Plots renders NaN as a gap in the line:

```julia
raw    = Tables.getcolumn(sim, :K)
series = [ismissing(x) ? NaN : Float64(x) for x in raw]

plot(0:length(series)-1, series; lw = 2, label = "K")
```

Use the same pattern (raw → coalesce-to-NaN → plot) for every variable you read out of a simulation table.

</details>

---

## Working setup reference

The two-command workflow once everything is in place:

```powershell
cd "C:\...\Codes"
. .\activate.ps1
julia run_stockflow.jl
```

<code>activate.ps1</code> sets <code>JULIA_PROJECT</code> to <code>.\venv</code> (and, if you applied the long-path fix above, <code>JULIA_DEPOT_PATH</code> to a short path).

A successful run ends with output like:

```
================ Steady state ================
  b        =   0.500000
  def      =   0.014563
  prdef    =  -0.004854
  intpay   =   0.019417
  y        =   0.000000
==============================================
IRF chart saved to stockflow_irfs.png
```

---

For anything not covered here, reach out to <a href="mailto:asyakostanyan@thebetterpolicyproject.org">asyakostanyan@thebetterpolicyproject.org</a>.