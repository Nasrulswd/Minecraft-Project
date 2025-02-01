disable_place_backpack:
    type: world
    debug: false
    events:
        on player places BackPackItem:
            - determine cancelled

BackPackItem:
    type: item
    display name: <&f>Backpack
    material: player_head
    allow in material recipes: true
    mechanisms:
        skull_skin: 538900a6-9df8-4e72-97b7-aa97afd37658|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvODM1MWU1MDU5ODk4MzhlMjcyODdlN2FmYmM3Zjk3ZTc5NmNhYjVmMzU5OGE3NjE2MGMxMzFjOTQwZDBjNSJ9fX0=
    flags:
        noplace: 0
        uuid: <util.random_uuid>
    recipes:
        1:
            type: shaped
            input:
            - leather|leather|leather
            - iron_ingot|*_planks|iron_ingot
            - iron_ingot|*_planks|iron_ingot

BackPackInventory:
    type: inventory
    inventory: chest
    title: Backpack
    size: 54
    gui: false
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []


backpackhandler:
    type: world
    events:
        on player crafts BackPackItem:
            - determine BackPackItem

        on player right clicks block with:BackPackItem:
            - if <player.item_in_hand.has_flag[BackPack]>:
                - inventory open d:BackPack_<context.item.flag[uuid]>
            - else:
                - inventory flag slot:hand BackPack
                - note <inventory[BackPackInventory]> as:BackPack_<context.item.flag[uuid]>
                - wait 1t
                - inventory open d:BackPack_<context.item.flag[uuid]>

        on player clicks BackPackItem in inventory:
            - if <player.open_inventory.note_name.exists>:
                - determine cancelled