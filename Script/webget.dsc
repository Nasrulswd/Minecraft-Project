webget_task:
    type: task
    script:
    - ~webget https://api.mojang.com/users/profiles/minecraft/<player.name> save:request
    - yaml loadtext:<entry[request].result> id:player_data