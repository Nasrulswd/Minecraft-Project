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


death_popup:
    type: world
    debug: fales
    events:
        on player dies:
            - toast "<&f><player.name> <&c><&l>ᴅᴇᴀᴛʜ!" icon:SKELETON_SKULL targets:<server.online_players> frame:goal
            - determine "<&f>"