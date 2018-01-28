functor MkThesaurusASP (ASP : ALL_SHORTEST_PATHS where type vertex = string)
  : THESAURUS =
struct
  structure Seq = ASP.Seq
  open Seq

  (* Remove the following two lines when you're done! *)
  exception NYI
  type nyi = unit

  (* You must define the following type and
   * explain your decision here with a comment.
   *)
  type thesaurus = ASP.graph

  (* Task 3.1 *)
  fun make (S : (string * string seq) seq) : thesaurus =
    let 
      val edges = Seq.flatten (Seq.map (fn (key,values) => (Seq.map (fn value => (key,value)) values)) S)
    in
      ASP.makeGraph edges
    end 

  (* Task 3.2 *)
  fun numWords (T : thesaurus) : int =
    ASP.numVertices T

  fun synonyms (T : thesaurus) (w : string) : string seq =
    ASP.outNeighbors T w

  (* Task 3.3 *)
  fun query (T : thesaurus) (w1 : string) (w2 : string) : string seq seq =
    let 
      val w1Asp = ASP.makeASP T w1
      val result = ASP.report w1Asp w2
    in
      result
    end

end
