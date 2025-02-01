knock_down_handler:
    type: world
    debug: false
    events:
        aFter player respawns:
            - flag <player> knockdown:!
        on player toggles sneaking:
            - if <player.has_flag[knockdown]>:
                - kill <player>
        on delta time secondly:
            - foreach <server.online_players> as:__player:
                - if <player.has_flag[knockdown]>:
                    - flag <player> knockdown:--
        on player death:
            - if !<player.has_flag[knockdown]>:
                - flag <player> knockdown:300
                - run KNOCKDOWN_TASK
                - run knockdown_crawl
                - determine cancelled

knockdown_task:
    type: task
    debug: false
    script:
        - wait 1t
        - while <player.is_online> && <player.is_spawned>:
            - if <player.flag[knockdown].is_less_than[0]>:
                - kill <player>
            - else:
                    - title "title:<&c><&l>KNOCK DOWN" "subtitle:<&8>[<&c>sʜɪғᴛ<&8>] <&c>ᴛᴏ ɢɪᴠᴇ ᴜᴘ! <&8><&l>| <&c>ᴛɪᴍᴇ<&8>: <&f><player.flag[knockdown]> <&C>sᴇᴄᴏɴᴅs" fade_in:0 fade_out:0 targets:<player> stay:3t
            - wait 1t

knockdown_crawl:
    type: task
    debug: false
    script:
        - wait 1t
        - while <player.has_flag[knockdown]> && <player.is_spawned>:
            - if <player.location.above[1].material.name> = air:
                    - showfake barrier <player.location.above[1]> d:1t
            - else if:<player.location.above[1].material.name> = water:
                - cast slow duration:1t amplifier:160 no_ambient no_clear no_icon hide_particles
                - showfake WATER <player.location.above[1]> d:1t
            - wait 1t