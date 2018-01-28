functor MkDivideAndConquerPD(structure P : PAREN_PACKAGE) : PAREN_DIST =
struct
  structure P = P
  open Primitives
  open P
  open Seq

  fun Max(x,y) = if x>y then x else y

  fun parenDist (parens : paren seq) : int option =
  	let
  		fun pd s = 
  			case showt s of
  				EMPTY => SOME (0,0,0,0,0,0)
  				| ELT OPAREN=> SOME (0,0,1,0,0,0)
  				| ELT CPAREN=> SOME (0,1,0,0,0,0)
  				| NODE (L,R) => let
        				  					val ((SOME (max1,L1,R1,BL1,MID1,BR1)),(SOME (max2,L2,R2,BL2,MID2,BR2))) = par(fn ()=> pd L,fn ()=> pd R)
        				  				in
        				  					if R1>L2 then
                              case (L1,R2) of
                                (0,0) =>SOME(Max(Max(max1,max2),2*L2+BR1+BL2),L1,R1+R2-L2,BL1+MID1,0,BR1+BL2+2*L2+MID2+BR2) 
                                | (0,_) =>SOME(Max(Max(max1,max2),2*L2+BR1+BL2),L1,R1+R2-L2,BL1+MID1,0,BR1+BL2+MID2+2*L2+BR2) 
                                | (_,0) =>SOME(Max(Max(max1,max2),2*L2+BR1+BL2),L1,R1+R2-L2,BL1,MID1,BR1+BL2+2*L2+MID2+BR2) 
                                | (_,_) =>SOME(Max(Max(max1,max2),2*L2+BR1+BL2),L1,R1+R2-L2,BL1,MID1,BR1+BL2+2*L2+MID2+BR2) 
        				  					else if R1<L2 then 
                              case (L1,R2) of
                                (0,0) =>SOME(Max(Max(max1,max2),2*R1+BR1+BL2),L1+L2-R1,R2,BL1+MID1+2*R1+BR1+BL2,0,MID2+BR2) 
                                | (0,_)=>SOME(Max(Max(max1,max2),2*R1+BR1+BL2),L1+L2-R1,R2,BL1+MID1+2*R1+BR1+BL2,MID2,BR2) 
                                | (_,0)=>SOME(Max(Max(max1,max2),2*R1+BR1+BL2),L1+L2-R1,R2,BL1+MID1+2*R1+BR1+BL2,0,MID2+BR2)  
                                | (_,_) =>SOME(Max(Max(max1,max2),2*R1+BR1+BL2),L1+L2-R1,R2,BL1+MID1+2*R1+BR1+BL2,MID2,BR2) 
                            else 
                              case (L1,R2) of
                                (0,0) => SOME(Max(Max(max1,max2),2*R1+BR1+BL2),0,0,BL1+BR2+BL2+2*R1+BR1+MID1+MID2,0,0)     
                                | (0,_) =>SOME(Max(Max(max1,max2),2*R1+BR1+BL2),L1,R2,BL1+BR1+BL2+2*R1+MID1+MID2,0,BR2) 
                                | (_,0) =>SOME(Max(Max(max1,max2),2*R1+BR1+BL2),L1,R2,BL1,0,MID1+MID2+BR1+BL2+2*R1+BR2) 
                                | (_,_) =>SOME(Max(Max(max1,max2),2*R1+BR1+BL2),L1,R2,BL1,MID1+2*R1+BR1+BL2+MID2,BR2) 
        				  				end
  	in
      if length(parens)<>0 then
    		(case pd parens of
    			SOME (max,0,0,_,_,_) => SOME (max-2)
    			| _ => NONE)
      else NONE
  	end	
end
