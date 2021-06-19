inputMessage1FileName = "../SystemVerilog/simulation/modelsim/message1.txt"
inputMessage2FileName = "../SystemVerilog/simulation/modelsim/message2.txt"
outputMessage1FileName = "../Octave/message1.txt"
outputMessage2FileName = "../Octave/message2.txt"

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

def binaryToDecimal(binaryNumber, sign):
    exp = 15
    index = 0
    result = 0

    while index != 32:
        result += int(binaryNumber[index]) * (2 ** exp)
        index += 1
        exp -= 1

    if sign == "1":
        return result * -1
    else:
        return result

def main():
    with open(inputMessage1FileName, "r") as inputMessage1File:
        with open(inputMessage2FileName, "r") as inputMessage2File:
            with open(outputMessage1FileName, "w") as outputMessage1File:
                with open(outputMessage2FileName, "w") as outputMessage2File:

                    while True:
                        binaryM1Value = inputMessage1File.readline()
                        binaryM2Value = inputMessage2File.readline()

                        if binaryM1Value == "" or binaryM2Value == "":
                            break

                        binaryM1Value = binaryM1Value.replace("\n", "")
                        binaryM2Value = binaryM2Value.replace("\n", "")

                        m1Sign = binaryM1Value[0]
                        m2Sign = binaryM2Value[0]

                        if m1Sign == "1":
                            binaryM1Value = twosComplement(binaryM1Value)

                        if m2Sign == "1":
                            binaryM2Value = twosComplement(binaryM2Value)

                        m1Value = binaryToDecimal(binaryM1Value, m1Sign)
                        m2Value = binaryToDecimal(binaryM2Value, m2Sign)

                        outputMessage1File.write(str(m1Value) + "\n")
                        outputMessage2File.write(str(m2Value) + "\n")


    print("Finished")
    return

if __name__ == "__main__":
    main()