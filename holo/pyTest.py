import matplotlib.pyplot as plt
import numpy as np
import holopy as hp
import wesley

def trans_func(schema, d, cfsp=0, squeeze=True,
               gradient_filter=0):
    """
    Calculates the optical transfer function to use in reconstruction

    This routine uses the analytical form of the transfer function
    found in in Kreis [1]_.  It can optionally do cascaded free-space
    propagation for greater accuracy [2]_, although the code will run
    slightly more slowly.

    Parameters
    ----------
    shape : (int, int)
       maximum dimensions of the transfer function
    spacing : (float, float)
       the spacing between points is the grid to calculate
    wavelen : float
       the wavelength in the medium you are propagating through
    d : float or list of floats
       reconstruction distance.  If list or array, this function will
       return an array of transfer functions, one for each distance
    cfsp : integer (optional)
       cascaded free-space propagation factor.  If this is an integer
       > 0, the transfer function G will be calculated at d/csf and
       the value returned will be G**csf.
    squeeze : Bool (optional)
       Remove length 1 dimensions (so that if only one distance is
       specified trans_func will be a 2d array)
    gradient_filter : float (optional)
       Subtract a second transfer function a distance gradient_filter
       from each z

    Returns
    -------
    trans_func : np.ndarray
       The calculated transfer function.  This will be at most as large as
       shape, but may be smaller if the frequencies outside that are zero

    References
    ----------
    .. [1] Kreis, Handbook of Holographic Interferometry (Wiley,
       2005), equation 3.79 (page 116)

    .. [2] Kreis, Optical Engineering 41(8):1829, section 5

    """
    d = np.array([d])

    wavelen = schema.optics.med_wavelen

    d = d.reshape([1, 1, d.size])

    if(cfsp > 0):
        cfsp = int(abs(cfsp)) # should be nonnegative integer
        d = d/cfsp

    # The transfer function is only defined on a finite domain of
    # spatial frequencies; outside this domain the transfer function
    # is zero (see Kreis, Optical Engineering 41(8):1829, page 1836).
    # It is important to set it to zero outside the domain, otherwise
    # the reconstruction is not correct.  Here I save memory by making
    # the size of the array only as large as the domain corresponding
    # to the transfer function at the smallest z-distance

    # for this we need to use the magnitude of d, size of the image
    # should be a positive number

    m, n = np.ogrid[[slice(-dim/(2*ext), dim/(2*ext), dim*1j) for
                     (dim, ext) in zip(schema.shape[:2], schema.extent[:2])]]

    root = 1.+0j-(wavelen*n)**2 - (wavelen*m)**2

    root *= (root >= 0)

    # add the z axis to this array so it broadcasts correctly
    root = root[..., np.newaxis]

    g = np.exp(-1j*2*np.pi*d/wavelen*np.sqrt(root))

    if gradient_filter:
        g -= np.exp(-1j*2*np.pi*(d+gradient_filter)/wavelen*np.sqrt(root))

    # set the transfer function to zero where the sqrt is imaginary
    # (this is equivalent to making sure that the largest spatial
    # frequency is 1/wavelength).  (root>=0) returns a boolean matrix
    # that is equal to 1 where the condition is true and 0 where it is
    # false.  Multiplying by this boolean matrix masks the array.
    g = g*(root>=0)

    if cfsp > 0:
        g = g**cfsp

    if squeeze:
        return np.squeeze(g)
    else:
        return g


magnification = 60
Spacing = 6.8/magnification
optics = hp.core.Optics(wavelen=.66, index=1.33, polarization=[1.0, 0.0])
obj = hp.load('image0100.tif', spacing=Spacing, optics=optics)

d = np.linspace(100,200,10)


m, n = np.ogrid[[slice(-dim/(2*ext), dim/(2*ext), dim*1j) for
                     (dim, ext) in zip(obj.shape[:2], obj.extent[:2])]]


d = np.array([d])
wavelen = obj.optics.med_wavelen
d = d.reshape([1, 1, d.size])

root = 1.+0j-(wavelen*n)**2 - (wavelen*m)**2
root *= (root >= 0)

#print root

#root = root[..., np.newaxis]
#print root[278,504,0]

#print d.shape
#print wavelen
#print root.shape
#
#print m.shape
#print n.shape
import time

from wesley import faster_trans_func
t1=time.time()
myg = faster_trans_func(m,n,d,wavelen)
t2=time.time()
print t2-t1
#myroot,mynewroot,myg = wesley.trans_func(m,n,d,wavelen)
#testroot, test = wesley.test(d,wavelen,root)

#t5 = time.time()
#root = 1.+0j-(wavelen*n)**2 - (wavelen*m)**2
#root *= (root >= 0)
#myroot,mynewroot,myg = wesley.trans_func(m,n,d,wavelen)
#t6 = time.time()
#print t6-t5

t3=time.time()
root = 1.+0j-(wavelen*n)**2 - (wavelen*m)**2
root *= (root >= 0)
root = root[..., np.newaxis]

g = np.exp(-1j*2*np.pi*d/wavelen*np.sqrt(root))
t4=time.time()
print t4-t3

print (t4-t3)-(t2-t1)

#print mynewroot
#print mynewroot[278,504]
#print myg
#plt.imshow(abs(myg[...,0]))
#plt.show()

#print myg
#print myg
#print np.allclose(root,myg)
#print 'done my g'

#g = np.exp(-1j*2*np.pi*d/wavelen*np.sqrt(root))
#plt.imshow(abs(g[...,0]))
#plt.show()

#print g[...,0]
#print myg[...,0]
#print g
#print np.allclose(g,myg)
#print 'done with g'


#print m.shape
#print n.shape
#print 'm'
#print m
#print 'n'
#print n


#t = wesley.fft2(obj)
#print t

#a = np.arange(9)
#nfft = np.fft.fft(a)
#
#fft = wesley.fft(a)
#print np.allclose(nfft,fft)
#
#a = np.array([[1,2,3],[4,5,6],[7,8,9]])
#nfft = np.fft.fft2(a)
#
#l=a.shape
#fft = wesley.fft2(a)
#print nfft
#print fft
#
#print np.allclose(nfft,fft)

