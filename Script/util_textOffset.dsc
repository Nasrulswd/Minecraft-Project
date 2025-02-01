util_textOffset:
    type: procedure
    debug: false
    definitions: int
    script:
    - if !<[int].exists>:
        - determine "<&c>integer doesn't exists<&f>"
        - stop

    - if <[int].contains_text[-]>:
        - define variable <[int].split[-]>
        - if !<[variable].last.is_integer>:
            - determine "<&c><[int]> isn't integer<&f>"
        - define int <[variable].last>
        - while <[int]> > 0:
            - if <[int]> >= 1024:
                - define int:-:1024
                - define spacing:->:<&chr[F80E]>
            - else if <[int]> >= 512:
                - define int:-:512
                - define spacing:->:<&chr[F80D]>
            - else if <[int]> >= 128:
                - define int:-:128
                - define spacing:->:<&chr[F80C]>
            - else if <[int]> >= 64:
                - define int:-:64
                - define spacing:->:<&chr[F80B]>
            - else if <[int]> >= 32:
                - define int:-:32
                - define spacing:->:<&chr[F80A]>
            - else if <[int]> >= 16:
                - define int:-:16
                - define spacing:->:<&chr[F809]>
            - else if <[int]> >= 8:
                - define int:-:8
                - define spacing:->:<&chr[F808]>
            - else if <[int]> >= 7:
                - define int:-:7
                - define spacing:->:<&chr[F807]>
            - else if <[int]> >= 6:
                - define int:-:6
                - define spacing:->:<&chr[F806]>
            - else if <[int]> >= 5:
                - define int:-:5
                - define spacing:->:<&chr[F805]>
            - else if <[int]> >= 4:
                - define int:-:4
                - define spacing:->:<&chr[F804]>
            - else if <[int]> >= 3:
                - define int:-:3
                - define spacing:->:<&chr[F803]>
            - else if <[int]> >= 2:
                - define int:-:2
                - define spacing:->:<&chr[F802]>
            - else:
                - define int:-:1
                - define spacing:->:<&chr[F801]>

    - else:
        - if !<[int].is_integer>:
            - determine "<&c><[int]> isn't integer<&f>"
        - while <[int]> > 0:
            - if <[int]> >= 1024:
                - define int:-:1024
                - define spacing:->:<&chr[F82E]>
            - else if <[int]> >= 512:
                - define int:-:512
                - define spacing:->:<&chr[F82D]>
            - else if <[int]> >= 128:
                - define int:-:128
                - define spacing:->:<&chr[F82C]>
            - else if <[int]> >= 64:
                - define int:-:64
                - define spacing:->:<&chr[F82B]>
            - else if <[int]> >= 32:
                - define int:-:32
                - define spacing:->:<&chr[F82A]>
            - else if <[int]> >= 16:
                - define int:-:16
                - define spacing:->:<&chr[F829]>
            - else if <[int]> >= 8:
                - define int:-:8
                - define spacing:->:<&chr[F828]>
            - else if <[int]> >= 7:
                - define int:-:7
                - define spacing:->:<&chr[F827]>
            - else if <[int]> >= 6:
                - define int:-:6
                - define spacing:->:<&chr[F826]>
            - else if <[int]> >= 5:
                - define int:-:5
                - define spacing:->:<&chr[F825]>
            - else if <[int]> >= 4:
                - define int:-:4
                - define spacing:->:<&chr[F824]>
            - else if <[int]> >= 3:
                - define int:-:3
                - define spacing:->:<&chr[F823]>
            - else if <[int]> >= 2:
                - define int:-:2
                - define spacing:->:<&chr[F822]>
            - else:
                - define int:-:1
                - define spacing:->:<&chr[F821]>

    - determine <[spacing].unseparated>
