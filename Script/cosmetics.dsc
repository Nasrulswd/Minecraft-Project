Armor_Data:
    type: data
    leather:
        helmet:
            bonus: 1
            toughness: 0
            knockback: 0
        chestplate:
            bonus: 3
            toughness: 0
            knockback: 0
        leggings:
            bonus: 2
            toughness: 0
            knockback: 0
        boots:
            bonus: 1
            toughness: 0
            knockback: 0
    iron:
        helmet:
            bonus: 2
            toughness: 0
            knockback: 0
        chestplate:
            bonus: 6
            toughness: 0
            knockback: 0
        leggings:
            bonus: 5
            toughness: 0
            knockback: 0
        boots:
            bonus: 2
            toughness: 0
            knockback: 0
    golden:
        helmet:
            bonus: 2
            toughness: 0
            knockback: 0
        chestplate:
            bonus: 5
            toughness: 0
            knockback: 0
        leggings:
            bonus: 3
            toughness: 0
            knockback: 0
        boots:
            bonus: 1
            toughness: 0
            knockback: 0
    diamond:
        helmet:
            bonus: 3
            toughness: 2
            knockback: 0
        chestplate:
            bonus: 8
            toughness: 2
            knockback: 0
        leggings:
            bonus: 6
            toughness: 2
            knockback: 0
        boots:
            bonus: 3
            toughness: 2
            knockback: 0
    netherite:
        helmet:
            bonus: 3
            toughness: 3
            knockback: 0.1
        chestplate:
            bonus: 8
            toughness: 3
            knockback: 0.1
        leggings:
            bonus: 6
            toughness: 3
            knockback: 0.1
        boots:
            bonus: 3
            toughness: 3
            knockback: 0.1

Player_Identification:
    type: task
    debug: false
    definitions: player
    script:
        - define size 36
        - define title "<player.name> Id"
        - define inventory <inventory[generic[size=<[size]>;title=<[title]>]]>

        - inventory open d:<[inventory]>

        - inventory set slot:9 o:<player.flag[cosmetic_helmet_item].if_null[<player.equipment.get[5]>]> d:<[inventory]>
        - inventory set slot:18 o:<player.flag[cosmetic_chestplate_item].if_null[<player.equipment.get[3]>]> d:<[inventory]>
        - inventory set slot:27 o:<player.flag[cosmetic_leggings_item].if_null[<player.equipment.get[2]>]> d:<[inventory]>
        - inventory set slot:36 o:<player.flag[cosmetic_boots_item].if_null[<player.equipment.get[1]>]> d:<[inventory]>

        - inventory set slot:8 o:<player.flag[cosmetic_helmet].if_null[air]> d:<[inventory]>
        - inventory set slot:17 o:<player.flag[cosmetic_chestplate].if_null[air]> d:<[inventory]>
        - inventory set slot:26 o:<player.flag[cosmetic_leggings].if_null[air]> d:<[inventory]>
        - inventory set slot:35 o:<player.flag[cosmetic_boots].if_null[air]> d:<[inventory]>


Cosmetics_Command:
    type: command
    name: hat
    description: Cosmetics Command
    usage: /hat
    permission: cosmetics
    debug: false
    script:
        - inventory open d:Cosmetics_Inventory

Cosmetics_Inventory:
    type: inventory
    inventory: chest
    debug: false
    title: cosmetics
    gui: true
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [Siff_Hat] [] [beanie] [] [Topi_Merdeka] [] []
    - [] [] [] [] [] [] [] [] []

beanie:
    type: item
    material: firework_star
    display name: "<&f>Beanie"
    lore:
        - ""
        - "  <&8><&l>| <&f>owned: <proc[Cosmetics_Proc].context[beanie]>  "
        - "  <&8><&l>| <&f>used: <player.flag[cosmetic_helmet].script.equals[<script[beanie]>].if_null[<&c>false]>  "
        - ""

    debug: false
    mechanisms:
        custom_model_data: 3
        hides: all
    flags:
        cosmetic: helmet

Siff_Hat:
    type: item
    material: firework_star
    display name: "<&f>Siff Hat"
    lore:
        - ""
        - "  <&8><&l>| <&f>owned: <proc[Cosmetics_Proc].context[Siff_Hat]>  "
        - "  <&8><&l>| <&f>used: <player.flag[cosmetic_helmet].script.equals[<script[Siff_Hat]>].if_null[<&c>false]>  "
        - ""
    debug: false
    mechanisms:
        custom_model_data: 2
    flags:
        cosmetic: helmet


Topi_Merdeka:
    type: item
    material: firework_star
    display name: "<&f>Merdeka Cap"
    lore:
        - ""
        - "  <&8><&l>| <&f>owned: <proc[Cosmetics_Proc].context[Topi_Merdeka]>  "
        - "  <&8><&l>| <&f>used: <player.flag[cosmetic_helmet].script.equals[<script[topi_merdeka]>].if_null[<&c>false]>  "
        - ""

    debug: false
    mechanisms:
        custom_model_data: 1
    flags:
        cosmetic: helmet

Cosmetics_Proc:
    type: procedure
    definitions: item
    script:
        - if <player.has_permission[cosmetics.helmet.<[item]>]>:
            - define b "<&a>yes"
        - else:
            - define b "<&c>no"
        - determine <[b]>


Cosmetics_Handler:
    type: world
    debug: false
    events:
        on player death:
            - if <player.has_flag[cosmetic_helmet]>:
                - define item <context.drops.find_match[<player.flag[cosmetic_helmet]>]>
                - define drops <context.drops.remove[<[item]>]>
                - determine <[drops]><player.flag[cosmetic_helmet_item].if_null[]>
        on player respawns:
            - if <player.has_flag[cosmetic_helmet]>:
                - equip <player> head:<player.flag[cosmetic_helmet]>
                - inventory adjust slot:head "lore:"
                - flag <player> cosmetic_helmet_item:!
                - flag <player> cosmetic_helmet_durability:!
                - flag <player> cosmetic_helmet_max_durability:!
                - flag <player> cosmetic_helmet_sub_durability:!
        on player right clicks block with:*_helmet:
            - if <player.has_flag[cosmetic_helmet]>:
                - determine cancelled
        on player damaged:
            - if <context.cause> == entity_attack || <context.cause> == projectile:
                - if <player.has_flag[cosmetic_helmet]> && <player.has_flag[cosmetic_helmet_item]>:
                    - flag <player> cosmetic_helmet_durability:--
                    - if <player.flag[cosmetic_helmet_durability].is_less_than_or_equal_to[0]>:
                        - playsound <player> sound:ENTITY_ITEM_BREAK
                        - flag <player> cosmetic_helmet_item:!
                        - flag <player> cosmetic_helmet_durability:!
                        - flag <player> cosmetic_helmet_max_durability:!
                        - flag <player> cosmetic_helmet_sub_durability:!
                        - inventory adjust slot:head "lore:"
                        - stop
                    - flag <player> cosmetic_helmet_sub_durability:++
                    - inventory adjust slot:head "lore:|<&f>Durability: <player.flag[cosmetic_helmet_durability]> / <player.flag[cosmetic_helmet_max_durability]>|<&f><player.flag[cosmetic_helmet_item].material.name.replace[_].with[ ].to_uppercase>"
        on player clicks item in Cosmetics_Inventory:
        - if <context.item.has_flag[cosmetic]>:
            - if <player.has_permission[cosmetics.helmet.<context.item.scriptname>].not>:
                - playsound <player> sound:entity_villager_no
                - narrate "<&8>[<&color[#3381f3]><&l>!<&8>] <&c>You don't have this cosmetic"
                - inventory close
                - stop

            - playsound <player> sound:entity_player_levelup
            - if <player.has_flag[cosmetic_helmet].not>:

                - if <player.equipment.get[4].equals[i<&at>air].not>:

                    - define equipment <player.equipment.get[4]>

                    - equip <player> head:<context.item>
                    - flag <player> cosmetic_helmet:<context.item>
                    - flag <player> cosmetic_helmet_item:<item[<[equipment]>]>
                    - flag <player> cosmetic_helmet_durability:<[equipment].max_durability.sub[<[equipment].durability>]>
                    - flag <player> cosmetic_helmet_max_durability:<[equipment].max_durability>
                    - flag <player> cosmetic_helmet_sub_durability:<[equipment].durability>

                    - inventory adjust slot:head "lore:|<&f>Durability: <player.flag[cosmetic_helmet_durability]> / <player.flag[cosmetic_helmet_max_durability]>|<&f><[equipment].material.name.replace[_].with[ ].to_uppercase>"
                    - playsound <player> sound:ITEM_ARMOR_EQUIP_<[equipment].material.name.replace[_helmet]>

                    - define toughness <script[Armor_Data].parsed_key[<[equipment].material.name.replace[_helmet]>.helmet.toughness]>
                    - define armor <script[Armor_Data].parsed_key[<[equipment].material.name.replace[_helmet]>.helmet.bonus]>
                    - define knockback <script[Armor_Data].parsed_key[<[equipment].material.name.replace[_helmet]>.helmet.knockback]>
                    - definemap attributes:
                        generic_armor_toughness:
                            1:
                                operation: ADD_NUMBER
                                amount: <[toughness]>
                                slot: head
                        generic_armor:
                            2:
                                operation: ADD_NUMBER
                                amount: <[armor]>
                                slot: head
                        generic_knockback_resistance:
                            3:
                                operation: ADD_NUMBER
                                amount: <[knockback]>
                                slot: head
                    - inventory adjust slot:head add_attribute_modifiers:<[attributes]>

                    - inventory close

                - else:
                    - equip <player> head:<context.item>
                    - inventory adjust slot:head "lore:"
                    - flag <player> cosmetic_helmet:<context.item>
                    - inventory close

            - else:

                - if <player.flag[cosmetic_helmet].script.equals[<context.item.script>]>:

                    - if <player.has_flag[cosmetic_helmet_item]>:
                        - equip <player> head:<player.flag[cosmetic_helmet_item]>
                        - flag <player> cosmetic_helmet:!

                    - else:
                        - equip <player> head:air
                        - flag <player> cosmetic_helmet:!

                - else:
                    - if <player.has_flag[cosmetic_helmet_item]>:

                        - define equipment <player.flag[cosmetic_helmet_item]>

                        - equip <player> head:<context.item>
                        - flag <player> cosmetic_helmet:<context.item>
                        - flag <player> cosmetic_helmet_item:<item[<[equipment]>]>
                        - flag <player> cosmetic_helmet_durability:<[equipment].max_durability.sub[<[equipment].durability>]>
                        - flag <player> cosmetic_helmet_max_durability:<[equipment].max_durability>
                        - flag <player> cosmetic_helmet_sub_durability:<[equipment].durability>

                        - inventory adjust slot:head "lore:|<&f>Durability: <player.flag[cosmetic_helmet_durability]> / <player.flag[cosmetic_helmet_max_durability]>|<&f><[equipment].material.name.replace[_].with[ ].to_uppercase>"
                        - playsound <player> sound:ITEM_ARMOR_EQUIP_<[equipment].material.name.replace[_helmet]>

                        - define toughness <script[Armor_Data].parsed_key[<[equipment].material.name.replace[_helmet]>.helmet.toughness]>
                        - define armor <script[Armor_Data].parsed_key[<[equipment].material.name.replace[_helmet]>.helmet.bonus]>
                        - define knockback <script[Armor_Data].parsed_key[<[equipment].material.name.replace[_helmet]>.helmet.knockback]>
                        - definemap attributes:
                            generic_armor_toughness:
                                1:
                                    operation: ADD_NUMBER
                                    amount: <[toughness]>
                                    slot: head
                            generic_armor:
                                2:
                                    operation: ADD_NUMBER
                                    amount: <[armor]>
                                    slot: head
                            generic_knockback_resistance:
                                3:
                                    operation: ADD_NUMBER
                                    amount: <[knockback]>
                                    slot: head
                        - inventory adjust slot:head add_attribute_modifiers:<[attributes]>

                    - else:
                        - equip <player> head:<context.item>
                        - inventory adjust slot:head "lore:"
                        - flag <player> cosmetic_helmet:<context.item>
                        - inventory close
                - inventory close

        on player clicks item in inventory:

            - if <player.has_flag[cosmetic_helmet]> && <context.slot.equals[40]>:
                
                - if <player.has_flag[cosmetic_helmet_item].not> && <context.cursor_item.contains_text[helmet]>:

                    - flag <player> cosmetic_helmet_item:<context.cursor_item>

                    - inventory adjust slot:<context.slot> enchantments:<context.cursor_item.enchantment_map> d:<player.inventory>
                    - flag <player> cosmetic_helmet_durability:<context.cursor_item.max_durability.sub[<context.cursor_item.durability>]>
                    - flag <player> cosmetic_helmet_max_durability:<context.cursor_item.max_durability>
                    - flag <player> cosmetic_helmet_sub_durability:<context.cursor_item.durability>

                    - inventory adjust slot:<context.slot> "lore:|<&f>Durability: <player.flag[cosmetic_helmet_durability]> / <player.flag[cosmetic_helmet_max_durability]>|<&f><context.cursor_item.material.name.replace[_].with[ ].to_uppercase>"
                    - playsound <player> sound:ITEM_ARMOR_EQUIP_<context.cursor_item.material.name.replace[_helmet]>

                    - define toughness <script[Armor_Data].parsed_key[<context.cursor_item.material.name.replace[_helmet]>.helmet.toughness]>
                    - define armor <script[Armor_Data].parsed_key[<context.cursor_item.material.name.replace[_helmet]>.helmet.bonus]>
                    - define knockback <script[Armor_Data].parsed_key[<context.cursor_item.material.name.replace[_helmet]>.helmet.knockback]>
                    - definemap attributes:
                        generic_armor_toughness:
                            1:
                                operation: ADD_NUMBER
                                amount: <[toughness]>
                                slot: head
                        generic_armor:
                            2:
                                operation: ADD_NUMBER
                                amount: <[armor]>
                                slot: head
                        generic_knockback_resistance:
                            2:
                                operation: ADD_NUMBER
                                amount: <[knockback]>
                                slot: head
                    - inventory adjust slot:head add_attribute_modifiers:<[attributes]>
                    - take cursoritem

                - else if <player.has_flag[cosmetic_helmet_item]> && <context.cursor_item.contains_text[helmet]>:
                    - define cursor_item <context.cursor_item>

                    - adjust <player> item_on_cursor:<item[<player.flag[cosmetic_helmet_item].material.name>[durability=<player.flag[cosmetic_helmet_sub_durability].if_null[0]>]]>
                    - equip <player> head:<player.flag[cosmetic_helmet]>
                    - inventory adjust slot:head "lore:"

                    - flag <player> cosmetic_helmet_item:<[cursor_item]>

                    - inventory adjust slot:40 enchantments:<[cursor_item].enchantment_map> d:<player.inventory>
                    - flag <player> cosmetic_helmet_durability:<[cursor_item].max_durability.sub[<[cursor_item].durability>]>
                    - flag <player> cosmetic_helmet_max_durability:<[cursor_item].max_durability>
                    - flag <player> cosmetic_helmet_sub_durability:<[cursor_item].durability>

                    - inventory adjust slot:<context.slot> "lore:|<&f>Durability: <player.flag[cosmetic_helmet_durability]> / <player.flag[cosmetic_helmet_max_durability]>|<&f><[cursor_item].material.name.replace[_].with[ ].to_uppercase>"
                    - playsound <player> sound:ITEM_ARMOR_EQUIP_<[cursor_item].material.name.replace[_helmet]>

                    - define toughness <script[Armor_Data].parsed_key[<context.cursor_item.material.name.replace[_helmet]>.helmet.toughness]>
                    - define armor <script[Armor_Data].parsed_key[<context.cursor_item.material.name.replace[_helmet]>.helmet.bonus]>
                    - define knockback <script[Armor_Data].parsed_key[<context.cursor_item.material.name.replace[_helmet]>.helmet.knockback]>
                    - definemap attributes:
                        generic_armor_toughness:
                            1:
                                operation: ADD_NUMBER
                                amount: <[toughness]>
                                slot: head
                        generic_armor:
                            2:
                                operation: ADD_NUMBER
                                amount: <[armor]>
                                slot: head
                        generic_knockback_resistance:
                            2:
                                operation: ADD_NUMBER
                                amount: <[knockback]>
                                slot: head
                    - inventory adjust slot:head add_attribute_modifiers:<[attributes]>

                - else:
                    - if <player.has_flag[cosmetic_helmet_item]>:
                        - equip <player> head:<player.flag[cosmetic_helmet]>
                        - inventory adjust slot:head "lore:"
                        - adjust <player> item_on_cursor:<item[<player.flag[cosmetic_helmet_item].material.name>[durability=<player.flag[cosmetic_helmet_sub_durability].if_null[0]>]]>
                        - flag <player> cosmetic_helmet_item:!
                        - flag <player> cosmetic_helmet_durability:!
                        - flag <player> cosmetic_helmet_max_durability:!
                        - flag <player> cosmetic_helmet_sub_durability:!
                    - else:
                        - equip <player> head:<player.flag[cosmetic_helmet]>
                        - inventory adjust slot:head "lore:"

                - determine cancelled

            - if <player.has_flag[cosmetic_chestplate]> && <context.slot.equals[39]>:
                - determine cancelled

            - if <player.has_flag[cosmetic_leggings]> && <context.slot.equals[38]>:
                - determine cancelled

            - if <player.has_flag[cosmetic_boots]> && <context.slot.equals[37]>:
                - determine cancelled