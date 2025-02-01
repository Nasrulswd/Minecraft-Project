################################################
#   ___    ___    ___________    __________    #
#  |   \  |   |  |   _____   |  |          |   #
#  |    \ |   |  |  |     |  |  |   _______|   #
#  |     \|   |  |  |     |  |  |   |______    #
#  |   |  \   |  |  |_____|  |  |_______   |   #
#  |   |\     |  |    ___    |   ______|   |   #
#  |   | \    |  |   |   |   |  |          |   #
#  |___|  \___|  |___|   |___|  |__________|   #
#                                              #
################################################

## This script made by Nasrulswd
## Discord: nasrulswd


item_chat_handler:
    type: world
    debug: false
    events:
        on player chats:
            - stop if:!<context.message.contains_text[[i]]>
            - stop if:<player.item_in_hand.contains_text[air]>

            - if <player.has_flag[cd_itemchat]> = true:
                - narrate "<&8>[<&c><&l>!<&8>] <&c>Item Chat is cooldown" targets:<player>
                - determine cancelled
            - define message <context.message.replace[[i]].with[<&R>]>

            - define item <player.item_in_hand>
            - define icon <[item].material.name.replace[_].with[<&sp>].to_titlecase>

            - define quantity <&r>
            - if <[item].quantity> > 1:
                - define quantity <&sp><&7>X<[item].quantity>

            - define hover "<&sp><&8>[ <&7><element[<[icon]>].hover_item[<player.item_in_hand>]><[quantity]> <&8>]"

            - announce "<player.flag[rank]> <&f><player.name> <&8>» <&7><[message]><[hover]>" to_console
            - announce "<player.flag[rank]> <&f><player.name> <&8>» <&7><[message]><[hover]>"

            - flag <player> cd_itemchat expire:15s
            - determine cancelled