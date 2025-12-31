from subprocess import run as system_command
import json
import sys
import os

arguments = sys.argv[1:]

HOME = os.path.expanduser("~")
JSON_PATH = os.path.join(
    HOME, "Dotfiles", "resources", "data", "widget_states.json"
)

data = default_data = {
    "status": 1,
    "desktopmusic": 1,
    "deskclock": 1,
    "activatelinux": 1,
}

default_data_json = json.dumps(default_data, indent=3)

# Import the file
def load_file():
    try:
        with open(JSON_PATH, 'r') as file:
            data = json.load(file)
    except (FileNotFoundError, json.JSONDecodeError):
        data = default_data.copy()  # <- return dict
    return data


# Write the file
def write_file(dataFile=default_data):
    jsonData = json.dumps(dataFile, indent=3)
    with open(JSON_PATH, 'w') as file:
        file.write(jsonData)

def open_widgets(dataF=data):
    for x in ["status", "desktopmusic", "deskclock", "activatelinux"]:
        if dataF.get(x):
            command = ["ewwii", "open", x]
            system_command(command)

widget_arguments = {"one", "two", "three", "four"}

try:
    data = load_file()
except:
    pass

for argument in arguments:
    if argument in widget_arguments:
        if argument == "one":
            print("One detected")
            currentState = not data.get("status")
            data.update(status=int(currentState))
        elif argument == "two":
            print("Two detected")
            currentState = not data.get("desktopmusic")
            data.update(desktopmusic=int(currentState))
        elif argument == "three":
            print("Three detected")
            currentState = not data.get("deskclock")
            data.update(deskclock=int(currentState))
        elif argument == "four":
            print("Four detected")
            currentState = not data.get("activatelinux")
            data.update(activatelinux=int(currentState))

        print(data)
        write_file(data)
    else:
        command = ["ewwii", "r"]
        if argument == "s":
            system_command(command)
            open_widgets(data)
        elif argument == "r":
            system_command(["ewwii", "close-all"])
            system_command(["pkill", "ewwii"])
            system_command(["ewwii", "kill"])
            system_command(["ewwii", "d"])
            open_widgets(data)
            system_command(["ewwii", "r"])
            print(data)
