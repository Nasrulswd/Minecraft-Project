BossBar_Data:
    type: data
    enable: true
    Java:
        1:
            enable: true
            progress: 0
            text:
                - "🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀<proc[world_proc]>🌌🌌🌌🌌🌌🌌🌌🌌🌌🌌🌌🌌🌌🌌<proc[time_proc]>"
            color:
                - "WHITE"
        2:
            enable: true
            progress: 0
            text:
                - "🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀<element[🔙].font[bossbar]>🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀<&f>ONLINE: <&color[#5cc4ff]><server.online_players.size>  <&f>PLAY.<&color[#5cc4ff]>LIPOSMP<&f>.XYZ  <&f>V.PARTY: <&color[#5cc4ff]><placeholder[votingplugin_votepartyvotescurrent]>"
            color:
                - "WHITE"

    Bedrock:
        progress: 0
        text:
            - "<&f><&l>ONLINE: <&color[#5cc4ff]><server.online_players.size>  <&f><&l>PLAY.<&color[#5cc4ff]><&l>LIPOSMP<&f><&l>.XYZ  <&f><&l>V.PARTY: <&color[#5cc4ff]><placeholder[votingplugin_votepartyvotescurrent]>"
        color:
            - "WHITE"

time_proc:
    type: procedure
    debug: false
    script:
        - define a "<element[🍕].font[bossbar]>🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀<&f><element[🕕].font[bossbar]> <util.time_now.format[K:mm a]>"

        - determine <[a]><&r>

world_proc:
    type: procedure
    debug: false
    script:
        - if <player.world.name.contains_text[dungeon]>:
            - define world "Dungeon"
        - else if <player.world.name.contains_text[nether]>:
            - define world "nether"
        - else if <player.world.name.contains_text[end]>:
            - define world "the end"
        - else if <player.world.name.contains_text[world]>:
            - define world "world "
        - else:
            - define world "<player.world.name.replace[_].with[]> "

        - define a "<element[🍕].font[bossbar]>🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀 <&f><element[🌎].font[bossbar]> <[world]>"

        - determine <[a]><&r>

money_proc:
    type: procedure
    debug: false
    script:
        - if <player.money.round_to[0].to_list.size.equals[1]>:
            - define b <player.money.round_to[0]>
        - if <player.money.round_to[0].to_list.size.equals[2]>:
            - define b <player.money.round_to[0]>
        - if <player.money.round_to[0].to_list.size.equals[3]>:
            - define b <player.money.round_to[0]>

        - if <player.money.round_to[0].to_list.size.equals[4]>:
            - define b <player.money.round_to[0].to_list.get[1]>k
        - if <player.money.round_to[0].to_list.size.equals[5]>:
            - define b <player.money.round_to[0].to_list.get[1]><player.money.round_to[0].to_list.get[2]>k
        - if <player.money.round_to[0].to_list.size.equals[6]>:
            - define b <player.money.round_to[0].to_list.get[1]><player.money.round_to[0].to_list.get[2]><player.money.round_to[0].to_list.get[3]>k

        - if <player.money.round_to[0].to_list.size.equals[7]>:
            - define b <player.money.round_to[0].to_list.get[1]>m
        - if <player.money.round_to[0].to_list.size.equals[8]>:
            - define b <player.money.round_to[0].to_list.get[1]><player.money.round_to[0].to_list.get[2]>m
        - if <player.money.round_to[0].to_list.size.equals[9]>:
            - define b <player.money.round_to[0].to_list.get[1]><player.money.round_to[0].to_list.get[2]><player.money.round_to[0].to_list.get[3]>m

        - if <player.money.round_to[0].to_list.size.equals[10]>:
            - define b <player.money.round_to[0].to_list.get[1]>b
        - if <player.money.round_to[0].to_list.size.equals[11]>:
            - define b <player.money.round_to[0].to_list.get[1]><player.money.round_to[0].to_list.get[2]>b
        - if <player.money.round_to[0].to_list.size.equals[12]>:
            - define b <player.money.round_to[0].to_list.get[1]><player.money.round_to[0].to_list.get[2]><player.money.round_to[0].to_list.get[3]>b

        - if <[b].to_list.size> = 1:
            - define b "<element[🥾].font[bossbar]>🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀<&f><element[💵].font[bossbar]> <[b]>🌌🌌🌌🌌🌌🌌🌌🌌🌌"

        - if <[b].to_list.size> = 2:
            - define b "<element[🥾].font[bossbar]>🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀<&f><element[💵].font[bossbar]> <[b]>🌌🌌🌌🌌🌌🌌"

        - if <[b].to_list.size> = 3:
            - define b "<element[🥾].font[bossbar]>🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀<&f><element[💵].font[bossbar]> <[b]>🌌🌌🌌"

        - if <[b].to_list.size> = 4:
            - define b "<element[🥾].font[bossbar]>🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀<&f><element[💵].font[bossbar]> <[b]>"

        - determine <[b]>

coin_proc:
    type: procedure
    debug: false
    script:
        - if <player.playerpoints_points.round_to[0].to_list.size.equals[1]>:
            - define b <player.playerpoints_points.round_to[0]>
        - if <player.playerpoints_points.round_to[0].to_list.size.equals[2]>:
            - define b <player.playerpoints_points.round_to[0]>
        - if <player.playerpoints_points.round_to[0].to_list.size.equals[3]>:
            - define b <player.playerpoints_points.round_to[0]>

        - if <player.playerpoints_points.round_to[0].to_list.size.equals[4]>:
            - define b <player.playerpoints_points.round_to[0].to_list.get[1]>k
        - if <player.playerpoints_points.round_to[0].to_list.size.equals[5]>:
            - define b <player.playerpoints_points.round_to[0].to_list.get[1]><player.playerpoints_points.round_to[0].to_list.get[2]>k
        - if <player.playerpoints_points.round_to[0].to_list.size.equals[6]>:
            - define b <player.playerpoints_points.round_to[0].to_list.get[1]><player.playerpoints_points.round_to[0].to_list.get[2]><player.playerpoints_points.round_to[0].to_list.get[3]>k

        - if <player.playerpoints_points.round_to[0].to_list.size.equals[7]>:
            - define b <player.playerpoints_points.round_to[0].to_list.get[1]>m
        - if <player.playerpoints_points.round_to[0].to_list.size.equals[8]>:
            - define b <player.playerpoints_points.round_to[0].to_list.get[1]><player.playerpoints_points.round_to[0].to_list.get[2]>m
        - if <player.playerpoints_points.round_to[0].to_list.size.equals[9]>:
            - define b <player.playerpoints_points.round_to[0].to_list.get[1]><player.playerpoints_points.round_to[0].to_list.get[2]><player.playerpoints_points.round_to[0].to_list.get[3]>m

        - if <player.playerpoints_points.round_to[0].to_list.size.equals[10]>:
            - define b <player.playerpoints_points.round_to[0].to_list.get[1]>b
        - if <player.playerpoints_points.round_to[0].to_list.size.equals[11]>:
            - define b <player.playerpoints_points.round_to[0].to_list.get[1]><player.playerpoints_points.round_to[0].to_list.get[2]>b
        - if <player.playerpoints_points.round_to[0].to_list.size.equals[12]>:
            - define b <player.playerpoints_points.round_to[0].to_list.get[1]><player.playerpoints_points.round_to[0].to_list.get[2]><player.playerpoints_points.round_to[0].to_list.get[3]>b

        - if <[b].to_list.size> = 1:
            - define b "<element[🥾].font[bossbar]>🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀<&f><element[👛].font[bossbar]> <[b]>🌌🌌🌌🌌🌌🌌🌌🌌🌌"

        - if <[b].to_list.size> = 2:
            - define b "<element[🥾].font[bossbar]>🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀<&f><element[👛].font[bossbar]> <[b]>🌌🌌🌌🌌🌌🌌"

        - if <[b].to_list.size> = 3:
            - define b "<element[🥾].font[bossbar]>🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀<&f><element[👛].font[bossbar]> <[b]>🌌🌌🌌"

        - if <[b].to_list.size> = 4:
            - define b "<element[🥾].font[bossbar]>🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀<&f><element[👛].font[bossbar]> <[b]>"

        - determine <[b]>

bossbar_handler:
    type: world
    debug: false
    events:

        # UPDATE ACTIONBAR EVERY 2 SECOND
        after delta time secondly every:2:

            # STOP IF ENABLE SET TO FALSE IN DATA
            - stop if:<script[BossBar_Data].parsed_key[enable].equals[true].not>
 
            - foreach <server.online_players> as:__player:

                # BEDROCK SIDE
                - if <player.client_brand> == geyser:
                    - bossbar bedrock players:<player> "title:<script[bossbar_data].parsed_key[Bedrock.text].separated_by[<n><reset>]>" color:<script[BossBar_Data].parsed_key[Bedrock.color].formatted> progress:<script[BossBar_Data].parsed_key[Bedrock.progress]>

                    # JAVA SIDE
                - else:

                    # DETACT PLAYER IF PLAYER HAS RESOURCEPACK
                    - if <player.has_flag[accept_resourcepack]>:

                        - if <script[BossBar_Data].parsed_key[Java.2.enable].equals[true]>:
                            - bossbar 2 players:<player> "title:<script[bossbar_data].parsed_key[Java.2.text].separated_by[<n><reset>]>" color:<script[BossBar_Data].parsed_key[Java.2.color].formatted> progress:<script[BossBar_Data].parsed_key[Java.2.progress]>

                        - if <script[BossBar_Data].parsed_key[Java.1.enable].equals[true]>:
                            - bossbar <player.name>1 players:<player> "title:<script[bossbar_data].parsed_key[Java.1.text].separated_by[<n><reset>]>" color:<script[BossBar_Data].parsed_key[Java.1.color].formatted> progress:<script[BossBar_Data].parsed_key[Java.1.progress]>
