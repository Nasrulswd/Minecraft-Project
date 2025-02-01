energy_handler:
    type: world
    debug: false
    events:

        on player respawns:
            - flag <player> energy:10

        after player joins:
            - if <player.has_flag[energy]>:
                - stop
            - else:
                - flag <player> energy:10

        on delta time secondly:
            - foreach <server.online_players_flagged[energy]> as:__player:

                # Stop if player gamemode survival
                - stop if:!<player.gamemode.equals[survival]>

                - if <player.flag[energy]> <= 0:

                        # add effect if energy is 0
                        - cast slow amplifier:2 duration:1s hide_particles no_ambient no_clear no_icon

                # if player sprinting ...energy is lower
                - if <player.is_sprinting>:
                    - if <player.flag[energy]> <= 0:
                        - foreach next
                    - flag <player> energy:--

                # if player not sprinting ..energy go up
                - else:
                    - if <player.flag[energy]> >= 10:
                        - flag <player> energy:10
                        - foreach next
                    - if <player.flag[energy]> <= 0:
                        - flag <player> energy:0
                        - wait 2s
                    - flag <player> energy:++

sprint_1:
    type: procedure
    definitions: player
    debug: false
    script:
        - if <player.flag[energy]> >= 10:
            - define bar "🦏⻔📗⻔📗⻔📗⻔📗⻔📗⻔📗⻔📗⻔📗⻔😺⻔⻔⻔⻔⚡"
        - if <player.flag[energy]> = 9:
            - define bar "🦏⻔📗⻔📗⻔📗⻔📗⻔📗⻔📗⻔📗⻔📗⻔💩⻔⻔⻔⻔⚡"
        - if <player.flag[energy]> = 8:
            - define bar "🦏⻔📗⻔📗⻔📗⻔📗⻔📗⻔📗⻔📗⻔🧧⻔💩⻔⻔⻔⻔⚡"
        - if <player.flag[energy]> = 7:
            - define bar "🦏⻔📗⻔📗⻔📗⻔📗⻔📗⻔📗⻔🧧⻔🧧⻔💩⻔⻔⻔⻔⚡"
        - if <player.flag[energy]> = 6:
            - define bar "🦏⻔📗⻔📗⻔📗⻔📗⻔📗⻔🧧⻔🧧⻔🧧⻔💩⻔⻔⻔⻔⚡"
        - if <player.flag[energy]> = 5:
            - define bar "🦏⻔📗⻔📗⻔📗⻔📗⻔🧧⻔🧧⻔🧧⻔🧧⻔💩⻔⻔⻔⻔⚡"
        - if <player.flag[energy]> = 4:
            - define bar "🦏⻔📗⻔📗⻔📗⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔💩⻔⻔⻔⻔⚡"
        - if <player.flag[energy]> = 3:
            - define bar "🦏⻔📗⻔📗⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔💩⻔⻔⻔⻔⚡"
        - if <player.flag[energy]> = 2:
            - define bar "🦏⻔📗⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔💩⻔⻔⻔⻔⚡"
        - if <player.flag[energy]> = 1:
            - define bar "🦏⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔💩⻔⻔⻔⻔⚡"
        - if <player.flag[energy]> <= 0:
            - define bar "🐏⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔🧧⻔💩⻔⻔⻔⻔⚡"
        - determine <&color[#4e5c24]><[bar].font[custom]>

sprint_2:
    type: procedure
    definitions: player
    debug: false
    script:
        - if <player.flag[energy]> >= 10:
            - define bar "🙉⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔😃⻔⻔⻔⻔🌩"
        - if <player.flag[energy]> = 9:
            - define bar "🙉⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔😨⻔⻔⻔⻔🌩"
        - if <player.flag[energy]> = 8:
            - define bar "🙉⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔😡⻔😨⻔⻔⻔⻔🌩"
        - if <player.flag[energy]> = 7:
            - define bar "🙉⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔😡⻔😡⻔😨⻔⻔⻔⻔🌩"
        - if <player.flag[energy]> = 6:
            - define bar "🙉⻔🤢⻔🤢⻔🤢⻔🤢⻔🤢⻔😡⻔😡⻔😡⻔😨⻔⻔⻔⻔🌩"
        - if <player.flag[energy]> = 5:
            - define bar "🙉⻔🤢⻔🤢⻔🤢⻔🤢⻔😡⻔😡⻔😡⻔😡⻔😨⻔⻔⻔⻔🌩"
        - if <player.flag[energy]> = 4:
            - define bar "🙉⻔🤢⻔🤢⻔🤢⻔😡⻔😡⻔😡⻔😡⻔😡⻔😨⻔⻔⻔⻔🌩"
        - if <player.flag[energy]> = 3:
            - define bar "🙉⻔🤢⻔🤢⻔😡⻔😡⻔😡⻔😡⻔😡⻔😡⻔😨⻔⻔⻔⻔🌩"
        - if <player.flag[energy]> = 2:
            - define bar "🙉⻔🤢⻔😡⻔😡⻔😡⻔😡⻔😡⻔😡⻔😡⻔😨⻔⻔⻔⻔🌩"
        - if <player.flag[energy]> = 1:
            - define bar "🙉⻔😡⻔😡⻔😡⻔😡⻔😡⻔😡⻔😡⻔😡⻔😨⻔⻔⻔⻔🌩"
        - if <player.flag[energy]> <= 0:
            - define bar "😗⻔😡⻔😡⻔😡⻔😡⻔😡⻔😡⻔😡⻔😡⻔😨⻔⻔⻔⻔🌩"
        - determine <&color[#4e5c24]><[bar].font[custom]>
