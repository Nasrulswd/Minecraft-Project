JoinMessage_Data:
    type: data
    bedrock:
        message:
            - "<&F><&L>WELCOME TO <&color[#5cc4ff]><&L>LIPO SMP"
            - "<&F>Start your adventure with <&e>/guide"
    java:
        message:
        - ""
        - ""
        - ""
        - "                            🕳"
        - ""
        - ""
        - ""
        - ""
        - "                             <&f>play.<&color[#5cc4ff]>liposmp<&f>.xyz"
        - ""



joinm_taSk:
    type: task
    script:
    - narrate "<script[JoinMessage_Data].parsed_key[message].separated_by[<n><reset>]>"

JoinMessage_Handler:
    type: world
    debug: false
    events:
        on player joins:
            # BEDROCK SIDE
            - if <player.client_brand> == geyser:
                - wait 6s
                - narrate "<script[JoinMessage_Data].parsed_key[bedrock.message].separated_by[<n><reset>]>"
                - playsound <player> sound:entity_player_levelup

            # JAVA SIDE
            - else:
                - wait 6s
                - narrate "<script[JoinMessage_Data].parsed_key[java.message].separated_by[<n><reset>]>"
                - playsound <player> sound:entity_player_levelup