functor MkAllShortestPaths (Table : TABLE) : ALL_SHORTEST_PATHS =
struct
  open Table
  open Seq

  (* Remove the following when you're done! *)
  exception NYI
  type nyi = unit

  (* Table.key defines our vertex type *)
  type vertex = key
  type edge = vertex * vertex

  (* You must define the following two types and
   * explain your decision here with comments.
   *)
  type graph = Set.set table
  type asp = graph

  (* Task 2.1 *)
  fun makeGraph (E : edge seq) : graph =
    let
      val reverse = map (fn (a,b) => (b,Set.empty())) E
      val mapout = Table.map (Set.fromSeq) (Table.collect E)
      val mapin = Table.fromSeq reverse
    in 
      Table.merge (fn (a,b) => a) (mapout, mapin)
    end 

  (* Task 2.2 *)
  fun numEdges (G : graph) : int =
    let 
      fun add (a,b) = a + b
      val edgesnum = Table.reduce add 0 (Table.map Set.size G)
    in 
      edgesnum
    end

  fun numVertices (G : graph) : int =
    Table.size G

  (* Task 2.3 *)
  fun outNeighbors (G : graph) (v : vertex) : vertex seq =
    let
      val vkey = Table.find G v
    in 
      case vkey of
        NONE => Seq.empty()
        | SOME v => Set.toSeq v
    end 

  (* Task 2.4 *)
  fun makeASP (G : graph) (v : vertex) : asp =
    let
      fun logByBFS (visited,frontier) = 
        if Set.size frontier = 0 then visited 
        else
          let
            val newVisits = Seq.map (fn v =>(v,outNeighbors G v)) (Set.toSeq (frontier))
            val patchNewVisits = Table.collect (Seq.flatten (Seq.map (fn (v,n) => (Seq.map (fn vert => (vert,v))) n) (newVisits)))
            val fixNewVisits = Table.map Set.fromSeq patchNewVisits
            val nfrontier = Table.domain (Table.erase ((fixNewVisits),Table.domain(visited)))
            val nvisited = Table.merge (fn(i,j)=>i) ((visited),(fixNewVisits))
          in
            logByBFS (nvisited,nfrontier)
          end
    in
      logByBFS ((Table.singleton(v,Set.empty())),Set.singleton(v))
    end

  (* Task 2.5 *)
   fun report (A : asp) (v : vertex) : vertex seq seq =
    let 
      fun reportList vert =
        case outNeighbors A vert of firstVertexs =>
          if length firstVertexs = 0 then singleton([vert]) 
          else 
            let
              val frontPaths = Seq.map reportList firstVertexs
              fun nthfullPaths i = Seq.map (fn param =>vert::param) (nth frontPaths i)
            in 
              Seq.flatten(Seq.tabulate nthfullPaths (Seq.length firstVertexs))
            end
      val result =Seq.map Seq.rev (Seq.map Seq.fromList (reportList v))
    in
      result
    end
end
