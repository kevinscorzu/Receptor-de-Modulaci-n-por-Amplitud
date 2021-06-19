inputFileName = "../Octave/data_mod.txt"
outputFileName = "../SystemVerilog/Memories/message.txt"

def appendZeros(binaryNumber, amount, direction):
    while amount != 0:
        if direction == 0:
            binaryNumber = "0" + binaryNumber
            amount -= 1
        else:
            binaryNumber = binaryNumber + "0"
            amount -= 1

    return binaryNumber

def twosComplement(binaryNumber):
    bits = len(binaryNumber) - 1
    binaryNumberAux = ""
    binaryNumberAux2 = ""

    for bit in binaryNumber:
        if bit == "0":
            binaryNumberAux += "1"
        else:
            binaryNumberAux += "0"
    
    while bits != -1:
        if binaryNumberAux[bits] == "1":
            binaryNumberAux2 = "0" + binaryNumberAux2
            bits -= 1
        else:
            binaryNumberAux2 = "1" + binaryNumberAux2
            bits -= 1
            break
    
    while bits != -1:
        binaryNumberAux2 = binaryNumberAux[bits] + binaryNumberAux2
        bits -= 1   

    return binaryNumberAux2

def floatToBinary(number):
    calculatedValues = []

    while True:
        if (len(calculatedValues) == 16):
            break

        result = number * 2
        intResult = int(result)
        floatResult = abs(abs(result) - abs(intResult))

        calculatedValues.append(str(intResult))

        if (floatResult == 0):
            break
        else:
            number = floatResult

    binaryFloat = ""
    for value in calculatedValues:
        binaryFloat = binaryFloat + value

    return binaryFloat

def main():
    with open(inputFileName, "r") as inputFile:
        with open(outputFileName, "w") as outputFile:
            
            while True:
                line = inputFile.readline()
                if line == "":
                    break

                value = float(line)
                
                if value < 0:
                    sign = 1
                else:
                    sign = 0

                intPart = abs(int(value))
                binaryInt = bin(intPart).replace("0b", "")
                currentIntBits = 16 - len(binaryInt)
                binaryInt = appendZeros(binaryInt, currentIntBits, 0)

                floatPart = abs(abs(value) - abs(intPart))
                binaryFloat = floatToBinary(floatPart)
                currentFloatBits = 16 - len(binaryFloat)
                binaryFloat = appendZeros(binaryFloat, currentFloatBits, 1)

                binaryNumber = binaryInt + binaryFloat

                if sign == 1 and binaryNumber.find("1") != -1:
                    binaryNumber = twosComplement(binaryNumber)

                outputFile.write(binaryNumber + "\n")
               
    print("Finished")
    return

if __name__ == "__main__":
    main()