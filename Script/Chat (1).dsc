Chat_Handler:
    type: world
    debug: false
    events:
        on player chats:
            - determine passively cancelled

            - define msg <context.message>
            - define name <player.display_name>

            - if <player.has_flag[setting.chat_team]>:
                - if <server.flag[team.team.<player.flag[team.team]>.leader].equals[<player.name>].if_null[]> || <player.has_flag[team.team.chat].if_null[]>:
                    - narrate "<&color[#277fff]><&l>TEAM <&color[#277fff]><[name]>: <&7><[msg]>" targets:<server.flag[team.team.<player.flag[team.team]>.uuid].if_null[]>
                    - announce "<&color[#277fff]><&l>TEAM <&color[#277fff]><[name]>: <&7><[msg]>" to_console
                - else:
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&c>You do not have permission to send message on the team chat"
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&c>You do not have permission to send message on the team chat"
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:entity_villager_no
                    - stop

            - else:
                - if <player.has_flag[chat.cooldown].if_null[]>:
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&c>Please wait 1 second before your next message."
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&c>Please wait 1 second before your next message."
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:entity_villager_no
                    - stop
                - if <player.flag[chat.repeat].equals[<context.message>].if_null[]>:
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&c>Please do not repeat the same (or similar) message."
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&c>Please do not repeat the same (or similar) message."
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:entity_villager_no
                    - stop
                - narrate "<&f><[name]>: <&7><[msg]>" targets:<server.online_players.exclude[<server.online_players_flagged[setting.chat_public]>].exclude[<server.online_players_flagged[setting.chat_team]>]>
                - announce "<&f><[name]>: <&7><[msg]>" to_console
                - flag <player> chat.cooldown expire:1s
                - flag <player> chat.repeat:<context.message> expire:5s