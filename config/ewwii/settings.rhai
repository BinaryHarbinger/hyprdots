fn settings_menu () {
    let selected_stack = 1;
    
    return box(#{class: "window"}, [
        scroll(#{
        },[
            box(#{orientation: "vertical"}, [
                button(#{label: "Option_0", on_click: {selected_stack = 0} }),
                button(#{label: "Option_1", on_click: {selected_stack = 1} })
            ])
        ]),
        // Settings Content
        stack(#{selected: selected_stack}, [
            label(#{text: "Content_Dummy_0"}),
            label(#{text: "Content_Dummy_1"}),
            label(#{text: "Content_Dummy_2"}),
        ]),
    ])
}
