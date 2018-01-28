functor MkSkyline(structure S : SEQUENCE) : SKYLINE =
struct
  structure Seq = S
  open Primitives
  open Seq

  (* Remove this line when you're done. *)
  datatype lar = LEFT | RIGHT
  fun skyline (buildings : (int * int * int) seq) : (int * int) seq =
  	let 
      fun conquer (L,R) = 
        let 
           
          val L' = map (fn (x,h)=>(x,h,LEFT)) L
          val R' = map (fn (x,h)=>(x,h,RIGHT)) R 
          fun cmp3 ((x,_,_),(x',_,_)) = if x<x' then LESS else if x=x' then EQUAL else GREATER
          val lhr = merge cmp3 L' R'
          fun copyright ((x,h,w),(x',h',w'))= 
            case w' of
              RIGHT => (x',h',w')
              |_ => (x',h,w)
          fun copyleft ((x,h,w),(x',h',w'))= 
            case w' of
              LEFT => (x',h',w')
              |_ => (x',h,w)
          val rs = scani copyright (0,0,RIGHT) lhr
          val ls = scani copyleft (0,0,LEFT) lhr
          val rr = map2 (fn ((x,h,_),(x',h',_))=> if h>h' then (x',h) else (x',h')) rs lhr
          val lr = map2 (fn ((x,h,_),(x',h',_))=> if h>h' then (x',h) else (x',h')) ls lhr
          val r = map2 (fn((x,h),(x',h')) => if h'>h then (x,h') else (x,h)) rr lr
          fun isUniq (0, _) = true
            | isUniq (i, (x,h)) = let val (x',h') = nth r (i-1) in h'<> h end
        in
          filterIdx isUniq r
        end 

    in
  		case length buildings of
        0 => empty()
        | 1 =>  let 
                  val (x,h,r) = nth buildings 0
            
                in 
                  fromList [(x,h),(r,0)]
                end
        | n =>        
                let 
                  val half = n div 2
                  val (L,R) = par
                              (
                                fn ()=> skyline(take(buildings,half)) , 
                                fn ()=> skyline(drop(buildings,half))
                              )
                in 
                  conquer(L,R)
                end     
  	end
end
