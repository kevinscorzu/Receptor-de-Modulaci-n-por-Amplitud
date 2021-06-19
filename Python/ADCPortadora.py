samplingFrequency = 100000
samplingTime = 1 / samplingFrequency
totalSamplingTime = 1
startSamplingTime = 0.2
adcResolution = 131071 / 5
inputFileName = "../Multisim/Analogico.scp"
outputCosFileName = "../SystemVerilog/Memories/cos.txt"
outputSinFileName = "../SystemVerilog/Memories/sin.txt"

def appendZeros(binaryNumber, amount):
    while amount != 0:
        binaryNumber = "0" + binaryNumber
        amount -= 1

    return binaryNumber

def main():

    samplesAmount = 0

    with open(inputFileName, "r") as inputFile:
        with open(outputCosFileName, "w") as cosOutputFile:
            with open(outputSinFileName, "w") as sinOutputFile:
                lastSamplingTime = 0
                index = 0

                while index != 19:
                    inputFile.readline()
                    index += 1

                while True:
                    line = inputFile.readline()
                    if line == "":
                        break

                    values = line.split()
                    currentTime = float(values[0])
                    if currentTime < startSamplingTime:
                        continue

                    if currentTime >= (totalSamplingTime + startSamplingTime):
                        break

                    if currentTime >= lastSamplingTime:
                        analogCosValue = float(values[1])
                        analogSinValue = float(values[2])

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

                        binaryDigitalCosValue = appendZeros(binaryDigitalCosValue, cosBitsLeft)
                        binaryDigitalSinValue = appendZeros(binaryDigitalSinValue, sinBitsLeft)
                        
                        cosOutputFile.write(binaryDigitalCosValue + "\n")
                        sinOutputFile.write(binaryDigitalSinValue + "\n")

                        samplesAmount += 1
                        lastSamplingTime += samplingTime

    print("Amount of samples: " + str(samplesAmount))
    print("Finished")
    return

if __name__ == "__main__":
    main()