MarkLocation_command:
    type: command
    name: marklocation
    usage: /marklocation
    debug: false
    description: Mark a location
    tab complete:
    - determine there|here
    aliases:
    - mark
    script:
        - define args <context.args>

        - if <[args].size> == 0:
            - stop

        - define subcommand <[args].get[1]>
        - choose <[subcommand]>:
            - case here:
                - define location <player.location>
                - define players <player.location.find_players_within[24]>
                - debugblock <[location]> players:<[players]> d:10s color:<green>
            - case there:
                - define location <player.cursor_on>
                - define players <player.location.find_players_within[24]>
                - debugblock <player.cursor_on> d:10s players:<[players]> color:<red>