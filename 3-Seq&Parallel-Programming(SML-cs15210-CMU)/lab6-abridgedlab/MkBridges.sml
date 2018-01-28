functor MkBridges(structure STSeq : ST_SEQUENCE) : BRIDGES =
struct
  structure Seq = STSeq.Seq
  open Seq

  type vertex = int
  type edge = vertex * vertex
  type edges = edge seq

  (* Remove these two lines before submittting. *)
  exception NotYetImplemented

  type ugraph = (vertex seq) seq 
  (*以索引作为key值，代表vertex，每一项代表相邻的vertex，因为这个图是整数代表vertex的*)

  fun makeGraph (E : edge seq) : ugraph = 
    let
      val reverse = map (fn (a,b) => (b,a)) E
      val uedges = append (E,reverse)
      val result = collect Int.compare uedges
    in 
      map (fn (a,b) => b) result
    end

(*(u,v)是bridge的充要条件是在DFStree中v以及v的子树没有其他方法到达u*)
  fun findBridges (G : ugraph) : edges = 
    let
      fun min(a,b) = case (a,b) of (SOME x, SOME y) => if x > y then SOME y else SOME x
      val bridges = empty()
      val low = STSeq.fromSeq (tabulate (fn i => NONE) (length G))
      val pre = STSeq.fromSeq (tabulate (fn i => NONE) (length G))
      val nodes = tabulate (fn i => (i,i)) (length G)
      fun bridge_dfs ((bridges, pre, low, time), (u,v)) =
        let
          val time' = time + 1
          val pre' = STSeq.update (v, SOME time') pre
          val low' = STSeq.update (v, SOME time') low
          val neighbors = nth G v 
        in
          iter
           (
            fn ((bridges,pre',low',time'),w) => 
              case (STSeq.nth pre' w) of 
                NONE => let 
                          val (bridges', pre'', low'', time') = bridge_dfs ((bridges, pre', low',time'), (v,w))
                          val newlow'' = STSeq.update (v, min(STSeq.nth low'' v, STSeq.nth low'' w)) low''
                        in
                          if (STSeq.nth newlow'' w) = (STSeq.nth pre'' w) then 
                            (append(bridges', singleton (v,w)), pre'', newlow'', time') 
                          else (bridges', pre'', newlow'',time')
                        end 
                |_ => if (w <> u) then 
                        let 
                          val low'' = STSeq.update (v, min(STSeq.nth low' v, STSeq.nth pre' w)) low'
                        in 
                          (bridges, pre', low'',time') 
                        end
                      else 
                        (bridges, pre', low', time')
           )
           (bridges,pre',low',time') neighbors
        end 
    in
      #1 (iter bridge_dfs (bridges, pre, low, 0) nodes)
    end

end
