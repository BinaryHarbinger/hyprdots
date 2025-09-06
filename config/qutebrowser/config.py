# qutebrowser config.py

config.load_autoconfig(False)

import os, sys
sys.path.append(os.path.join(os.path.expanduser('~'), ".config/qutebrowser/"))
# Colors
bg_main = "#11111b"
bg_hover = "#30304d"
bg_active = "#33334c"
bg_alt = "#939cda"
bg_alt2 = "#191929"
content_main = "#b4befe"
content_hover = "#b4befe"
content_alt = "#484872"
content_act = "#cdd4ff"
content_inactive = "#b4befe"

from theme import *

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
c.colors.tabs.even.fg = content_inactive
c.colors.tabs.odd.fg = content_inactive
c.colors.tabs.selected.even.bg = bg_hover
c.colors.tabs.selected.odd.bg = bg_hover
c.colors.tabs.selected.even.fg = content_act
c.colors.tabs.selected.odd.fg = content_act
c.colors.tabs.indicator.system = "rgb"

# Statusbar
c.colors.statusbar.normal.bg = bg_main
c.colors.statusbar.normal.fg = content_main
c.colors.statusbar.command.bg = bg_active
c.colors.statusbar.command.fg = content_hover
c.colors.statusbar.insert.bg = bg_alt2
c.colors.statusbar.insert.fg = content_act
c.colors.statusbar.private.bg = bg_alt2
c.colors.statusbar.private.fg = content_main

# Completion
c.colors.completion.category.bg = bg_main
c.colors.completion.category.fg = content_hover
c.colors.completion.even.bg = bg_main
c.colors.completion.odd.bg = bg_alt2
c.colors.completion.item.selected.bg = bg_hover
c.colors.completion.item.selected.fg = content_act
c.colors.completion.item.selected.border.top = bg_active
c.colors.completion.item.selected.border.bottom = bg_active
c.colors.completion.match.fg = content_hover

# Font
c.fonts.tabs.selected = "10pt FiraCode Nerd Font"
c.fonts.tabs.unselected = "10pt FiraCode Nerd Font"

# New Tab
c.url.start_pages = ["https://web.tabliss.io/"]
c.url.default_page = "https://web.tabliss.io/"

# Misc
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
c.colors.webpage.darkmode.policy.images = "smart"
c.colors.webpage.darkmode.policy.page = "smart"

# Adblock
c.content.blocking.enabled = True

c.content.blocking.method = "both"

c.content.headers.do_not_track = True

# Privacy

c.content.cookies.accept = "no-3rdparty"
