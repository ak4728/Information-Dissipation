
# coding: utf-8

# In[1]:



# coding: utf-8
import csv
from shapely import geometry
import numpy as np
import pandas as pd
import operator
import matplotlib.pyplot as plt
filename = 'E:/Paramics/Dissipation Network/Log/run-008/vehicle-trajectory-07-00-00.csv' # Filename
distance = 480


# In[2]:



reader = csv.reader(open(filename), delimiter = ",")
next(reader)


time = []
ids = [] 
x = []
y = []
uTs = sorted(list(set(time))) #around 10 minutes

for row in reader:
	time.append(row[0])
	ids.append(row[1])
	x.append(row[6])
	y.append(row[7])


# In[3]:


#del df
df = pd.DataFrame({'ID':ids, 'x': x, 'y': y,'time':time}, columns= ['ID','x','y','time'])
df[['x', 'y']] = df[['x', 'y']].astype(float)

df.head()


# In[12]:


vehList = list(set(df['ID'].reset_index(drop=True)))

vehList2 = np.random.choice(vehList, size=5, replace=True, p=None)

newDf = df[df['ID'].isin(vehList2)].reset_index(drop=True)

newDf.head()


# In[4]:


def findInfectedVehs(Dictionary):
    b = Dictionary
    keyList = b.keys()
    compL = []
    for i,v in enumerate(keyList):
        if i == 0:
            compL.extend(b[list(keyList)[i]])
            size = len(b[list(keyList)[i]])
        list2=b[list(keyList)[i]]
        #print compL, "<- Complete Set"
        #print list2, "<- New Set"
        #print 'fark',list(set(list2)-set(compL)) , "<- Difference"
        diff = list(set(list2)-set(compL))
        #print list(set(compL).intersection(list2))
        compL.extend(list2)
        size = size + len(diff)
    return size


# In[5]:


def findP(k,rangeVar,df):
    df = df
    ts = df["time"]
    uTs = sorted(list(set(ts))) #around 10 minutes
    rangeVar = rangeVar
    k = k
    point_1 = geometry.Point(675427.1,-731954.4)
    iDict = {}
    for i in range(k,rangeVar):
        dfFiltered = df[df["time"]==uTs[i]]
        dfFiltered=dfFiltered.reset_index(drop=True)
        varLen = len(dfFiltered["time"])
        if df['ID'][i] != "34_65":
            # Dictionary to find the furthest vehicle
            disDict = {}
            if(varLen>=1):
                # Infected Vehicles
                infectedList = []
                for j in range(varLen):
                    # Buffer Zone
                    circle_buffer = point_1.buffer(distance)
                    point_2 = geometry.Point(dfFiltered["x"][j],dfFiltered["y"][j])
                    # Check if the other point lies within    
                    if point_2.within(circle_buffer):
                        # Infected Vehicle List
                        infectedList.append(dfFiltered["ID"][j])
                        # Dictionary to find the furthest vehicle
                        disDict[dfFiltered["x"][j],dfFiltered["y"][j]] = dfFiltered["x"][j]

            # Get the key with maximum value in a dictionary
            try:
                # Get the furthest vehicle in the buffer
                updatedP1 = min(disDict, key=disDict.get)
                res="not found"
                # If message is reached the target, stop
                if updatedP1[0]<674570.4:
                    res = float(uTs[i])-float(uTs[k])
                    print(res)
                    break
                # Update message location
                point_1 = geometry.Point(updatedP1)

            except:
                pass
                res="not found"
        iDict[i] = infectedList
    return res, iDict


# In[65]:


#vehList = list(set(df['ID'].reset_index(drop=True)))
#vehList2 = np.random.choice(vehList, size=700, replace=True, p=None)
#newDf = df[df['ID'].isin(vehList2)].reset_index(drop=True)


# In[15]:


print(distance)


# In[114]:


runX = []
runY = []

for i in range(0,150):
    vehList = list(set(df['ID'].reset_index(drop=True)))
    vehList2 = np.random.choice(vehList, size=490, replace=False, p=None)
    newDf = df[df['ID'].isin(vehList2)].reset_index(drop=True)
    a, b = findP(2500,35800,newDf)#35800,newDf)
    iVehs = findInfectedVehs(b)
    print("Infection Time = ",a, " Infected Vehicles = ", iVehs)
    fVehs = []
    infsecs = {}
    for k,v in b.items():
        if k ==2500:
            fVehs.extend(v)
            infsecs[2500] = 0
        else:
            tempVehs = []
            for el in v:
                if el in fVehs:
                    pass
                else:
                    fVehs.append(el)
                    tempVehs.append(el)
            infsecs[k] = len(tempVehs)
    x= list(infsecs)
    y= np.cumsum(list(infsecs.values()))
    runX.append(x)
    runY.append(y)



# In[130]:


import matplotlib
from scipy.ndimage.filters import gaussian_filter1d

runX = runX50
runY = runY50

# Normalize
runx = []
runy = []


matplotlib.rcParams['font.family'] = "sans-serif"

for i in range(len(runX)):
    temp = []
    for j in range(len(runX[i])):
        temp.append(runY[i][j]/runY[i][-1])
    runy.append(temp)


    
def getLambda(MP=1.0):
    crossover = MP
    Vf = 35*1.467
    L = 0.556
    n = 3
    Area = 480
    kjam = 450/5280
    C = MP
    normLambda = L/(Vf*kjam)
    tstt = np.random.normal(0.21,0.29,1)
    localD = ((  (1-tstt)**(n+1)/normLambda ) + 1 )**(-1)
    ldd = kjam*Area*localD*MP*MP
    return ldd


def getran(MP):
    val = 4000
    m = 0.01
    s = 0.99
    lamda =1.63
    sus = []
    ran = []
    l = getLambda(MP)
    for i in range(val):
        s = s- l * m * s
        sus.append(1-s)
        ran.append(2500+i)
    return ran,sus
    

MP=0.5


for i in range(len(runX)):
    ran,sus = getran(MP)
    plt.plot(ran,sus,color='r',linewidth=3, alpha = 0.05)
    
for i in range(len(runX)):
    ysmoothed = gaussian_filter1d(runy[i], sigma=5)
    plt.plot(runX[i],ysmoothed,color='b',linewidth=3,alpha=0.05)




plt.xlim(2500,6000)
plt.xlabel('Timesteps (10 timesteps = 1 second)',fontsize=12)
plt.ylabel('Infected Population (Normalized)',fontsize=12)
plt.suptitle('Infected Population over Time (50% MP)', fontsize=15)
plt.show()
a=[]
[a.extend(x) for x in runX]
b=[]
[b.extend(x) for x in runy]
d = {'xvals':a, 'yvals':b}
df2 = pd.DataFrame(d)
# put them into a dataframe and use groupby after ordering them by time.
df2.head()
df3 = df2.groupby(['yvals'], as_index=False)['xvals'].mean()
df3.head()

plt.suptitle('test title', fontsize=20)

plt.plot(df3['xvals'],df3['yvals'])


# In[131]:


# 20 Percent
runX20 = runX
runY20 = runY
d20 = {'xvals':runX20, 'yvals':runY20}
df20 = pd.DataFrame(d20)
df3.to_csv('df3-20.csv')
df20.to_csv('df20.csv')


# In[132]:


# 35 Percent
runX35 = runX
runY35 = runY
d35 = {'xvals':runX35, 'yvals':runY35}
df35 = pd.DataFrame(d35)
df3.to_csv('df3-35.csv')
df35.to_csv('df35.csv')


# In[100]:


# 50 Percent
runX50 = runX
runY50 = runY
d50 = {'xvals':runX50, 'yvals':runY50}
df50 = pd.DataFrame(d50)
df3.to_csv('df3.csv')
df50.to_csv('df50.csv')


# In[133]:


# 100 Percent
runX100 = runX
runY100 = runY
d100 = {'xvals':runX100, 'yvals':runY100}
df100 = pd.DataFrame(d100)
df3.to_csv('df3-100.csv')
df100.to_csv('df100.csv')


# In[28]:


final = list(set(fVehs))
len(final)


# In[20]:


resDict = {}

for k in range(0,rangeVar,60,df):
    a, b = findP(k,rangeVar)
    iVehs = findInfectedVehs(b)
    resDict[a] = iVehs
    
print resDict


# In[574]:


sorted(resDict.items())


# In[1]:


resDict1 = resDict
x =  [x for x in resDict.values()]
y = [y for y in resDict.keys()]

y[38] = 1
print x,y
nx = []
for i in range(len(x)):
    
    nx.append(float(x[i])/float(y[i]))
    
plt.scatter(y,nx)
plt.ylim(0,1)
plt.show()


# In[298]:


plotDf = df
plotDf
plt.scatter(plotDf['x'],plotDf['y'])
plt.show()

