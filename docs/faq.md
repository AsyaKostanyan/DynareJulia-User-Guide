# ❓ Frequently Asked Questions (FAQ)

---

## Who should I contact for questions, collaboration, or training?

For any questions about using DynareJulia, contributing to the project, or organizing training sessions and workshops, please contact:  
**Asya Kostanyan** – [asyakostanyan@thebetterpolicyproject.org](mailto:asyakostanyan@thebetterpolicyproject.org)

---

## Is training available for DynareJulia?

Yes! We offer **ongoing training opportunities** through The Better Policy Project, including:

- Introductory courses on DynareJulia and macroeconomic modeling
- Hands-on workshops on scenario analysis, ENDOCRED and DSGE models
- Custom trainings for central banks and research teams

To request training or schedule a session, contact [asyakostanyan@thebetterpolicyproject.org](mailto:asyakostanyan@thebetterpolicyproject.org)

---

## What is DynareJulia?

DynareJulia is an open-source modeling engine written in Julia that builds on the well-established **Dynare for MATLAB/Octave** framework.  
It supports solving, simulating, and analyzing macroeconomic models written in `.mod` files — including support for perfect foresight, stochastic simulations, and modular frameworks like **ENDOCRED**.

---

## How is this different from Dynare (MATLAB version)?

DynareJulia reimplements many of the core features of Dynare in **pure Julia**, which offers:

- ✅ Faster performance on large simulations
- ✅ Better modularity and flexibility
- ✅ Full integration with the Julia package ecosystem (e.g., `Plots.jl`, `DataFrames.jl`)
- ✅ No need for MATLAB licenses or proprietary software

However, some advanced Dynare (MATLAB) features are still under development.

---

## Is this only for advanced users?

No! DynareJulia is designed for both:

- **Beginner users** learning DSGE modeling through `.mod` files and visual outputs
- **Advanced users** developing modular, nonlinear, or multi-country models

If you’re familiar with Dynare in MATLAB or FPAS-style modeling, you can switch to DynareJulia easily.

---

## Is DynareJulia free?

Yes. DynareJulia is **100% free and open source** — and it will remain that way.  
You can use it, modify it, and redistribute it under its permissive license.

---

## What is PythonDynareJulia?

**PythonDynareJulia** is a new project under development that provides a **Python-based frontend for DynareJulia**.

Its goals are to:

- Make DynareJulia more accessible to economists familiar with Python
- Offer a GUI-like interface for loading, solving, and simulating `.mod` files
- Integrate `Dynare.jl` as the computational backend while using Python for:
  - Input/output
  - Visualization (`matplotlib`, `seaborn`)
  - Notebook-based interaction (e.g., Jupyter)

This allows users to benefit from Julia's performance **without leaving their Python workflow**.

---

> 📌 The PythonDynareJulia interface will be fully free and open source. More details coming soon!

## What features are currently supported?

- Solving DSGE and perfect foresight models
- `@dynare` macro and `Dynare.run_model()` interface
- Visualizing IRFs with `Plots.jl`
- Multiple-model comparison
- Integration with custom Julia scripts

---

## Is this a final release?

Not yet. DynareJulia is actively under development.

---

## Can I contribute?

Yes, contributors are welcome! You can:

- Submit feedback via email  
- Share your own `.mod` and `.jl` examples  
- Help write docs or tutorials

---

## Where can I learn more?

Explore:

- [Video Tutorials](video-tutorials.md)
- [Simple Model Walkthrough](simple-model.md)
- [ENDOCRED Use Case](endocred.md)
- [Official Research](https://www.thebetterpolicyproject.org/research-papers)

Also see the official DynareJulia repositories:

- [DynareJulia GitHub repository](https://github.com/DynareJulia/Dynare.jl)
- [DynareJulia Documentation](https://dynarejulia.github.io/Dynare.jl/dev/)

---

For anything else, reach out to [asyakostanyan@thebetterpolicyproject.org](mailto:asyakostanyan@thebetterpolicyproject.org)
