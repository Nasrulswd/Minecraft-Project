HealthBar_Proc:
    type: procedure
    debug: false
    definitions: entity
    script:
        - define health <[entity].health.round_to[0].div[<[entity].health_max.round_to[0]>].mul[10].round_to[0]>

        - define 🚗 <element[🚗].font[healthbar]>
        - define 🚓 <element[🚓].font[healthbar]>
        - define 🚕 <element[🚕].font[healthbar]>
        - define 🛺 <element[🛺].font[healthbar]>
        - define 🚙 <element[🚙].font[healthbar]>
        - define 🚌 <element[🚌].font[healthbar]>
        - define b 🚀🚀

        - if <[health]> <= 0:
            - define a "<[🛺]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚌]>"
        - if <[health]> == 1:
            - define a "<[🚗]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚌]>"
        - if <[health]> == 2:
            - define a "<[🚗]><[b]><[🚓]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚌]>"
        - if <[health]> == 3:
            - define a "<[🚗]><[b]><[🚓]><[b]><[🚓]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚌]>"
        - if <[health]> == 4:
            - define a "<[🚗]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚌]>"
        - if <[health]> == 5:
            - define a "<[🚗]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚌]>"
        - if <[health]> == 6:
            - define a "<[🚗]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚌]>"
        - if <[health]> == 7:
            - define a "<[🚗]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚙]><[b]><[🚙]><[b]><[🚌]>"
        - if <[health]> == 8:
            - define a "<[🚗]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚙]><[b]><[🚌]>"
        - if <[health]> == 9:
            - define a "<[🚗]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚌]>"
        - if <[health]> >= 10:
            - define a "<[🚗]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚓]><[b]><[🚕]>"

        - determine <[a]>

HealthBar_Handler:
    type: world
    debug: false
    events:
        on player joins:
            - if <player.client_brand> == geyser:
                - flag <player> bedrock
            - else:
                - if <player.has_flag[bedrock]>:
                    - flag <player> bedrock:!

        # on player kills entity:
        #     - if <context.entity.passenger.contains_text[text_display].if_null[]>:

        #         - define random <util.random_uuid>
        #         - define passenger <context.entity.passenger>
        #         - define 🚗 <element[🚗].font[healthbar]>
        #         - define 🚓 <element[🚓].font[healthbar]>
        #         - define 🚕 <element[🚕].font[healthbar]>
        #         - define 🛺 <element[🛺].font[healthbar]>
        #         - define 🚙 <element[🚙].font[healthbar]>
        #         - define 🚌 <element[🚌].font[healthbar]>
        #         - define b 🚀🚀

        #         - adjust <[passenger]> text:<[🛺]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚙]><[b]><[🚌]>
        #         - wait 1s
        #         - remove <[passenger]>

        on entity damaged by player:
                - define location <location[<context.entity.location.x>,<context.entity.location.y.add[2]>,<context.entity.location.z>,0,0,<context.entity.world.name>]>

                - define random <util.random_uuid>
                - if <context.entity.passenger.contains_text[text_display].if_null[]>:
                    - adjust <context.entity.passenger> text:<proc[HealthBar_Proc].context[<context.entity>]>
                - else:
                    - spawn <[location]> text_display[text=<proc[HealthBar_Proc].context[<context.entity>]>;pivot=vertical;translation=0,0.5,0] save:<[random]>
                    - adjust <server.online_players_flagged[bedrock]> hide_entity:<entry[<[random]>].spawned_entity>
                    - adjust <context.entity> passenger:<entry[<[random]>].spawned_entity>
                    - wait 3s
                    - if <entry[<[random]>].spawned_entity.is_spawned.not>:
                        - stop
                    - remove <entry[<[random]>].spawned_entity>