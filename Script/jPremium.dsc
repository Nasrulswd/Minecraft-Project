events_nas:
    type: world
    events:
        after player joins:
            - ~webget https://api.mojang.com/users/profiles/minecraft/<player.name> save:premium
            - narrate <entry[premium].result.contains_text[<player.uuid.replace[-].with[]>]>