Holo_Handler:
    type: world
    debug: false
    events:
        on player join:
            - if <player.name.to_list.get[1].equals[_]>:
                - foreach <world[lobby].entities[text_display]> as:holo:
                    - adjust <player> hide_entity:<[holo]>