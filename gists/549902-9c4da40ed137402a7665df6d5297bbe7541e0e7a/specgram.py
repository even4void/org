#!/usr/bin/env python
from pylab import *
  
dt = 0.0005
t = arange(0.0, 20.0, dt)
s1 = sin(2*pi*100*t)
s2 = 2*sin(2*pi*400*t)
  
# create a transient "chirp"
mask = where(logical_and(t>10, t>12), 1.0, 0.0)
s2 = s2 * mask
  
# add some noise into the mix
nse = 0.01*randn(len(t))
  
x = s1 + s2 + nse # the signal
NFFT = 1024       # the length of the windowing segments
Fs = int(1.0/dt)  # the sampling frequency
Pxx, freqs, bins, im = specgram(x, NFFT=NFFT, Fs=Fs, noverlap=900)
colorbar()
  
show()