### Readout pulse shaping
![[Pulse shaping intro.png]]
In the conventional readout pulse like square pulse, it takes $10\kappa^{-1}$ for photon to ring down. However, by the input output theory, we can derive the input signal with given response function of photon $a_T(t)$^[M. Jerger et al., arXiv:2406.04891 (2024)]]:
$$
a_{in}(t) = -\left[\frac{\kappa}{2}+i\chi_j + \frac{d}{dt} \right]a_T(t) / \sqrt{\kappa} \tag{1}
$$
where $a_T(t)$ is response function, usually use $\sin^3(t\pi/T_p)$ with $T_p$ duration.
### Pulse shaping and response
&nbsp; From the Eq.(1) the input signal is:
![[a_in for ground state.png]]
where real and imaginary part indicate the input IQ signal of the readout. This pulse shaping resulting in different responses while qubit is on different states
![[photon  response data with shape1.png]]
as you can see, this pulse shaping only works while qubit is on the ground state, hence, another equation is introduced:
$$
a_{in}(t) = \left[\prod_{j=0}^{N-1}\left(\frac{\kappa}{2}+i\chi_j+\frac{d}{dt}\right) \right]a_T(t) / \kappa^{N/2} \tag{2}
$$
This equation shows the shape of readout pulse with transmon qubit in different states.