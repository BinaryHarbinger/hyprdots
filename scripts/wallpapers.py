#!/usr/bin/env python
import argparse
import os
import subprocess
import sys

HOME = os.path.expanduser("~")
WALLPAPER_DIR = os.path.join(HOME, "Dotfiles", "resources", "wallpapers")
WALLPAPER_SCRIPT = os.path.join(HOME, "Dotfiles", "bin", "wallpaper")
HYPR_WALL = os.path.join(HOME, ".config", "hypr", "wallppr.png")

def wallpapers():
    return sorted(
        os.path.splitext(f)[0]
        for f in os.listdir(WALLPAPER_DIR)
        if f.lower().endswith((".png", ".jpg"))
    )

def list_wallpapers():
    for w in wallpapers():
        print(f" {w}")

def resolve_wallpaper(name: str) -> str:
    name = name.replace("", "").strip()

    for ext in (".png", ".jpg"):
        path = os.path.join(WALLPAPER_DIR, name + ext)
        if os.path.isfile(path):
            return path

    raise FileNotFoundError(f"No wallpaper named '{name}'")

def set_wallpaper(name: str):
    path = resolve_wallpaper(name)

    os.symlink(path, HYPR_WALL + ".tmp")
    os.replace(HYPR_WALL + ".tmp", HYPR_WALL)

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

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-l", "--list", action="store_true", help="List wallpapers")
    parser.add_argument("-s", "--set", metavar="NAME", help="Set wallpaper")

    if len(sys.argv) == 1:
        parser.print_help()
        sys.exit(0)

    args = parser.parse_args()

    if args.list:
        list_wallpapers()
    elif args.set:
        set_wallpaper(args.set)
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
