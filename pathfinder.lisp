; Pathfinder is a searching agent with minor reflexive behavior:
; - if standing on dirt, always clean (reflex)
; - if no instruction list is available, build one
; -- create list of dirt locations (represented by two-element lists)
; -- create permutations
; -- for each permutation, generate instruction list, minimizing the path length
; -- the winning instruction list is our instruction list
; - pop the next instruction from the list
