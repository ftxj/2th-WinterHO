functor MkBoruvkaMST (structure Seq : SEQUENCE
                      structure Rand : RANDOM210
                      sharing Seq = Rand.Seq) : MST =
struct
  structure Seq = Rand.Seq
  open Seq

  type vertex = int
  type weight = int
  type edge = vertex * vertex * weight

  (* Remove this exception when you're done! *)
  exception NotYetImplemented
  fun revcmp (a, b) = if a > b then LESS else GREATER

  fun MST (E : edge seq, n : int) : edge seq =
    let
      
      fun mst(V,E,T) s =
        let
          (*撒点*)
          val coins = Rand.flip s n
          (*判断是否满足tail head条件*)
          fun isTailHead (u,(v,l)) = (nth coins u = 0) andalso (nth coins v = 1)
          (*取得每个点发出的最短边*)
          val minEs = filter (fn (_,(a,_))=> a >= 0) (enum (inject E (tabulate (fn _ => (~1,~1)) n)))
          (*作为收缩对象的边，要满足两个条件，head与tail撒点筛选条件以及light_edge条件*)
          val contractions = filter isTailHead minEs
          (*要删除的边，以（s,d）格式返回*)
          val conts = map (fn (s,(d,_))=>(s,d)) contractions

          val V' = inject conts V
          val T' = append ((map (fn (s,(d,w)) => (s,d,w)) contractions),T)
          val E' = filter (fn (s,(d,_))=> s <> d) (map (fn (s,(d,w)) => ((nth V' s),(nth V' d,w))) E)
        in 
          if (length E = 0) then T else mst (V',E',T') (Rand.next s)
        end
      val init_E = map (fn (s,d,w)=>(s,(d,w))) (sort (fn ((s1,d1,w1),(s2,d2,w2))=> (revcmp (w1,w2))) E)
      val init_V = tabulate (fn i => i) n
      val init_T = empty()
    in
      mst (init_V,init_E,init_T) (Rand.fromInt 19)
    end 
    (*raise NotYetImplemented*)

end
