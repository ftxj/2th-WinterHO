functor MkTableKGramStats(structure Util : SEQUENCE_UTIL
                          structure T : TABLE
                            where type Key.t = string Util.Seq.seq
                          sharing T.Seq = Util.Seq) : KGRAM_STATS =
struct
  structure Table = T
  structure Seq = T.Seq
  open Util
  open Seq

  type token = string
  type kgram = token seq  
  type kgramstats = ((token * int) seq) T.table * int 
  (*这样定义得话，这个类型为二元组，第一位为一个Table，key是一段字符串kgram，value是用key来预测得到的下一个单词结果的直方图。第二位存储maxK*)
  fun makeStats (corpus : string) (maxK : int) : kgramstats =
    let
      val words = tokens (fn c => not (Char.isAlphaNum c)) corpus
      fun subs k n = (subseq words (n, k), nth words (n+k))
      fun kgrams k = tabulate (subs k) (length words - k) (* subs k 为取长度为k的子串以及他接下来的单词*)
      val maxKgram =flatten (tabulate kgrams (maxK+1))
      val states = Table.collect maxKgram
    in 
      (Table.map (histogram String.compare) states, maxK)
    end

  fun lookupExts (stats : kgramstats) (kgram : kgram) : (token * int) seq =
    let 
      val a = #1 stats
      val result = Table.find a kgram
    in 
      case result of
        SOME x => x
        | NONE => empty()  
    end(* 注意这里要求的类型匹配*)

  fun maxK (stats : kgramstats) : int =
    #2 stats

end
