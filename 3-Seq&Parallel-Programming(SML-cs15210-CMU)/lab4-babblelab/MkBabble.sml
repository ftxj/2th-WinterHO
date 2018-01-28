functor MkBabble(structure R :  RANDOM210
                 structure KS : KGRAM_STATS
                 structure Util : SEQUENCE_UTIL
                 sharing KS.Seq = Util.Seq
                 sharing KS.Seq = R.Seq) : BABBLE =
struct
  structure Rand = R
  structure Stats = KS
  open Stats.Seq

  exception NoData

(*使用k-gram算法，第k+1个word由前k个决定（这里用的是小于k的，处理一些比较小的情况）*)
  fun randomSentence (stats : KS.kgramstats) (n : int) (seed : R.rand) =
    let
      val randomPro  = Rand.randomRealSeq seed (SOME (0.0, 1.0)) n 
      val randomInit = Rand.randomRealSeq seed NONE 1
      fun next ((sentence, gram),ranPro) = 
        case KS.lookupExts stats gram 
          of temp => if (length temp) = 0 then next ((sentence, drop(gram,1)),ranPro)
                  else (append(sentence, singleton(Util.choose temp ranPro)), append(gram, singleton(Util.choose temp ranPro))) 
      val words = case iter next (singleton(" "), empty()) randomPro of (s,_) => s       
    in
      String.concatWith " " (toList words)
    end

  fun randomDocument (stats : KS.kgramstats) (n : int) (seed : R.rand) =
    let
      val lenPro = Rand.randomIntSeq seed (SOME(5, 10)) n
      val seedPro = map Rand.fromInt (Rand.randomIntSeq seed NONE n)
      val sentenceSeq = map2 (fn (len, seqseed) => randomSentence stats len seqseed) lenPro seedPro
    in
      String.concatWith "\n" (toList sentenceSeq)
    end
end
