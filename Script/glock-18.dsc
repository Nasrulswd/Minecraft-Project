glock-18:
    type: item
    material: wooden_hoe
    display name: <&f>Glock-18 <&7>(<&f>20<&7>/<&f>120<&7>)
    lore:
        - ''
        - ' <&8><&l>| <&f>Right-Click: <&7>Shoot  '
        - ' <&8><&l>| <&f>Left-Click: <&7>Reload  '
        - ''
        - ' <&8><&l>| <&f>Damage:  '
        - ' <&8>- <&f>Head: <&7>113  '
        - ' <&8>- <&f>Body: <&7>30  '
        - ' <&8>- <&f>Leg: <&7>15  '
        - ''

    mechanisms:
        hides: all
    flags:

        # Damage armored
        head-armored: 57
        body-armored: 15
        leg-armored: 15

        # Damage unarmored
        head-unarmored: 113
        body-unarmored: 30
        leg-unarmored: 15

        # %
        armor-penetration: 47

        # RPM
        rate-of-fire: 400

        # meters
        accurate-range: 20

        # reload time
        reload: 2.3

        # bullet in 1 mag
        magazine-capacity: 20

        # limit bullet
        ammo-limt: 120

glock-18-handler:
    type: world
    debug: false
    events:
        after player scrolls their hotbar:
            - if <player.item_in_hand.script.name.equals[glock-18].if_null[false]>:
                - cast SLOW amplifier:1 duration:0 no_ambient no_clear no_icon hide_particles
            - else:
                - cast remove slow
        on player jumps:
            - determine passively cancelled
            - wait 0.1t
            - adjust <player> velocity:0,0.4,0
        on player left clicks block with:glock-18:
            - if <player.item_in_hand.flag[magazine-capacity]> < 20 && <player.item_in_hand.flag[ammo-limt]> != 0:
                - playsound <player> sound:UI_BUTTON_CLICK pitch:1.8
                - define slot <player.held_item_slot>

                - itemcooldown WOODEN_HOE duration:2.3
                - inventory adjust s:<[slot]> d:<player.inventory> flag:ammo-limt:-:20
                - inventory adjust s:<[slot]> d:<player.inventory> flag:magazine-capacity:20
                - inventory adjust s:<[slot]> d:<player.inventory> flag:reloading
                - inventory adjust s:<[slot]> d:<player.inventory> 'display:<&c>Reloading...'
                - wait 2.3
                - playsound <player> sound:UI_BUTTON_CLICK pitch:1.8

                - inventory adjust s:<[slot]> d:<player.inventory> 'display:<&f>Glock-18 <&7>(<&f><player.item_in_hand.flag[magazine-capacity]><&7>/<&f><player.item_in_hand.flag[ammo-limt]><&7>)'
                - inventory adjust s:<[slot]> d:<player.inventory> flag:reloading:!

        on player right clicks block with:glock-18:
            - determine passively cancelled
            - define slot <player.held_item_slot>
            # stop if player has cooldown
            - stop if:<player.has_flag[cd-glock]>
            - if <player.item_in_hand.has_flag[reloading]>:
                - playsound <player> sound:UI_BUTTON_CLICK pitch:1.8
                - stop
            - if <player.item_in_hand.flag[ammo-limt].is_less_than_or_equal_to[0]> && <player.item_in_hand.flag[magazine-capacity].is_less_than_or_equal_to[0]>:
                - inventory adjust s:<player.held_item_slot> d:<player.inventory> 'display:<&c><&L>NO AMMO!'
                - playsound <player> sound:UI_BUTTON_CLICK pitch:1.8
                - stop
            - if <player.item_in_hand.flag[magazine-capacity].is_less_than_or_equal_to[0]>:
                - playsound <player> sound:UI_BUTTON_CLICK pitch:1.8
                - stop

            # shooting mechanisms
            - inject create_bullet
            - inject glock_hit
            - inventory adjust s:<player.held_item_slot> d:<player.inventory> flag:magazine-capacity:--
            - inventory adjust s:<player.held_item_slot> d:<player.inventory> 'display:<&f>Glock-18 <&7>(<&f><player.item_in_hand.flag[magazine-capacity]><&7>/<&f><player.item_in_hand.flag[ammo-limt]><&7>)'

            - if <player.item_in_hand.flag[magazine-capacity].is_less_than_or_equal_to[0]>:
                - stop if:<player.item_in_hand.flag[ammo-limt].is_less_than_or_equal_to[0]>
                - playsound <player> sound:UI_BUTTON_CLICK pitch:1.8

                - itemcooldown WOODEN_HOE duration:2.3
                - inventory adjust s:<[slot]> d:<player.inventory> flag:ammo-limt:-:20
                - inventory adjust s:<[slot]> d:<player.inventory> flag:magazine-capacity:20
                - inventory adjust s:<[slot]> d:<player.inventory> flag:reloading
                - inventory adjust s:<[slot]> d:<player.inventory> 'display:<&c>Reloading...'
                - define meg <player.item_in_hand.flag[magazine-capacity]>

                - define limit <player.item_in_hand.flag[ammo-limt]>
                - wait 2.3

                - playsound <player> sound:UI_BUTTON_CLICK pitch:1.8

                - inventory adjust s:<[slot]> d:<player.inventory> 'display:<&f>Glock-18 <&7>(<&f><[meg]><&7>/<&f><[limit]><&7>)'
                - inventory adjust s:<[slot]> d:<player.inventory> flag:reloading:!
                - stop

            # Make cooldown
            - define RPS <player.item_in_hand.flag[rate-of-fire].div[60].round_to[2]>
            - define CD <element[1].div[<[RPS]>].round_to[2]>

            - flag <player> cd-glock expire:<[CD]>

glock_hit:
    type: task
    debug: false
    script:
        - if <player.target.is_living.if_null[]>:

            - define hit_location <player.precise_target_position.y>
            - define target <player.precise_target[<player.item_in_hand.flag[accurate-range]>]>

            # Head
            - if <[hit_location]> >= <player.target.eye_location.y.sub[0.05]> && <[hit_location]> <= <player.target.eye_location.y.add[0.70]>:
                # Armored
                - if <[target].equipment.get[4].script.name.equals[helmet-armor].if_null[]>:
                    - narrate 'Part: Head'
                    - narrate 'Status: armored'
                    - narrate 'Damge: <player.item_in_hand.flag[head-armored]>'
                - else:
                    - narrate 'Part: Head'
                    - narrate 'Status: Unarmored'
                    - narrate 'Damge: <player.item_in_hand.flag[head-unarmored]>'

            # Leg
            - else if <[hit_location]> <= <player.target.eye_location.y.sub[0.7]> && <[hit_location]> <= <player.target.eye_location.y.add[0.70]>:
                - narrate 'Part: Leg'
                - narrate 'Status: Unarmored'
                - narrate 'Damge: <player.item_in_hand.flag[leg-armored]>'

            # Body
            - else:
                - if <[target].equipment.get[3].script.name.equals[vest-armor].if_null[]>:
                    - narrate 'Part: Body'
                    - narrate 'Status: Armored'
                    - narrate 'Damge: <player.item_in_hand.flag[body-armored]>'
                - else:
                    - narrate 'Part: Body'
                    - narrate 'Status: Unarmored'
                    - narrate 'Damge: <player.item_in_hand.flag[body-unarmored]>'
create_bullet:
    type: task
    debug: false
    script:

        # Target Block
        - define eye_loc          <player.eye_location>
        - define origin           <[eye_loc].forward>
        - define origin           <[origin].below[0.2]> if:<player.has_flag[fort.gun_scoped]>
        - define ignored_entities <server.online_players.filter[gamemode.equals[SPECTATOR]].include[<player>].include[<player.world.entities[armor_stand]>]>
        - define target_loc       <[origin].ray_trace[range=<player.item_in_hand.flag[accurate-range]>;entities=*;ignore=<[ignored_entities]>;default=air]>

        # Bullet
        - define start_particle <player.eye_location.forward[0.6].relative[-0.33,-0.2,0.3].right[0.055]>
        - define between <[start_particle].points_between[<[target_loc]>].distance[2]>
        - playeffect at:<[between]> effect:CRIT offset:0 visibility:500

        # Block Crack
        - define particle_dest <[target_loc].face[<[eye_loc]>].forward[0.1]>
        - playeffect at:<[particle_dest]> effect:sweep_attack offset:0 quantity:1 visibility:250 velocity:1.65,1.65,1.65

        - define mat <player.cursor_on[<player.item_in_hand.flag[accurate-range]>].material.name.if_null[air]>

        # Crack Particle
        - playsound <player.location> sound:ENTITY_FIREWORK_ROCKET_BLAST_FAR pitch:1.7 volume:1.2
        - if <player.target.is_living.if_null[]>:
            - playsound <player> sound:ITEM_ARMOR_EQUIP_LEATHER pitch:2
            - playeffect at:<[particle_dest]> effect:BLOCK_CRACK offset:0 quantity:3 visibility:150 special_data:red_wool
        - else:
            - playeffect at:<[particle_dest]> effect:BLOCK_CRACK offset:0 quantity:8 visibility:150 special_data:<[mat]>

        # Recoil
        - look <player> yaw:<player.location.yaw> pitch:<player.location.pitch.sub[0.4]> offthread_repeat:3 if:<player.is_online>
        - define RPS <player.item_in_hand.flag[rate-of-fire].div[60].round_to[2]>
        - define CD <element[1].div[<[RPS]>].round_to[2]>

        - wait <[CD]>s
        - look <player> yaw:<player.location.yaw> pitch:<player.location.pitch.add[0.4]> offthread_repeat:3 if:<player.is_online>
