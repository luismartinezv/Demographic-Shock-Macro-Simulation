# 📉 Demographic Shock Macro-Simulation (Spain 2025-2050)

![Macroeconomics](https://img.shields.io/badge/Macroeconomics-Solow_Growth_Model-darkblue)
![Tech Stack](https://img.shields.io/badge/Tech_Stack-MATLAB_|_Dynare-orange)
![Policy Analysis](https://img.shields.io/badge/Policy-Structural_Simulation-black)

## 🏛️ Executive Summary & Policy Question

**The Challenge:** Spain (and Europe at large) is facing an unprecedented contraction of its native labor force. The population pyramid inversion is exerting immense pressure on public finances and potential output, with the active population growth rate projected to enter negative territory (-0.1%).

**The Economic Question:** Can Total Factor Productivity (TFP) growth and *capital deepening* mitigate the demographic drag on GDP per capita and real wages?

**The Approach:** A deterministic simulation of the Solow Growth Model using **Dynare/MATLAB** to project the transition dynamics and macroeconomic aggregates from 2025 to 2050 under a perfect foresight shock.

## 📊 Model Calibration (Macroeconomic Parameters)
The model parameters have been strictly calibrated using empirical data from the Bank of Spain (BdE), the National Statistics Institute (INE), and the OECD to reflect the current Spanish structural reality:

| Parameter | Symbol | Value | Economic Justification |
| :--- | :---: | :---: | :--- |
| **Capital Share** | $\alpha$ | `0.37` | High capital intensity in the Spanish productive structure (BdE). |
| **Depreciation** | $\delta$ | `0.038` | Weighted average of structures and equipment depreciation (Eurostat). |
| **Savings Rate** | $s$ | `0.21` | Structural Gross Fixed Capital Formation capacity (INE). |
| **TFP Growth** | $g$ | `1.1%` | Target technological progress required for convergence. |
| **Demographic Shock** | $n$ | `0.0` $\rightarrow$ `-0.001` | Long-term projection of effective labor force contraction. |

## ⚙️ Technical Implementation
The `.mod` file solves for the initial steady state and simulates a **perfect foresight demographic shock** over 100 periods. It computes the transition paths for capital accumulation ($k$), marginal product of labor/wages ($w$), implicit real interest rate ($r$), consumption ($c$), and output ($y$).

## 💡 Key Policy Implications (Simulation Results)

![Simulation Results](results/simulation_results.png)

*Note: If the image does not load, please check the `/results` folder.*

1. **The Capital Deepening Mechanism:** A declining population triggers an automatic capital deepening effect. With fewer new workers entering the labor force, the "break-even investment" drops, pushing capital per effective worker ($k$) to a higher steady state.
2. **Labor vs. Capital Returns:** This transition temporarily boosts real wages ($w$) and output per effective worker ($y$) due to labor scarcity. However, it forces a secular decline in the real interest rate ($r$), signaling a phase of *secular stagnation* for passive capital returns.
3. **The Productivity Imperative:** The simulation proves that capital deepening is merely a transitional buffer. Long-term sustainability strictly requires pushing the TFP growth boundary (the $g$ parameter) above historical averages; otherwise, the demographic drag will ultimately suppress per capita welfare.

## 📂 Repository Structure
* `/src`: Contains the Dynare simulation script `solow_simulation.mod`.
* `/docs`: The full macroeconomic research paper (`Macroeconomic_Analysis_Demographic_Winter_Spain.pdf`) detailing the theoretical framework and literature review.
* `/results`: Graphical outputs of the transition dynamics.

---
*Developed by **Luis Martínez Vicente** - Economist & Data Scientist*
*[Connect on LinkedIn](INSERTA_TU_LINK_DE_LINKEDIN_AQUI)*
