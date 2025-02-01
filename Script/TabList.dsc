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
        enable: true
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
        enable: true
        text:
            - "<&color[#4e5c24]><element[🏀].font[custom]><&color[#4e5c24]><proc[util_textoffset].context[-63]><element[⌚].font[custom]>  <util.time_now.format[K:mm a]>"
        color:
            - "white"
#_____________________________________________________________________________________________________________________________

motd_config:
    type: data
    motd:
        enable: true
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
            - " <&gradient[from=#FBD300;to=#826E00]><&l>ᴘᴏʀᴛғᴏʟɪᴏ sᴇʀᴠᴇʀ"

        lines:
            - "<&F>"
            - " <&gradient[from=#FBD300;to=#826E00]>▪ <&f>ɴᴀᴍᴇ: <&7><player.name>"
            - " <&gradient[from=#FBD300;to=#826E00]>▪ <&f>ʀᴀɴᴋ: <&r><player.flag[rank]>"
            - " <&gradient[from=#FBD300;to=#826E00]>▪ <&f>ᴍᴏɴᴇʏ: <&7>0<&gradient[from=#FBD300;to=#826E00]>$"
            - " <&gradient[from=#FBD300;to=#826E00]>▪ <&f>ᴘɪɴɢ: <&7><player.ping><&gradient[from=#FBD300;to=#826E00]>ms"
            - "<&f>"
            - "    <&7>ᴘʟᴀʏ.<&gradient[from=#FBD300;to=#826E00]><&l>ᴘᴏʀᴛғᴏʟɪᴏ<&7>.xᴢʏ"
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
                - define title <script[scoreboard_config].parsed_key[scoreboard.title].space_separated>
                - define lines <script[scoreboard_config].parsed_key[scoreboard.lines].parse[parsed]>
                - sidebar title:<[title]> values:<[lines]> players:<player>

#_____________________________________________________________________________________________________________________________