import numpy as np
#import FFT
import wesley

a = np.arange(9)
nfft = np.fft.fft(a)

fft = wesley.fft(a)
print np.allclose(nfft,fft)

a = np.array([[1,2,3],[4,5,6],[7,8,9]])
nfft = np.fft.fft2(a)

l=a.shape
fft = wesley.fft2(a)
print nfft
print fft

print np.allclose(nfft,fft)
