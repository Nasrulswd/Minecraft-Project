
clear_chat:
    type: command
    name: clearchat
    debug: false
    permission: *
    description: clearchat
    usage: /clearchat
    script:
        - repeat 100:
            - announce <&a> to_console
            - announce <&a>

speech_bubble_handler:
    type: world
    debug: false
    events:
        on player chats:
        - if <player.gamemode> = SURVIVAL:
            - run speech_bubble_spawn def.text:<context.message.parse_color> def.recipients:<context.recipients>
        - if <player.gamemode> = CREATIVE:
            - run speech_bubble_spawn def.text:<context.message.parse_color> def.recipients:<context.recipients>
        - if <player.gamemode> = ADVENTURE:
            - run speech_bubble_spawn def.text:<context.message.parse_color> def.recipients:<context.recipients>

speech_bubble_spawn:
    type: task
    debug: false
    definitions: text|recipients
    script:
    - if !<player.exists>:
        - debug error "<&[error]>The task requires a linked player!"
        - stop
    - if !<[text].exists>:
        - debug error "<&[error]>You must specify a text!"
        - stop
    - foreach <[recipients].if_null[<list>]> as:player:
        - if !<[player].as[PlayerTag].exists>:
            - debug error "<&[error]>Recipients do contain a non-player entity, ignoring them."
            - define recipients[<[loop_index]>]:<-
    - fakespawn speech_bubble[text=<[text]>] <player.location.above[1]> players:<[recipients]> duration:9s save:bubble
    - run speech_bubble_fade_out def.entity:<entry[bubble].faked_entity>
    - define bubble_count <player.flag[chat_bubbles.bubble_count].if_null[0]>
    - flag <player> chat_bubbles.bubble_map.<[bubble_count]>:<entry[bubble].faked_entity> expire:9s
    - flag <player> chat_bubbles.bubble_count:++
    - foreach <player.flag[chat_bubbles.bubble_map].values.reverse> as:text_display:
        - if !<[text_display].is_spawned>:
            - foreach next
        - define height <[height].exists.if_true[<[height].add[<[last_lines].mul[0.25]>]>].if_false[0.75]>
        - define last_lines <[text_display].text.text_width.div[200].round_up>
        - adjust <[text_display]> translation:0,<[height]>,0
        - mount <[text_display]>|<player>
speech_bubble:
    type: entity
    debug: false
    entity_type: text_display
    mechanisms:
        pivot: CENTER
        opacity: 255
        translation: 0,0.75,0
speech_bubble_fade_out:
    type: task
    debug: false
    definitions: entity
    script:
    - wait 121t
    - repeat 62:
        - adjust <[entity]> opacity:<element[252].sub[<[value].mul[4]>]>
        - wait 1t