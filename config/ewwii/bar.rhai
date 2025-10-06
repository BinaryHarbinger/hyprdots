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

enter([
  // Add all defwindow inside enter. Enter is the root of the config.
  defwindow(
    "bar",
    #{
      monitor: 0,
      class: "bar",
      windowtype: "dock",
      stacking: "fg",
      wm_ignore: false,
      geometry: #{
        x: "0%",
        y: "2px",
        width: "100%",
        height: "30px",
        anchor: "top center",
      },
      exclusive: true,
      reserve: #{ distance: "40px", side: "top" },
    },
    greeter()
  ),
]);
