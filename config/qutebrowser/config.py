# qutebrowser config.py

config.load_autoconfig(False)

import os, sys
import re
from pathlib import Path

sys.path.append(os.path.join(os.path.expanduser('~'), ".config/qutebrowser/"))

SCSS_VAR_REGEX = re.compile(
    r'^\s*\$(?P<name>[a-zA-Z0-9_-]+)\s*:\s*(?P<value>.+?)\s*;'
)
REF_REGEX = re.compile(r'^\$(?P<name>[a-zA-Z0-9_-]+)$')

def scss_name_to_python(name: str) -> str:
    return name.replace("-", "_").lower()

def parse_scss_variables(text: str) -> dict:
    raw = {}
    for line in text.splitlines():
        match = SCSS_VAR_REGEX.match(line)
        if not match:
            continue
        py_name = scss_name_to_python(match.group("name"))
        value = match.group("value").strip()
        raw[py_name] = value
    return raw

def resolve_variables(raw: dict) -> dict:
    resolved = {}
    resolving = set()

    def resolve(name: str):
        if name in resolved:
            return resolved[name]
        if name in resolving:
            raise RuntimeError(f"Circular SCSS variable reference involving {name}")
        resolving.add(name)
        value = raw[name]
        ref_match = REF_REGEX.match(value)
        if ref_match:
            target = scss_name_to_python(ref_match.group("name"))
            if target not in raw:
                raise KeyError(f"Unknown SCSS variable ${ref_match.group('name')}")
            resolved[name] = resolve(target)
        else:
            resolved[name] = value
        resolving.remove(name)
        return resolved[name]

    for key in raw:
        resolve(key)

    return resolved

# --- Load SCSS at runtime ---
THEME_SCSS = Path.home() / ".config/qutebrowser/newtab/static/theme.scss"
if THEME_SCSS.exists():
    raw_vars = parse_scss_variables(THEME_SCSS.read_text(encoding="utf-8"))
    THEME = resolve_variables(raw_vars)
else:
    THEME = {}

fg_main = THEME.get("fg_main", "#b4befe")
bg_main = THEME.get("bg_main", "#11111b")
bg_hover = THEME.get("bg_hover", "#484872")
bg_second = THEME.get("bg_second", "#33334c")
bg_third = THEME.get("bg_third", "#cdd4ff")
bg_alt = THEME.get("bg_alt", "#939cda")
border_main = THEME.get("border_main", "1px solid #484872")

# Tabs
c.tabs.position = "left"
c.tabs.width = 36
c.tabs.show = "multiple"
c.tabs.max_width = 240
c.tabs.min_width = 100
c.tabs.favicons.show = "always"
c.tabs.padding = {"top": 8, "bottom": 8, "left": 6, "right": 5}
c.tabs.indicator.width = 2 
c.tabs.wrap = True
c.tabs.last_close = "default-page"

# Tab Colors
c.colors.tabs.bar.bg = bg_main
c.colors.tabs.even.bg = bg_main
c.colors.tabs.odd.bg = bg_main
c.colors.tabs.even.fg = fg_main
c.colors.tabs.odd.fg = fg_main
c.colors.tabs.selected.even.bg = bg_hover
c.colors.tabs.selected.odd.bg = bg_hover
c.colors.tabs.selected.even.fg = bg_third
c.colors.tabs.selected.odd.fg = bg_third
c.colors.tabs.indicator.system = "rgb"

# Statusbar
c.colors.statusbar.normal.bg = bg_main
c.colors.statusbar.normal.fg = fg_main
c.colors.statusbar.command.bg = bg_second
c.colors.statusbar.command.fg = fg_main
c.colors.statusbar.insert.bg = bg_second
c.colors.statusbar.insert.fg = bg_third
c.colors.statusbar.private.bg = bg_second
c.colors.statusbar.private.fg = fg_main

# Hints
c.colors.hints.bg = fg_main
c.colors.hints.fg = bg_main
c.hints.border = "2px solid"+ border_main


# Completion
c.colors.completion.category.bg = bg_main
c.colors.completion.category.fg = fg_main
c.colors.completion.even.bg = bg_main
c.colors.completion.odd.bg = bg_second
c.colors.completion.item.selected.bg = bg_hover
c.colors.completion.item.selected.fg = bg_third
c.colors.completion.item.selected.border.top = bg_second
c.colors.completion.item.selected.border.bottom = bg_second
c.colors.completion.match.fg = fg_main

# Font
c.fonts.statusbar = "14pt CaskaydiaMono Nerd Font"
c.fonts.tabs.selected = "12.5pt CaskaydiaMono Nerd Font"
c.fonts.tabs.unselected = "12.5pt CaskaydiaMono Nerd Font"

# New Tab
c.url.start_pages = ["https://web.tabliss.io/"]
c.url.default_page = "https://web.tabliss.io/"

# Misc
c.qt.force_software_rendering = "chromium"
c.scrolling.smooth = True
c.completion.web_history.max_items = 0

c.auto_save.session = True


c.completion.use_best_match = False
c.completion.show = "never"

c.content.autoplay = False

c.editor.command = ["nvim", "-f", "{file}", "-c", "normal {line}G{column0}l"]

# Bindings
config.bind("<Ctrl-Tab>", "tab-next")
config.bind("<Ctrl-Shift-Tab>", "tab-prev")
config.bind('M', "spawn --detach mpv --ytdl-format='bestvideo+bestaudio' {url}")


# Dark Mode
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.policy.images = "never"
c.colors.webpage.darkmode.policy.page = "smart"

# Adblock
c.content.blocking.enabled = True

c.content.blocking.method = "both"

c.content.headers.do_not_track = True

# Privacy

c.content.cookies.accept = "no-3rdparty"

# Custom start page

import subprocess
import atexit
import os

# Expand tilde to full path
project_path = os.path.expanduser("~/.config/qutebrowser/newtab")
app_file = os.path.join(project_path, "main.py")  # your Flask app

# Start Flask server
flask_proc = subprocess.Popen(["python3", app_file])

# Ensure Flask stops when qutebrowser closes
atexit.register(lambda: flask_proc.terminate())

# Set startpage to localhost
c.url.start_pages = "http://localhost:5000"
c.url.default_page = "http://localhost:5000"

