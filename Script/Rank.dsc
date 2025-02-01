Rank_config:
    type: data
    rank:
        - owner
        - admin
        - member

rank_handler:
    type: world
    debug: false
    events:
        on player joins:
            - if <player.has_flag[rank]>:
                - define player <player.name>
                - if <context.message.contains[<&e><player.name> joined the game]>:
                    - announce "<player.flag[rank]> <&8>[<&a>+<&8>] <&7><[player]>"
                    - determine ""
                - stop

            - else:
                - flag <player> rank:<element[👾].font[custom]>
                - team name:member add:<player> "prefix:<element[👾].font[custom]> "
                - define player <player.name>
                - if <context.message.contains[<&e><player.name> joined the game]>:
                    - announce "<player.flag[rank]> <&8>[<&a>+<&8>] <&7><[player]>"
                    - determine ""