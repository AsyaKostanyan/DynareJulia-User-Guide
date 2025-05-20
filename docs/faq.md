# Frequently Asked Questions (FAQ)

---

<details>
<summary>Who should I contact for questions, collaboration, or training?</summary>

For any questions about using DynareJulia, contributing to the project, or organizing training sessions and workshops, please contact:  
**Asya Kostanyan** – [asyakostanyan@thebetterpolicyproject.org](mailto:asyakostanyan@thebetterpolicyproject.org)

</details>

---

<details>
<summary>Is training available for DynareJulia?</summary>

Yes! We offer **ongoing training opportunities** through The Better Policy Project, including:

- Introductory courses on DynareJulia and macroeconomic modeling  
- Hands-on workshops on scenario analysis, ENDOCRED and DSGE models  
- Custom trainings for central banks and research teams

To request training or schedule a session, contact [asyakostanyan@thebetterpolicyproject.org](mailto:asyakostanyan@thebetterpolicyproject.org)

</details>

---

<details>
<summary>What is DynareJulia?</summary>

DynareJulia is an open-source modeling engine written in Julia that builds on the well-established **Dynare for MATLAB/Octave** framework.  
It supports solving, simulating, and analyzing macroeconomic models written in `.mod` files — including support for perfect foresight, stochastic simulations, and modular frameworks like **ENDOCRED**.

</details>

---

<details>
<summary>How is this different from Dynare (MATLAB version)?</summary>

DynareJulia reimplements many of the core features of Dynare in **pure Julia**, which offers:

- ✅ Faster performance on large simulations  
- ✅ Better modularity and flexibility  
- ✅ Full integration with the Julia package ecosystem (e.g., `Plots.jl`, `DataFrames.jl`)  
- ✅ No need for MATLAB licenses or proprietary software

However, some advanced Dynare (MATLAB) features are still under development.

</details>

---

<details>
<summary>Is this only for advanced users?</summary>

No! DynareJulia is designed for both:

- **Beginner users** learning DSGE modeling through `.mod` files and visual outputs  
- **Advanced users** developing modular, nonlinear, or multi-country models

If you’re familiar with Dynare in MATLAB or FPAS-style modeling, you can switch to DynareJulia easily.

</details>

---

<details>
<summary>Is DynareJulia free?</summary>

Yes. DynareJulia is **100% free and open source** — and it will remain that way.  
You can use it, modify it, and redistribute it under its permissive license.

</details>

---

<details>
<summary>What is PythonDynareJulia?</summary>

**PythonDynareJulia** is a new project under development that provides a **Python-based frontend for DynareJulia**.

Its goals are to:

- Make DynareJulia more accessible to economists familiar with Python  
- Offer a GUI-like interface for loading, solving, and simulating `.mod` files  
- Integrate `Dynare.jl` as the computational backend while using Python for:  
  - Input/output  
  - Visualization (`matplotlib`, `seaborn`)  
  - Notebook-based interaction (e.g., Jupyter)

This allows users to benefit from Julia's performance **without leaving their Python workflow**.

> 📌 The PythonDynareJulia interface will be fully free and open source. More details coming soon!

</details>

---

<details>
<summary>What features are currently supported?</summary>

- Solving DSGE and perfect foresight models  
- `@dynare` macro and `Dynare.run_model()` interface  
- Visualizing IRFs with `Plots.jl`  
- Multiple-model comparison  
- Integration with custom Julia scripts

</details>

---

<details>
<summary>Is this a final release?</summary>

Not yet. DynareJulia is actively under development.

</details>

---

<details>
<summary>Can I contribute?</summary>

Yes, contributors are welcome! You can:

- Submit feedback via email  
- Share your own `.mod` and `.jl` examples  
- Help write docs or tutorials

</details>

---

<details>
<summary>Where can I learn more?</summary>

Explore:

- [Video Tutorials](video-tutorials.md)  
- [Simple Model Walkthrough](simple-model.md)  
- [ENDOCRED Use Case](endocred.md)  
- [Official Research](https://www.thebetterpolicyproject.org/research-papers)

Also see the official DynareJulia repositories:

- [DynareJulia GitHub repository](https://github.com/DynareJulia/Dynare.jl)  
- [DynareJulia Documentation](https://dynarejulia.github.io/Dynare.jl/dev/)

</details>

---

For anything else, reach out to [asyakostanyan@thebetterpolicyproject.org](mailto:asyakostanyan@thebetterpolicyproject.org)
