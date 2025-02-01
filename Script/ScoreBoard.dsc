scoreboard_config:
    type: data
    scoreboard:
        enable: true
        java:
            title:
                - "<element[💚].font[abmoney]>🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀<&f>😎  "

            lines:
                - ""
                - "        ping: <&7><player.ping><&color[#5cc4ff]>ms"
                - "        rank: <proc[rank_proc]>"
                - "        t.fly: <&7><placeholder[tempfly_time-hours]><&color[#5cc4ff]>h <&7><placeholder[tempfly_time-minutes]><&color[#5cc4ff]>m"
                - ""
                - ""
                - "          <&f>play.<&color[#5cc4ff]>liposmp<&f>.xyz"
        bedrock:
            title:
                - "<&color[#5cc4ff]><&L>LIPOSMP"

            lines:
                - ""
                - "  <&C>| <&f><&l>PING: <&C><&7><player.ping>ms"
                - "  <&3>| <&f><&l>RANK: <&3><placeholder[vault_prefix].parse_color>"
                - "  <&e>| <&f><&l>COIN: <&e><placeholder[playerpoints_points_formatted]>"
                - "  <&A>| <&f><&l>MONEY: <&A><placeholder[vault_eco_balance_formatted]>"
                - "  <&6>| <&f><&l>T.FLY: <&6><placeholder[tempfly_time-hours]>h <placeholder[tempfly_time-minutes]>m"
                - ""
                - "  <&f>play.<&color[#5cc4ff]><&l>LIPOSMP<&f>.xyz"

rank_proc:
    type: procedure
    debug: false
    script:
        - define a <placeholder[vault_prefix]>
        - choose <[a]>:
            - case "&f &7":
                - define a "&f &7    <&r>"
            - case "&f &7":
                - define a "&f &7    <&r>"
            - case "&f &7":
                - define a "&f &7    <&r>"
            - case "&f &7":
                - define a "&f &7    <&r>"
            - default:
                - define a <[a]>

        - determine <[a].parse_color>

        # - if <placeholder[vault_prefix].equals[&f &7]>:
        #     - define a "&f &7    <&r>"
        # - else if <placeholder[vault_prefix].equals[&f &7]>:
        #     - define a "&f &7    <&r>"
        # - else if <placeholder[vault_prefix].equals[&f &7]>:
        #     - define a "&f &7    <&r>"
        # - else if <placeholder[vault_prefix].equals[&f &7]>:
        #     - define a "&f &7    <&r>"
        # - else:
        #     - define a "<placeholder[vault_prefix]>"

        # - determine <[a].parse_color>


scoreboard_handler:
    type: world
    debug: false
    events:
        after delta time secondly every:2:

            - stop if:<server.online_players.is_empty>
            - stop if:<script[scoreboard_config].parsed_key[scoreboard.enable].equals[true].not>

            - foreach <server.online_players> as:__player:

                - if <player.client_brand> == geyser:
                    - define title <script[scoreboard_config].parsed_key[scoreboard.bedrock.title].space_separated>
                    - define lines <script[scoreboard_config].parsed_key[scoreboard.bedrock.lines].parse[parsed]>
                    - sidebar title:<[title]> values:<[lines]> players:<player>

                - else:

                    - if <player.has_flag[accept_resourcepack]>:

                        - define title <script[scoreboard_config].parsed_key[scoreboard.java.title].space_separated>
                        - define lines <script[scoreboard_config].parsed_key[scoreboard.java.lines].parse[parsed]>
                        - sidebar title:<[title]> values:<[lines]> players:<player>


