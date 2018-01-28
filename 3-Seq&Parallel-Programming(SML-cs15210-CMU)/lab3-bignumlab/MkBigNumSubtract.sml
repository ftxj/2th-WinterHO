functor MkBigNumSubtract(structure BNA : BIGNUM_ADD) : BIGNUM_SUBTRACT =
struct
  structure Util = BNA.Util
  open Util
  open Seq
  
  infix 6 ++ --

  fun x ++ y = BNA.add (x, y)
  fun x -- y =
    case (length x,length y) of
      (0,0) => empty ()
      |(_,0) => x
      |(m,n) =>
     let
      fun converse x' = map (fn x => if x = ONE then ZERO else ONE) x'
      val firres = if m>n then converse (append (y,tabulate (fn x => ZERO) (m-n-1))) else converse y
      val sec = append (firres,singleton(ONE))
      val fir = x
    in
      subseq (fir ++ sec ++ singleton (ONE)) (0,m)
    end
  val sub = op--
end
