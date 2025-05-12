# Getting Started with DynareJulia

This section will walk you through installing **Julia** — the foundational language for running DynareJulia.

---

## Step 1: Download Julia

DynareJulia currently requires **Julia version 1.9.4** for compatibility and performance reasons.

> 🛠️ You must install **version 1.9.4**, not the latest version.

To download it:

👉 Visit the [Julia Old Releases Page](https://julialang.org/downloads/oldreleases/)

Then scroll down to find: 
Version 1.9.4 (released on 2023-12-21)

Select the appropriate installer based on your operating system:

### 💻 For Windows
- Click on: `julia-1.9.4-win64.exe` (or `julia-1.9.4-win32.exe` if using 32-bit)
- Run the installer
- Accept default settings (you can check “Add Julia to PATH” if available)

### 🍎 For macOS
- Click on: `julia-1.9.4-mac64.dmg`
- Open the `.dmg` file and drag **Julia** into your `Applications` folder

### 🐧 For Linux
- Download the `julia-1.9.4-linux-x86_64.tar.gz`
- Extract it using your terminal

## Step 2: Testing

![Julia 1.9.4 Download Section](julia.png)


Step 3: Install Visual Studio Code (VS Code)

[Visual Studio Code (VS Code)](https://code.visualstudio.com/) is a lightweight and powerful code editor.  
We recommend it for writing and managing Julia code, editing `.mod` model files, and building this documentation.

---

### 📥 Download VS Code

1. Go to the official [VS Code download page](https://code.visualstudio.com/Download)
2. Choose your operating system:
   - **Windows**: Click on the `.exe` installer
   - **macOS**: Choose the `.zip` or `.dmg` version
   - **Linux**: Download the `.deb` or `.rpm` file

---

### 💻 Install Instructions by OS

💻 #### Windows

- Run the downloaded `.exe` file
- During setup:
  - ✅ Enable **“Add to PATH”**
  - ✅ Enable **“Open with Code”** in the right-click context menu
- Complete the installation by clicking **Next** through the installer

🍎 #### macOS

- Open the downloaded `.dmg` file
- Drag the **Visual Studio Code** icon into your `Applications` folder
- Open VS Code from the Applications menu or using Spotlight (`Cmd + Space`, then type "Code")


## Step 4: Install the Julia Extension in VS Code

To enable full Julia support in VS Code — including syntax highlighting, interactive REPL, inline plots, variable browser, and more — you need to install the official **Julia extension**.

---

### How to Install the Julia Extension

1. Open **Visual Studio Code**
2. Click on the **Extensions icon** in the left sidebar (or press `Ctrl+Shift+X`)
3. In the search bar at the top, type: **Julia**

4. Look for the extension published by **Julia Language** — it should appear first in the list

- **Name**: *Julia*
- **Publisher**: Julia Language

5. Click the **Install** button

---

### First-Time Setup

After installing the extension:

1. **Open a Julia file**, or click `View → Command Palette` (`Ctrl+Shift+P`)
2. Type: **Execute Active File**
3. VS Code will prompt you to select the **Julia executable path**  
(if it doesn't auto-detect it)
4. Browse to the path where Julia 1.9.4 is installed:

- On Windows (default):

  ```
  C:\Users\<YourUsername>\AppData\Local\Programs\Julia-1.9.4\bin\julia.exe
  ```

- On macOS:

  ```
  /Applications/Julia-1.9.app/Contents/Resources/julia/bin/julia
  ```

- On Linux (if installed via tarball):

  ```
  /opt/julia-1.9.4/bin/julia
  ```

5. Select the correct path → the extension will configure automatically

---

### ✅ Verify Julia REPL Integration

To check if it's working:

1. Create a new file and save it as `test.jl`
2. Add:

```julia
println("Hello from Julia in VS Code!")



