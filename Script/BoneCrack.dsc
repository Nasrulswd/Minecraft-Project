bone_crack:
  type: world
  debug: false
  events:
    after player respawns:
      - flag <player> bonecrack:!
    on player damaged by fall:
    - define falldamage <context.entity.fall_distance>
    - if <[falldamage]> > 7:
        - flag <player> bonecrack expire:6s
        - cast JUMP duration:6s amplifier:250 hide_particles no_ambient no_icon
        - cast slow duration:6s amplifier:3 hide_particles no_ambient no_icon
