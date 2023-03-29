num = 1234567891234567
  
if(len(str(num)) == 16):
        den = (10 ** (len(str(num))-1))
        fd = round(num / den)
        print(fd)