SetHome_Commnad:
    type: command
    name: sethome
    debug: false
    description: Set Home Command
    permission: denizen.home
    usage: /sethome
    script:
        - if <context.server>:
            - announce "<&c>Your are not player" to_console
            - stop
        - if <player.has_permission[homes.premium].not> and <player.flag[home.limit].equals[2].if_null[]>:
            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&c>You reached home limits"
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&c>You reached home limits"
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:entity_villager_no
            - stop

        - else if <player.has_flag[home.1].not>:

            - flag <player> home.1.location:<player.location>
            - flag <player> home.1.name:1
            - flag <player> home.1.tab:<player.location>
            - flag <player> home.limit:++

            - if <player.has_flag[home.list].not>:
                - define list <list>
                - define list:->:1
                - flag <player> home.list:<[list]>
            - else:
                - define list <player.flag[home.list]>
                - define list:->:1
                - flag <player> home.list:<[list]>

            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&7>Home created"
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&7>Home created"

        - else if <player.has_flag[home.2].not>:

            - flag <player> home.2.location:<player.location>
            - flag <player> home.2.name:2
            - flag <player> home.2.tab:<player.location>
            - flag <player> home.limit:++

            - if <player.has_flag[home.list].not>:
                - define list <list>
                - define list:->:2
                - flag <player> home.list:<[list]>
            - else:
                - define list <player.flag[home.list]>
                - define list:->:2
                - flag <player> home.list:<[list]>

            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&7>Home created"
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&7>Home created"

        - else if <player.has_flag[home.3].not>:

            - flag <player> home.3.location:<player.location>
            - flag <player> home.3.name:3
            - flag <player> home.3.tab:<player.location>
            - flag <player> home.limit:++

            - if <player.has_flag[home.list].not>:
                - define list <list>
                - define list:->:3
                - flag <player> home.list:<[list]>
            - else:
                - define list <player.flag[home.list]>
                - define list:->:3
                - flag <player> home.list:<[list]>

            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&7>Home created"
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&7>Home created"

        - else if <player.has_flag[home.4].not>:

            - flag <player> home.4.location:<player.location>
            - flag <player> home.4.name:4
            - flag <player> home.4.tab:<player.location>
            - flag <player> home.limit:++

            - if <player.has_flag[home.list].not>:
                - define list <list>
                - define list:->:4
                - flag <player> home.list:<[list]>
            - else:
                - define list <player.flag[home.list]>
                - define list:->:4
                - flag <player> home.list:<[list]>

            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&7>Home created"
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&7>Home created"

        - else if <player.has_flag[home.5].not>:

            - flag <player> home.5.location:<player.location>
            - flag <player> home.5.name:5
            - flag <player> home.5.tab:<player.location>
            - flag <player> home.limit:++

            - if <player.has_flag[home.list].not>:
                - define list <list>
                - define list:->:5
                - flag <player> home.list:<[list]>
            - else:
                - define list <player.flag[home.list]>
                - define list:->:5
                - flag <player> home.list:<[list]>

            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&7>Home created"
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&7>Home created"

Home_Command:
    type: command
    name: home
    debug: false
    description: Home Command
    usage: /home
    aliases:
        - homes
    tab completions:
        1: <player.flag[home.list].if_null[]>
    script:
        
        - if <context.server>:
            - announce "<&c>Your are not player" to_console
            - stop
        - if <context.args.get[1].if_null[].equals[]>:
            - flag <player> home.open
            - define size 36
            - define title "Homes"
            - define inventory <inventory[generic[size=<[size]>;title=<[title]>]]>

            - inventory open d:<[inventory]>

            - if <player.has_flag[team.team]> && <server.flag[team.team.<player.flag[team.team]>.leader].equals[<player.name>]> && <server.has_flag[team.team.<player.flag[team.team]>.home].not>:
                - inventory set slot:11 o:<item[Dont_Team_Home_Item]> d:<[inventory]>
                - inventory set slot:20 o:<item[Dont_Team_Home_Item1]> d:<[inventory]>

            - else if <player.has_flag[team.team]> && <server.flag[team.team.<player.flag[team.team]>.leader].equals[<player.name>]> && <server.has_flag[team.team.<player.flag[team.team]>.home]>:
                - inventory set slot:11 o:<item[Team_Home_Item]> d:<[inventory]>
                - inventory set slot:20 o:<item[Team_Home_Item1]> d:<[inventory]>

            - else if <player.has_flag[team.team].not>:
                - inventory set slot:11 o:<item[Team_Home_Item2]> d:<[inventory]>
                - inventory set slot:20 o:<item[Team_Home_Item3]> d:<[inventory]>

            # Set Home
            - define THome 13
            - define DHome 22
            - repeat 5:

                # Have home
                - if <player.has_flag[home.<[THome].sub[12]>.location]>:
                    # Teleport home
                    - inventory set slot:<[THome]> o:<item[THome_Item]> d:<[inventory]>
                    - inventory adjust slot:<[THome]> "display:<&color[#277fff]>Home <player.flag[home.<[THome].sub[12]>.name]>" d:<[inventory]>
                    - inventory adjust slot:<[THome]> "lore:<&f>Click to teleport to your home" d:<[inventory]>
                    - define THome:++

                    # Delete home
                    - inventory set slot:<[DHome]> o:<item[DHome_Item]> d:<[inventory]>
                    - inventory adjust slot:<[DHome]> "display:<&color[#277fff]>Home <player.flag[home.<[DHome].sub[21]>.name]>" d:<[inventory]>
                    - inventory adjust slot:<[DHome]> "lore:<&f>Click to delete this home" d:<[inventory]>
                    - define DHome:++

                # Not have home
                - else:
                    - if <player.has_permission[homes.premium].not> and <player.flag[home.limit].equals[2].if_null[]>:
                        - if <player.has_flag[home.<[THome].sub[12]>].not>:
                            - inventory set slot:<[THome]> o:<item[Dont_Perm_item]> d:<[inventory]>
                            - inventory set slot:<[DHome]> o:<item[Dont_Perm_item2]> d:<[inventory]>
                            - define THome:++
                            - define DHome:++

                    - else:
                        # Teleport home
                        - inventory set slot:<[THome]> o:<item[Dont_THome_Item]> d:<[inventory]>
                        - define THome:++

                        # Delete home
                        - inventory set slot:<[DHome]> o:<item[Dont_DHome_Item]> d:<[inventory]>
                        - define DHome:++

                - wait 0.0001t
        - else:
            - if <player.flag[home.list].contains_text[<context.raw_args>]>:
                - stop if:<player.is_online.not>
                - stop if:<player.is_spawned.not>

                - if <player.has_flag[home.tp]>:
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&c>You are already teleporting."
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&c>You are already teleporting."
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:entity_villager_no
                    - stop

                - flag <player> home.tp:<player.location.below.center>
                - define s 5
                - repeat 5:
                    - if <player.flag[home.tp].equals[<player.location.below.center>].not>:
                        - if <player.has_flag[setting.chat_server_msg].not>:
                            - narrate "<&c>Teleport cancelled because you moved."
                        - if <player.has_flag[setting.hotbar_server_msg].not>:
                            - actionbar "<&c>Teleport cancelled because you moved."
                        - flag <player> home.tp:!
                        - stop
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&7>Teleporting in <&color[#277fff]><[s]> <&7>seconds"
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&7>Teleporting in <&color[#277fff]><[s]> <&7>seconds"
                    - define s:--
                    - wait 1s
                - flag <player> home.tp:!
                - teleport <player> <player.flag[home.<context.raw_args>.tab]>
                - if <player.has_flag[setting.chat_server_msg].not>:
                    - narrate "<&7>You teleported to your home"
                - if <player.has_flag[setting.hotbar_server_msg].not>:
                    - actionbar "<&7>You teleported to your home"
                - if <player.has_flag[setting.sound_effect].not>:
                    - playsound <player> sound:entity_enderman_teleport

            - else:
                - execute as_player "homes"
Home_Handler:
    type: world
    debug: false
    events:
        on player closes inventory:
            - flag <player> home.open:!
        on player clicks item in inventory:
            - if <context.clicked_inventory.equals[<inventory[<player.inventory>]>].if_null[]> && <player.has_flag[home.open]>:
                - determine cancelled
        on player respawns:
            - flag <player> home.open:!
            - flag <player> home.tp:!
            - flag <player> home.rename:!
            - flag <player> home.del_home:!
        on player quits:
            - flag <player> home.open:!
            - flag <player> home.tp:!
            - flag <player> home.rename:!
            - flag <player> home.del_home:!

        on player clicks Team_Home_Item2 in inventory:
            - determine passively cancelled
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:ui_button_click
                - playsound <player> sound:entity_villager_no
            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&c>You do not have a team."
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&c>You do not have a team."
            
        on player clicks Team_Home_Item3 in inventory:
            - determine passively cancelled
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:ui_button_click
                - playsound <player> sound:entity_villager_no
            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&c>You do not have a team."
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&c>You do not have a team."

        on player clicks Dont_Team_Home_Item in inventory:
            - determine passively cancelled
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:ui_button_click
            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&7>Team home set."
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&7>Team home set"
            - flag server team.team.<player.flag[team.team]>.home:<player.location>
            - execute as_player "home"

        
        on player clicks Dont_Team_Home_Item1 in inventory:
            - determine passively cancelled
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:ui_button_click
            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&7>Team home set."
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&7>Team home set"
            - flag server team.team.<player.flag[team.team]>.home:<player.location>
            - execute as_player "home"

        on player clicks Team_Home_Item in inventory:
            - determine passively cancelled
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:ui_button_click


            - if <player.has_flag[home.tp]>:
                - if <player.has_flag[setting.chat_server_msg].not>:
                    - narrate "<&c>You are already teleporting."
                - if <player.has_flag[setting.hotbar_server_msg].not>:
                    - actionbar "<&c>You are already teleporting."
                - if <player.has_flag[setting.sound_effect].not>:
                    - playsound <player> sound:entity_villager_no
                - stop

            - flag <player> home.tp:<player.location.below.center>
            - define s 5
            - repeat 5:
                - stop if:<player.is_online.not>
                - stop if:<player.is_spawned.not>
                - if <player.flag[home.tp].equals[<player.location.below.center>].not>:
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&c>Teleport cancelled because you moved."
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&c>Teleport cancelled because you moved."
                    - flag <player> home.tp:!
                    - stop
                - if <player.has_flag[setting.chat_server_msg].not>:
                    - narrate "<&7>Teleporting in <&color[#277fff]><[s]> <&7>seconds"
                - if <player.has_flag[setting.hotbar_server_msg].not>:
                    - actionbar "<&7>Teleporting in <&color[#277fff]><[s]> <&7>seconds"
                - define s:--
                - wait 1s
            - flag <player> home.tp:!
            - teleport <player> <server.flag[team.team.<player.flag[team.team]>.home]>
            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&7>You teleported to your team's home"
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&7>You teleported to your team's home"
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:entity_enderman_teleport

        on player clicks Team_Home_Item1 in inventory:
            - determine passively cancelled
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:ui_button_click
            
            - if <player.has_flag[home.tp]>:
                - if <player.has_flag[setting.chat_server_msg].not>:
                    - narrate "<&c>You are already teleporting."
                - if <player.has_flag[setting.hotbar_server_msg].not>:
                    - actionbar "<&c>You are already teleporting."
                - if <player.has_flag[setting.sound_effect].not>:
                    - playsound <player> sound:entity_villager_no
                - stop

            - flag <player> home.tp:<player.location.below.center>
            - define s 5
            - repeat 5:
                - stop if:<player.is_online.not>
                - stop if:<player.is_spawned.not>
                - if <player.flag[home.tp].equals[<player.location.below.center>].not>:
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&c>Teleport cancelled because you moved."
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&c>Teleport cancelled because you moved."
                    - flag <player> home.tp:!
                    - stop
                - if <player.has_flag[setting.chat_server_msg].not>:
                    - narrate "<&7>Teleporting in <&color[#277fff]><[s]> <&7>seconds"
                - if <player.has_flag[setting.hotbar_server_msg].not>:
                    - actionbar "<&7>Teleporting in <&color[#277fff]><[s]> <&7>seconds"
                - define s:--
                - wait 1s
            - flag <player> home.tp:!
            - teleport <player> <server.flag[team.team.<player.flag[team.team]>.home]>
            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&7>You teleported to your home"
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&7>You teleported to your home"
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:entity_enderman_teleport

        on player clicks Dont_THome_Item in inventory:
            - determine passively cancelled
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:ui_button_click

        on player clicks Dont_DHome_Item in inventory:
            - determine passively cancelled
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:ui_button_click

            - flag <player> home.<context.slot.sub[21]>.location:<player.location>
            - flag <player> home.<context.slot.sub[21]>.name:<context.slot.sub[21]>
            - flag <player> home.<context.slot.sub[21]>.tab:<player.location>
            - flag <player> home.limit:++

            - if <player.has_flag[home.list].not>:
                - define list <list>
                - define list:->:<context.slot.sub[21]>
                - flag <player> home.list:<[list]>
            - else:
                - define list <player.flag[home.list]>
                - define list:->:<context.slot.sub[21]>
                - flag <player> home.list:<[list]>

            - execute as_player "home"
            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&7>Home created"
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&7>Home created"

        on player left clicks THome_Item in inventory:
            - determine passively cancelled
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:ui_button_click

            - if <player.has_flag[home.tp]>:
                - if <player.has_flag[setting.chat_server_msg].not>:
                    - narrate "<&c>You are already teleporting."
                - if <player.has_flag[setting.hotbar_server_msg].not>:
                    - actionbar "<&c>You are already teleporting."
                - if <player.has_flag[setting.sound_effect].not>:
                    - playsound <player> sound:entity_villager_no
                - stop

            - flag <player> home.tp:<player.location.below.center>
            - define s 5
            - repeat 5:
                - stop if:<player.is_online.not>
                - stop if:<player.is_spawned.not>
                - if <player.flag[home.tp].equals[<player.location.below.center>].not>:
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&c>Teleport cancelled because you moved."
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&c>Teleport cancelled because you moved."
                    - flag <player> home.tp:!
                    - stop
                - if <player.has_flag[setting.chat_server_msg].not>:
                    - narrate "<&7>Teleporting in <&color[#277fff]><[s]> <&7>seconds"
                - if <player.has_flag[setting.hotbar_server_msg].not>:
                    - actionbar "<&7>Teleporting in <&color[#277fff]><[s]> <&7>seconds"
                - define s:--
                - wait 1s
            - flag <player> home.tp:!
            - teleport <player> <player.flag[home.<context.slot.sub[12]>.location]>
            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&7>You teleported to your home"
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&7>You teleported to your home"
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:entity_enderman_teleport

        on player chats:
            - if <player.has_flag[home.rename]>:
                - if <player.has_flag[setting.chat_server_msg].not>:
                    - narrate "<&7>You renamed your home to <&color[#277fff]><context.message>"
                - if <player.has_flag[setting.hotbar_server_msg].not>:
                    - actionbar "<&7>You renamed your home to <&color[#277fff]><context.message>"
                - if <player.flag[home.<player.flag[home.rename]>.name].equals[<player.flag[home.rename]>]>:
                    - define list <player.flag[home.list]>
                    - define list:->:<context.message>
                    - define 1:<[list]>
                    - define 1:<-:<player.flag[home.rename]>
                    - define 2:<[1]>
                    - flag <player> home.list:<[2]>
                    - flag <player> home.<player.flag[home.rename]>.tab:!
                    - flag <player> home.<context.message>.tab:<player.flag[home.<player.flag[home.rename]>.location]>
                    - flag <player> home.<context.message>.server:<player.flag[home.<player.flag[home.rename]>.server]>


                - else:
                    - define list <player.flag[home.list]>
                    - define list:<-:<player.flag[home.<player.flag[home.rename]>.name].replace_text[<player.flag[home.rename]><&sp>].with[]>
                    - define 1 <[list]>
                    - define 1:->:<context.message>
                    - define 2 <[1]>
                    - flag <player> home.list:<[2]>
                    - flag <player> home.<player.flag[home.rename]>_<player.flag[home.<player.flag[home.rename]>.name].replace_text[<player.flag[home.rename]><&sp>].with[]>.tab:!
                    - flag <player> home.<context.message>.tab:<player.flag[home.<player.flag[home.rename]>.location]>


                - flag <player> home.<player.flag[home.rename]>.name:<player.flag[home.rename]><&sp><context.message>
                - execute as_player "home"
                - flag <player> home.rename:!
                - determine cancelled

        on player right clicks THome_Item in inventory:
            - determine passively cancelled
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:ui_button_click

            - inventory close
            - if <player.has_flag[setting.chat_server_msg].not>:
                - narrate "<&7>Type the new home name in chat"
            - if <player.has_flag[setting.hotbar_server_msg].not>:
                - actionbar "<&7>Type the new home name in chat"
            - flag <player> home.rename:<context.slot.sub[12]>

        on player clicks DHome_Item in inventory:
            - determine passively cancelled
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:ui_button_click

            - flag <player> home.del_home:<context.slot.sub[21]>

            - inventory open d:DHome_Inventory

            - flag <player> home.wait expire:1s

        on player clicks Dont_Perm_item in inventory:
            - determine passively cancelled
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:ui_button_click

        on player clicks Dont_Perm_item2 in inventory:
            - determine passively cancelled
            - if <player.has_flag[setting.sound_effect].not>:
                - playsound <player> sound:ui_button_click

        on player opens DHome_Inventory:
            - inventory set slot:14 o:blue_dye d:<context.inventory>
            - inventory adjust slot:14 "display:<&color[#277fff]>Home <player.flag[home.<player.flag[home.del_home]>.name]>" d:<context.inventory>

        on player closes DHome_Inventory:
            - flag <player> del_home:!

        on player clicks item in DHome_Inventory:
            - determine passively cancelled

            - if <context.slot.equals[14]>:
                - if <player.has_flag[setting.sound_effect].not>:
                    - playsound <player> sound:ui_button_click

            - if <context.slot.equals[16]>:
                - if <player.has_flag[setting.sound_effect].not>:
                    - playsound <player> sound:ui_button_click
                - if <player.has_flag[home.wait]>:
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&c>Wait 1 seconds before confirming this, are you sure this is not a mistake?"
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&c>Wait 1 seconds before confirming this, are you sure this is not a mistake?"
                - else:
                    - flag <player> home.limit:--
                    - if <player.flag[home.<player.flag[home.del_home]>.name].equals[<player.flag[home.del_home]>]>:
                        - define list <player.flag[home.list]>
                        - define list:<-:<player.flag[home.<player.flag[home.del_home]>.name]>
                        - define home_list <[list]>
                        - flag <player> home.list:<[home_list]>
                        - flag <player> home.<player.flag[home.del_home]>.tab:!
                    - else:
                        - define list <player.flag[home.list]>
                        - define list:<-:<player.flag[home.<player.flag[home.del_home]>.name].replace_text[<player.flag[home.del_home]><&sp>].with[]>
                        - define home_list <[list]>
                        - flag <player> home.list:<[home_list]>
                        - flag <player> home.<player.flag[home.<player.flag[home.del_home]>.name].replace_text[<player.flag[home.del_home]><&sp>].with[]>.tab:!

                    - flag <player> home.<player.flag[home.del_home]>:!

                    - execute as_player "home"
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&7>Home deleted"
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&7>Home deleted"

            - if <context.slot.equals[12]>:
                - if <player.has_flag[setting.sound_effect].not>:
                    - playsound <player> sound:ui_button_click
                - execute as_player "home"


DHome_Inventory:
    type: inventory
    inventory: chest
    debug: false
    title: Confirm delete
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [Cancel_Delete] [] [] [] [Confirm_Delete] [] []
    - [] [] [] [] [] [] [] [] []

Confirm_Delete:
    type: item
    material: lime_stained_glass_pane
    debug: false
    display name: <&color[#00ff0a]>Confirm
    lore:
        - "<&f>Click to delete"

Cancel_Delete:
    type: item
    material: red_stained_glass_pane
    debug: false
    display name: <&color[#ff0000]>Cancel
    lore:
        - "<&f>Click to cancel"

Dont_Team_Home_Item:
    type: item
    material: white_banner
    debug: false
    display name: <&color[#ff0000]>Team Home
    lore:
        - "<&f>Click to create a team home"

Dont_Team_Home_Item1:
    type: item
    material: gray_dye
    debug: false
    display name: <&color[#ff0000]>Team Home
    lore:
        - "<&f>Click to create a team home"

Team_Home_Item:
    type: item
    material: white_banner
    debug: false
    display name: <&color[#3381f3]>Team Home
    lore:
        - "<&f>Click to teleport to your team's home"

Team_Home_Item1:
    type: item
    material: blue_dye
    debug: false
    display name: <&color[#3381f3]>Team Home
    lore:
        - "<&f>Click to teleport to your team's home"

Team_Home_Item2:
    type: item
    material: red_banner
    debug: false
    display name: <&color[#ff0000]>Team Home
    lore:
        - "<&f>You don't have a team"

Team_Home_Item3:
    type: item
    material: red_dye
    debug: false
    display name: <&color[#ff0000]>Team Home
    lore:
        - "<&f>You don't have a team"

THome_Item:
    type: item
    material: light_blue_bed
    debug: false
    display name: <&color[#3381f3]>Home

DHome_Item:
    type: item
    material: blue_dye
    debug: false
    display name: <&color[#3381f3]>Home

Dont_THome_Item:
    type: item
    material: light_gray_bed
    debug: false
    display name: <&7>No home set
    lore:
        - "<&f>- Click to create a home"

Dont_DHome_Item:
    type: item
    material: gray_dye
    debug: false
    display name: <&7>No home set
    lore:
        - "<&f>Click to create a home"

Dont_Perm_item:
    type: item
    material: red_bed
    debug: false
    display name: <&color[#ff0000]>No permission
    lore:
        - "<&f>You need a higher rank for this home"

Dont_Perm_item2:
    type: item
    material: red_dye
    debug: false
    display name: <&color[#ff0000]>No permission
    lore:
        - "<&f>You need a higher rank for this home"