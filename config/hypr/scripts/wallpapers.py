import os
import sys
from subprocess import run as runCommand

path = "/home/"+os.getlogin()+'/.config/binarydots/wallpapers/'

image_dict = {}

image_dict = os.listdir(path)

def printImageNames(image_dictionoary=image_dict):
    for imageName in image_dictionoary:
        imageName = imageName.split(".png")[0]
        imageName = imageName.split(".jpg")[0]
        print(' ',imageName)

arguments = sys.argv[1:]

firstArgument = arguments[0]

if firstArgument =="echoImageNames":
        printImageNames()
elif firstArgument == "changeWallpaper":
    argument = " ".join(arguments[1:])
    print(argument)

    if " " in argument:
        argument = argument.split(" ")[1]
    print(argument)

    imageNamePNG = argument+".png"
    imageNameJPG = argument+".jpg"

    scriptPath = "/home/"+os.getlogin()+"/.config/scripts/wallpaper"

    if imageNamePNG in image_dict:
        imagePath = path+imageNamePNG
        print("PNG detected:", imagePath)
        command = [scriptPath, "--set", imagePath]
        runCommand(command)

    elif imageNameJPG in image_dict:
        imagePath = path+imageNameJPG
        print("JPG detected:", imagePath)
        command = [scriptPath, "--set", imagePath]
        runCommand(command)
