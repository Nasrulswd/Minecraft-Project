pump_handler:
    type: world
    debug: false
    events:
        on player right clicks block with:pump_gun:
            - if <context.item.has_flag[Reloading]> || <player.has_flag[Gun_CD]>:
                - stop
            - flag player Gun_CD duration:1.5s
            - define Slot <player.held_item_slot>
            - define start_location <player.eye_location>
            - define random_up <player.eye_location.forward[15].up[<util.random.int[0].to[3]>]>
            - define random_down <player.eye_location.forward[15].down[<util.random.int[0].to[3]>]>
            - define random_left <player.eye_location.forward[15].left[<util.random.int[0].to[3]>]>
            - define random_right <player.eye_location.forward[15].right[<util.random.int[0].to[3]>]>
            - playeffect effect:redstone at:<[start_location].points_between[<[random_up]>]> quantity:0.5 offset:0 visibility:100 special_data:1|<gray>
            - playeffect effect:redstone at:<[start_location].points_between[<[random_down]>]> quantity:0.5 offset:0 visibility:100 special_data:1|<white>
            - playeffect effect:redstone at:<[start_location].points_between[<[random_left]>]> quantity:0.5 offset:0 visibility:100 special_data:1|<gray>
            - playeffect effect:redstone at:<[start_location].points_between[<[random_right]>]> quantity:0.5 offset:0 visibility:100 special_data:1|<white>
            - playeffect effect:redstone at:<[start_location].forward[1]> quantity:10 offset:0.2 visibility:100 special_data:1|<gold>
            - playsound sound:entity_firework_rocket_blast pitch:0 at:<[start_location]> effect:crit offset:0 visibility:1 volume:1
            - inject pump_hit
            - inject pump_recoil
            - wait 0.5s
            - playsound sound:item_goat_horn_sound_0 at:<player.eye_location> effect:crit offset:0 visibility:1 volume:1
            - inventory adjust slot:<[Slot]> flag:Clip:--
            - inventory adjust slot:<[Slot]> "display_name:<&f><&l>PUMP <&7><context.item.flag[Clip].sub[1]> <&8><&l>| <&a>∞"
            - if <context.item.flag[Clip]> <= 1:
                - itemcooldown <item[pump_gun].material.name> duration:50t
                - inventory adjust slot:<[Slot]> flag:Reloading:True
                - inventory adjust slot:<[Slot]> "display_name:<&f><&l>PUMP <&7>0 <&8><&l>| <&7>(<&c>Reloading...<&7>)"
                - wait 50t
                - inventory adjust slot:<[Slot]> flag:Clip:<context.item.script.data_key[data.stats.bullet]>
                - inventory adjust slot:<[Slot]> "display_name:<&f><&l>PUMP <&7>8 <&8><&l>| <&a>∞"
                - inventory adjust slot:<[Slot]> flag:Reloading:!

            - determine cancelled
        on player left clicks block with:pump_gun:
            - if <context.item.has_flag[Reloading]>:
              - stop
            - define Slot <player.held_item_slot>
            - itemcooldown <item[pump_gun].material.name> duration:50t
            - inventory adjust slot:<[Slot]> flag:Reloading:True
            - inventory adjust slot:<[Slot]> "display_name:<&f><&l>PUMP <&7>0 <&8><&l>| <&7>(<&c>Reloading...<&7>)"
            - wait 50t
            - inventory adjust slot:<[Slot]> flag:Clip:8
            - inventory adjust slot:<[Slot]> "display_name:<&f><&l>PUMP <&7>8 <&8><&l>| <&a>∞"
            - inventory adjust slot:<[Slot]> flag:Reloading:!
        on player toggles sneaking:
          - if <player.item_in_hand> matches pump_gun:
            - adjust <player> fov_multiplier:2
            - define Slot <player.held_item_slot>
            - inventory adjust slot:<[Slot]> custom_model_data:12
        on player stops sneaking:
          - if <player.item_in_hand> matches pump_gun:
            - adjust <player> fov_multiplier:0
            - define Slot <player.held_item_slot>
            - inventory adjust slot:<[Slot]> custom_model_data:11

pump_hit:
    type: task
    debug: false
    script:
        - define hit_location <player.precise_target_position.y>
        - define target <player.precise_target[15]>
        - if <[hit_location]> >= <player.target.eye_location.y.sub[0.05]> && <[hit_location]> <= <player.target.eye_location.y.add[0.70]>:
          - hurt 20 <[target]> source:<player>
          - cast SLOW amplifier:1 duration:1 hide_particles no_icon no_ambient <[Target]>
        - else if <[hit_location]> <= <player.target.eye_location.y.sub[0.7]> && <[hit_location]> <= <player.target.eye_location.y.add[0.70]>:
          - hurt 5 <[target]> source:<player>
          - cast SLOW amplifier:1 duration:1 hide_particles no_icon no_ambient <[Target]>
        - else:
          - hurt 8 <[target]> source:<player>
          - playeffect effect:redstone at:<player.eye_location.forward[60]> quantity:0.5 offset:0 visibility:100 special_data:1|<red>
          - cast SLOW amplifier:1 duration:1 hide_particles no_icon no_ambient <[Target]>

pump_recoil:
    type: task
    debug: false
    script:
        - if <player.is_sneaking>:
          - define recoil <player.eye_location.forward[<context.item.script.data_key[data.stats.sneakrecoil]>].up[<util.random.int[1].to[5]>].left[<util.random.int[-5].to[5]>]>
        - else:
          - define recoil <player.eye_location.forward[<context.item.script.data_key[data.stats.recoil]>].up[<util.random.int[1].to[1]>].left[<util.random.int[-5].to[5]>]>
        - look <player> <[recoil]>

pump_gun:
    type: item
    debug: false
    material: diamond_hoe
    mechanisms:
      custom_model_data: 11
    display name: <&f><&l>PUMP <&7>8 <&8><&l>| <&a>∞
    lore:
        - "<&7>Damage:"
        -   <&7>Head: <&a>20
        -   <&7>Body: <&a>8
        -   <&7>Legg: <&a>5
        -   <empty>
    data:
        stats:
            range: 15
            headdamage: 100
            bodydamage: 10
            feetdamage: 1
            bullet: 8
            recoil: 100
            sneakrecoil: 1000
            reloadrate: 2
            fireraterate: 0.3
    flags:
        Clip: 8