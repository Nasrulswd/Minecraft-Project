message_handler:
    type: world
    debug: false
    events:
        on player quit:
            - define player <player.name>
            - if <context.message.contains[<&e><player.name> left the game]>:
                - determine "<&8>[<&c>-<&8>] <&7><[player]>"
        on player chats:
            - define player <player.name>
            - define text <context.message>
            - define rank <player.flag[rank]>

            - announce "<[rank]> <[player]> <&8>» <&7><[text]>" to_console
            - announce "<[rank]> <[player]> <&8>» <&7><[text]>"

            - determine cancelled