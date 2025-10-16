/*enter([
  listen("workspaces-list", #{
    initial: "i",
    cmd: "hyprland-workspaces `hyprctl monitors -j | jq -r \".[0].name\"`",
  });
]) */


    fn greeter() {
  return box(#{
    orientation: "horizontal",
    halign: "center"
  }, [
    button(#{ onclick: `notify-send 'Hello' 'Hello, d`, label: "Greet" })
  ]);
};

fn custom_buttons() {
    return box(#{space_evenly: false}, [
        button(#{label: "", class:"custom-buttons", onclick: "~/Dotfiles/bin/launchrofi --drun"}),
        button(#{label: "", class:"custom-buttons", onclick: "~/Dotfiles/bin/launchrofi --system_menu" }),
        button(#{label: "", class:"custom-buttons", onclick: "~/Dotfiles/bin/launchrofi --menu"}),
        button(#{label: "  Playing", class:"mpris", onclick: "playerctl play-pause"}),
    ]);
}

fn quick_buttons() {
    return box(#{space_evenly: false, class: "custom_buttons"}, [
        button(#{label: "󰤢", class:"custom-buttons", onclick: "~/Dotfiles/bin/launchrofi --drun"}),
        button(#{label: "", class:"custom-buttons", onclick: "~/Dotfiles/bin/launchrofi --system_menu" }),
        button(#{label: " ", class:"custom-buttons", onclick: "~/Dotfiles/bin/launchrofi --menu"}),
    ]);
}

enter([
  // Add all defwindow inside enter. Enter is the root of the config.
  defwindow(
    "bar",
    #{
      monitor: 0,
      class: "random",
      windowtype: "normal",
      exclusive: true,
      stacking: "fg",
       geometry: #{
        x: "3.2%",
        y: "1%",
        width: "100%",
        height: "32px",
        anchor: "top center",
      },
    },
    box(#{class:"bar", space_evenly: true, valign: "fill"}, [
        box(#{halign: "start"}, [
            custom_buttons(),
            label(#{text: "Left Dummy"}),
        ]),
        label(#{text: "Center Dummy"}),
        box(#{halign: "end"}, [
            label(#{text: "Right Dummy"}),
            quick_buttons(),
            label(#{ text: " "+hours+":"+minutes }),
        ]),
    ])
         ),
]);
