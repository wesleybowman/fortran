import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import beep

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
newA = beep.matrix3(a)
print newA


a = np.array([[1,2,3],[4,5,6],[7,8,9]])
d = {'one':pd.Series([1,2,3],index=['a','b','c']),'two':pd.Series([7,8,9,10],index=['a','b','c','d'])}
df = pd.DataFrame(d)

index = pd.date_range('1/1/2000', periods=8)
df = pd.DataFrame(np.random.randn(8, 3), index=index, columns=list('ABC'))
#np.asarray(df)
print df

dataTest = beep.matrix3(df)


wp = pd.Panel(np.random.randn(2, 5, 4), items=['Item1', 'Item2'],
              major_axis=pd.date_range('1/1/2000', periods=5),
           minor_axis=['A', 'B', 'C', 'D'])

print wp
print wp.values
panelTest = beep.matrix3(wp)

