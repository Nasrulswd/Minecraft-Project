glock_handler:
    type: world
    debug: false
    events:
        on player right clicks block with:glock_gun:
            - if <context.item.has_flag[Reloading]> || <player.has_flag[Gun_CD]>:
                - stop
            - flag player Gun_CD duration:7t
            - define Slot <player.held_item_slot>
            - define start_location <player.eye_location>
            - define end_loc <player.eye_location.forward[30]>
            - playeffect effect:redstone at:<[start_location].points_between[<[end_loc]>]> quantity:0.5 offset:0 visibility:100 special_data:1|<gray>
            - playeffect effect:redstone at:<[start_location].points_between[<[end_loc]>]> quantity:0.5 offset:0 visibility:100 special_data:1|<white>
            - playsound sound:entity_firework_rocket_blast pitch:0 at:<[start_location]> effect:crit offset:0 visibility:1 volume:1
            - playeffect effect:redstone at:<[start_location].forward[1]> quantity:10 offset:0.2 visibility:100 special_data:1|<gold>
            - inject glock_hit
            - inject glock_recoil
            - inventory adjust slot:<[Slot]> flag:Clip:--
            - inventory adjust slot:<[Slot]> "display_name:<&f><&l>GLOCK <&7><context.item.flag[Clip].sub[1]> <&8><&l>| <&a>∞"
            - if <context.item.flag[Clip]> <= 1:
                - itemcooldown <item[glock_gun].material.name> duration:50t
                - inventory adjust slot:<[Slot]> flag:Reloading:True
                - inventory adjust slot:<[Slot]> "display_name:<&f><&l>GLOCK <&7>0 <&8><&l>| <&7>(<&c>Reloading...<&7>)"
                - wait 50t
                - inventory adjust slot:<[Slot]> flag:Clip:<context.item.script.data_key[data.stats.bullet]>
                - inventory adjust slot:<[Slot]> "display_name:<&f><&l>GLOCK <&7>8 <&8><&l>| <&a>∞"
                - inventory adjust slot:<[Slot]> flag:Reloading:!

            - determine cancelled
        on player left clicks block with:glock_gun:
            - if <context.item.has_flag[Reloading]>:
              - stop
            - define Slot <player.held_item_slot>
            - itemcooldown <item[glock_gun].material.name> duration:50t
            - inventory adjust slot:<[Slot]> flag:Reloading:True
            - inventory adjust slot:<[Slot]> "display_name:<&f><&l>GLOCK <&7>0 <&8><&l>| <&7>(<&c>Reloading...<&7>)"
            - wait 50t
            - inventory adjust slot:<[Slot]> flag:Clip:20
            - inventory adjust slot:<[Slot]> "display_name:<&f><&l>GLOCK <&7>20 <&8><&l>| <&a>∞"
            - inventory adjust slot:<[Slot]> flag:Reloading:!

glock_hit:
    type: task
    debug: false
    script:
        - define hit_location <player.precise_target_position.y>
        - define target <player.precise_target[30]>
        - if <[hit_location]> >= <player.target.eye_location.y.sub[0.05]> && <[hit_location]> <= <player.target.eye_location.y.add[0.70]>:
          - hurt 7 <[target]> source:<player>
          - cast SLOW amplifier:1 duration:1 hide_particles no_icon no_ambient <[Target]>
        - else if <[hit_location]> <= <player.target.eye_location.y.sub[0.7]> && <[hit_location]> <= <player.target.eye_location.y.add[0.70]>:
          - hurt 3 <[target]> source:<player>
          - cast SLOW amplifier:1 duration:1 hide_particles no_icon no_ambient <[Target]>
        - else:
          - hurt 1 <[target]> source:<player>
          - cast SLOW amplifier:1 duration:1 hide_particles no_icon no_ambient <[Target]>

glock_recoil:
    type: task
    debug: false
    script:
        - if <player.is_sneaking>:
          - define recoil <player.eye_location.forward[<context.item.script.data_key[data.stats.sneakrecoil]>].up[<util.random.int[1].to[5]>].left[<util.random.int[-5].to[5]>]>
        - else:
          - define recoil <player.eye_location.forward[<context.item.script.data_key[data.stats.recoil]>].up[<util.random.int[1].to[1]>].left[<util.random.int[-5].to[5]>]>
        - look <player> <[recoil]>

glock_gun:
    type: item
    debug: false
    material: diamond_hoe
    mechanisms:
      custom_model_data: 31
    display name: <&f><&l>GLOCK <&7>20 <&8><&l>| <&a>∞
    lore:
        - "<&7>Damage:"
        -   <&7>Head: <&a>20
        -   <&7>Body: <&a>8
        -   <&7>Legg: <&a>5
        -   <empty>
    data:
        stats:
            range: 30
            headdamage: 100
            bodydamage: 10
            feetdamage: 1
            bullet: 20
            recoil: 100
            sneakrecoil: 1000
            reloadrate: 2
            fireraterate: 0.3
    flags:
        Clip: 20