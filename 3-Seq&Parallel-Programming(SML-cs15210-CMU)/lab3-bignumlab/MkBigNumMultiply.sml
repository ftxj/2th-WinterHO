functor MkBigNumMultiply(structure BNA : BIGNUM_ADD
                         structure BNS : BIGNUM_SUBTRACT
                         sharing BNA.Util = BNS.Util) : BIGNUM_MULTIPLY =
struct
  structure Util = BNA.Util
  open Util
  open Seq
  open Primitives


  infix 6 ++ --
  infix 7 **

  fun x ++ y = BNA.add (x, y)
  fun x -- y = BNS.sub (x, y)
  fun Multi x y =
    case (length x,length y) of
      (0,_) => empty ()
      |(_,0) => empty ()
      |(1,1) => if nth x 0 = ZERO orelse nth y 0 = ZERO then singleton (ZERO) else singleton (ONE)
      |(m,n) => 
      let
        val A = if m>n orelse m=n then x else y 
        val B = if m>n orelse m=n then append (y,tabulate (fn x => ZERO) (m-n)) else append (x,tabulate (fn x => ZERO) (n-m))
        val len = length A
        val mid = len div 2
        val temp = tabulate (fn x => ZERO) len
        fun cut x' = (subseq x' (0,len div 2) , subseq x' (len div 2,len - (len div 2)))
        val (p,q) = cut A
        val (r,s) = cut B
        val (a,b,c) = par3 (
            fn _ => Multi p r,
            fn _ => Multi p s ++ Multi q r,
            fn _ => Multi q s 
            )

        val result = append (subseq temp (0,mid + mid),c) ++ append (subseq temp (0,mid),b) ++ a
      in
        result
      end
  fun x ** y = Multi x y 
  val mul = op**
end
