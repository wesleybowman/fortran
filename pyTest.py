import numpy as np
import beep
import FFT

beep.add(2)

a= np.array([1.0,2.0,3.0,4.0])
x = beep.fcumsum(a)

b= np.arange(2,10)
y = beep.fcumsum(b)

print 'For a'
print x

print 'For b'
print y

a = np.ones((3,3))
a = np.array([[1,2,3],[4,5,6],[7,8,9]])
newA = beep.matrix(a)
print newA


a = np.ones((3,3,3))
#a = np.array([[1,2,3],[4,5,6],[7,8,9]])
newA = beep.tdmatrix(a)
print newA


a = np.array([[1,2,3],[4,5,6],[7,8,9]])
nfft = np.fft.fft2(a)
print nfft

myfft = FFT.four2(a,1)
print myfft
print nfft==myfft


