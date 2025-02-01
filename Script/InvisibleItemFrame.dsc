itemframe_handler:
    type: world
    debug: false
    events:
        on player right clicks item_frame:
            - stop if:<player.item_in_hand.material.name.equals[air]>
            - if !<context.entity.has_framed_item> && <player.is_sneaking>:
                - adjust <context.entity> visible:false
                - stop
            - stop if:<player.is_sneaking>
            - if <context.entity.has_framed_item>:
                - determine cancelled
        on player damages item_frame:
            - if <context.entity.has_framed_item> && !<context.entity.visible>:
                - adjust <context.entity> visible:true
        on player right clicks glow_item_frame:
            - stop if:<player.item_in_hand.material.name.equals[air]>
            - if !<context.entity.has_framed_item> && <player.is_sneaking>:
                - adjust <context.entity> visible:false
                - stop
            - stop if:<player.is_sneaking>
            - if <context.entity.has_framed_item>:
                - determine cancelled
        on player damages glow_item_frame:
            - if <context.entity.has_framed_item> && !<context.entity.visible>:
                - adjust <context.entity> visible:true