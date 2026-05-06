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