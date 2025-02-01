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


blood_handler:
    type: world
    debug: false
    events:
        on entity damaged by entity:
            - stop if:<context.entity.contains_text[item_frame]>
            - playeffect effect:BLOCK_CRACK at:<context.entity.eye_location.down[0.5]> quantity:10 offset:0.1 special_data:redstone_block
            - if <context.entity.location.below> matches air:
                - stop
            - if <context.entity.location.below> matches water:
                - stop
            - if <context.entity.location> matches air:
                - showfake <context.entity.location.below[0]> redstone_wire d:7s players:<server.online_players>