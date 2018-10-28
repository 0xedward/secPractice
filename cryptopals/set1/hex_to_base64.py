#create a dictionary for base64

#iterate through each binary value and sum up each 6 bit to the corresponding base64 value
def hexToBase64(string):
    binary = bin(int(string,16)) #convert string -> integer -> binary
    print(binary)
    base = 6
    mask = '111111'
    rv = ""
    while (binary != 0):
        bit = 1
        while (base >= bit):
            if binary & bit:
                yield bit
            bit = bit << 1
        print(bit)
        rv.append(bit)
    print(rv)
    return rv

#iterate through each hex value and next two binary values and map to corresponding base64 value
#def hexToBase64fast(str):
 #   while (str.length() != 0):
  #      for (i = 0; i < 4; i++):
   #         str.substring(0, 1)

# apply mask to each iteration until remaining bit string is < 6, then use a tail case to sum the rest. 

print(hexToBase64("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"))
