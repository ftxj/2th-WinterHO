functor MkAStarCore(structure Table : TABLE
                    structure PQ : PQUEUE
                      where type Key.t = real) : ASTAR =
struct
  structure Set = Table.Set
  structure Seq = Set.Seq
  open Seq
  type weight = real
  type vertex = Set.key
  type edge = vertex * vertex * weight
  type heuristic = vertex -> real

  (* Uncomment this line once you're done *)
  exception NotYetImplemented

  (* Define this type yourself *)
  type graph = weight Table.table Table.table 

  fun makeGraph (E : edge Seq.seq) : graph = 
    let
      val edgeTable = map (fn (a,b,w) => (a,(b,w))) E
      val vertexTable = Table.collect edgeTable
    in 
      Table.map Table.fromSeq vertexTable 
    end

  fun findPath h G (S, T) = 
    let
      fun N(v) =
            case Table.find G v
              of NONE => Table.empty ()
               | SOME nbr => nbr

(*D: table that stores final results*)
(*Q: tmp results in pq*)

      fun dijkstra' D Q =
            case PQ.deleteMin Q
              of (NONE, _) => NONE
               | (SOME (d, v), Q') => 
                 if Set.find T v then SOME(v,d) else 
                   case Table.find D v
                     of SOME _ => dijkstra' D Q'
                      | NONE =>
                        let
                          val insert = Table.insert (fn (x,_) => x)
                          val D' = insert (v, d) D
                          fun relax (q, (u, w)) = PQ.insert (d + w + (h u) - (h v), u) q
                          val Q'' = Table.iter relax Q' (N v)
                        in 
                          dijkstra' D' Q''
                        end
      val sourcespq = (PQ.fromList o toList o map (fn x=>(0.0+ h x, x)) o Set.toSeq) S
    in 
      dijkstra' (Table.empty()) sourcespq
    end

end
