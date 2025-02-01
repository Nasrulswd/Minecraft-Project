item_lore:
    type: data
    item:
        diamond:
            coins: 20
    lore:
        text:
            - ""
            - "<&e><&l>COST: <&e>⛃<script[item_lore].parsed_key[item.diamond.coins]> <&F>Coins"
            - ""
            - "<&e><&l>NIGHTMARKET"
            - ""

night_market_command:
    type: command
    name: nightmarket
    description: Night Market Command
    usage: /nightmarket
    script:
        - flag player inventory_contents:<player.inventory.list_contents>
        - inventory clear
        - inventory open d:night_market

night_market:
    type: inventory
    inventory: chest
    size: 27
    title: <&F><proc[util_textoffset].context[-8]><element[🌃].font[custom]>
    gui: true
    definitions:
        filler: map[display=<&r>;custom_model_data=1]
    procedural items:
        - define contents <player.flag[night_market.contents].if_null[<item[unrevealed_item].repeat_as_list[6]>]>
        - if <player.has_flag[night_market.rerolled]>:
            - define reroll "map[display=<&c><&L>YOU'VE ALREADY REROLLED..;custom_model_data=4]"
        - else:
            - define reroll reroll_item
        - determine <[contents].include[<[reroll]>]>
    slots:
        - [filler] [filler] [filler] [filler] [filler] [filler] [filler] [filler] [filler]
        - [filler] [] [] [] [filler] [] [] [] [filler]
        - [] [filler] [filler] [filler] [filler] [filler] [filler] [filler] [filler]

unrevealed_item:
    type: item
    material: map
    display name: <&7><&l>CLICK TO REVEAL ITEM
    mechanisms:
        custom_model_data: 2

reroll_item:
    type: item
    material: map
    display name: <&E><&L>CLICK TO RE-ROLL
    mechanisms:
        custom_model_data: 3

night_market_handler:
    type: world
    events:
        on player closes night_market:
            - adjust <player.inventory> contents:<player.flag[inventory_contents]>
            - flag <player> inventory_contents:!
        after player clicks unrevealed_item in night_market:
        - define loot <list[iron_ingot|gold_ingot|diamond|netherite_ingot].random>
        - inventory set slot:<context.slot> d:<context.inventory> o:<[loot]>
        - inventory adjust slot:<context.slot> d:<context.inventory> lore:<script[item_lore].parsed_key[lore.text].separated_by[<n>]>
        - define contents <context.inventory.slot[11|12|13|15|16|17]>
        - flag <player> night_market.contents:<[contents]>

        after player clicks reroll_item in night_market:
        - define rolls <player.flag[night_market.contents].if_null[<list>]>

        - if <[rolls].contains_match[unrevealed_item]> || !<[rolls].is_truthy>:
            - narrate "<&e><&l>NIGHTMARKET <&7><&l>» <&6>Roll every item first!"
            - stop

        - flag <player> night_market.contents:!

        - flag <player> night_market.rerolled

        - inventory open d:night_market


        after system time 12:00:
        - if <util.time_now.day_of_week_name> != sunday:
            - stop
        - announce "<&a>Night Market <&7>has been reset!"

        - flag <server.players_flagged[night_market]> night_market:!