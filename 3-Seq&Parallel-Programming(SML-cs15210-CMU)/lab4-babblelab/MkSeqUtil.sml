functor MkSeqUtil(structure S : SEQUENCE) : SEQUENCE_UTIL =
struct
  structure Seq = S
  open Seq

  type 'a hist = ('a * int) seq

  fun tokens (cp : char -> bool) (str : string) : string seq =
    let
      val n = String.size str
      val chars = tabulate (fn i => (i, String.sub (str, i))) n
      val idx = map (fn (i,_) => i) (filter (fn (_,c) => cp c) chars)
      (* idx为cp为ture的全体id *)
      (* grab substrings in between delimiters *)
      val subs = map2 (fn (i,i') => String.substring (str, i, i' - i))
                      (append (singleton 0, map (fn i => i + 1) idx))
                      (append (idx, singleton n))
      (* subs 为cp 为false的连续string *)
    in filter (fn s => size s > 0) subs
      (* 返回maximal non-empty substrings of s containing no character c for which cp(c) evaluates to true *)
    end

  fun histogram (cmp : 'a ord) (s : 'a seq) : 'a hist =
    map (fn (a, c) => (a, length c))
        (collect cmp (map (fn a => (a, ())) s))
  (* 返回概率密度直方图 *)

  fun choose (hist : 'a hist) (p : real) : 'a =
    let 
      fun add (a,b) = a + b
      val every = scani add 0 (map (fn (_,b) => b) hist)
      val pro = map (fn c => (real c / real (nth every ((length every)-1)))) every (*求得概率*)
      val (_,idx) = scan add 0 (map (fn b => if b < p then 1 else 0) pro)
    in
      nth (map (fn (a,_) => a) hist) idx
    end
end
