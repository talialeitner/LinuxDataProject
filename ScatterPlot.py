#!/usr/bin/env python3

import matplotlib.pyplot as plt
import random
import math

# will have two y-axes
fig, ax = plt.subplots()
# adjust the right side of the plot so that both y-axes fit
fig.subplots_adjust(right=.85)

# x and y for mental health professional data
x = []
y = []
label = []

data = open("ZIPProfIncome.txt")
line = data.readline()
while line:
    fields = line.split("|")

    # remove outliers from the plot
    if float(fields[2]) > 20000 and float(fields[2]) <= 200000 and float(fields[1]) <= .06:
        # field 2 is the average income
        x.append(float(fields[2]))
        # field 1 is the professionals per capita
        y.append(float(fields[1]))
        # field 0 is the zip code
        label.append(str(fields[0]))
        
    line = data.readline()

# x and y for mental health emergency data
x2 = []
y2 = []
label2 = []

data2 = open("ZIPEmergencyIncome.txt")
line = data2.readline()
while line:
    fields = line.split("|")

    # remove outliers from the plot
    if float(fields[2]) > 20000 and float(fields[2]) <= 200000 and float(fields[1]) <= 1:
        # field 2 is the average income
        x2.append(float(fields[2]))
        # field 1 is the emergencies per capita
        y2.append(float(fields[1]))
        # field 0 is the zip code
        label2.append(str(fields[0]))
        
    line = data2.readline()

#plot the emergency data
ax.scatter(x2, y2, color='red')
    
plt.xlabel("Average Income")
plt.ylabel("Mental Health Emergencies per Capita (RED)")

# create the second y axis (with the same x axis)
ax2 = ax.twinx()

#plot the professional data
ax2.scatter(x, y, color='blue')
    
plt.ylabel("Mental Health Professionals per Capita (BLUE)")

plt.show()
fig.savefig("ScatterPlot.pdf")
