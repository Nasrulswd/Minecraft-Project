################################################
#   ___    ___    ___________    __________    #
#  |   \  |   |  |   _____   |  |          |   #
#  |    \ |   |  |  |     |  |  |   _______|   #
#  |     \|   |  |  |     |  |  |   |______    #
#  |   |  \   |  |  |_____|  |  |_______   |   #
#  |   |\     |  |    ___    |   ______|   |   #
#  |   | \    |  |   |   |   |  |          |   #
#  |___|  \___|  |___|   |___|  |__________|   #
#                                              #
################################################

## This script made by Nasrulswd
## Discord: nasrulswd

Thirst_Config:
    type: data
    thirst:
        food:

            # [ MELON ] FOOD CONFIG
            melon_slice:
                enable: true
                level: 4

            # [ APPLE ] FOOD CONFIG
            apple:
                enable: true
                level: 4

            # [ CARROT ] FOOD CONFIG
            carrot:
                enable: true
                level: 2

            # [ SWEET BERRIES ] FOOD CONFIG
            sweet_berries:
                enable: true
                level: 2

            # [ MILK BUCKET ] FOOD CONFIG
            milk_bucket:
                enable: true
                level: 10

            # [ MUSHROOM STEW ] FOOD CONFIG
            mushroom_stew:
                enable: true
                level: 10

            # [ BEETROOT SOUP ] FOOD CONFIG
            beetroot_soup:
                enable: true
                level: 10

            # [ WATER BUCKET ] FOOD CONFIG
            water_bucket:
                enable: true
                level: 10

            # [ DROWNIG ] CONFIG
            drowning:
                enable: true
                level: 20

            # [ WATER BOTTLE ] CONFIG
            water_bottle:
                enable: true
                level: 4

            # [ BOILED WATER BOTTLE ] CONFIG
            boiled_water_bottle:
                enable: true
                level: 10

#__________________________________________________________THE END OF THE CONFIG___________________________________________________________________
#_________________________________________________________DO NOT TOUCH THIS SCRIPT_________________________________________________________________

Thirst_Flag_Handler:
    type: world
    debug: false
    events:
        after player join:
            - if <player.has_flag[thirst]>:
                - wait 1t
                - run THIRST_ACTIONBAR_HANDLER
                - stop
            - else:
                - wait 1t
                - flag <player> thirst:20
                - run THIRST_ACTIONBAR_HANDLER

Thirst_Lower:
    type: world
    debug: false
    events:
        after player changes gamemode to survival:
            - run THIRST_ACTIONBAR_HANDLER
        after player changes gamemode to adventure:
            - run THIRST_ACTIONBAR_HANDLER
        on delta time minutely:
            - foreach <server.online_players_flagged[thirst]> as:__player:
                - stop if:!<player.gamemode.equals[SURVIVAL]>
                - stop if:<player.has_flag[thirst].equals[false]>
                - stop if:<player.flag[thirst].is_less_than_or_equal_to[0]>
                - flag <player> thirst:--

        on delta time secondly:
            - foreach <server.online_players_flagged[thirst]> as:__player:
                - stop if:<player.has_flag[thirst].equals[false]>
                - if <player.flag[thirst]> <= 0:
                        - flag <player> thirst:0
                        - cast slow amplifier:2 duration:5 no_ambient no_icon no_clear hide_particles
                        - cast confusion amplifier:1 duration:5 no_ambient no_icon no_clear hide_particles
Thirst_Food_Handler:
    type: world
    debug: false
    events:
        # [ MELON ] FOOD HANDLER
        on player consumes melon_slice:
            - stop if:<script[thirst_config].parsed_key[thirst.food.melon_slice.enable].equals[false]>
            - stop if:<player.has_flag[thirst].equals[false]>
            - flag <player> thirst:+:4
            - if <player.flag[thirst]> >= 20:
                - flag <player> thirst:20
            - if <player.flag[thirst]> > 0:
                - cast remove slow
                - cast remove jump
                - cast remove confusion

        # [ APPLE ] FOOD HANDLER
        on player consumes apple:
            - stop if:<script[thirst_config].parsed_key[thirst.food.apple.enable].equals[false]>
            - stop if:<player.has_flag[thirst].equals[false]>
            - flag <player> thirst:+:<script[Thirst_Config].parsed_key[thirst.food.melon_slice.level]>
            - if <player.flag[thirst]> >= 20:
                - flag <player> thirst:20
            - if <player.flag[thirst]> > 0:
                - cast remove slow
                - cast remove jump
                - cast remove confusion

        # [ CARROT ] FOOD HANDLERcoal
        on player consumes carrot:
            - stop if:<script[thirst_config].parsed_key[thirst.food.carrot.enable].equals[false]>
            - stop if:<player.has_flag[thirst].equals[false]>
            - flag <player> thirst:+:<script[Thirst_Config].parsed_key[thirst.food.carrot.level]>
            - if <player.flag[thirst]> >= 20:
                - flag <player> thirst:20
            - if <player.flag[thirst]> > 0:
                - cast remove slow
                - cast remove jump
                - cast remove confusion

        # [ SWEAT BERRIES ] FOOD HANDLER
        on player consumes sweet_berries:
            - stop if:<script[thirst_config].parsed_key[thirst.food.sweet_berries.enable].equals[false]>
            - stop if:<player.has_flag[thirst].equals[false]>
            - flag <player> thirst:+:<script[Thirst_Config].parsed_key[thirst.food.sweet_berries.level]>
            - if <player.flag[thirst]> >= 20:
                - flag <player> thirst:20
            - if <player.flag[thirst]> > 0:
                - cast remove slow
                - cast remove jump
                - cast remove confusion

        # [ MILK BUCKET ] FOOD HANDLER
        on player consumes milk_bucket:
            - stop if:<script[thirst_config].parsed_key[thirst.food.milk_bucket.enable].equals[false]>
            - stop if:<player.has_flag[thirst].equals[false]>
            - flag <player> thirst:+:<script[Thirst_Config].parsed_key[thirst.food.milk_bucket.level]>
            - if <player.flag[thirst]> >= 20:
                - flag <player> thirst:20
            - if <player.flag[thirst]> > 0:
                - cast remove slow
                - cast remove jump
                - cast remove confusion

        # [ MUSHROOM STEW ] FOOD HANDLER
        on player consumes mushroom_stew:
            - stop if:<script[thirst_config].parsed_key[thirst.food.mushroom_stew.enable].equals[false]>
            - stop if:<player.has_flag[thirst].equals[false]>
            - flag <player> thirst:+:<script[Thirst_Config].parsed_key[thirst.food.mushroom_stew.level]>
            - if <player.flag[thirst]> >= 20:
                - flag <player> thirst:20
            - if <player.flag[thirst]> > 0:
                - cast remove slow
                - cast remove jump
                - cast remove confusion

        # [ BEETROOT SOUP ] FOOD HANDLER
        on player consumes beetroot_soup:
            - stop if:<script[thirst_config].parsed_key[thirst.food.beetroot_soup.enable].equals[false]>
            - stop if:<player.has_flag[thirst].equals[false]>
            - flag <player> thirst:+:<script[Thirst_Config].parsed_key[thirst.food.beetroot_soup.level]>
            - if <player.flag[thirst]> >= 20:
                - flag <player> thirst:20
            - if <player.flag[thirst]> > 0:
                - cast remove slow
                - cast remove jump
                - cast remove confusion

        # [ WATER BOTTLE ] FOOD HANDLER
        on player consumes item:
            - stop if:<script[thirst_config].parsed_key[thirst.food.water_bottle.enable].equals[false]>
            - stop if:<player.has_flag[thirst].equals[false]>
            - if <player.item_in_hand.contains_text[type=WATER]>:
                - if <player.item_in_hand.has_lore>:
                    - flag <player> thirst:+:<script[Thirst_Config].parsed_key[thirst.food.boiled_water_bottle.level]>
                    - if <player.flag[thirst]> >= 20:
                        - flag <player> thirst:20
                    - if <player.flag[thirst]> > 0:
                        - cast remove poison
                        - cast remove slow
                        - cast remove jump
                        - cast remove confusion
                        - cast remove confusion

            - if <player.item_in_hand.contains_text[type=WATER]>:
                - if !<player.item_in_hand.has_lore>:
                    - flag <player> thirst:+:<script[Thirst_Config].parsed_key[thirst.food.water_bottle.level]>
                    - if <player.flag[thirst]> >= 20:
                        - flag <player> thirst:20
                    - if <player.flag[thirst]> > 0:
                        - cast poison amplifier:1 duration:3 no_ambient no_icon no_clear hide_particles
                        - cast remove slow
                        - cast remove jump
                        - cast remove confusion
                        - cast remove confusion

        # [ WATER ] FOOD HANDLER
        on player left clicks block:
            - stop if:<player.has_flag[thirst].equals[false]>
            - stop if:!<player.item_in_hand.material.name.equals[air]>
            - if <player.cursor_on[2].material.name.equals[water].if_null[]> = true:
                - stop if:<player.flag[thirst].is_more_than_or_equal_to[20]>
                - flag <player> thirst:++
                - if <player.flag[thirst]> > 0:
                    - cast remove slow
                    - cast poison amplifier:1 duration:3 no_ambient no_icon no_clear hide_particles
                    - cast remove jump
                    - cast remove confusion
            - else :
                - stop

        # [ WATER BUCKET ] FOOD HANDLER
            - stop if:<script[thirst_config].parsed_key[thirst.food.water_bucket.enable].equals[false]>
            - if <player.item_in_hand.material.name.equals[water_bucket]> = true:
                - stop if:<player.has_flag[thirst].equals[false]>
                - flag <player> thirst:+:<script[Thirst_Config].parsed_key[thirst.food.water_bucket.level]>
                - if <player.flag[thirst]> >= 20:
                    - flag <player> thirst:20
                - if <player.flag[thirst]> > 0:
                    - cast remove slow
                    - cast poison amplifier:1 duration:3 no_ambient no_icon no_clear hide_particles
                    - cast remove jump
                    - cast remove confusion
                - take slot:<player.held_item_slot>
                - give bucket slot:<player.held_item_slot>

        # [ DROWING ] HANDLER
        on player damaged by drowning:
            - stop if:<script[thirst_config].parsed_key[thirst.food.drowning.enable].equals[false]>
            - stop if:<player.has_flag[thirst].equals[false]>
            - flag <player> thirst:<script[Thirst_Config].parsed_key[thirst.food.drowning.level]>
            - if <player.flag[thirst]> > 0:
                - cast remove slow
                - cast remove jump
                - cast remove confusion

        # [ RESPAWN ] HANDLER
        after player respawns:
            - stop if:<player.has_flag[thirst].equals[false]>
            - flag <player> thirst:20
            - while <player.is_online> && <player.is_spawned>:
                - run Thirst_Actionbar_Handler
                - wait 1s

Thirst_Heal_Command:
    type: command
    name: heal
    usage: /heal
    debug: false
    description: Heal Player
    script:
        - narrate "<&8>[<&a><&l>!<&8>] <&a>You Has Been heal"
        - heal 20
        - feed amount:40
        - flag <player> thirst:20
        - flag <player> energy:10


thirst_1:
    type: procedure
    definitions: player
    debug: false
    script:
        - if <player.flag[thirst]> >= 20:
            - define bar "🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢"
        - if <player.flag[thirst]> = 19:
            - define bar "🟡🟢🟢🟢🟢🟢🟢🟢🟢🟢"
        - if <player.flag[thirst]> = 18:
            - define bar "🔴🟢🟢🟢🟢🟢🟢🟢🟢🟢"
        - if <player.flag[thirst]> = 17:
            - define bar "🔴🟡🟢🟢🟢🟢🟢🟢🟢🟢"
        - if <player.flag[thirst]> = 16:
            - define bar "🔴🔴🟢🟢🟢🟢🟢🟢🟢🟢"
        - if <player.flag[thirst]> = 15:
            - define bar "🔴🔴🟡🟢🟢🟢🟢🟢🟢🟢"
        - if <player.flag[thirst]> = 14:
            - define bar "🔴🔴🔴🟢🟢🟢🟢🟢🟢🟢"
        - if <player.flag[thirst]> = 13:
            - define bar "🔴🔴🔴🟡🟢🟢🟢🟢🟢🟢"
        - if <player.flag[thirst]> = 12:
            - define bar "🔴🔴🔴🔴🟢🟢🟢🟢🟢🟢"
        - if <player.flag[thirst]> = 11:
            - define bar "🔴🔴🔴🔴🟡🟢🟢🟢🟢🟢"
        - if <player.flag[thirst]> = 10:
            - define bar "🔴🔴🔴🔴🔴🟢🟢🟢🟢🟢"
        - if <player.flag[thirst]> = 9:
            - define bar "🔴🔴🔴🔴🔴🟡🟢🟢🟢🟢"
        - if <player.flag[thirst]> = 8:
            - define bar "🔴🔴🔴🔴🔴🔴🟢🟢🟢🟢"
        - if <player.flag[thirst]> = 7:
            - define bar "🔴🔴🔴🔴🔴🔴🟡🟢🟢🟢"
        - if <player.flag[thirst]> = 6:
            - define bar "🔴🔴🔴🔴🔴🔴🔴🟢🟢🟢"
        - if <player.flag[thirst]> = 5:
            - define bar "🔴🔴🔴🔴🔴🔴🔴🟡🟢🟢"
        - if <player.flag[thirst]> = 4:
            - define bar "🔴🔴🔴🔴🔴🔴🔴🔴🟢🟢"
        - if <player.flag[thirst]> = 3:
            - define bar "🔴🔴🔴🔴🔴🔴🔴🔴🟡🟢"
        - if <player.flag[thirst]> = 2:
            - define bar "🔴🔴🔴🔴🔴🔴🔴🔴🔴🟢"
        - if <player.flag[thirst]> = 1:
            - define bar "🔴🔴🔴🔴🔴🔴🔴🔴🔴🟡"
        - if <player.flag[thirst]> <= 0:
            - define bar "🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴"
        - determine <&color[#4e5c24]><[bar].font[custom]>

thirst_2:
    type: procedure
    definitions: player
    debug: false
    script:
        - if <player.flag[thirst]> >= 20:
            - define bar "💚💚💚💚💚💚💚💚💚💚"
        - if <player.flag[thirst]> = 19:
            - define bar "💛💚💚💚💚💚💚💚💚💚"
        - if <player.flag[thirst]> = 18:
            - define bar "❤💚💚💚💚💚💚💚💚💚"
        - if <player.flag[thirst]> = 17:
            - define bar "❤💛💚💚💚💚💚💚💚💚"
        - if <player.flag[thirst]> = 16:
            - define bar "❤❤💚💚💚💚💚💚💚💚"
        - if <player.flag[thirst]> = 15:
            - define bar "❤❤💛💚💚💚💚💚💚💚"
        - if <player.flag[thirst]> = 14:
            - define bar "❤❤❤💚💚💚💚💚💚💚"
        - if <player.flag[thirst]> = 13:
            - define bar "❤❤❤💛💚💚💚💚💚💚"
        - if <player.flag[thirst]> = 12:
            - define bar "❤❤❤❤💚💚💚💚💚💚"
        - if <player.flag[thirst]> = 11:
            - define bar "❤❤❤❤💛💚💚💚💚💚"
        - if <player.flag[thirst]> = 10:
            - define bar "❤❤❤❤❤💚💚💚💚💚"
        - if <player.flag[thirst]> = 9:
            - define bar "❤❤❤❤❤💛💚💚💚💚"
        - if <player.flag[thirst]> = 8:
            - define bar "❤❤❤❤❤❤💚💚💚💚"
        - if <player.flag[thirst]> = 7:
            - define bar "❤❤❤❤❤❤💛💚💚💚"
        - if <player.flag[thirst]> = 6:
            - define bar "❤❤❤❤❤❤❤💚💚💚"
        - if <player.flag[thirst]> = 5:
            - define bar "❤❤❤❤❤❤❤💛💚💚"
        - if <player.flag[thirst]> = 4:
            - define bar "❤❤❤❤❤❤❤❤💚💚"
        - if <player.flag[thirst]> = 3:
            - define bar "❤❤❤❤❤❤❤❤💛💚"
        - if <player.flag[thirst]> = 2:
            - define bar "❤❤❤❤❤❤❤❤❤💚"
        - if <player.flag[thirst]> = 1:
            - define bar "❤❤❤❤❤❤❤❤❤💛"
        - if <player.flag[thirst]> <= 0:
            - define bar "❤❤❤❤❤❤❤❤❤❤"
        - determine <&color[#4e5c24]><[bar].font[custom]>

#_________________________________________________________DO NOT TOUCH THIS SCRIPT_________________________________________________________________

boiled_water:
    type: item
    material: potion
    display name: "<&f>Boiled Water"
    mechanisms:
        potion_effects:
            type: WATER
        hides: all
    lore:
        - "<&9>Food & Drinks"

cauldron_handler:
    type: world
    debug: false
    events:
        on player right clicks water_cauldron:
            - if <context.location.below.material.contains_text[switched=true]>:
                - if <player.item_in_hand.material.name.equals[glass_bottle]>:
                    - if <context.location.material.level> = 3:
                        - playsound <player> sound:ITEM_BOTTLE_FILL volume:100
                        - adjustblock <context.location> level:2
                    - else if <context.location.material.level> = 2:
                        - playsound <player> sound:ITEM_BOTTLE_FILL volume:100
                        - adjustblock <context.location> level:1
                    - else if <context.location.material.level> = 1:
                        - playsound <player> sound:ITEM_BOTTLE_FILL volume:100
                        - modifyblock <context.location> cauldron
                    - take iteminhand
                    - give boiled_water
                    - determine cancelled passively