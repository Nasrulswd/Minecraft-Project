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

# GraveStone Item
GraveStone_Marker:
    type: entity
    debug: false
    entity_type: armor_stand
    mechanisms:
        visible: false
        arms: true
        gravity: false
        fire_time: 0
        armor_pose: right_arm=0,0,0;left_arm=0,0,0
        item_in_offhand: <item[paper].with[custom_model_data=1]>

GraveStone_GUI:
    type: task
    debug: false
    definitions: player|cause
    script:
        - stop if:<[player].inventory.list_contents.is_empty>

        # GraveStone Inventory
        - define size 54
        - define title "<proc[util_textoffset].context[-8]><&f><element[💎].font[custom]><proc[util_textoffset].context[-170]><&8><[player].name>'s GraveStone"
        - define inventory <inventory[generic[size=<[size]>;title=<[title]>]]>

        # Move equipment to slot 1, 2, 3, and 4
        - define equipment <[player].equipment>
        - foreach <[equipment].reverse>:
            - define n:++
            - inventory set o:<[value]> slot:<[n]> d:<[inventory]>

        # Move item offhand to slot 6
        - inventory set o:<[player].item_in_offhand> slot:6 d:<[inventory]>

        # Move item in inventory to GraveStone
        - define n 18
        - foreach <[player].inventory.list_contents.get[1].to[36]>:
            - define n:++
            - inventory set o:<[value]> slot:<[n]> d:<[inventory]>

        # Clear inventory player after death
        - inventory clear d:<[player]>

        # Spawn Gravestone item on player death location
        - define location <[player].location.below[1.2]>
        - if <[cause]> == void && <[location]> < 0:
            - define location <[location].with_y[0]>
        - spawn GraveStone_Marker <[location]> save:GraveStone_Marker
        - define gravestone <entry[GraveStone_Marker].spawned_entity>
        - equip <[gravestone]> hand:<item[player_head].with[custom_model_data=2;skull_skin=<[player].name>]>

        # Player Item in GraveStone
        - define id_gravestone GraveStone_<[player]>_<[gravestone]>
        - note <[inventory]> as:<[id_gravestone]>

        ## idk
        - flag <[gravestone]> GraveStone.owner:<[player]>
        - flag <[gravestone]> GraveStone.inventory:<[id_gravestone]>

GraveStone_listener:
    type: world
    debug: false
    events:
        after system time 0:00:
            - remove GraveStone_Marker
        on player death:
            - stop if:<player.gamemode.equals[creative]>
            - stop if:!<player.has_flag[knockdown]>
            - if !<player.inventory.is_empty>:
                - narrate ""
                - narrate "<&c>☠ <&8>» <&c>Your Death World:"
                - narrate "      <&8>[<&c><player.world.name.replace[_].with[<&sp>].to_titlecase><&8>]"
                - narrate "<&c>☠ <&8>» <&c>Your Gravestone Location:"
                - narrate "      <&8>[<&c>X: <player.location.x.as_money><&8>] <&8>[<&c>Y: <player.location.y.as_money><&8>] <&8>[<&c>Z: <player.location.z.as_money><&8>]"
                - narrate ""
            - run GraveStone_GUI def:<player>|<context.cause>
            - determine no_drops

        on player right clicks armor_stand:

            # Stop if not gravestone
            - stop if:!<context.entity.has_flag[gravestone]>
            - determine passively cancelled

            # Click on top of the armor stand
            - if <context.click_position.y.is_more_than[1.22]> && <context.entity.has_flag[GraveStone]>:
                - define entity <context.entity>

                # Open gravestone
                - inventory open d:<[entity].flag[GraveStone.inventory]>

        on player clicks in inventory:
            # check if the inventory is gravestone
            - if <context.inventory.title.contains_text[GraveStone]>:

                # player can't shift click
                - if <context.is_shift_click>:
                    - determine cancelled

                # other player can't take other player gravestone
                - if !<context.inventory.title.contains_text[<player.name>'s GraveStone]>:
                    - determine cancelled

                # player can't place item in gravestone
                - if <context.cursor_item.is_truthy> && <context.clicked_inventory.inventory_type> == chest:
                    - determine cancelled

                # take all
                - if <context.slot> >= 7 && <context.slot> <= 9 && <context.clicked_inventory.inventory_type> == chest:
                    - ratelimit <player> 1s

                    - playsound <player> sound:ui_button_click

                    - define inventory <context.inventory>
                    - define contents <[inventory].slot[<util.list_numbers_to[36].parse[add[18]].separated_by[|]>]>
                    - define shulker <[contents].filter[contains[shulker_box]].filter[inventory_contents.is_emty.not]>
                    - define items <[contents].filter[contains[<item[air]>].not]>

                    - repeat 4:
                        - define armor:->:<item[air]>

                    - define equipment <[inventory].slot[<util.list_numbers_to[4].separated_by[|]>]>
                    - foreach <[equipment].reverse>:
                        - define n:++
                        - if <[value].equals[<item[air]>]>:
                            - foreach next
                        - if <player.equipment.get[<[n]>].is_truthy>:
                            - if <[value].is_truthy>:
                                - define item:->:<[value]>
                            - define armor[<[n]>]:<player.equipment.get[<[n]>]>
                        - else:
                            - define armor[<[n]>]:<[value]>

                    - adjust <player> equipment:<[armor]>
                    - inventory close

                    - define item_offhand <[inventory].slot[6]>
                    - define player_offhand <player.item_in_offhand>
                    - if <[item_offhand].is_truthy> && !<[player_offhand].is_truthy>:
                        - equip <player> offhand:<[item_offhand]>
                    - else:
                        - define items:->:<[item_offhand]>
                    - if !<[items].is_empty>:
                        - give <[items].filter[contains[<item[air]>].not]> to:<player.inventory>
                        - give <[shulker]> to:<player.inventory>

                    - define inventory <context.inventory>
                    - define id_gravestone <[inventory].note_name.if_null[null]>
                    - stop if:<[id_gravestone].equals[null]>

                    - define gravestone <[id_gravestone].split[_].get[3].split[/].get[1].as_entity>

                    - note remove as:<[id_gravestone]>
                    - remove <[gravestone]>

        on player closes inventory:
            # check if the inventory is gravestone
            - if <context.inventory.title.contains_text[GraveStone]>:

                # remove gravestone
                - if <context.inventory.is_empty>:
                    - define inventory <context.inventory>
                    - define id_gravestone <[inventory].note_name.if_null[null]>
                    - stop if:<[id_gravestone].equals[null]>

                    - define gravestone <[id_gravestone].split[_].get[3].split[/].get[1].as_entity>

                    - note remove as:<[id_gravestone]>
                    - remove <[gravestone]>