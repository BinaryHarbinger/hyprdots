import "std::command" as cmd;

enter([
  poll("musictitle", #{
      // It is recommended to have initial property passed.
      // If not provided, it will default to no value which may cause problems when used.
      // You can pass something like "" if you want no initial value.
      initial: "No Media",
      interval: "2",
      cmd: "playerctl metadata --format '{{ title }}' | cut -c1-30", // command to execute"
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
    halign: "center"
  }, [
    button(#{ class: "musicartdesk", onclick: `notify-send 'Hello' 'Hello, d'`, label: "Greet" }),
    box(#{
        orientation: "vertical",
        space_evenly: false,
        halign: "center",
        class: "musicartdesk"
    }, [
        label(#{ class: "musictitle", text: musictitle }),
        box(#{
            orientation: "horizontal",
            space_evenly: false,
            halign: "center",
            class: "musicartdesk"
        }, [
            label(#{ class: "musictitle" , text: cmd::run_and_read(`playerctl metadata --format "{{ duration(position) }}"`) } ),
            scale(#{ class: "musicscale", space_evenly: false, halign: "center", orientation: "vertical", min:0, max:101, value: cmd::run_and_read(`echo 20`) } ),
            label(#{  class: "musictitle" , text: cmd::run_and_read(`playerctl metadata --format "{{ duration(mpris:length)}}"`) } ),

        ]), 

        box(#{
            orientation: "horizontal",
            space_evenly: false,
            halign: "center",
            class: "musicartdesk"
        }, [
            button(#{ class: "musicbutton", onclick: `playerctl previous &`, label: "R" }),
            button(#{ class: "musicbutton", onclick: `playerctl previous &`, label: "" }),
            button(#{ class: "musicbutton", onclick: `playerctl play-pause &`, label: "P" }),
            button(#{ class: "musicbutton", onclick: `playerctl next &`, label: "" }),
            button(#{ class: "musicbutton", onclick: `notify-send 'Hello' 'Hello, d'`, label: "S" }),
        ]), 
    ]),

  ]),

  ),
]);
