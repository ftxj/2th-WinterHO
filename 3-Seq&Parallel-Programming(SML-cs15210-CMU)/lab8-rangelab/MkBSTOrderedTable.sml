functor MkBSTOrderedTable (structure Tree : BSTREE
                           structure Seq : SEQUENCE) : ORD_TABLE =
struct

  structure Table = MkBSTTable(structure Tree = Tree
                               structure Seq = Seq)

  (* Include all the functionalities of the standard Table *)
  open Table

  (* This is defined after "open" so it doesn't get overwritten *)
  structure Key = Tree.Key
  type key = Key.t

  (* Remember, type 'a table = 'a Tree.bst *)

  (* Remove this line before submitting! *)
  exception NYI

  fun first (T : 'a table) : (key * 'a) option =
    case (Tree.expose T) of 
      NONE => NONE
      | SOME ({left,key,value,right})
        => case (Tree.expose left) of NONE
          => SOME (key,value)
          | _ => first left

  fun last (T : 'a table) : (key * 'a) option =
     case (Tree.expose T) of 
      NONE => NONE
      | SOME ({left,key,value,right})
        => case (Tree.expose right) of NONE
          => SOME (key,value)
          | _ => last right

  fun previous (T : 'a table) (k : key) : (key * 'a) option =
    last(#1 (Tree.splitAt (T,k)))

  fun next (T : 'a table) (k : key) : (key * 'a) option =
    first(#3(Tree.splitAt (T,k)))

  fun join (L : 'a table, R : 'a table) : 'a table =
    Tree.join (L,R)

  fun split (T : 'a table, k : key) : 'a table * 'a option * 'a table =
    Tree.splitAt(T,k)

  fun getRange (T : 'a table) (low : key, high : key) : 'a table =
    (*let 
      val (_,mid,result) = Tree.splitAt (T,low)
      val T' = case mid of NONE => result | (SOME V) => Tree.join (result,Tree.singleton(low,V))
      val (result',mid',_) = Tree.splitAt(T',high)
    in 
      case mid' of 
      NONE => result'
      | SOME v' =>Tree.join(result',Tree.singleton(high,v'))
    end *)
    let
      val highSplit = split (T,high)
      val lowerHalf = case highSplit of (result,NONE,_)=>result
                                      | (result,SOME v,_) =>join(result,singleton(high,v))
      val lowSplit = split (lowerHalf,low)
    in
      case lowSplit of (_,NONE,result')=>result'
        | (_,SOME v,result') => join (singleton(low,v),result')
    end
          

end
