#Version 1.0
#Author Icecapade
#Date 2021-11-15
custom_name_droplets:
    type: world
    debug: false
    events:
        after dropped_item spawns:
        - define entity <context.entity>
        #If the item which was dropped, doesn't have a display name, stop the script.
        #If the item does have a display name, set mechanisms on the entity to show the display name.
        - adjust <[entity]> custom_name:<[entity].item.replace_text[i<&at>].with[<&sp>].replace[_].with[<&sp>].to_titlecase>
        - adjust <[entity]> custom_name_visible:true