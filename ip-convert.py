from IPy import IP
with open(r'C:\Users\Gaoyuzhe\ipnet.txt', 'wt') as f:
	for line in open("a.txt"):
		ip=(IP(line).strNormal(3));
		print(ip.replace("-", " "),file=f)