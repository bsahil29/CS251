string1 = raw_input("Enter the number in base b ");
flag=0;
if string1[0]=='-':
	flag=1;
	string=string1[1:]
else:
	string=string1[0:]
base = input("Enter the base value ");
def lengthof(string):
	count=0;
	for i in string:
		count=count+1;
	return count;
length=lengthof(string)
string2=''
string3=''
for i in range(0,length):
	if string[i] != '.':
		string2+=string[i]
	else:
		string3=string[i+1:]
		break
value = {
				'0' : 0,
                '1' : 1,
                '2' : 2,
                '3' : 3,
                '4' : 4,
                '5' : 5,
                '6' : 6,
                '7' : 7,
                '8' : 8,
                '9' : 9,
                'A' : 10,
                'B' : 11,
                'C' : 12,
                'D' : 13,
                'E' : 14,
                'F' : 15,
                'G' : 16,
                'H' : 17,
                'I' : 18,
                'J' : 19,
                'K' : 20,
                'L' : 21,
                'M' : 22,
                'N' : 23,
                'O' : 24,
                'P' : 25,
                'Q' : 26,
                'R' : 27,
                'S' : 28,
                'T' : 29,
                'U' : 30,
                'V' : 31,
                'W' : 32,
                'X' : 33,
                'Y' : 34,
                'Z' : 35,
};
def beforedecimal(string, base):
    length = lengthof(string);
    pow = 1; 
    num = 0; 
    for i in range(length-1,-1,-1):
    	if string[i] not in value:
    		print "Invalid input";
           	exit();
    for i in range(length-1,-1,-1):
        if value[string[i]] >= base:
           	print "Invalid input";
           	exit();
        num += value[string[i]] * pow;
        pow = pow * base;
    global flag
    #if flag==1:
    #	return -num
    #else:
    return num
def afterdecimal(string, base):
    length = lengthof(string);
    pow = base; 
    num2 = 0; 
    for i in range(0,length):
    	if string[i] not in value:
    		print "Invalid input";
           	exit();
    for i in range(0,length):
        if value[string[i]] >= base:
           	print "Invalid input";
           	exit();
        num2 += float(value[string[i]]) / pow;
        pow = pow * base;
    return num2
ans1=beforedecimal(string2,base)
ans2=afterdecimal(string3,base)
if ans2==0:
	if flag==1:
		print -ans1
	else:
		print ans1
else:
	if flag==1:
		print -(ans1+ans2)
	else:
		print ans1+ans2