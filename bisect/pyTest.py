import numpy as np
import bisect

data = np.linspace(0,1e8,1e5)

print data.shape

i2 = bisect.bisect_right(data, 35000)
print i2

import Bi

i2 = Bi.bisect_right(data,35000)
print i2

i1 = bisect.bisect_left(data,35000)
print i1

i1 = Bi.bisect_left(data,35000)
print i1


