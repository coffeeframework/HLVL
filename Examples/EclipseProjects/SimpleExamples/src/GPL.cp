model GPL
variables:
boolean GPL
boolean GType 
boolean Weight 
boolean Search 
boolean Algorithms 
boolean Directed 
boolean Undirected 
boolean Weighted 
boolean Unweighted 
boolean BFS 
boolean DFS 
boolean Kruskal 
boolean CycleCheck 
boolean StronglyCon 
boolean VertexNum 
boolean ConnComp 
boolean SSP 
boolean Prim 
boolean MST 
constraints:
C_GPL : GPL = 1
c2: GPL = GType
c3: GPL = Algorithms
c4: GPL >= Weight
c5: GPL >= Search
c6: (Directed => GType) AND
(Undirected => GType) AND
(GType>= 1) => (Directed+Undirected >= 1) AND
(GType>= 1) => (Directed+Undirected <= 1) 
c7: (Weighted => Weight) AND
(Unweighted => Weight) AND
(Weight>= 1) => (Weighted+Unweighted >= 1) AND
(Weight>= 1) => (Weighted+Unweighted <= 1) 
c8: (BFS => Search) AND
(DFS => Search) AND
(Search>= 1) => (BFS+DFS >= 1) AND
(Search>= 1) => (BFS+DFS <= 1) 
c9: (CycleCheck => Algorithms) AND
(StronglyCon => Algorithms) AND
(VertexNum => Algorithms) AND
(ConnComp => Algorithms) AND
(SSP => Algorithms) AND
(Algorithms>= 1) => (CycleCheck+StronglyCon+VertexNum+ConnComp+SSP >= 0) AND
(Algorithms>= 1) => (CycleCheck+StronglyCon+VertexNum+ConnComp+SSP <= 5) 
C92: Algorithms = MST
cNew: (Kruskal => MST) AND
(Prim => MST) AND
(MST>= 1) => (Kruskal+Prim >= 0) AND
(MST>= 1) => (Kruskal+Prim <= 2) 
c10: CycleCheck => DFS
c11: StronglyCon => Directed
c12: StronglyCon => DFS
c13: VertexNum => Search
c14: ConnComp => Undirected
c15: Kruskal => Undirected
c16: Kruskal => Weighted
c17: Prim => Undirected
c18: Prim => Weighted
c19: SSP => Directed
c20: SSP => Weighted
c21: StronglyCon + ConnComp<= 1
c22: StronglyCon + Kruskal<= 1
c23: StronglyCon + Prim<= 1
c24: SSP + ConnComp<= 1
c25: SSP + Kruskal<= 1
c26: SSP + Prim<= 1
