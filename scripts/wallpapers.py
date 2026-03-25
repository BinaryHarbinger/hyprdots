#!/usr/bin/env python
import argparse
import os
import subprocess
import sys
from time import sleep
from pathlib import Path

from dot_utils import is_running, kill_process

WALLPAPER_DATA = Path("~/.config/binarydots/wallpaper.txt").expanduser()
HOME = os.path.expanduser("~")
WALLPAPER_DIR = os.path.join(HOME, "Dotfiles", "resources", "wallpapers")
WALLPAPER_SCRIPT = os.path.join(HOME, "Dotfiles", "bin", "wallpaper")
HYPR_WALL = os.path.join(HOME, ".config", "hypr", "wallppr.png")

def window_manager_running():
    return is_running("dwl") or is_running("hyprland") or is_running("start-hyprland") or is_running("Hyprland")

def wallpapers():
    return sorted(
        os.path.splitext(f)[0]
        for f in os.listdir(WALLPAPER_DIR)
        if f.lower().endswith((".png", ".jpg", ".gif", ".mp4"))
    )

def list_wallpapers():
    for w in wallpapers():
        print(f" {w}")


def resolve_wallpaper(name: str) -> str:
    name = name.strip()

    if os.path.isabs(name) and os.path.isfile(name):
        return name

    if os.path.isfile(name):
        return os.path.abspath(name)

    clean = name.replace("", "").strip()
    for ext in (".png", ".jpg", ".gif", ".mp4"):
        candidate = os.path.join(WALLPAPER_DIR, clean + ext)
        if os.path.isfile(candidate):
            return candidate

    raise FileNotFoundError(f"No wallpaper named '{name}'")


def set_wallpaper(name: str, theme: bool = False):
    path = resolve_wallpaper(name)

    os.symlink(path, HYPR_WALL + ".tmp")
    os.replace(HYPR_WALL + ".tmp", HYPR_WALL)
    if not window_manager_running():
        print("Hyprland is not running exiting.")
        sys.exit(0)
    if ".mp4" in path:
        is_mp4 = True
    else:
        is_mp4 = False

    if is_mp4 and is_running("ewwii"):
        kill_process("ewwii")

    if not is_mp4: 
        if is_running("mpvpaper"):
            kill_process("mpvpaper")
        if not is_running("swww-daemon"):
            subprocess.Popen(
            [
                "swww-daemon"
            ],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            start_new_session=True,
        )
        sleep(1.22)
        subprocess.Popen(
            [
                "swww", "img", path,
                "--transition-fps", "60",
                "--transition-step", "255",
                "--transition-type", "wipe",
                "--transition-angle", "30",
            ],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            start_new_session=True,
        )
    else:
        for wall_app in ["swww-daemon", "mpvpaper"]:
            if is_running(wall_app): 
                kill_process(wall_app)

        subprocess.Popen(
        [
            "mpvpaper", "ALL", path,
            "--mpv-options=--no-config "
            "--no-input-default-bindings "
            "--no-input-builtin-bindings "
            "--no-osc "
            "--osd-level=0 "
            "--loop-file=inf "
            "--vf=fps=30"
        ],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        start_new_session=True,
        )
        while not is_running("mpvpaper"):
            sleep(0.5)
    while not is_running("riftbar"):
        sleep(0.3)
    if not is_running("ewwii"):
        os.system("python ~/Dotfiles/scripts/widgets.py r")

    write_last_wallpaper(path) 


def write_last_wallpaper(name: str):
    WALLPAPER_DATA.parent.mkdir(parents=True, exist_ok=True)
    WALLPAPER_DATA.write_text(name + "\n", encoding="utf-8")

def read_last_wallpaper():
    return WALLPAPER_DATA.read_text(encoding="utf-8").strip()

def initialaze():
    path = read_last_wallpaper()
    set_wallpaper(path)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-l", "--list", action="store_true", help="List wallpapers")
    parser.add_argument("-t", "--theme_set", action="store_true", help="Call when setting theme")
    parser.add_argument("-s", "--set", metavar="NAME", help="Set wallpaper")
    parser.add_argument("-i", "--init", action="store_true", help="Initialize wallpaper")

    if len(sys.argv) == 1:
        parser.print_help()
        sys.exit(0)

    args = parser.parse_args()

    if args.list:
        list_wallpapers()
    elif args.set:
        set_wallpaper(args.set)
    elif args.init:
        initialaze()
    elif args.theme_set:
        print("")
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
