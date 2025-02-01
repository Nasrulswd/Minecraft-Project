Team_Command:
    type: command
    name: team
    description: Team Command
    tab complete:
        - if <player.has_flag[team.team].not>:
            - if <context.args.get[1].equals[create].if_null[]>:
                - determine (name)
            - else if <context.args.get[1].equals[join].if_null[]>:
                - determine <server.online_players.parse[name]>
            - else:
                - determine create|join

        # Have team
        - else if <player.has_flag[team.team]>:
            - if <context.args.get[1].equals[chat].if_null[]>:
                - determine ""
            - else if <context.args.get[1].equals[delhome].if_null[]>:
                - determine ""
            - else if <context.args.get[1].equals[disband].if_null[]>:
                - determine ""
            - else if <context.args.get[1].equals[home].if_null[]>:
                - determine ""
            - else if <context.args.get[1].equals[info].if_null[]>:
                - determine <server.online_players.parse[name]>
            - else if <context.args.get[1].equals[invite].if_null[]>:
                - determine <server.online_players.parse[name]>
            - else if <context.args.get[1].equals[kick].if_null[]>:
                - determine <server.flag[team.team.<player.flag[team.team]>.member].if_null[]>
            - else if <context.args.get[1].equals[leave].if_null[]>:
                - determine ""
            - else if <context.args.get[1].equals[sethome].if_null[]>:
                - determine ""
            - else if <context.args.get[1].equals[create].if_null[]>:
                - determine '(already have a team)'
            - else if <context.args.get[1].equals[join].if_null[]>:
                - determine '(already have a team)'
            - else:
                - determine chat|delhome|disband|home|info|invite|kick|leave|sethome


    aliases:
        - teams
    usage: /team
    permission: denizen.team
    script:
        ## Player don't have a team
        - if <player.has_flag[team.team].not>:
            - if <context.args.get[1].if_null[].equals[]>:
                - narrate "<&c>You don't have a team. Type /team create (name) to create a team."
                - flag <player> team:!


            
            # Tab Join

            - else if <context.args.get[1].equals[join]> && <server.match_player[<context.args.get[2]>].has_flag[team.team].not.if_null[]>:
                - narrate "<&c>Team does not exist"

            - else if <context.args.get[1].equals[join]> && <server.match_player[<context.args.get[2]>].has_flag[team.team].if_null[]> && <player.flag[team.invited].find[<context.args.get[2]>].equals[-1]>:
                - narrate "<&c>You are not invited to this team."

            - else if <context.args.get[1].equals[join]> && <server.match_player[<context.args.get[2]>].has_flag[team.team].if_null[]> && <player.flag[team.invited].contains[<context.args.get[2]>]>:
                - if <player.has_flag[setting.chat_server_msg].not>:
                    - narrate "<&7>Joined <&color[#277fff]><context.args.get[2]> <&7>team"
                - if <player.has_flag[setting.hotbar_server_msg].not>:
                    - actionbar "<&7>Joined <&color[#277fff]><context.args.get[2]> <&7>team"

                - define ply <player.name>
                - foreach <server.match_player[<context.args.get[2]>]> as:__player:
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&7>user <&color[#277fff]><[ply]> <&7>joined the team"
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&7>Joined <&color[#277fff]><[ply]> <&7>joined the team"
                - flag <player> team.invited:!
                - flag <player> team.team:<server.match_player[<context.args.get[2]>].flag[team.team]>
                - flag <player> team.name.<server.match_player[<context.args.get[2]>].flag[team.team]>
                - define a <server.flag[team.team.<player.flag[team.team]>.member]>
                - define b <server.flag[team.team.<player.flag[team.team]>.uuid]>
                - define a:->:<player.name>
                - define b:->:<player>
                - flag server team.team.<player.flag[team.team]>.member:<[a]>
                - flag server team.team.<player.flag[team.team]>.uuid:<[b]>

            # Tab Create
            - else if <context.args.get[1].equals[create]> && <context.args.get[2].if_null[].equals[]>:
                - stop

            - else if <context.args.get[1].equals[create]> && <context.args.get[2].equals[].not>:
                - if <player.has_flag[setting.chat_server_msg].not>:
                    - narrate "<&color[#50ff00]>Team created."
                - if <player.has_flag[setting.hotbar_server_msg].not>:
                    - actionbar "<&color[#50ff00]>Team created."
                - if <player.has_flag[setting.sound_effect].not>:
                    - playsound <player> sound:entity_player_levelup pitch:2

                - flag <player> team.team:<context.args.get[2]>
                - flag <player> team.name.<context.args.get[2]>
                - flag server team.team.<context.args.get[2]>.leader:<player.name>
                - flag server team.team.<context.args.get[2]>.member:<player.name.as_list>
                - flag server team.team.<context.args.get[2]>.uuid:<player.uuid.as_player.as_list>

            - else:
                - narrate "<&c>You don't have a team. Type /team create (name) to create a team."

        ## Player have a team
        - else:
            - if <context.args.get[1].if_null[].equals[]>:
                - flag <player> team_page:1
                - inventory open d:Team_GUI
                - stop

            
            - else:
                ## TEAM CHAT
                - if <context.args.get[1].equals[chat]>:
                    - if <player.has_flag[setting.chat_team].not>:
                        - if <player.has_flag[setting.chat_server_msg].not>:
                            - narrate "<&7>You enable team chat."
                        - if <player.has_flag[setting.hotbar_server_msg].not>:
                            - actionbar "<&7>You enable team chat."
                        - flag <player> setting.chat_team
                    - else if <player.has_flag[setting.chat_team]>:
                        - if <player.has_flag[setting.chat_server_msg].not>:
                            - narrate "<&7>You disable team chat."
                        - if <player.has_flag[setting.hotbar_server_msg].not>:
                            - actionbar "<&7>You disable team chat."
                        - flag <player> setting.chat_team:!

                ## TEAM DELETE HOME
                - else if <context.args.get[1].equals[delhome]>:
                    - if <server.flag[team.team.<player.flag[team.team]>.leader].equals[<player.name>].if_null[]> || <player.has_flag[team.<player.flag[team.team]>.edithome].if_null[]>:
                        - if <server.has_flag[team.team.<player.flag[team.team]>.home]>:
                            - if <player.has_flag[setting.chat_server_msg].not>:
                                - narrate "<&7>Team home deleted."
                            - if <player.has_flag[setting.hotbar_server_msg].not>:
                                - actionbar "<&7>Team home deleted."
                            - flag server team.team.<player.flag[team.team]>.home:!
                        - else:
                            - if <player.has_flag[setting.chat_server_msg].not>:
                                - narrate "<&7>Your team does not have a home."
                            - if <player.has_flag[setting.hotbar_server_msg].not>:
                                - actionbar "<&7>Your team does not have a home."
                            - if <player.has_flag[setting.sound_effect].not>:
                                - playsound <player> sound:entity_villager_no
                    - else:
                        - if <player.has_flag[setting.chat_server_msg].not>:
                            - narrate "<&c>You do not have permission to delete the team home."
                        - if <player.has_flag[setting.hotbar_server_msg].not>:
                            - actionbar "<&c>You do not have permission to delete the team home."
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:entity_villager_no
                        - stop

                ## DELETE TEAM / LEAVE TEAM
                - else if <context.args.get[1].equals[disband]>:
                    - if <server.flag[team.team.<player.flag[team.team]>.leader].equals[<player.name>].if_null[]>:
                        - define size 27
                        - define title "Confirm disbanding team"
                        - define inventory <inventory[generic[size=<[size]>;title=<[title]>]]>

                        - inventory open d:<[inventory]>

                        - inventory set slot:12 o:<item[red_stained_glass_pane[display=<&color[#ff0000]>Cancel;lore=<&f>Click to cancel]]> d:<[inventory]>
                        - inventory set slot:16 o:<item[lime_stained_glass_pane[display=<&color[#00ff0a]>Confirm;lore=<&f>Click to confirm]]> d:<[inventory]>

                    - else:
                        - define size 27
                        - define title "Confirm leaving team"
                        - define inventory <inventory[generic[size=<[size]>;title=<[title]>]]>

                        - inventory open d:<[inventory]>

                        - inventory set slot:12 o:<item[red_stained_glass_pane[display=<&color[#ff0000]>Cancel;lore=<&f>Click to cancel]]> d:<[inventory]>
                        - inventory set slot:16 o:<item[lime_stained_glass_pane[display=<&color[#00ff0a]>Confirm;lore=<&f>Click to confirm]]> d:<[inventory]>

                ## HOME
                - else if <context.args.get[1].equals[home]>:

                    - if <server.flag[team.team.<player.flag[team.team]>.leader].equals[<player.name>].if_null[]> || <player.has_flag[team.<player.flag[team.team]>.teamhome].if_null[]>:
                        - if <server.has_flag[team.team.<player.flag[team.team]>.home]>:

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

                        - else:
                            - if <player.has_flag[setting.chat_server_msg].not>:
                                - narrate "<&7>Your team does not have a home."
                            - if <player.has_flag[setting.hotbar_server_msg].not>:
                                - actionbar "<&7>Your team does not have a home."
                            - if <player.has_flag[setting.sound_effect].not>:
                                - playsound <player> sound:entity_villager_no
                    - else:
                        - if <player.has_flag[setting.chat_server_msg].not>:
                            - narrate "<&c>You do not have permission to go to the home."
                        - if <player.has_flag[setting.hotbar_server_msg].not>:
                            - actionbar "<&c>You do not have permission to go to the home."
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:entity_villager_no
                        - stop

                ## INFO
                - else if <context.args.get[1].equals[info]>:
                    - stop

                ## INVITE
                - else if <context.args.get[1].equals[invite]>:
                    - if <server.flag[team.team.<player.flag[team.team]>.leader].equals[<player.name>].if_null[]> || <player.has_flag[team.<player.flag[team.team]>.manage].if_null[]>:
                        - if <server.match_player[<context.args.get[2]>].is_online.not>:
                            - if <player.has_flag[setting.sound_effect].not>:
                                - playsound <player> sound:entity_villager_no
                            - if <player.has_flag[setting.chat_server_msg].not>:
                                - narrate "<&c>This user is offline."
                            - if <player.has_flag[setting.hotbar_server_msg].not>:
                                - actionbar "<&c>This user is offline."
                        - else if <server.match_player[<context.args.get[2]>].has_flag[team.team]>:
                            - if <player.has_flag[setting.sound_effect].not>:
                                - playsound <player> sound:entity_villager_no
                            - if <player.has_flag[setting.chat_server_msg].not>:
                                - narrate "<&c>This user already have a team."
                            - if <player.has_flag[setting.hotbar_server_msg].not>:
                                - actionbar "<&c>This user already have a team."
                        - else if <server.match_player[<context.args.get[2]>].has_flag[team.team]>:
                            - if <player.has_flag[setting.sound_effect].not>:
                                - playsound <player> sound:entity_villager_no
                            - if <player.has_flag[setting.chat_server_msg].not>:
                                - narrate "<&c>This user already have a team."
                            - if <player.has_flag[setting.hotbar_server_msg].not>:
                                - actionbar "<&c>This user already have a team."
                        - else if <server.match_player[<context.args.get[2]>].has_flag[team.team].not>:

                            - if <server.match_player[<context.args.get[2]>].has_flag[team.invited].not>:
                                - if <server.match_player[<context.args.get[2]>].flag[team.invited].contains[<player.name>].if_null[]>:
                                    - if <player.has_flag[setting.chat_server_msg].not>:
                                        - narrate "<&c>This user is already invited to the team."
                                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                                        - actionbar "<&c>This user is already invited to the team."
                                    - stop
                                - flag <server.match_player[<context.args.get[2]>]> team.invited:<player.name.as_list> expire:1m
                            - else:
                                - if <server.match_player[<context.args.get[2]>].flag[team.invited].contains[<player.name>].if_null[]>:
                                    - if <player.has_flag[setting.chat_server_msg].not>:
                                        - narrate "<&c>This user is already invited to the team."
                                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                                        - actionbar "<&c>This user is already invited to the team."
                                    - stop
                                - define a <server.match_player[<context.args.get[2]>].flag[team.invited]>
                                - define a:->:<player.name>
                                - flag <server.match_player[<context.args.get[2]>]> team.invited:<[a]> expire:1m

                            - if <player.has_flag[setting.sound_effect].not>:
                                - playsound <player> sound:entity_player_levelup pitch:2
                            - if <player.has_flag[setting.chat_server_msg].not>:
                                - narrate "<&7>You invited <&color[#277fff]><context.args.get[2]> <&7>to the team."
                            - if <player.has_flag[setting.hotbar_server_msg].not>:
                                - actionbar "<&7>You invited <&color[#277fff]><context.args.get[2]> <&7>to the team."

                            - define ply <player.name>
                            - foreach <server.match_player[<context.args.get[2]>]> as:__player:
                                - if <player.has_flag[setting.sound_effect].not>:
                                    - playsound <player> sound:entity_player_levelup pitch:2
                                - if <player.has_flag[setting.chat_server_msg].not>:
                                    - clickable usages:1 save:test:
                                        - define cmd "team join <[ply]>"
                                        - execute as_player <[cmd]>
                                    - narrate "<&color[#277fff]><server.match_player[<[ply]>].name> <&7>invited you to the <server.match_player[<[ply]>].flag[team.team]>. <element[<&8>[<&color[#277fff]><&l>✔<&8>]].on_hover[click to join].on_click[<entry[test].command>]>"
                                - if <player.has_flag[setting.hotbar_server_msg].not>:
                                    - actionbar "<&color[#277fff]><server.match_player[<[ply]>].name> <&7>invited you to the <server.match_player[<[ply]>].flag[team.team]>. <element[<&8>[<&color[#277fff]><&l>✔<&8>]].on_hover[click to join].on_click[<entry[test].command>]>"
                    - else:
                        - if <player.has_flag[setting.chat_server_msg].not>:
                            - narrate "<&c>You don't have permission to invite new members"
                        - if <player.has_flag[setting.hotbar_server_msg].not>:
                            - actionbar "<&c>You don't have permission to invite new members"
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:entity_villager_no
                        - stop

                ## KICK
                - else if <context.args.get[1].equals[kick]>:
                    - if <context.args.get[2].equals[<server.flag[team.team.<player.flag[team.team]>.leader]>]>:
                        - if <player.has_flag[setting.chat_server_msg].not>:
                            - narrate "<&c>You don't have permission to do this"
                        - if <player.has_flag[setting.hotbar_server_msg].not>:
                            - actionbar "<&c>You don't have permission to do this"
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:entity_villager_no
                        - stop
                    - else if <server.flag[team.team.<player.flag[team.team]>.leader].equals[<player.name>].if_null[]> || <player.has_flag[team.<player.flag[team.team]>.manage].if_null[]>:
                        - define size 27
                        - define title "Confirm kick"
                        - define inventory <inventory[generic[size=<[size]>;title=<[title]>]]>

                        - inventory open d:<[inventory]>

                        - inventory set slot:12 o:<item[red_stained_glass_pane[display=<&color[#ff0000]>Cancel;lore=<&f>Click to cancel]]> d:<[inventory]>
                        - inventory set slot:16 o:<item[lime_stained_glass_pane[display=<&color[#00ff0a]>Confirm;lore=<&f>Click to confirm]]> d:<[inventory]>
                        - flag <player> team.kick:<context.args.get[2]>
                        - stop
                    - else:
                        - if <player.has_flag[setting.chat_server_msg].not>:
                            - narrate "<&c>You don't have permission to do this"
                        - if <player.has_flag[setting.hotbar_server_msg].not>:
                            - actionbar "<&c>You don't have permission to do this"
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:entity_villager_no
                        - stop

                ## LEAVE / DISBAN
                - else if <context.args.get[1].equals[leave]>:
                    - if <server.flag[team.team.<player.flag[team.team]>.leader].equals[<player.name>]>:
                        - define size 27
                        - define title "Confirm disbanding team"
                        - define inventory <inventory[generic[size=<[size]>;title=<[title]>]]>

                        - inventory open d:<[inventory]>

                        - inventory set slot:12 o:<item[red_stained_glass_pane[display=<&color[#ff0000]>Cancel;lore=<&f>Click to cancel]]> d:<[inventory]>
                        - inventory set slot:16 o:<item[lime_stained_glass_pane[display=<&color[#00ff0a]>Confirm;lore=<&f>Click to confirm]]> d:<[inventory]>
                    - else:
                        - define size 27
                        - define title "Confirm leaving team"
                        - define inventory <inventory[generic[size=<[size]>;title=<[title]>]]>

                        - inventory open d:<[inventory]>

                        - inventory set slot:12 o:<item[red_stained_glass_pane[display=<&color[#ff0000]>Cancel;lore=<&f>Click to cancel]]> d:<[inventory]>
                        - inventory set slot:16 o:<item[lime_stained_glass_pane[display=<&color[#00ff0a]>Confirm;lore=<&f>Click to confirm]]> d:<[inventory]>

                ## SETHOME
                - else if <context.args.get[1].equals[sethome]>:
                    - if <server.flag[team.team.<player.flag[team.team]>.leader].equals[<player.name>].if_null[]> || <player.has_flag[team.<player.flag[team.team]>.edithome].if_null[]>:
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:ui_button_click
                        - if <player.has_flag[setting.chat_server_msg].not>:
                            - narrate "<&7>Team home set."
                        - if <player.has_flag[setting.hotbar_server_msg].not>:
                            - actionbar "<&7>Team home set"
                        - flag server team.team.<player.flag[team.team]>.home:<player.location>
                    - else:
                        - if <player.has_flag[setting.chat_server_msg].not>:
                            - narrate "<&c>You cannot manage team homes."
                        - if <player.has_flag[setting.hotbar_server_msg].not>:
                            - actionbar "<&c>You cannot manage team homes."
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:entity_villager_no
                        - stop

                - else:
                    - stop

Team_Disban:
    type: world
    debug: false
    events:
        on player clicks item in Team_GUI:
            - stop if:<context.item.material.name.equals[air]>
            - if <context.item.material.name.equals[player_head]>:
                - if <context.item.flag[name].equals[<server.flag[team.team.<player.flag[team.team]>.leader]>]>:
                
                    - narrate "<&c>You cannot manage the team leader permissions"
                    - stop
                - else:
                    - flag <player> team.manageteam:<context.item.flag[name]>
                    - define name <context.item.flag[name]>
                    - if <server.flag[team.team.<player.flag[team.team]>.leader].equals[<player.name>]> || <player.has_flag[team.team.manage].if_null[]>:
                        - define size 27
                        - define title "Edit <[name]>"
                        - define inventory <inventory[generic[size=<[size]>;title=<[title]>]]>

                        - inventory open d:<[inventory]>

                        - inventory set slot:19 o:<item[red_stained_glass_pane[display=<&color[#ff0000]>Back;lore=<&f>Click to back]]> d:<[inventory]>

                        - inventory set slot:11 o:<item[white_banner[display=<&e>Edit home;lore=<&7>Let <[name]> set and remove the team home|<&f>Currently: <server.match_player[<[name]>].has_flag[team.<player.flag[team.team]>.edithome].if_true[<&a><&l>ON].if_false[<&C><&l>OFF]>]]> d:<[inventory]>
                        - inventory set slot:12 o:<item[oak_door[display=<&e>Kick;lore=<&7>Click to kick <[name]>]]> d:<[inventory]>
                        - inventory set slot:13 o:<item[iron_helmet[display=<&e>Manage teammates;lore=<&7>Let <[name]> invite and kick teammates|<&f>Currently: <server.match_player[<[name]>].has_flag[team.<player.flag[team.team]>.manage].if_true[<&a><&l>ON].if_false[<&C><&l>OFF]>]]> d:<[inventory]>
                        - inventory set slot:15 o:<item[iron_sword[display=<&e>PvP;lore=<&7>Let <[name]> turn on and off team pvp|<&f>Currently: <server.match_player[<[name]>].has_flag[team.<player.flag[team.team]>.pvp].if_true[<&a><&l>ON].if_false[<&C><&l>OFF]>]]> d:<[inventory]>
                        - inventory set slot:16 o:<item[ender_pearl[display=<&e>Visit team home;lore=<&7>Let <[name]> go to team home|<&f>Currently: <server.match_player[<[name]>].has_flag[team.<player.flag[team.team]>.teamhome].if_true[<&a><&l>ON].if_false[<&C><&l>OFF]>]]> d:<[inventory]>
                        - inventory set slot:17 o:<item[feather[display=<&e>Team Chat;lore=<&7>Let <[name]> speak in chat|<&f>Currently: <server.match_player[<[name]>].has_flag[team.<player.flag[team.team]>.chat].if_true[<&a><&l>ON].if_false[<&C><&l>OFF]>]]> d:<[inventory]>
                    - else:
                        - if <player.has_flag[setting.chat_server_msg].not>:
                            - narrate "<&c>You don't have permission to manage team members."
                        - if <player.has_flag[setting.hotbar_server_msg].not>:
                            - actionbar "<&c>You don't have permission to manage team members."
                        - if <player.has_flag[setting.sound_effect].not>:
                            - playsound <player> sound:entity_villager_no
                        - stop
        after player first login:
            - flag <player> skull:<player.skull_skin>
        after player joins:
            - flag <player> skull:<player.skull_skin>
        on player closes inventory:
            - flag <player> team.kick:!
            - flag <player> team_page:!
        
        on player clicks item in inventory:
            ## DISBANDING TEAM
            - if <context.inventory.title.contains_text[Confirm disbanding team]>:
                - determine passively cancelled

                - if <context.slot.equals[12]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:ui_button_click
                    - inventory close
                - if <context.slot.equals[16]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:ui_button_click
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&7>Your disbanded your team."
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&7>Your disbanded your team."
                    - inventory close
                    - flag <server.players_flagged[team.name.<player.flag[team.team]>]> team:!
                    - flag server team.team.<player.flag[team.team]>:!

            ## LEAVE TEAM
            - if <context.inventory.title.contains_text[Confirm leaving team]>:
                - determine passively cancelled

                - if <context.slot.equals[12]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:ui_button_click
                    - inventory close
                - if <context.slot.equals[16]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:ui_button_click
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&7>You left the team."
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&7>You left the team."
                    - inventory close
                    - flag server team.team.<player.flag[team.team]>.member:<server.flag[team.team.<player.flag[team.team]>.member].exclude[<player.name>]>
                    - flag server team.team.<player.flag[team.team]>.uuid:<server.flag[team.team.<player.flag[team.team]>.uuid].exclude[<player.uuid.as_player>]>
                    - flag <player> team:!

            ## KICK TEAM MEMBER
            - if <context.inventory.title.contains_text[Confirm kick]>:
                - determine passively cancelled

                - if <context.slot.equals[12]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:ui_button_click
                    - inventory close
                - if <context.slot.equals[16]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:ui_button_click
                    - if <player.has_flag[setting.chat_server_msg].not>:
                        - narrate "<&7>Member kicked."
                    - if <player.has_flag[setting.hotbar_server_msg].not>:
                        - actionbar "<&7>Member kicked."
                    - flag server team.team.<player.flag[team.team]>.member:<server.flag[team.team.<player.flag[team.team]>.member].exclude[<player.flag[team.kick]>]>
                    - flag server team.team.<player.flag[team.team]>.uuid:<server.flag[team.team.<player.flag[team.team]>.uuid].exclude[<server.match_player[<player.flag[team.kick]>].uuid.as_player>]>
                    - flag <server.match_player[<player.flag[team.kick]>]> team:!
                    - flag <player> team.kick:!
                    - inventory close

            ## MANAGE TEAM MEMBER
            - if <context.inventory.title.contains_text[Edit]>:
                - determine passively cancelled

                - if <context.slot.equals[19]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:ui_button_click
                    - define cmd team
                    - execute as_player <[cmd]>

                - if <context.slot.equals[11]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:ui_button_click
                        - if <player.has_flag[team.<player.flag[team.team]>.edithome].not>:
                            - narrate a
                            - narrate <server.match_player[<player.flag[team.manageteam]>].name>
                            - flag <server.match_player[<player.flag[team.manageteam]>]> team.<player.flag[team.team]>.edithome
                        - else if <player.has_flag[team.<player.flag[team.team]>.edithome]>:
                            - narrate b
                            - flag <server.match_player[<player.flag[team.manageteam]>]> team.<player.flag[team.team]>.edithome:!
                        - narrate <player.has_flag[team.<player.flag[team.team]>.edithome]>
                        - inventory set slot:<context.slot> o:<item[white_banner[display=<&e>Edit home;lore=<&7>Let <player.flag[team.manageteam]> set and remove the team home|<&f>Currently: <server.match_player[<player.flag[team.manageteam]>].has_flag[team.<player.flag[team.team]>.edithome].if_true[<&a><&l>ON].if_false[<&C><&l>OFF]>]]> d:<context.inventory>

                - if <context.slot.equals[12]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:ui_button_click
                        - define size 27
                        - define title "Confirm kick"
                        - define inventory <inventory[generic[size=<[size]>;title=<[title]>]]>

                        - inventory open d:<[inventory]>

                        - inventory set slot:12 o:<item[red_stained_glass_pane[display=<&color[#ff0000]>Cancel;lore=<&f>Click to cancel]]> d:<[inventory]>
                        - inventory set slot:16 o:<item[lime_stained_glass_pane[display=<&color[#00ff0a]>Confirm;lore=<&f>Click to confirm]]> d:<[inventory]>
                        - flag <player> team.kick:<player.flag[team.manageteam]>

                - if <context.slot.equals[13]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:ui_button_click
                        - if <player.has_flag[team.<player.flag[team.team]>.manage].not>:
                            - flag <server.match_player[<player.flag[team.manageteam]>]> team.<player.flag[team.team]>.manage
                        - else:
                            - flag <server.match_player[<player.flag[team.manageteam]>]> team.<player.flag[team.team]>.manage:!
                        - inventory set slot:<context.slot> o:<item[iron_helmet[display=<&e>Manage teammates;lore=<&7>Let <player.flag[team.manageteam]> invite and kick teammates|<&f>Currently: <server.match_player[<player.flag[team.manageteam]>].has_flag[team.<player.flag[team.team]>.manage].if_true[<&a><&l>ON].if_false[<&C><&l>OFF]>]]> d:<context.inventory>

                - if <context.slot.equals[15]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:ui_button_click
                        - if <player.has_flag[team.<player.flag[team.team]>.pvp].not>:
                            - flag <server.match_player[<player.flag[team.manageteam]>]> team.<player.flag[team.team]>.pvp
                        - else:
                            - flag <server.match_player[<player.flag[team.manageteam]>]> team.<player.flag[team.team]>.pvp:!
                        - inventory set slot:<context.slot> o:<item[iron_sword[display=<&e>PvP;lore=<&7>Let <player.flag[team.manageteam]> turn on and off team pvp|<&f>Currently: <server.match_player[<player.flag[team.manageteam]>].has_flag[team.<player.flag[team.team]>.pvp].if_true[<&a><&l>ON].if_false[<&C><&l>OFF]>]]> d:<context.inventory>


                - if <context.slot.equals[16]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:ui_button_click
                        - if <player.has_flag[team.<player.flag[team.team]>.teamhome].not>:
                            - flag <server.match_player[<player.flag[team.manageteam]>]> team.<player.flag[team.team]>.teamhome
                        - else:
                            - flag <server.match_player[<player.flag[team.manageteam]>]> team.<player.flag[team.team]>.teamhome:!
                        - inventory set slot:<context.slot> o:<item[ender_pearl[display=<&e>Visit team home;lore=<&7>Let <player.flag[team.manageteam]> go to team home|<&f>Currently: <server.match_player[<player.flag[team.manageteam]>].has_flag[team.<player.flag[team.team]>.teamhome].if_true[<&a><&l>ON].if_false[<&C><&l>OFF]>]]> d:<context.inventory>

                - if <context.slot.equals[17]>:
                    - if <player.has_flag[setting.sound_effect].not>:
                        - playsound <player> sound:ui_button_click
                        - if <player.has_flag[team.<player.flag[team.team]>.chat].not>:
                            - flag <server.match_player[<player.flag[team.manageteam]>]> team.<player.flag[team.team]>.chat
                        - else:
                            - flag <server.match_player[<player.flag[team.manageteam]>]> team.<player.flag[team.team]>.chat:!
                        - inventory set slot:<context.slot> o:<item[feather[display=<&e>Team Chat;lore=<&7>Let <player.flag[team.manageteam]> speak in chat|<&f>Currently: <server.match_player[<player.flag[team.manageteam]>].has_flag[team.<player.flag[team.team]>.chat].if_true[<&a><&l>ON].if_false[<&C><&l>OFF]>]]> d:<context.inventory>
 

Team_GUI:
    type: inventory
    title: Team (<player.flag[team_page].size.if_null[1]>/<server.flag[team.team.<player.flag[team.team]>.member].size.div[45].round_up>)
    inventory: chest
    debug: false
    gui: true
    procedural items:
    - define list <list>
    - foreach <server.flag[team.team.<player.flag[team.team]>.uuid].get[<element[45].mul[<player.flag[team_page]>].sub[44]>].to[<element[45].mul[<player.flag[team_page]>]>].if_null[]> as:__player:
        - define item "player_head[skull_skin=<player.skull_skin.if_null[<player.flag[skull]>]>;display=<&f><player.name>;lore=<&7>Click to edit;flag_map=[name=<player.name>]]"
        - define list:->:<[item]>
    - determine <[list]>
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [<item[white_banner[display=<&e>Home;lore=<player.proc[Home_Team_proc]>]]>] [] [] [Home_Prev_Item] [<item[iron_helmet[display=<&e>Team <player.flag[team.team]>;lore=<&7>Click to refresh]]>] [Home_Next_Item] [] [] [<item[iron_sword[display=<&e>PvP;lore=<&7>Currently: <player.proc[PvP_Team_proc]>]]>]


Home_Next_Item:
    type: item
    material: arrow
    display name: <&e>Next
    lore:
        - '<&7>Click to go to the next page'

Home_Prev_Item:
    type: item
    material: arrow
    display name: <&e>Back
    lore:
        - '<&7>Click to go to the previous page'

Home_Team_proc:
    type: procedure
    script:
        - if <server.has_flag[team.team.<player.flag[team.team]>.home].not>:
            - define a "<&7>Set the team home with /team sethome"
        - else:
            - define a "<&7>Click to teleport to your team's home"
        - determine <[a]>

PvP_Team_proc:
    type: procedure
    script:
        - if <server.has_flag[team.team.<player.flag[team.team]>.PVP]>:
            - define a "<&a><&l>ON"
        - else:
            - define a "<&C><&l>OFF"
        - determine <[a]>