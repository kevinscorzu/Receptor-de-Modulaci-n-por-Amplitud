adcResolution = 131071 / 5
inputCosFileName = "costest.txt"
inputSinFileName = "sintest.txt"

outputCosFileName = "../SystemVerilog/Memories/cos.txt"
outputSinFileName = "../SystemVerilog/Memories/sin.txt"

def appendZeros(binaryNumber, amount, direction):
    while amount != 0:
        if direction == 0:
            binaryNumber = "0" + binaryNumber
            amount -= 1
        else:
            binaryNumber = binaryNumber + "0"
            amount -= 1

    return binaryNumber

def main():

    samplesAmount = 0

    with open(inputCosFileName, "r") as cosInputFile:
        with open(inputSinFileName, "r") as sinInputFile:
            with open(outputCosFileName, "w") as cosOutputFile:
                with open(outputSinFileName, "w") as sinOutputFile:

                    while True:
                        cosValue = cosInputFile.readline()
                        sinValue = sinInputFile.readline()
                        if cosValue == "" or sinValue == "":
                            break

                        analogCosValue = float(cosValue)
                        analogSinValue = float(sinValue)

                        if analogCosValue < 0:
                            analogCosValue = 0

                        if analogSinValue < 0:
                            analogSinValue = 0

                        if analogCosValue > 5:
                            analogCosValue = 5

                        if analogSinValue > 5:
                            analogSinValue = 5

                        digitalCosValue = analogCosValue * adcResolution
                        digitalSinValue = analogSinValue * adcResolution

                        binaryDigitalCosValue = bin(abs(int(digitalCosValue))).replace("0b", "")
                        binaryDigitalSinValue = bin(abs(int(digitalSinValue))).replace("0b", "")

                        cosBitsLeft = 32 - len(binaryDigitalCosValue)
                        sinBitsLeft = 32 - len(binaryDigitalSinValue)

                        binaryDigitalCosValue = appendZeros(binaryDigitalCosValue, cosBitsLeft, 0)
                        binaryDigitalSinValue = appendZeros(binaryDigitalSinValue, sinBitsLeft, 0)

                        cosOutputFile.write(binaryDigitalCosValue + "\n")
                        sinOutputFile.write(binaryDigitalSinValue + "\n")

                        samplesAmount += 1
                            

    print("Amount of samples: " + str(samplesAmount))
    print("Finished")
    return

if __name__ == "__main__":
    main()