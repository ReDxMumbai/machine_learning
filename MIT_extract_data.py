"""Extracts out the target data for St. Bernard's Sleep Apnea Diagnostic dataset
   Merges all *.txts to one .csv file
   Attaches source signal file name for convenient training
   Some Desat values are missing, missing values have been replaced with -ve values
   In the future, I may just simply delete those datapoints instead.
   Values with PB/CS markings are deleted because they are not necessary for our ML task"""

from csv import writer

def prop(x):
	if(x<10):
		return '0{0}'.format(x)
	else:
		return x
		
def convertToSeconds(line):
	return int(line[0:2])*3600+int(line[3:5])*60+int(line[6:])
	
def apneaAsciiToInt(x):
	if x[0]=="H":
		return 1
	elif x[0]=="A":
		return 2
	elif(x[0]=='P'):
		return 3
	else:
		return 0
		
def plusMinusToInt(x):
	if x=='-':
		return 0
	else:
		return 1
		
data=[]

for num in range(2,29):
	try:
		base="ucddb0{0}_respevt.txt".format(prop(num))
		with open(base,'r') as f:
			for line in f.readlines()[3:-1]:
				temp=line.split()
				if(temp[1]=='PB'):
					continue
				start=convertToSeconds(temp[0])
				apneaState=apneaAsciiToInt(temp[1])
				end=start+int(temp[2])
				desat_low=float(temp[3])
				desat_drop=float(temp[4])
				snore=plusMinusToInt(temp[5])
				arousal=plusMinusToInt(temp[6])
				if(len(temp)>7):
					rate=float(temp[7])
					change=float(temp[8])
				else:
					rate=""
					change=""
				#data.append([start,apneaState,end,desat_low,desat_drop,snore,arousal,rate,change,num])
				data.append([start,apneaState,end,num])
	except FileNotFoundError:
		print("{0} file missing".format(base))
		continue
	except ValueError as e:
		print(e)
		print(base+temp[0])
		
with open('MIT_Health_Data_Targets2.csv','w+') as out:
	#out.write("start,apnea_state,end,saturation_low,saturation_drop,snore_state,arousal,rate,change,source_file\n")
	out.write("{0} {1}\n".format(len(data),len(data[0])))
	out.write("start,apnea_state,end,source_file\n")
	csv_writer=writer(out)
	csv_writer.writerows(data)
