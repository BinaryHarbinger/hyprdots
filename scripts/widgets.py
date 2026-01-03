from subprocess import run as system_command
import json
import sys
import os
from time import sleep
from pathlib import Path

from dot_utils import is_running, kill_process

arguments = sys.argv[1:]

HOME = os.path.expanduser("~")

JSON_PATH = Path("~/.config/binarydots/widget_states.json").expanduser()

data = default_data = {
    "status": 1,
    "desktopmusic": 1,
    "deskclock": 1,
    "activatelinux": 1,
}

default_data_json = json.dumps(default_data, indent=3)

def reload_widgets():
    if is_running("ewwii"):
        system_command(["ewwii", "close-all"])
        kill_process("ewwii")
    while not is_running("ewwii"):
        system_command(["ewwii", "d"])
        sleep(0.2)
    open_widgets(data)


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
    JSON_PATH.parent.mkdir(parents=True, exist_ok=True)
    jsonData = json.dumps(dataFile, indent=3)
    with open(JSON_PATH, 'w') as file:
        file.write(jsonData)

def open_widgets(dataF=data):
    for x in ["status", "desktopmusic", "deskclock", "activatelinux"]:
        if dataF.get(x):
            command = ["ewwii", "open", x]
            system_command(command)

widget_arguments = {"status", "deskclock", "desktopmusic", "activatelinux", "activate"}

try:
    data = load_file()
except:
    pass

for argument in arguments:
    if argument.lower() in widget_arguments:
        argument = argument.lower()
        if argument == "status":
            print("Status detected")
            currentState = not data.get("status")
            data.update(status=int(currentState))
        elif argument == "desktopmusic":
            print("Desktop Music detected")
            currentState = not data.get("desktopmusic")
            data.update(desktopmusic=int(currentState))
        elif argument == "deskclock":
            print("Desktop Clock detected")
            currentState = not data.get("deskclock")
            data.update(deskclock=int(currentState))
        elif argument in ["activate", "activatelinux"]:
            print("Activation detected")
            argument = "activatelinux"
            currentState = not data.get("activatelinux")
            data.update(activatelinux=int(currentState))
        system_command(["ewwii", "open", "--toggle", argument])
        print(data)
        write_file(data)
    else:
        if argument in ["s", "init", "i"]:
           reload_widgets() 
        elif argument in ["r", "reload"]:
            reload_widgets() 
            print(data)
