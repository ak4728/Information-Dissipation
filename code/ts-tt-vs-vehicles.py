import csv
from shapely import geometry
import numpy as np
import pandas as pd
import operator
import matplotlib.pyplot as plt
filename = 'E:/Paramics/Dissipation Network/Log/run-008/vehicle-trajectory-07-00-00.csv' # Filename

distance = 450

reader = csv.reader(open(filename), delimiter = ",")
next(reader)


time = []
ids = [] 
x = []
y = []
z = []
uTs = sorted(list(set(time))) #around 10 minutes

for row in reader:
    time.append(row[0])
    ids.append(row[1])
    x.append(row[6])
    y.append(row[7])
    z.append(row[12])

df = pd.DataFrame({'ID':ids, 'x': x, 'y': y,'time':time, 'speed':z}, columns= ['ID','x','y','time','speed'])
df[['x', 'y','time','speed']] = df[['x', 'y','time','speed']].astype(float)
print(df.head())

def findInfectedVehs(Dictionary):
    b = Dictionary
    keyList = list(b.keys())
    compL = []
    for i,v in enumerate(keyList):
        if i == 0:
            compL.extend(b[keyList[i]])
            size = len(b[keyList[i]])
        list2=b[keyList[i]]
        #print compL, "<- Complete Set"
        #print list2, "<- New Set"
        #print 'fark',list(set(list2)-set(compL)) , "<- Difference"
        diff = list(set(list2)-set(compL))
        #print list(set(compL).intersection(list2))
        compL.extend(list2)
        size = size + len(diff)
    return size


# Ts/Tt distribution
def timeFilter(time1,time2,df):
    df = df[df["time"]<=time2].reset_index(drop=True)
    df = df[df["time"]>=time1].reset_index(drop=True)
    return df


resDict = {}

size = 1
while size<51:
    tsList = []
    # Filter dataset for selected vehicles
    #vehList = list(set(df['ID'].reset_index(drop=True))) #['11874']
    filteredVehicle = np.random.choice(vehList, size=size, replace=True, p=None)
    # Calculate Ts/Tt for 10 second periods (100 timesteps)
    totaltime = int(float(max(selected['time']))-float(min(selected['time'])))
    #print(totaltime,len(selected['time']),min(selected['time']),max(selected['time']))
    # For loop for all vehicles
    for j in range(len(filteredVehicle)):
        # Select the vehicle
        selected = df[df['ID'].isin(filteredVehicle)].reset_index(drop=True)
        # For selected vehicle compute ts/tt
        for i in range(int(min(selected['time'])),int(max(selected['time']))+10,10):
            #print("Time step: ",i)
            # Filter the dataset for values between i and i+interval
            filt2 = i
            filt3 = i+10
            # Dataframe is filtered between filt2 and filt 3 e.g.25200 and 25210
            tDf = timeFilter(filt2,filt3,selected)
            if len(tDf) <= 101:
                if len(tDf) > 0:
                    #print('length',len(tDf),i,i+10)
                    # Stopping time should be "0" to start
                    ts = 0
                    # Iterate through interval * 10 timesteps and find speed < 1
                    for l in range(len(tDf)):
                        if tDf['speed'][l]<= 5:
                            # Add it to ts
                            #print(filt2,filt3,l,i)
                            ts += 1
                    #print(ts)
                    tsList.append(ts/len(tDf))
    resDict[size] = tsList
    size = size + 1
    print(size)

li = []
for k,v in enumerate(resDict.values()):
    if k == 51:
        break
    else:
        x = np.mean(v)
        li.append(x)
        
means = []
stds = []
for i in range(1,len(li)):
    if i == 0:
        next
    else:
        means.append(np.mean(li[0:i]))
        stds.append(np.std(li[0:i]))
mdiffs = []
sdiffs = []
for i in range(1,len(means)-1):
    mdiffs.append(abs(means[i+1] - means[i])/means[i])
    sdiffs.append(abs(stds[i+1] - stds[i])/stds[i])
    
print(means[-1],stds[-1])
print(mdiffs)
print(sdiffs)
li = pd.Series(li)
#data = pd.Series(resDict[19])

binwidth = 0.1
#plt.hist(data)
#plt.hist(li)
#plt.hist(data, bins=range(min(data), max(data) + binwidth, binwidth))


plt.plot(mdiffs,'g', sdiffs, 'r')
plt.show()