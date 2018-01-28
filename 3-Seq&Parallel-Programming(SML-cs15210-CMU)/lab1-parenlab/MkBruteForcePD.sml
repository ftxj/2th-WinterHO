functor MkBruteForcePD(structure P : PAREN_PACKAGE) : PAREN_DIST =
struct
  structure P = P
  open P
  open Seq

  (* Remove this line when you're done. *)
  fun parenMatch p = 
    let 
      fun pm ((NONE , _) | (SOME 0, CPAREN)) = NONE 
        | pm (SOME c, CPAREN) = SOME (c-1) 
        | pm (SOME c, OPAREN) = SOME (c+1) 
      in 
        iter pm (SOME 0) p = (SOME 0) 
      end

  fun distance (_,[],(SOME len)) = NONE
    | distance (1,CPAREN::P,(SOME len)) = (SOME (len+1))
    | distance (0,CPAREN::P,(SOME len)) = NONE 
    | distance (i,OPAREN::P,(SOME len)) = distance(i+1,P,(SOME (len +1)))
    | distance (i,CPAREN::P,(SOME len)) = distance(i-1,P,(SOME (len +1)))
    | distance (_,_,_) = NONE

  fun parenDist (parens : paren seq) : int option =
    let
      val n = length(parens)
      val listit = (tabulate (fn i => i) n)
      fun rewrite (NONE,i) = distance(0,toList(subseq parens (i,n-i)),(SOME 0))
        | rewrite ((SOME max),i) = Option210.intMax((SOME max),distance(0,toList(subseq parens (i,n-i)),(SOME 0)))
    in
      case (iter rewrite NONE listit,(parenMatch parens))
        of (_,false) => NONE
        | (NONE,_) => NONE
        | (SOME max,_) => (SOME (max - 2))
    end
end