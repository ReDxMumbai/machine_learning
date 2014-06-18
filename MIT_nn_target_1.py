from csv import writer

def convert(thing):
	if thing==0:
		return "1,0,0"
	elif thing==1:
		return "0,1,0"
	else:
		return "0,0,1"
		
contains=lambda bk1,bk2: bk1[0]<=bk2[0]<=bk1[1] and bk1[0]<=bk2[1]<=bk1[1]#bk2 should be entirely contained in bk1

def checkForOverlap(positives,types,bkt):
	for bracket in positives:
		if contains(bkt,bracket):
			print(bkt,"contains",bracket,"->",types[bracket])
			return types[bracket]
	return 0

WINDOW_SIZE=150 #2.5 mins window
SIGNAL_END=359520 #second by second movement
EVAL_BRACKET_START=20 #width of evaluation of apnea/hypoapnea from bracket
EVAL_BRACKET_END=60
positives=[]
types={}

with open("MIT_Health_Data_Targets2.csv") as data:
	for row in data.readlines()[2:-1]:
		D=row.split(sep=',')
		#print(D)
		if D[3]=='3\n':
			break
		start=int(D[0])
		end=int(D[2])
		type=int(D[1])
		positives.append((start,end))
		types[(start,end)]=type
windows=[]
input()
for i in range(WINDOW_SIZE+1,SIGNAL_END+2):
	#print(i-WINDOW_SIZE,i-1)
	windows.append(checkForOverlap(positives,types,(i-EVAL_BRACKET_END-1,i-EVAL_BRACKET_START-1)))
with open("MIT_nn_target_1.csv","w+") as output:
	for thing in windows:
		output.write("{0}\n".format(convert(thing)))