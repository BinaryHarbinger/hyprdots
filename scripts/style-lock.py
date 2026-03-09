import json
import sys
import os

arguments = sys.argv[1:]

HOME = os.path.expanduser("~")
JSON_PATH = os.path.join(
    HOME, ".config", "binarydots", "style_lock_data.json"
)

default_data = {
    "Riftbar": 0,
    "Widgets": 0,
    "Wallpaper": 0,
}

data = default_data.copy()


# Import the file
def load_file():
    try:
        with open(JSON_PATH, "r") as file:
            loaded = json.load(file)

        # If file is empty or missing keys, restore defaults
        if not isinstance(loaded, dict):
            return default_data.copy()

        for key in default_data:
            loaded.setdefault(key, default_data[key])

        return loaded

    except (FileNotFoundError, json.JSONDecodeError):
        return default_data.copy()


# Write the file
def write_file(data_file):
    os.makedirs(os.path.dirname(JSON_PATH), exist_ok=True)
    with open(JSON_PATH, "w") as file:
        json.dump(data_file, file, indent=3)


# List options for dmenu
def print_dmenu(data_file):
    for x in data_file:
        if not data_file.get(x):
            print("  " + x)
        else:
            print("  " + x)


widget_arguments = {"Riftbar", "Widgets", "Wallpaper"}

data = load_file()

for argument in arguments:
    argument = argument.lower()

    if argument == "get_state":
        for name in data:
            print(data.get(name))

    elif argument == "riftbar":
        data["Riftbar"] = int(not data["Riftbar"])
        write_file(data)

    elif argument == "widgets":
        data["Widgets"] = int(not data["Widgets"])
        write_file(data)

    elif argument == "wallpaper":
        data["Wallpaper"] = int(not data["Wallpaper"])
        write_file(data)

    elif argument == "dmenu":
        print_dmenu(data)
