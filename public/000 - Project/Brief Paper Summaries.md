#### **Model-Based Optimization of Superconducting Qubit Readout**
This work defined several errors by the input-output theory. Also, this work build up a model to optimize the readout errors, and apply the ex situ optimization by snake optimizer.
1. Error Modeling
	* Using input–output theory, build models for multiple readout errors, including separation error, relaxation error, and residual photon error.
2. Parameter Sweep
	* Independently vary the qubit frequency, pulse length, and pulse amplitude, and compute the corresponding error metrics for each setting.
3. Ex Situ Optimization
	* Employ a model-driven, ex situ global optimization using the Snake Optimizer to search for the parameter set that minimizes the total error.
4. Individualized Pulse Design
	* Automatically generate a unique, optimized pulse shape for each qubit, reducing the average readout error rate from ~1.9% to ~1.5% and suppressing both reset errors and leakage. 

 > [!note] Note
 > There is a model called "Heuristic model" which include the measurment-induced state transition

#### **Enhancing Dispersive Readout of Superconducting Qubits through Dynamic Control of the Dispersive Shift: Experiment and Theory**
This paper shows that dynamically reducing the qubit–resonator detuning Δ amplifies the dispersive shift χ, leading to higher readout SNR. A combined theoretical model (input–output theory + qubit–resonator–Purcell filter Hamiltonian) and experiment explore:
1. Detuning dependence
	* When the Purcell filter coupled with resonator, there are two eigenenergy with higher and lower frequency. Fig.2 shows dispersive shift and effective linewidth of resonator in different eigenmodes in different qubit state.
2. SNR and assignment error
	* The SNR and assignment error are defined as 
	$$
	\begin{aligned}
	\text{SNR}&\equiv \left| \frac{\mu_{g}-\mu_{e}}{(\sigma_g+\sigma_e)/2} \right|^2 \\
	\varepsilon_a &=1-F_{g, e} \\
	&=[P(e|g)+P(g|e)]/2
	\end{aligned}
	$$
	and this article shows assignment error with different detuning and integration time which obtained the lowest error with 
	$$
	\Delta = -1.3 \text{ GHz}, \tau=100 \text{ ns}
	$$
3. Driving power
	* This article also demonstrate the SNR (assignment error) v.s. the photon number, which obtain the assignment error increases when $n>n_{crit}$ which the attribute nonlinearities and measurement-induced transition.

#### **Benchmarking the Readout of a Superconducting Qubit for Repeated Measurements**
1. 