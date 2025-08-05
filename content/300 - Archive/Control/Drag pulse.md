---
title: The brief introduction to DRAG pulse
author: 魏宇森
date: 2025-04-21
institute: National Central University, Department of Physics
share_link: https://share.note.sx/f555ggev#aY4nbhDr9zCVOZKvU0SlDsO/GRTAcgwxQr58RI2JAe0
share_updated: 2025-07-09T11:21:10+08:00
---

### Drag pulse
&nbsp; The Derivative Removal by Adiabatic Gate (DRAG) is an analytical method designed to improve gate fidelity by reducing leakage errors^[F. Motzoi et al., Physical Review Letters 103, 110501 (2009)]. In contrast, the GRAPE pulse employs numerical optimization using the gradient descent algorithm to determine the optimal parameters that minimize leakage.

### Leakage
&nbsp; Qubits are typically treated as two-level systems; however, the transmon qubit used in our setup is inherently a multilevel system.  When a control pulse such as a Gaussian pulse is applied, it can unintentionally excite the third energy level, resulting in leakage, i.e., an increase in the population of the $|2\rangle$ state. This type of leakage cannot be represented on the conventional two-dimensional Bloch sphere; instead, it manifests as a shortening of the Bloch vector, which contributes to gate errors. Moreover, the leakage dominate the total gate error.

### Gaussian pulse
&nbsp; Gaussian pulse suffer from the high gate error in the scale of $(\epsilon^x_{max})^2/ \Delta$ with the short gate times. In order to quantify the gate error, the gate fidelity is define as 
$$
F_g=\frac{1}{6}\sum_{j=\pm x,\pm y, \pm z}{\mathrm{Tr}[U_{ideal}\rho_jU^\dagger_{ideal}M_P(\rho_j)]} \tag{1}
$$ 
where $U_{ideal}$ is an unitary operator of rotating frame with frequency of qubit. 

### Compensation to leakage error
​&nbsp; When introducing the adiabatic transformation $V(t)=\mathrm{exp}[-i\mathcal{E}^x(t)(\hat{\sigma}^y_{0,1}+\lambda\hat{\sigma}^y_{2,1})/2\Delta]$. The transformed Hamiltonian becomes $H^V=VH^RV^{\dagger}+i\hbar\dot{V}V^{\dagger}$ reads 
$$
\begin{aligned}
H^V/\hbar &\approx \frac{\mathcal{E}^x}{2}\hat{\sigma^x_{0,2}} 
+ \frac{\lambda\mathcal{E}^2_x}{8\Delta} 
+ \left(\delta_2+\frac{(\lambda^2+2)\mathcal{E}^2_x}{4\Delta}\right)\Pi_2 \\
&+ \left(\delta_1-\frac{(\lambda^2-4)\mathcal{E}^2_x}{4\Delta}\right)\Pi_1
+ \left[\frac{\mathcal{E}^y}{2}+\frac{\dot{\mathcal{E}^x}}{2\Delta}\right](\hat{\sigma}^y_{0,1}+\lambda\hat{\sigma}^y_{1,2}) 
\end{aligned} \tag{2}
$$
which consists of 0-1 and 0-2 transition term, and the energy term of state $|2\rangle$ and $|1\rangle$. The phase error and inertial term can be removed by giving second control with 
$$
\mathcal{E}^y=-\frac{\dot{\mathcal{E}^x}}{\Delta}\quad \mathrm{and} \quad \delta_1=\frac{(\lambda^2-4)\mathcal{E}}{4\Delta} \tag{3}
$$
which can eliminate the leakage error to order $\mathcal{E}^4_x/4\Delta$

### Mathematical form of pulses
&nbsp; The more precision of transformation up to 5th order results in
$$
\begin{aligned}
&\mathcal{E}^x(t)=\mathcal{E}_\pi+\frac{(\lambda^2-4)\mathcal{E}^3_\pi}{8\Delta^2}-\frac{(13\lambda^4-76\lambda^2+112)\mathcal{E}^5_\pi}{128\Delta^4}, \\
&\mathcal{E}^y(t)=-\frac{\dot{\mathcal{E}_\pi}}{\Delta}+\frac{33(\lambda^2-2)\mathcal{E}^2_\pi\dot{\mathcal{E}_\pi}}{24\Delta^3}, \\
&\delta_1(t)=\frac{(\lambda^2-4)\mathcal{E}^2_\pi}{4\Delta}-\frac{(\lambda^4-7\lambda^2+12)\mathcal{E}^4_\pi}{16\Delta^3}
\end{aligned} \tag{4}
$$
These pluses remove most of the leakage error, for convenience of experiment, the high order term can be removed.

### Weighting and detuning
&nbsp; The more simple form of the DRAG pulse can be expressed as 
$$
\Omega'(t)=\Omega(t)-i\alpha \frac{\dot{\Omega}(t)}{\Delta}  \tag{5}
$$
where $\alpha$ is a weighting parameter, and $\Delta$ is the anharmonicity.

&nbsp; The gate fidelity of the DRAG pulse and leakage population obtained from [[Randomized Benchmarking]] (RB) imply the performance of DRAG pulse in different $\alpha$ see Fig.1. This figure shows the DRAG pulse can not suppress phase and gate error to minimum simultaneously. However, the phase error can be minimized into the same level by change detuning^[Z. Chen et al., Physical Review Letters 116, 020501 (2016).] to against the ac-Stark shift. The detuning can be obtained by the experiment that apply $\pi$ and $-\pi$ multiple times:
![[+pi -pi exp..png]]
by applying the detuning $\Delta=\omega_{21}-(\omega_{10}+2\pi\delta f)$, the phase error can be suppressed in the same level see Fig.2. The leakage error is suppressed with $\alpha=1.4$.

![[Phase and leakage error.png]]
Fig.1 This image implies the DRAG pulse enhance the gate fidelity with $\alpha=0.5$ and the leakage population is suppressed with $\alpha=1$

![[change detuning.png]]
Fig.2 The gate fidelity and leakage rates versus DRAG weighting $\alpha$, measured using RB. 

### Comparison between DRAG and GRAPE pulse
&nbsp; GRAPE pulse employs the numerical way(gradient descent) to find the best parameters to minimize the gate error. As a result, it require more time resources for training.
Compare to the DRAG pulse, the GRAPE, although, spend more time, but it is able to obtain smaller gate error.

| | DRAG | GRAPE |
| :-- | :--: | :--: |
| Approach | Analytical | Numerical |
| Gate error | Small | Smaller |
| Meaning | Physics derivation | Mathematical process |

### Result and gate fidelity 
![[gate error comparison.png]]
This fig shows error vs pulse duration with difference type of pulses: Gaussian pulse (blue solid line), Gaussian with DRAG (red dot-dashed line), tangential with DRAG (green dashed line), and GRAPE pulse (purple crosses with dotted guiding line)

&nbsp; From this result, GRAPE pulse can obtain the relative small gate error with the same gate time compare to others pulses, and performance of gate fidelity is better as well. 

### Conclusion 
&nbsp; DRAG pulse can reduce the gate error by the compensation of inertial and [[ac-Stark shift]] and 0-2 transition. This also promise DRAG pulse to reach better gate error with shorter duration compare to Gaussian pulse. GRAPE reduce the gate error more then DRAG pulse, however, its' required computing resources and time are more the DRAG pulse, and DRAG is more easy to apply to qubit.