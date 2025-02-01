Thirst_Actionbar_Handler:
    type: task
    debug: false
    script:
        - while <player.is_online> && <player.is_spawned>:

            - if <player.gamemode> matches CREATIVE && SPECTATOR:
                - actionbar "<&f> <&r>"
                - stop
            - if <player.gamemode> matches SPECTATOR:
                - actionbar "<&f> <&r>"
                - stop


            - if <player.has_flag[bonecrack]>:
                - if !<player.equipment.formatted.equals[nothing, nothing, nothing, and nothing]>:
                    - actionbar "<proc[util_textoffset].context[-40]><&color[#4e5c24]><element[🐔].font[custom]><proc[util_textoffset].context[7]><player.proc[sprint_2]><proc[util_textoffset].context[16]><player.proc[thirst_1]>"
                    - if <player.oxygen.is_less_than[15]>:
                        - actionbar "<proc[util_textoffset].context[-40]><&color[#4e5c24]><element[🐔].font[custom]><proc[util_textoffset].context[7]><player.proc[sprint_2]><proc[util_textoffset].context[16]><player.proc[thirst_2]>"
                - else:
                    - if <player.oxygen.is_less_than[15]>:
                        - actionbar "<proc[util_textoffset].context[-40]><&color[#4e5c24]><element[🐔].font[custom]><proc[util_textoffset].context[7]><player.proc[sprint_1]><proc[util_textoffset].context[16]><player.proc[thirst_2]>"
                    - else:
                        - actionbar "<proc[util_textoffset].context[-40]><&color[#4e5c24]><element[🐔].font[custom]><proc[util_textoffset].context[7]><player.proc[sprint_1]><proc[util_textoffset].context[16]><player.proc[thirst_1]>"


            - else if <player.oxygen.is_less_than[15]>:
                - if !<player.equipment.formatted.equals[nothing, nothing, nothing, and nothing]>:
                    - actionbar "<proc[util_textoffset].context[-1]><player.proc[sprint_2]><proc[util_textoffset].context[16]><player.proc[thirst_2]>"
                - else:
                    - actionbar "<proc[util_textoffset].context[-1]><player.proc[sprint_1]><proc[util_textoffset].context[16]><player.proc[thirst_2]>"
            - else if <player.vehicle.health_max.is_more_than[21].if_null[]>:
                - if !<player.equipment.formatted.equals[nothing, nothing, nothing, and nothing]>:
                    - actionbar "<proc[util_textoffset].context[-1]><player.proc[sprint_2]><proc[util_textoffset].context[16]><player.proc[thirst_2]>"
                - else:
                    - actionbar "<proc[util_textoffset].context[-1]><player.proc[sprint_1]><proc[util_textoffset].context[16]><player.proc[thirst_2]>"


            - else if !<player.equipment.formatted.equals[nothing, nothing, nothing, and nothing]>:
                - actionbar "<proc[util_textoffset].context[-1]><player.proc[sprint_2]><proc[util_textoffset].context[16]><player.proc[thirst_1]>"


            - else:
                - actionbar "<proc[util_textoffset].context[-1]><player.proc[sprint_1]><proc[util_textoffset].context[16]><player.proc[thirst_1]>"
            - wait 1t
