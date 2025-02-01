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

#_____________________________________________________________________________________________________________________________

tab_config:
    type: data
    tab:
        enable: false
        header:
            - ""
            - "<&gradient[from=#FBD300;to=#826E00]><&L>ɴxsʀᴜʟsᴡᴅ"
            - "<&L><&gradient[from=gray;to=white]>ᴘᴏʀᴛғᴏʟɪᴏ<white><&gradient[from=white;to=gray]><&l> sᴇʀᴠᴇʀ"
            - ""
        footer:
            - ""
            - "<&gradient[from=#FBD300;to=#826E00]><&L>ᴘɪɴɢ<&7><&l>: <&7><player.ping> | <&gradient[from=#FBD300;to=#826E00]><&L>ᴛᴘs<&7>: <&7><server.recent_tps.get[1].as_money>"
            - "<&gradient[from=#FBD300;to=#826E00]><&L>ᴏɴʟɪɴᴇ ᴘʟᴀʏᴇʀs<&7><&l>: <&7><server.online_players.size>"
            - "      <&gradient[from=#FBD300;to=#826E00]><&L>ᴛɪᴍᴇ<&7><&l>: <&7><util.time_now.format[K:mm a]> - <util.time_now.format[d/MM/yyyy]>      "
            - ""

#_____________________________________________________________________________________________________________________________

bossbar_config:
    type: data
    bossbar:
        enable: false
        text:
            - "<&color[#4e5c24]><element[🏀].font[custom]><&color[#4e5c24]><proc[util_textoffset].context[-63]><element[⌚].font[custom]>  <util.time_now.format[K:mm a]>"
        color:
            - "white"
#_____________________________________________________________________________________________________________________________

motd_config:
    type: data
    motd:
        enable: false
        line_1:
            - "                     <&gradient[from=#FBD300;to=#826E00]>♦ <&L><&gradient[from=#FBD300;to=#826E00]>ɴxsʀᴜʟsᴡᴅ <&gradient[from=#FBD300;to=#826E00]>♦"

        line_2:
            - "              <&L><&gradient[from=gray;to=white]>ᴘᴏʀᴛғᴏʟɪᴏ<white><reset><white><&gradient[from=white;to=gray]><&l> sᴇʀᴠᴇʀ"

#_____________________________________________________________________________________________________________________________

scoreboard_config:
    type: data
    scoreboard:
        enable: true

        title:
            - " <&gradient[from=#0083FF;to=#6AECFF]><&l>Donut SMP"

        lines:
            - "<&F>"
            - "<&color[#03FF00]><&l>$ <&F>Money <&color[#03FF00]><player.money.if_null[0]>"
            - "<&color[#7500FF]>⭐ <&F>Shards <&color[#7500FF]><player.flag[shards].if_null[0]>"
            - "<&color[#FF0000]>⚔ <&F>Kills <&color[#FF0000]><player.statistic[player_kills]>"
            - "<&color[#FF7C00]>☠ <&F>Deaths <&color[#FF7C00]><player.statistic[deaths]>"
            - "<&color[#0083FF]>⌛ <&F>Keyall <&color[#0083FF]>1m"
            - "<&color[#FFF800]>⌚ <&F>Playtime <&color[#FFF800]><player.time_lived.formatted>"
            - "<&f>"
            - "<&7>Asia <&7>(<&color[#0083FF]><player.ping>ms<&7>)"

scoreboard_config1:
    type: data
    scoreboard:
        enable: true

        title:
            - " <&gradient[from=#0083FF;to=#6AECFF]><&l>Donut SMP"

        lines:
            - "<&F>"
            - "<&color[#03FF00]><&l>$ <&F>Money <&color[#03FF00]><player.money.if_null[0]>"
            - "<&color[#7500FF]>⭐ <&F>Shards <&color[#7500FF]><player.flag[shards].if_null[0]>"
            - "<&color[#FF0000]>⚔ <&F>Kills <&color[#FF0000]><player.statistic[player_kills]>"
            - "<&color[#FF7C00]>☠ <&F>Deaths <&color[#FF7C00]><player.statistic[deaths]>"
            - "<&color[#0083FF]>⌛ <&F>Keyall <&color[#0083FF]>1m"
            - "<&color[#FFF800]>⌚ <&F>Playtime <&color[#FFF800]><player.time_lived.formatted>"
            - "<&color[#0083FF]>🪓 <&F>Team <&color[#0083FF]><player.flag[team.team]>"
            - "<&f>"
            - "<&7>Asia <&7>(<&color[#0083FF]><player.ping>ms<&7>)"
#_____________________________________________________________________________________________________________________________




































































#_____________________________________________________________________________________________________________________________

tab_handler:
    type: world
    debug: false
    events:
        on delta time secondly:
        - stop if:<script[tab_config].parsed_key[tab.enable].equals[false]>
        - stop if:<server.online_players.is_empty>
        - foreach <server.online_players> as:__player:
            - define header <script[tab_config].parsed_key[tab.header].separated_by[<n><reset>]>
            - define footer <script[tab_config].parsed_key[tab.footer].separated_by[<n><reset>]>
            - adjust <player> tab_list_info:<[header]>|<[footer]>

bossbar_handler:
    type: world
    debug: false
    events:
        on delta time secondly:
            - stop if:<script[bossbar_config].parsed_key[bossbar.enable].equals[false]>
            - foreach <server.online_players> as:__player:
                    - bossbar test players:<server.online_players> "title:<script[bossbar_config].parsed_key[bossbar.text].formatted>" color:<script[bossbar_config].parsed_key[bossbar.color].formatted>

motd_handler:
    type: world
    debug: false
    events:
        on server list ping:
        - stop if:<script[motd_config].parsed_key[motd.enable].equals[false]>
        - define line1 <script[motd_config].data_key[motd.line_1].random.parsed>
        - define line2 <script[motd_config].data_key[motd.line_2].random.parsed>
        - determine passively <[line1]><n><[line2]>

scoreboard_handler:
    type: world
    debug: false
    events:
        on delta time secondly:
            - stop if:<server.online_players.is_empty>
            - stop if:<script[scoreboard_config].parsed_key[scoreboard.enable].equals[false]>
            - foreach <server.online_players> as:__player:
                - if <player.has_flag[team.team]>:
                    - if <player.has_flag[setting.scoreboard]>:
                        - foreach next
                    - define title <script[scoreboard_config1].parsed_key[scoreboard.title].space_separated>
                    - define lines <script[scoreboard_config1].parsed_key[scoreboard.lines].parse[parsed]>
                    - sidebar title:<[title]> values:<[lines]> players:<player>
                - else:
                    - if <player.has_flag[setting.scoreboard]>:
                        - foreach next
                    - define title <script[scoreboard_config].parsed_key[scoreboard.title].space_separated>
                    - define lines <script[scoreboard_config].parsed_key[scoreboard.lines].parse[parsed]>
                    - sidebar title:<[title]> values:<[lines]> players:<player>
#_____________________________________________________________________________________________________________________________