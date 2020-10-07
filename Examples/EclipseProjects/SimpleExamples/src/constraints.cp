model constraints
variables:
integer A domain: 1..5
integer B domain: 1..5
integer D domain: [2,3,4] 
boolean E domain: [true,false]
boolean C
boolean F
constraints:
c1: A+B > D
c2: C AND F




