flash_light:
    type: item
    debug: false
    material: shulker_shell
    mechanisms:
      custom_model_data: 100
    display name: <&f><&l>FLASH LIGHT

flasH_light_handler:
    type: world
    debug: false
    events:
        on delta time secondly:
            - foreach <server.online_players> as:__player:
                - while <player.is_online> && <player.is_spawned>:
                    - if <player.item_in_hand> matches flash_light:
                        - showfake <player.cursor_on.backward[1]> dirt d:1s players:<server.online_players>
                    - if <player.item_in_offhand> matches flash_light:
                        - showfake <player.cursor_on.backward[1]> dirt d:1s players:<server.online_players>
                    - wait 10t