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

#### Option B: From inside Visual Studio Code

1. Press `Ctrl + Shift + P` (or `Cmd + Shift + P` on macOS)
2. In the **Command Palette**, type:
3. Press `Enter`  
VS Code will open a terminal panel with the Julia REPL running.

---

### 2.2 Add the Dynare.jl package

Once the REPL is open, enter the following commands:

```julia
using Pkg
Pkg.add("Dynare")

### 2.3 First-Time Use

After installing Dynare.jl, test that the package loads correctly.

In the Julia REPL, type:

using Dynare

Note: The first time you use the package, Julia will precompile it. This may take a minute.

**Recommendation:** After installing packages, it is good practice to restart your Julia REPL or VS Code terminal.  
This ensures that all changes take effect properly, especially when adding new packages or changing environments.

---

### 2.4 Optional: Check the Installed Version

To verify which version of Dynare was installed, run:

Pkg.status("Dynare")

You should see an output like:

Dynare v0.9.18

This confirms the package is installed and active in your Julia environment.




