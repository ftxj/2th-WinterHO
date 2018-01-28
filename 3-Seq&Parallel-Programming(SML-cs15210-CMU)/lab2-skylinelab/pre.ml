let
  		fun minMax ((x,h),(x',h')) =
  			if x=x' then 
  				(x,Int.max(h,h'))
  			else 
  				(
  					if (x<x' andalso h=h') then 
	  					(x,h)
	 				else
	 					(
	 					if (x>x' andalso h=h') then 
	 						(x',h')
	 					else
	 						(0,0)
	 					)
 				)


  		fun addone i f (x,h) =
  			if i > length f then 
  				append (f,singleton (x,h))
  			else
  				(
  					case minMax ((nth f i),(x,h)) of
  						(0,0) => (addone (i+1) f (x,h))
  						| (x',h') => (inject (singleton(i,(x',h'))) f)
  				)

  		fun conquer f b = 
  			case length f of
				0 => b
				| _ => 
					(
						case length b of 
			 	 			0 => f 
			  				| _ =>	(let
			  							fun add s (x,h) = addone 0 f (x,h)
			  						in 
			  							iter add f b
			  						end)
			  		)