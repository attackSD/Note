### Introduction
Readout-induce leakage benchmarking (RILB) is a technique that can measurement the average leakage rate of the readout pulse. 

### Application
To apply this experiment, you need to do the following steps
1. Generate random sequence of control gate $\{i_m\}$ consist of $X_{\pi}$ and $I$
2. Applying this sequence to get the bit flip string $\{o_m\}$
3. Obtain bit-wise correlation by $C_m=1-2(i_m \oplus i_o)$ where $\oplus$ is the bit-wise XOR.
4. Repeat step 2~3 for several times, and average over the times of the repetition