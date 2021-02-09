#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import sys
import csv

file = open(sys.argv[1],"r")
strcount= []
while True:
    line = file.readline()
    if line == "":
        break
    else:
        strcount.append(int(line.replace("\n","")))
        
file = open(sys.argv[2],"r")
genomelength= int(file.readline().replace("\n",""))

        
file = open(sys.argv[3],"r")
strbase= int(file.readline().replace("\n",""))


species_name= sys.argv[4]

filename = sys.argv[5]
filepath = "/storage/mgymrek/TReeofLife/SnakemakeTest/"+filename


# In[ ]:
strnumsum = sum(strcount)

strpercent = []
for i in range(0,len(strcount)):
    strpercent.append(strcount[i]/strnumsum)


# In[ ]:
final = []
row = []
for i in strcount:
    row.append(i)
for k in strpercent:
    row.append(k)
row.append(genomelength)
row.append(strbase)
row.append(strbase/genomelength)
row.append(strnumsum)
row.append(strnumsum/genomelength)


final.append(species_name)

for n in row:
    final.append(str(n))
# In[ ]:
print(final)

from csv import writer

with open(filepath, 'a+', newline='') as write_obj:
        # Create a writer object from csv module
    csv_writer = writer(write_obj)
        # Add contents of list as last row in the csv file
    csv_writer.writerow(final)

#with open(, 'w') as csvfile:
#    csvwriter = csv.writer(csvfile,delimiter=',')
#    csvwriter.writerow(final)
