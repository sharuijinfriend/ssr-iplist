from IPy import IP
with open(r'./chn_ip.txt', 'wt') as f:
	for line in open("ip_ranges.txt"):
		ip=(IP(line).strNormal(3));
		print(ip.replace("-", " "),file=f)
