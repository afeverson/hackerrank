#!/bin/python
def calculate_bid(player,pos,first_moves,second_moves):
    if player == 1:
        e = 10
        m = 100 - sum(first_moves)
        o = 100 - sum(second_moves)
    else:
        e = 0
        m = 100 - sum(second_moves)
        o = 100 - sum(first_moves)
    delt = abs(e-pos)
    md = m - o
    
    return max(min(delt*2, m),1)



#gets the id of the player
player = input()
scotch_pos = int(raw_input())     #current position of the scotch
first_moves = map(int, raw_input().split())
second_moves = map(int, raw_input().split())

bid = calculate_bid(player,scotch_pos,first_moves,second_moves)
print bid
