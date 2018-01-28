functor MkBoruvkaSegmenter
  (structure Seq : SEQUENCE
   structure Rand : RANDOM210
   sharing Seq = Rand.Seq)
  : SEGMENTER =
struct
  structure Seq = Rand.Seq
  open Seq
  structure R = Rand
  type vertex = int
  type weight = int
  type edge = vertex * vertex * weight

  fun revcmp (a, b) = if a > b then LESS else GREATER
  (*注意inject函数，与书中讲述是相反的，即 应该这样用 inject <(0,2),(1,3)> <1,2,3>*)
  fun findSegments (E, n) initial_credit =
    let
      (*初始化的节点，n是图中节点数*)
      val init_verts = tabulate (fn i => i )n
      (*初始化每个点的额度*)
      val init_creds = tabulate (fn _ => initial_credit) n
      (*初始化便于inject的边，按weight从大到小排，按有向图来考虑*)
      val init_edges = map (fn (a,b,c) => (a,(b,c))) (sort (fn ((_,_,w1),(_,_,w2)) => (revcmp(w1,w2))) E)

      fun Creed_BoruvkaMST (Vs,Es,C) s =
        let
          (*撒点*)
          val coins = Rand.flip s n
          (*判断是否为TailHead类型*)
          fun isTH (s,(d,w)) = (nth coins s = 0) andalso (nth coins d = 1) 
          (*取得每个点发出的最短边*)
          val minEs = filter (fn (_,(a,_))=> a >= 0) (enum (inject Es (tabulate (fn _ => (~1,~1)) n)))
          (*作为收缩对象的边，要满足两个条件，head与tail撒点筛选条件以及light_edge条件*)
          val contractions = filter isTH minEs 
          (*要删除的边，以（s,d）格式返回*)
          val conts = map (fn (s,(d,_))=>(s,d)) contractions
          (*收缩点*)
          val V' = inject conts Vs
          (*以上部分与MST相似*)

          (*得到收缩后点与他周围的点集 (1,((2,3),(3,4))) 这种形式*)
          val vert = collect Int.compare (map (fn (s,(d,w))=>(d,(s,w))) contractions)
          (*计算每个收缩后节点周围的总weight*) 
          val tolweight = map (fn (d,p) => (d,reduce op+ 0 (map (fn (_,w)=>w) p))) vert
          (*得到要收缩点的最小额度 （点，额度）这种形式返回*)
          val minCreds = map (fn (d,p) => (d,(Int.min(nth C d, reduce Int.min initial_credit (map (fn (s,w)=>nth C s) p))))) vert
          (*更新额度*)
          val updCreds = inject minCreds C
          (*计算收缩后减去权值后的额度并更新，得到最终额度*)
          val finalCreds = inject (map (fn (d,delt)=>(d,nth updCreds d - delt)) tolweight) updCreds 
          (*更新边,将收缩点的信息带入边中*)
          val E' =filter (fn (s,(d,_)) => s<>d) (map (fn (s,(d,w)) => ((nth V' s),(nth V' d,w))) Es)
          (*根据pdf中提示 for every edge uv, keep it in the graph iff min(c u ,c v )−w uv ≥ 0,and remove it otherwise*)
          val finalE = filter (fn (s,(d,w))=> w < nth finalCreds s andalso w < nth finalCreds d) E'
        in 
          if (length Es = 0) then V' else Creed_BoruvkaMST (V',finalE,finalCreds) (Rand.next s)
        end
      val res = Creed_BoruvkaMST (init_verts,init_edges,init_creds) (Rand.fromInt 19)
  in
      res
  end
end