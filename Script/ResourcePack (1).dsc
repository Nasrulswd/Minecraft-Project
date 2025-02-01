ResourcePack_Data:
    type: data

    enable: true

    url: "https://download.mc-packs.net/pack/9c4d18fad7c392fbf9769eeab58d73d080cbb3de.zip"
    hash: "9c4d18fad7c392fbf9769eeab58d73d080cbb3de"
    aplying:
        title: "<&e><&L>APPLYING RESOURCEPACK"
        subtitle: "<&F>ᴘʟᴇᴀsᴇ ᴡᴀɪᴛ ғᴏʀ ᴀ sᴇᴄᴏɴᴅ..."
    kick_message:
        - ""
        - "<&8><&m>                                                  <&r>"
        - ""
        - "<&c>You need to use resourcepack!"
        - ""
        - "<&7>if there any technical issue"
        - "<&7>please contact our helper!"
        - ""
        - "<&color[#3984f1]>discord.liposmp.xyz"
        - ""
        - "<&8><&m>                                                  <&r>"
        - ""
    message:
        - ""
        - "<&8><&m>                                                  <&r>"
        - ""
        - "<&e>Hey there, Adventurer!"
        - ""
        - "<&7>To begin your adventure"
        - "<&7>journey, you must first accept"
        - "<&7>our servers resource pack!"
        - ""
        - "<&c>Are your ready?"
        - ""
        - "<&8><&m>                                                  <&r>"
        - ""

resource_pack:
    type: world
    debug: false
    events:
        on player quit:
            - flag <player> accept_resourcepack:!
        on player damaged:
            - if <player.has_flag[resourcepack]>:
                - determine cancelled
        on resource pack status:

            - if <context.status> == FAILED_RELOAD:
                - wait 5s
                - kick <player> reason:<script[ResourcePack_Data].parsed_key[kick_message].separated_by[<n><reset>]>
            - if <context.status> == DECLINED:
                - determine "<script[ResourcePack_Data].parsed_key[kick_message].separated_by[<n><reset>]>"
            - if <context.status> == ACCEPTED:
                - flag <player> resourcepack
                - cast BLINDNESS duration:10m <player> hide_particles no_icon no_ambient
                - title "title:<script[ResourcePack_Data].parsed_key[aplying.title]>" "subtitle:<script[ResourcePack_Data].parsed_key[aplying.subtitle]>" fade_in:0 stay:10m
            - if <context.status> == SUCCESSFULLY_LOADED:
                - flag <player> resourcepack:!
                - flag <player> accept_resourcepack
                - cast remove BLINDNESS
                - title "title:<&r>" "subtitle:<&r>" stay:0.1s


        on player join:
            - if <script[ResourcePack_Data].parsed_key[enable].equals[true].not>:
                - flag <player> accept_resourcepack
                - stop
            - wait 2s
            - resourcepack url:<script[ResourcePack_Data].parsed_key[url]> hash:<script[ResourcePack_Data].parsed_key[hash]> "prompt:<script[ResourcePack_Data].parsed_key[message].separated_by[<n><reset>]>" forced
        on player first login:
            - stop if:<script[ResourcePack_Data].parsed_key[enable].equals[true].not>
            - resourcepack url:<script[ResourcePack_Data].parsed_key[url]> hash:<script[ResourcePack_Data].parsed_key[hash]> "prompt:<script[ResourcePack_Data].parsed_key[message].separated_by[<n><reset>]>" forced

ResourcePack_Command:
    type: command
    name: resourcepack
    description: resourcepack reload
    usage: /resourcepack
    debug: false
    #permission: denizen.resourcepack
    script:
        - resourcepack url:<script[ResourcePack_Data].parsed_key[url]> hash:<script[ResourcePack_Data].parsed_key[hash]> "prompt:<script[ResourcePack_Data].parsed_key[message].separated_by[<n><reset>]>" forced