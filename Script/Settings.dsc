Settings_Command:
    type: command
    name: setting
    debug: false
    description: setting Command
    usage: /setting
    aliases:
        - settings
    script:
        
        - define size 27
        - define title "Settings"
        - define inventory <inventory[generic[size=<[size]>;title=<[title]>]]>

        - inventory open d:<[inventory]>

        # Chat Server Message
        - if <player.has_flag[setting.chat_server_msg].not>:
            - inventory set slot:11 o:lime_stained_glass_pane d:<[inventory]>
            - inventory adjust slot:11 "display:<&e>Chat Server Message" d:<[inventory]>
            - inventory adjust slot:11 "lore:<&f>Currently: <&a><&l>ON " d:<[inventory]>

        - else:
            - inventory set slot:11 o:red_stained_glass_pane d:<[inventory]>
            - inventory adjust slot:11 "display:<&e>Chat Server Message" d:<[inventory]>
            - inventory adjust slot:11 "lore:<&f>Currently: <&c><&l>OFF " d:<[inventory]>

        # Hotbar Server Message
        - if <player.has_flag[setting.hotbar_server_msg].not>:
            - inventory set slot:12 o:lime_stained_glass_pane d:<[inventory]>
            - inventory adjust slot:12 "display:<&e>Hotbar Server Message" d:<[inventory]>
            - inventory adjust slot:12 "lore:<&f>Currently: <&a><&l>ON " d:<[inventory]>

        - else:
            - inventory set slot:12 o:red_stained_glass_pane d:<[inventory]>
            - inventory adjust slot:12 "display:<&e>Hotbar Server Message" d:<[inventory]>
            - inventory adjust slot:12 "lore:<&f>Currently: <&c><&l>OFF " d:<[inventory]>

        # Server Sound Effect
        - if <player.has_flag[setting.sound_effect].not>:
            - inventory set slot:13 o:lime_stained_glass_pane d:<[inventory]>
            - inventory adjust slot:13 "display:<&e>Server Sound Effect" d:<[inventory]>
            - inventory adjust slot:13 "lore:<&f>Currently: <&a><&l>ON " d:<[inventory]>

        - else:
            - inventory set slot:13 o:red_stained_glass_pane d:<[inventory]>
            - inventory adjust slot:13 "display:<&e>Server Sound Effect" d:<[inventory]>
            - inventory adjust slot:13 "lore:<&f>Currently: <&c><&l>OFF " d:<[inventory]>

        # Chat Public
        - if <player.has_flag[setting.chat_public].not>:
            - inventory set slot:14 o:lime_stained_glass_pane d:<[inventory]>
            - inventory adjust slot:14 "display:<&e>Chat Public" d:<[inventory]>
            - inventory adjust slot:14 "lore:<&f>Currently: <&a><&l>ON " d:<[inventory]>

        - else:
            - inventory set slot:14 o:red_stained_glass_pane d:<[inventory]>
            - inventory adjust slot:14 "display:<&e>Chat Public" d:<[inventory]>
            - inventory adjust slot:14 "lore:<&f>Currently: <&c><&l>OFF " d:<[inventory]>

        # Chat Team
        - if <player.has_flag[setting.chat_team]>:
            - inventory set slot:15 o:lime_stained_glass_pane d:<[inventory]>
            - inventory adjust slot:15 "display:<&e>Chat Team" d:<[inventory]>
            - inventory adjust slot:15 "lore:<&f>Currently: <&a><&l>ON " d:<[inventory]>

        - else:
            - inventory set slot:15 o:red_stained_glass_pane d:<[inventory]>
            - inventory adjust slot:15 "display:<&e>Chat Team" d:<[inventory]>
            - inventory adjust slot:15 "lore:<&f>Currently: <&c><&l>OFF " d:<[inventory]>

        # Scoreboard
        - if <player.has_flag[setting.scoreboard].not>:
            - inventory set slot:16 o:lime_stained_glass_pane d:<[inventory]>
            - inventory adjust slot:16 "display:<&e>Scoreboard" d:<[inventory]>
            - inventory adjust slot:16 "lore:<&f>Currently: <&a><&l>ON " d:<[inventory]>

        - else:
            - inventory set slot:16 o:red_stained_glass_pane d:<[inventory]>
            - inventory adjust slot:16 "display:<&e>Scoreboard" d:<[inventory]>
            - inventory adjust slot:16 "lore:<&f>Currently: <&c><&l>OFF " d:<[inventory]>

Settings_Handler:
    type: world
    debug: false
    events:
        on player clicks item in inventory:
            - if <context.inventory.title.contains_text[Settings]>:

                # Chat Server Message
                - if <context.slot.equals[11]>:
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:ui_button_click
                        - flag <player> setting.chat_server_msg
                        - execute as_player "setting"
                    - else:
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:ui_button_click
                        - flag <player> setting.chat_server_msg:!
                        - execute as_player "setting"

                # Hotbar Server Message
                - if <context.slot.equals[12]>:
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:ui_button_click
                        - flag <player> setting.hotbar_server_msg
                        - execute as_player "setting"
                    - else:
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:ui_button_click
                        - flag <player> setting.hotbar_server_msg:!
                        - execute as_player "setting"

                # Server Sound Effect
                - if <context.slot.equals[13]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:ui_button_click
                        - flag <player> setting.sound_effect
                        - execute as_player "setting"
                    - else:
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:ui_button_click
                        - flag <player> setting.sound_effect:!
                        - execute as_player "setting"
                    
                # Chat Public
                - if <context.slot.equals[14]>:
                    - if <player.has_flag[setting.chat_public].not>:
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:ui_button_click
                        - flag <player> setting.chat_public
                        - execute as_player "setting"
                    - else:
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:ui_button_click
                        - flag <player> setting.chat_public:!
                        - execute as_player "setting"

                # Chat Team
                - if <context.slot.equals[15]>:
                    - if <player.has_flag[setting.chat_team].not>:
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:ui_button_click
                        - flag <player> setting.chat_team
                        - execute as_player "setting"
                    - else:
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:ui_button_click
                        - flag <player> setting.chat_team:!
                        - execute as_player "setting"

                # Scoreboard
                - if <context.slot.equals[16]>:
                    - if <player.has_flag[setting.scoreboard].not>:
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:ui_button_click
                        - flag <player> setting.scoreboard
                        - execute as_player "setting"
                        - sidebar remove players:<player>
                    - else:
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:ui_button_click
                        - flag <player> setting.scoreboard:!
                        - execute as_player "setting"
                        - if <player.has_flag[team.team]>:
                            - define title <script[scoreboard_config1].parsed_key[scoreboard.title].space_separated>
                            - define lines <script[scoreboard_config1].parsed_key[scoreboard.lines].parse[parsed]>
                            - sidebar title:<[title]> values:<[lines]> players:<player>
                        - else:
                            - define title <script[scoreboard_config].parsed_key[scoreboard.title].space_separated>
                            - define lines <script[scoreboard_config].parsed_key[scoreboard.lines].parse[parsed]>
                            - sidebar title:<[title]> values:<[lines]> players:<player>