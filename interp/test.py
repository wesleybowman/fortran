import numpy as np
#import matplotlib.pyplot as plt
from scipy.interpolate import Rbf
#import finterp
import wesley

x = np.linspace(10,100,10)
y = np.linspace(10,100,10)


a = np.arange(15, 90)

z = wesley.linear(x,y,a)
print z

z = Rbf(x,y,function='linear')
rbf =z(a)
print rbf

#zz = finterp.interp_linear(1, x, y, a)
#zz = finterp.interp_linear(1, 10, x, y, 10, a)
#print zz
