from shapely import geometry
import pandas as pd

filename = 'data.csv' # Filename
# Create a message
point_1 = geometry.Point(2260.83, 4098.07)
# create your circle buffer from one of the points
distance = 50

df = pd.read_csv(filename)
df.head()

ts = df["transtime"]

rangeVar = len(ts)

for i in range(10):
    dfFiltered = df[df["transtime"]==ts[i]]
    dfFiltered=dfFiltered.reset_index(drop=True)
    varLen = len(dfFiltered["transtime"])
    print varLen
    if(varLen>0):
        print "okay"
        for j in range(varLen):
            circle_buffer = point_1.buffer(distance)
            print dfFiltered["x"][j],dfFiltered["y"][j]
            point_2 = geometry.Point(dfFiltered["x"][j],dfFiltered["y"][j])
            print point_2
            # and you can then check if the other point lies within
            if point_2.within(circle_buffer):
                print('point 2 is within the distance buffer of point 1')
                print point_2, dfFiltered["ID"][j]