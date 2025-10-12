from subprocess import run as runCommand
import json
import sys

arguments = sys.argv[1:]

data = defaultData = {
    "status": 1,
    "desktopmusic": 1,
    "deskclock": 1,
    "activatelinux": 1,
}

defaultDataJson = json.dumps(defaultData, indent=3)

# Import the file
def loadFile():
    try:
        with open('widgets.json','r') as file:
            data = json.load(file)
    except:
        data = defaultDataJson
    return data

#Write the file
def writeFile(dataFile=defaultData):
    jsonData = json.dumps(dataFile, indent=3)
    with open('widgets.json','w') as file :
        file.write(jsonData)

def openWidgets(dataF=data):
    for x in ["status", "desktopmusic", "deskclock", "activatelinux"]:
        if dataF.get(x):
            command = ["/usr/bin/ewwii", "open", x]
            runCommand(command)
    
changeArguments = {"one", "two", "three", "four"}

try:
    data = loadFile()
except:
    pass

for argument in arguments:
    if argument in changeArguments:
        if argument == "one":
            print("One detected")
            currentState = not data.get("status")
            data.update(status = int(currentState))
        elif argument == "two":
            print("Two detected")
            currentState = not data.get("desktopmusic")
            data.update(desktopmusic = int(currentState))
        elif argument == "three":
            print("Three detected")
            currentState = not data.get("deskclock")
            data.update(deskclock = int(currentState))
        elif argument == "four":
            print("Four detected")
            currentState = not data.get("activatelinux")
            data.update(activatelinux = int(currentState))

        print(data)
        writeFile(data)
    else:
        command = ["/usr/bin/ewwii", "r"]
        if argument == "s":
            command = ["/usr/bin/ewwii", "r"]
            runCommand(command)
            openWidgets(data)
        elif argument == "r":
            command = ["ewwii","close-all"]
            runCommand(command)
            command = ["kill","-9","ewwii"]
            runCommand(command)
            command = ["ewwii","kill"]
            runCommand(command)
            command = ["ewwii", "d"]
            runCommand(command)
            openWidgets(data)
            command = ["ewwii", "r"]
            print(data)

exit()
