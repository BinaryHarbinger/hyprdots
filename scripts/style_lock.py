import json
import sys

arguments = sys.argv[1:]

data = defaultData = {
    "Waybar": 0,
    "Widgets": 0,
    "Wallpaper": 0,
}

defaultDataJson = json.dumps(defaultData, indent=3)

# Import the file
def loadFile():
    try:
        with open('lock_data.json','r') as file:
            data = json.load(file)
    except:
        data = defaultData
    return data

# Write the file
def writeFile(dataFile=defaultData):
    jsonData = json.dumps(dataFile, indent=3)
    with open('lock_data.json','w') as file :
        file.write(jsonData)

# List options for dmenu
def print_dmenu(dataF=data):
    for x in dataF:
        if not dataF.get(x):
            print_format = "  " + x
        else:
            print_format = "  " + x
        print(print_format)

changeArguments = {"Waybar", "Widgets", "Wallpaper"}

try:
    data = loadFile()
except:
    pass

for argument in arguments:
    if "get_state" == argument:
        for name in data:
            print(data.get(name))
    elif argument in changeArguments:
        if argument == "Waybar":
            currentState = not data.get("Waybar")
            data.update(Waybar = int(currentState))
        elif argument == "Widgets":
            currentState = not data.get("Widgets")
            data.update(Widgets = int(currentState))
        elif argument == "Wallpaper":
            currentState = not data.get("Wallpaper")
            data.update(Wallpaper = int(currentState))
        print("Chaning lock of '"+argument+"'")

        print(data)
        writeFile(data)
    elif argument == "dmenu":
        print_dmenu(loadFile())

exit()
