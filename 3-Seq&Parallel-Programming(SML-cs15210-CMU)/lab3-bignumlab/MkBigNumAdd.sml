functor MkBigNumAdd(structure U : BIGNUM_UTIL) : BIGNUM_ADD =
struct
  structure Util = U
  open Util
  open Seq

  infix 6 ++

  datatype carry = GEN | PROP | STOP
  fun fn1 (a,b) = a  
  fun fn2 (a,b) = b
  fun x ++ y =
      let
        fun prestep (ONE,ONE) = (GEN,ONE)
          | prestep (ONE,ZERO) = (PROP,ONE)
          | prestep (ZERO,ONE) = (PROP,ONE)
          | prestep (ZERO,ZERO) = (STOP,ZERO)
        fun samelen (a,b) = 
          (if ((length a) >= (length b)) then 
            a
          else 
            append (a,(tabulate (fn i => ZERO) (length b - length a))) 
          )
        val a' = samelen(x,y)
        val b' = samelen(y,x)
        val bit1 = (map2 prestep a' b')

        fun copy ((GEN,_),(GEN,_))  =   (GEN,ZERO)
          | copy ((GEN,_),(PROP,ONE)) = (GEN,ZERO)
          | copy ((GEN,_),(PROP,ZERO))= (PROP,ONE)
          | copy ((GEN,_),(STOP,_)) =   (STOP,ONE)  
          | copy ((STOP,_),(GEN,_)) =   (GEN,ZERO)
          | copy ((STOP,ZERO),(PROP,_)) =(PROP,ZERO)
          | copy ((PROP,_),(GEN,_)) =   (GEN,ZERO)
          | copy (_,p) = p
        val fuckzhouyu = (scani copy (STOP,ZERO) bit1)
        val fuckwangshuai = map (fn (a,b) => if a = PROP then (PROP,ONE) else (a,b)) fuckzhouyu
        val secondresult = append(map (fn (i,(a,b))=>
                                    case a of 
                                    GEN =>
                                       (if(i>0) then 
                                          (
                                          case nth fuckwangshuai (i-1) of
                                            (GEN,_) => (
                                                        case nth bit1 i of 
                                                          (GEN,_) => ONE
                                                          | _ =>ZERO
                                                        )
                                            | _ => ZERO
                                          )
                                        else 
                                          b
                                        )
                                    | _ => b 
                                  )
            (enum fuckwangshuai), singleton (if length fuckwangshuai >=1 then 
                                        (case fn1 (nth fuckwangshuai ((length fuckwangshuai)-1)) of 
                                          GEN =>ONE 
                                          |_=> ZERO)
                                      else 
                                        ZERO)
                                          )
      in
        secondresult
      end


  val add = op++
end
