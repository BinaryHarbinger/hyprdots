
---
<div style="text-align: center;">
<pre>
██████╗ ██╗███╗   ██╗ █████╗ ██████╗ ██╗   ██╗██████╗  ██████╗ ████████╗███████╗
██╔══██╗██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝
██████╔╝██║██╔██╗ ██║███████║██████╔╝ ╚████╔╝ ██║  ██║██║   ██║   ██║   ███████╗
██╔══██╗██║██║╚██╗██║██╔══██║██╔══██╗  ╚██╔╝  ██║  ██║██║   ██║   ██║   ╚════██║
██████╔╝██║██║ ╚████║██║  ██║██║  ██║   ██║   ██████╔╝╚██████╔╝   ██║   ███████║
╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝
</pre>
</div>

---

## Features

- Powerfull system menu (SUPER + U)
- System wide themes
- Aesthetic widgets powered by <a href="https://github.com/Ewwii-sh/ewwii/tree/main">ewwii</a>
- Auto-install script (designed for Arch-based distros)
- Git based update system

## BinaryDots are powered by 
- [Riftbar](https://github.com/BinaryHarbinger/riftbar) (GTK4 waybar alternative written with rust)
- [ewwii](https://github.com/Ewwii-sh/ewwii/tree/main) (GTK4 and feature-fulll rewrite of eww)
- [Walker](https://github.com/abenz1267/walker) (GTK4 applicaton launcher and dmenu alternative written with rust)
- [Hyprland](https://hypr.land/) (Modern compositor with the looks)

## Example Photos
<details>
  <summary>Click to extend</summary>

<details><summary>
🔍 Walker
</summary></p>

![image](https://raw.githubusercontent.com/BinaryHarbinger/binarydots/main/preview/Walker.png)

<p></details>

<details><summary>
⚙️ System Menu
</summary></p>

![image](https://raw.githubusercontent.com/BinaryHarbinger/binarydots/main/preview/SystemMenu.png)

<p></details>

<details><summary>
🚀 Quick Settings (Powered by <a href="https://github.com/Ewwii-sh/ewwii/tree/main">ewwii</a>) 
</summary></p>

![image](https://raw.githubusercontent.com/BinaryHarbinger/binarydots/main/preview/QuickSettings.png)

<p></details>

<details><summary>
🔔 Notification Menu
</summary></p>

![image](https://raw.githubusercontent.com/BinaryHarbinger/binarydots/main/preview/MakoWalker.png)

<p></details>

<details><summary>
🌐 qutebrowser
</summary></p>

![image](https://raw.githubusercontent.com/BinaryHarbinger/binarydots/main/preview/QuteBrowser.png)

<p></details>

<details><summary>
⌨️ Terminal Applications
</summary></p>

![image](https://raw.githubusercontent.com/BinaryHarbinger/binarydots/main/preview/Terminal.png)

<p></details>

<details><summary>
💻 Desktop Widgets (Powered by <a href="https://github.com/Ewwii-sh/ewwii/tree/main">ewwii</a>) 
</summary></p>

![image](https://raw.githubusercontent.com/BinaryHarbinger/binarydots/main/preview/Desktop.png)

<p></details>
</details>

---

## Requirements


**Recommended base**: Arch Linux or Arch-based distro (EndeavourOS, Manjaro, etc.).

**Optional/hardware**:
- NVIDIA users: proprietary `nvidia-dkms` often required.
- Ensure `multilib` enabled on Arch if you need 32-bit libs for some apps.

## How to install?

> [!WARNING]
> Using [Chaotic AUR](https://aur.chaotic.cx/docs) is highly recommended!

Run this command to install:
```
curl -fsSL -o install.sh https://raw.githubusercontent.com/BinaryHarbinger/binarydots/main/install.sh && chmod +x install.sh && ./install.sh
```

# Installing manualy (For non-Arch based distros)

> [!WARNING]
> I don't really recommend installing manually or using with non-Arch based distros.
> BinaryDots uses some patched packages from AUR.
> Install script uses symlinks for most of the configuration files. Without symlinks scripts will break.

» Compile or install all applications in PACKAGES file.

» Put repository in your home directory as `Dotfiles`

» Symlink all folders under `config` to `~/.config/`

» Run `bash ~/Dotfiles/bin/change-theme -c Binary`

---

## Check other Binary themes

[SDDM](https://github.com/BinaryHarbinger/sddm-binary-theme)
[Heroic Games Launcher](https://github.com/BinaryHarbinger/Heroic-Games-Launcher-Binary-Theme)


---

