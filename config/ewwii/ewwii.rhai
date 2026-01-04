import "style.rhai" as style_file;
import "desktop_widgets.rhai" as desktop_widgets;

import "std::command" as cmd;

fn mini_player(musicartlink, music_title, music_position,music_position_percentage, music_loop, music_shuffle, music_lenght, playing_paused){
    return box(#{
    orientation: "horizontal",
    space_evenly: true,
    halign: "center",
    valign: "fill",
    class: "musiccenter",
  }, [
    box(#{
        orientation: "vertical",
        space_evenly: false,
        halign: "center",
        class: "musiccontrols"
    }, [
        label(#{ class: "musictitle", text: music_title, limit_width: 2 }),
        box(#{
            orientation: "horizontal",
            space_evenly: false,
            halign: "center",
        }, [
            label(#{ class: "label" , style: "font-size: 13px", text: music_position } ),
            scale(#{ class: "musicscale", 
                space_evenly: false,
                halign: "center", 
                orientation: "horizontal", 
                min:0, max:101, 
                value: music_position_percentage,
                onchange: ""
            } ),            
            label(#{  class: "label" , style: "font-size: 13px", text: music_lenght } ),

        ]), 

        box(#{
            orientation: "horizontal",
            space_evenly: false,
            halign: "center",
            spacing: 10,
        }, [
            button(#{ class: if music_loop != "None" { "musicbutton2" } else { "musicbutton2dis" } , onclick: `playerctl loop $( [ "$(playerctl loop)" = "None" ] && echo "Playlist" || echo "None" )
`, label: " " }),
            button(#{ class: "musicbutton", onclick: `playerctl previous &`, label: "" }),
            button(#{ class: "playbutton", onclick: `playerctl play-pause &`, label: if playing_paused != "Paused" { "" } else { "" } }),
            button(#{ class: "musicbutton", onclick: `playerctl next &`, label: "" }),
            button(#{ class: if music_shuffle != "Off" { "musicbutton2" } else { "musicbutton2dis" }, onclick: if music_shuffle != "Off" { "playerctl shuffle off" } else { "playerctl shuffle on" }, label: " " }),
        ]), 
    ]),

  ]);

}

fn quick_center_content(up_time, volume, brightness, mic_percent, network_status, bluetooth_status, dnd_status, sunset_status, cafein_status, power_mode) {
    let pfp_path = cmd::run_and_read(`[ -f "$HOME/.face" ] && printf "%s" "$(realpath "$HOME/.face")" || printf "%s" "placeholder.png"`);
    let username = cmd::run_and_read("whoami");
    let user_host = cmd::run_and_read(`echo "$(id -un)@$(uname -n)"`);
    return box(#{
    orientation: "vertical",
    space_evenly: false,
    class: "quick-center-content",
    },
    [
        box(#{ 
            class: "top-center", 
            orientation: "horizontal", 
            halign: "start", 
            valign: "start", 
            spacing: 3, 
            space_evenly: false,
            }, [ 
                image(#{class: "pfp", path: pfp_path}),
                box(#{ 
                    class: "random", 
                    orientation: "vertical", 
                    halign: "center", 
                    valign: "center",
                    style: "margin-bottom: 5px;",
                    spacing: 3, 
                    space_evenly: false,
                    }, [
                        label(#{ xalign: 0, limit_width: 12 , text: username, class: "Random" }),
                        label(#{ xalign: 0, limit_width: 20, text: user_host }),
                        label(#{ xalign: 0, limit_width: 20, text: up_time })
                    ],
                ),
        

        ],
        ),
            quick_center_scales(volume, mic_percent, brightness),
            box(#{ class: "bottom-center", orientation: "vertical" }, [
                box(#{ class: "random" }, [
                button(#{ label: " ", class: if network_status != "no-network" { "button-active" } else { "button" }, onclick: "rfkill toggle wifi &"}),
                button(#{ label: "󰂯", class: if bluetooth_status != "no" { "button-active" } else { "button" }, onclick: "rfkill toggle bluetooth"}),
                button(#{ label: " ", class: if sunset_status != "no-process" { "button-active" } else { "button" }, onclick: "bash ~/Dotfiles/scripts/toggle-sunset" })
                ]),
            box(#{ class: "random" }, [
                button(#{ label: " ", class: if cafein_status == "no-process" { "button-active" } else { "button" }, onclick: "$HOME/Dotfiles/scripts/cafein toggle" }),
                button(#{ label: " ", class: if dnd_status == "on" { "button-active" } else { "button" }, onclick: "makoctl mode -t dnd" }),
                button(#{ label: " ", class: "button", onclick: "~/Dotfiles/bin/launchrofi --system_menu& ewwii close actioncenter"})
                ]),
            box(#{ class: "random", space_evenly: false }, 
            [
                box(#{class: "button-box", style:"", space_evenly: false}, [
                    button(#{class:if power_mode == "Performance" { "button-active" } else { "button " }, label: if power_mode == "Performance" { "" } else { " " }, onclick: `[[ "$(powerprofilesctl get 2>/dev/null)" == "balanced" ]] && powerprofilesctl set performance || powerprofilesctl set balanced
`}), 
                    label(#{text: "  "+power_mode+" ", style: "font-size: 16px; min-width: 130px;"}) 
                ])
                
            ]),
            ]),
    ]);
}

fn quick_center_scales(volume, mic_percent, brightness) {
   return box(#{
        orientation: "vertical",
        valign: "start",
        halign: "start",
        space_evenly: false,
        spacing: 7,
        class: "middle-center",
    }, [
        box(#{
            orientation: "horizontal",
            halign: "center",
            space_evenly: false,
            style: "all: unset,",
            class: "random",
            }, [
                label(#{  class: "statuslabel" , text: "" } ),
                scale(#{ class: "statusscale", 
                    space_evenly: false,
                    valign: "center",
                    timeout: 800,
                    orientation: "horizontal", 
                    min:0, max:101, 
                    value: volume,
                    onchange: "pamixer --set-volume {}"
                } ), 
        ]),
        box(#{
            orientation: "horizontal",
            halign: "center",
            space_evenly: false,
            style: "all: unset,",
            class: "random",
        }, [
                label(#{  class: "statuslabel" , text: "" } ),
                scale(#{ class: "statusscale", 
                    space_evenly: false,
                    valign: "center",
                    timeout: 800,
                    orientation: "horizontal", 
                    min:0, max:101, 
                    value: mic_percent,
                    onchange: "pamixer --source @DEFAULT_SOURCE@ --set-volume {}"
                } ), 
   ]),

        box(#{
            orientation: "horizontal",
            halign: "center",
            space_evenly: false,
            style: "all: unset,",
            class: "random",
        }, [
            label(#{  class: "statuslabel" , text: "" } ),
            scale(#{ class: "statusscale", 
                space_evenly: false,
                valign: "center",
                timeout: 500,
                orientation: "horizontal", 
                min:0, max:101, 
                value: brightness,
                onchange: "brightnessctl set {}%",
            } ), 
   ]) 

   ]) 
; 
}


fn status_scales(volume, brightness) {
   return box(#{
   orientation: "vertical",
   valign: "center",
    space_evenly: false,
    spacing: 7,
    style: "all: unset,",
    class: "random",
   }, [
   box(#{
   orientation: "horizontal",
   halign: "center",
    space_evenly: false,
    style: "all: unset,",
    class: "random",
   }, [
    label(#{  class: "statuslabel" , text: "" } ),
   scale(#{ class: "statusscale", 
                space_evenly: false,
                valign: "center",
                timeout: 4000,
                orientation: "horizontal", 
                min:0, max:101, 
                value: volume,
                onchange: "pamixer --set-volume {}"
            } ), 
   ]),
    box(#{
   orientation: "horizontal",
   halign: "center",
    space_evenly: false,
    style: "all: unset,",
    class: "random",
   }, [
    label(#{  class: "statuslabel" , text: "" } ),
   scale(#{ class: "statusscale", 
                space_evenly: false,
                valign: "center",
                timeout: 4000,
                orientation: "horizontal", 
                min:0, max:101, 
                value: brightness,
                onchange: "brightnessctl set {}%",
            } ), 
   ]) 

   ]) 
; 
}

enter([
    
    poll("musictitle", #{
      // It is recommended to have initial property passed.
      // If not provided, it will default to no value which may cause problems when used.
      // You can pass something like "" if you want no initial value.
      initial: "No Media",
      interval: "2",
      cmd: "playerctl metadata --format '{{ title }}' | cut -c1-30", // command to execute"
  }),

    poll("network_status", #{
      initial: "yes",
      interval: "5",
      cmd: `ssid=$(nmcli -t -f active,ssid dev wifi | awk -F: '$1=="yes"{print $2; exit}'); if [ -z "$ssid" ]; then echo "no-network"; else echo "$ssid"; fi`, // command to execute"
  }),

  poll("bluetooth_status", #{
      initial: "yes",
      interval: "5",
      cmd: `bluetoothctl show | grep "Powered" | cut -c11-`, // command to execute"
  }),

  poll("sunset_status", #{
      initial: "yes",
      interval: "5",
      cmd: `pid=$(pgrep hyprsunset | head -n1); if [ -z "$pid" ]; then echo "no-process"; else echo "$pid"; fi`, // command to execute"
  }),

  poll("cafein_status", #{
      initial: "yes",
      interval: "5",
      cmd: `pid=$(pgrep hypridle | head -n1); if [ -z "$pid" ]; then echo "no-process"; else echo "$pid"; fi`, // command to execute"
  }),

    poll("dnd_status", #{
      initial: "off",
      interval: "5",
      cmd: `makoctl mode | grep -q "dnd" && echo "on" || echo "off"`, // command to execute"
  }),

  poll("power_mode", #{
      initial: "balanced",
      interval: "2",
      cmd: `powerprofilesctl get 2>/dev/null | rg -o -e 'balanced' -e 'power-saver' -e 'performance' | sed 's/.*/\u&/'`, // command to execute"
  }),

    poll("up_time", #{
      initial: "0 hours, 0 minutes",
      interval: "60",
      cmd: `uptime -p | cut -c3-`, // command to execute"
  }),

  poll("hours", #{
      initial: "00",
      interval: "10s",
      cmd: `date +"%H"`, // command to execute"
  }),

  poll("minutes", #{
      initial: "00",
      interval: "8s",
      cmd: `date +"%M"`, // command to execute"
  }),

    poll("brightness", #{
      initial: "50",
      interval: "5",
      cmd: `scripts/brightness.sh`, // command to execute"
  }),

  listen("volume", #{
        initial: "0",
        cmd: "scripts/getVol.sh speaker listen"}),

  listen("mic_percent", #{
      initial: "0",
      cmd: `scripts/getVol.sh mic listen`, // command to execute"
  }),

  poll("music_title", #{
      initial: "No Media",
      interval: "2",
      cmd: `playerctl metadata --format '{{ title }}' 2>/dev/null || echo "No Media"`, // command to execute"
  }),

  poll("playing_paused", #{
      initial: "Paused",
      interval: "1",
      cmd: "playerctl status"
  }),

    poll("music_shuffle", #{
      initial: "On",
      interval: "2",
      cmd: `playerctl shuffle`, // command to execute"
  }),

  poll("music_loop", #{
      initial: "On",
      interval: "2",
      cmd: `playerctl loop`, // command to execute"
  }),

  poll("music_position", #{
      initial: "0:00",
      interval: "1",
      cmd: `playerctl metadata --format "{{ duration(position) }}" 2>/dev/null || echo "0:00"`, // command to execute"
  }),

  poll("music_position_percentage", #{
      initial: "0",
      interval: "1",
      cmd: `playerctl metadata --format "{{ position / (mpris:length / 100)  }}" 2>/dev/null || echo "0"`, // command to execute"
  }),

  poll("music_lenght", #{
      initial: "0:00",
      interval: "5",
      cmd: `playerctl metadata --format '{{ duration(mpris:length) }}' 2>/dev/null || echo "0:00"`, // command to execute"
  }),

  poll("musicartlink", #{
      initial: "placeholder.png",
      interval: "3",
      cmd: `scripts/coverart.sh 2>/dev/null || echo "placeholder.png"`, // command to execute"
  }),

]);

enter([ 
  // Desktop Music Player Window
  defwindow(
    "desktopmusic",
    #{
      monitor: 0,
        class: "desktopmusic",
        windowtype: "normal",
        stacking: "bg",
        wm_ignore: true,
        geometry: #{
        x: "1%",
        y: "12.2%",
        width: "16.2%",
        height: "8%",
        anchor: "bottom left",
      },
      exclusive: false,
    },
    box(#{
    orientation: "vertical",
    space_evenly: false,
    halign: "center",
    class: "desktopmusic",
  }, [
        box(#{class: "musicartdesk", style: if musicartlink != "" { "background-image: url(\"" + musicartlink + "\"); min-height:260px; min-width:260px" } else { "min-height:260px" }, }, [ label(#{ text: "" })]),
        // image(#{class: "musicartdesk", path: musicartlink, reserve_aspect_ratio: false }),
    box(#{
        orientation: "vertical",
        space_evenly: false,
        halign: "center",
        class: "musiccontrols"
    }, [
        label(#{ class: "musictitle", text: music_title, limit_width: 2 }),
        box(#{
            orientation: "horizontal",
            space_evenly: false,
            halign: "center",
        }, [
            label(#{ class: "label" , style: "font-size: 13px", text: music_position } ),
            scale(#{ class: "musicscale", 
                space_evenly: false,
                halign: "center", 
                orientation: "horizontal", 
                min:0, max:101, 
                value: music_position_percentage,
                onchange: ""
            } ),            
            label(#{  class: "label", style: "font-size: 13px", text: music_lenght } ),

        ]), 

        box(#{
            orientation: "horizontal",
            space_evenly: false,
            halign: "center",
            spacing: 10,
        }, [
            button(#{ class: if music_loop != "None" { "musicbutton2" } else { "musicbutton2dis" } , onclick: `playerctl loop $( [ "$(playerctl loop)" = "None" ] && echo "Playlist" || echo "None" )
`, label: " " }),
            button(#{ class: "musicbutton", onclick: `playerctl previous &`, label: "" }),
            button(#{ class: "playbutton", onclick: `playerctl play-pause &`, label: if playing_paused != "Paused" { "" } else { "" } }),
            button(#{ class: "musicbutton", onclick: `playerctl next &`, label: "" }),
            button(#{ class: if music_shuffle != "Off" { "musicbutton2" } else { "musicbutton2dis" }, onclick: if music_shuffle != "Off" { "playerctl shuffle off" } else { "playerctl shuffle on" }, label: " " }),
        ]), 
    ]),

  ]),

  ),
defwindow(
    "status",
    #{
      monitor: 0,
      class: "random",
      windowtype: "normal",
      stacking: "bg",
       geometry: #{
        x: "1%",
        y: "1.4%",
        width: "16.2%",
        height: "10%",
        anchor: "bottom left",
      },
    },
    box(#{class: "status"}, [status_scales(volume, brightness)]),
    ),
    defwindow(
    "deskclock",
    #{
        monitor: 0,
        windowtype: "normal",
        stacking: "bg",
        geometry: #{
        x: "0%",
        y: "12%",
        width: "0%",
        height: "0%",
        anchor: "top center",
      },
    },
        box(#{
            halign: "center",
            valign: "center",
            space_evenly: false,
            spacing: 0,
            orientation: "vertical",

       }, [       
       label(#{ text: hours }),
       label(#{ text: minutes }),
] ),
  ),

   defwindow(
    "activatelinux",
    #{
      monitor: 0,
      class: "random",
      windowtype: "normal",
      stacking: "bg",
       geometry: #{
        x: "2%",
        y: "3.4%",
        width: "0%",
        height: "0%",
        anchor: "bottom right",
      },
    },
       box(#{
       halign: "start",
       valign: "start",
       yalign: "0",
       space_evenly: false,
       orientation: "vertical",

       }, [       
       label(#{  xalign: 0, markup: "<span font_size=\"large\">Activate Linux</span>" }),
       label(#{  xalign: 0, text: "Go to Settings to activate Linux" }),
] ),
  ),
  defwindow(
    "volOSD",
    #{
      monitor: 0,
      class: "random",
      namespace: style_file::bar_widget_namespace(),
      windowtype: "normal",
      stacking: "overlay",
       geometry: #{
        x: "0%",
        y: "2%",
        width: "16%",
        height: "0%",
        anchor: "top center",
      },
    },
       box(#{
            orientation: "horizontal",
            halign: "center",
            space_evenly: false,
            class: "OSD",
            }, [
                label(#{  class: "statuslabel" , text: "" } ),
                scale(#{ class: "statusscale", 
                    space_evenly: false,
                    valign: "center",
                    timeout: 4000,
                    orientation: "horizontal", 
                    min:0, max:101, 
                    value: volume,
                    onchange: "pamixer --set-volume {}"
                } ), 
        ]),

  ),
  defwindow(
    "calendar",
    #{
      monitor: 0,
      class: "random",
      namespace: style_file::bar_widget_namespace(),
      windowtype: "normal",
      stacking: "fg",
       geometry: #{
        x: "3.2%",
        y: "1%",
        width: "16%",
        height: "0%",
        anchor: style_file::calendar_anchor(),
      },
    },
       calendar(#{}) 
  ),
 
  defwindow(
    "actioncenter",
    #{
      monitor: 0,
        class: "random",
        namespace: style_file::bar_widget_namespace(),
        windowtype: "normal",
        stacking: "fg",
        geometry: #{
            x: "3%",
            y: "1%",
            width: "3%",
            height: "3%",
            anchor: style_file::quick_center_anchor(),
        },
    },
       box(#{
       halign: "start",
       valign: "start",
       yalign: "0",
       space_evenly: false,
       orientation: "vertical",

       }, [       
        revealer(#{transition: "slidedown", duration: 400 , reveal: true}, [
        box(#{
        class: "random",
        space_evenly: false,
        orientation: "vertical",
        spacing: 10,
        }, [quick_center_content(up_time, volume, brightness, mic_percent, network_status, bluetooth_status, dnd_status, sunset_status, cafein_status, power_mode),mini_player(musicartlink, music_title, music_position, music_position_percentage, music_loop, music_shuffle, music_lenght, playing_paused)])
        ]) 
] ),
  ),


]);


