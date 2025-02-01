motd_config:
    type: data
    motd:
        enable: true
        line_1:
            - "                    <&color[#5cc4ff]><&l>ʟɪᴘᴏsᴍᴘ <&e><&l>2 <&8>(1.21.x)"

        line_2:
            - "                     <&f>ᴘʟᴀʏ.<&color[#5cc4ff]><&l>ʟɪᴘᴏsᴍᴘ<&f>.xʏᴢ"

motd_handler:
    type: world
    debug: false
    events:
        on server list ping:
        - stop if:<script[motd_config].parsed_key[motd.enable].equals[false]>
        - define line1 <script[motd_config].data_key[motd.line_1].random.parsed>
        - define line2 <script[motd_config].data_key[motd.line_2].random.parsed>
        - determine passively <[line1]><n><[line2]>