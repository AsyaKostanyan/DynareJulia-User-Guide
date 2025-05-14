# Installation

This section explains how to install the necessary components to use DynareJulia, starting with setting up a Python virtual environment and preparing to install Dynare.

---

## Step 1: Set Up a Virtual Environment

Before installing Dynare, it's recommended to create a **virtual environment** (venv) inside the folder where your model files will be stored.

---

### What is a Virtual Environment?

A virtual environment is an isolated workspace that keeps your project's dependencies (such as Python packages or Dynare wrappers) separate from your system-wide configuration.

Using a venv helps:
- Keep each modeling project self-contained
- Avoid conflicts with other tools or versions
- Improve reproducibility when sharing your setup

---

### 1.1 Create a project folder

Create a directory where your `.mod` files and Julia scripts will live:
activate venv

## Step 2: Install Dynare in Julia

Once your virtual environment is ready and Julia is installed, the next step is to install the **Dynare.jl** package using Julia’s package manager.

---

### 2.1 Open the Julia REPL

There are two ways to launch the Julia REPL:

#### Option A: From your system terminal

Simply type:

```bash
julia
```


#### Option B: From inside Visual Studio Code

1. Press `Ctrl + Shift + P` (or `Cmd + Shift + P` on macOS)
2. In the **Command Palette**, type:
3. Press `Enter`  
VS Code will open a terminal panel with the Julia REPL running.

---

### 2.2 Add the Dynare.jl package

Once the REPL is open, enter the following commands:

```bash
using Pkg
Pkg.add("Dynare")
```

### 2.3 First-Time Use

After installing Dynare.jl, test that the package loads correctly.

In the Julia REPL, type:

```bash
using Dynare
```

Note: The first time you use the package, Julia will precompile it. This may take a minute.

**Recommendation:** After installing packages, it is good practice to restart your Julia REPL or VS Code terminal.  
This ensures that all changes take effect properly, especially when adding new packages or changing environments.

---

### 2.4 Optional: Check the Installed Version

To verify which version of Dynare was installed, run:

```bash
Pkg.status("Dynare")
```

You should see an output like:

```bash
Dynare v0.9.18
```

This confirms the package is installed and active in your Julia environment.

### 2.5 Install Required Julia Packages for Modeling

In addition to `Dynare`, you will need several additional Julia packages for typical modeling workflows:

- `PATHSolver` — used for solving models with complementarity conditions
- `DataFrames` — for structured data manipulation
- `Dates` — to handle time-based elements like periods or ranges
- `Plots` — for generating charts and visualizations

---

#### Step 1: Launch Julia

In your terminal, start Julia by typing:

```bash
julia
```

#### Step 2: Install the required packages
Once the Julia REPL opens, run the following commands:
```bash
using Pkg
Pkg.add([
    "PATHSolver",
    "DataFrames",
    "Dates",
    "Plots"
])
```

#### Step 3: Test the installation
To verify that everything is working, enter:
```bash
using PATHSolver, DataFrames, Dates, Plots
```

### 2.6 Configure the PATH License

Dynare uses the [PATH solver](https://pages.cs.wisc.edu/~ferris/path.html) by S. Dirkse, M.C. Ferris, and T. Munson — as accessed through `PATHSolver.jl` — to solve perfect foresight models with occasionally binding constraints.

To use it, you need to register the free license key in your Julia startup file.

---

#### 1. Obtain the license

The license is publicly available at:

https://pages.cs.wisc.edu/~ferris/path/LICENSE

For convenience, here is the license string:
setenv PATH_LICENSE_STRING "2830898829&Courtesy&&&USR&45321&5_1_2021&1000&PATH&GEN&31_12_2025&0_0_0&6000&0_0"

#### 2. Add the license to your `startup.jl` file

Create a file named `startup.jl` and add the following line:

```julia
ENV["PATH_LICENSE_STRING"] = "2830898829&Courtesy&&&USR&45321&5_1_2021&1000&PATH&GEN&31_12_2025&0_0_0&6000&0_0"
```

### Instructions by Platform

---

#### 💻 Windows (File Explorer method)

1. Open File Explorer and go to your user folder (e.g., `C:\Users\YourName`).
2. Navigate to the `.julia` folder and create a new folder named `config` if it doesn't already exist.
3. Inside `.julia\config`, create a new text file:
   - Right-click → **New** → **Text Document**
4. Open the new file and paste the following line:

```julia
ENV["PATH_LICENSE_STRING"] = "2830898829&Courtesy&&&USR&45321&5_1_2021&1000&PATH&GEN&31_12_2025&0_0_0&6000&0_0"
```

   5. Save the file:
   - Go to **File → Save As**
   - In **Save as type**, choose **All Files**
   - In **File name**, type: `startup.jl`
   - Click **Save**

---

#### 🍎 macOS / Linux (terminal method)

1. Open a terminal.
2. Create the Julia config folder if it doesn't exist:
```bash
mkdir -p ~/.julia/config
    ```
3. Open the `startup.jl` file in your preferred text editor (e.g., nano, vim, or VS Code):
```bash
nano ~/.julia/config/startup.jl
    ```
4. Paste this line into the file:
```julia
ENV["PATH_LICENSE_STRING"] = "2830898829&Courtesy&&&USR&45321&5_1_2021&1000&PATH&GEN&31_12_2025&0_0_0&6000&0_0"
 ```
5. Save and close the file.

