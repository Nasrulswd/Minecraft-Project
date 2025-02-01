armored-bot:
    type: task
    debug: false
    script:

        - create player Dummy save:armored <player.location>
        - define npc <entry[armored].created_npc>
        - lookclose <[npc]> state:true range:20 realistic

        - equip <[npc]> head:helmet-armor
        - equip <[npc]> chest:vest-armor

        - flag <[npc]> health:100
