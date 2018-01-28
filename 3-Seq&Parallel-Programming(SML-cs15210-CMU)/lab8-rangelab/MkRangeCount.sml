functor MkRangeCount(structure OrdTable : ORD_TABLE) : RANGE_COUNT =
struct
  structure OrdTable = OrdTable
  open OrdTable
  open Seq
  (* Ordered table type: *)
  type 'a table = 'a table
  type 'a seq = 'a Seq.seq
  type point = Key.t * Key.t

  (* Use this to compare x- or y-values. *)
  val compareKey : (Key.t * Key.t) -> order = Key.compare

  (* Remove this before submitting! *)
  exception NYI

  (* Define this yourself *)
  type countTable = unit table table

 fun makeCountTable (S : point seq) : countTable = 
  let
    val sortx = sort (fn (a, b) => compareKey (#1 a, #1 b)) S
    (*val insert : ('a * 'a -> 'a) -> (key * 'a) -> 'a table -> 'a table*)
    val (midseq, res) = iterh (fn (a, b) => OrdTable.insert #1 (#2 b, ()) a) (OrdTable.empty ()) sortx
    val maps = if (length S) = 0 then empty () else append (drop (midseq, 1), singleton res)
    val result = map (fn (p, m) => (#1 p, m)) (zip sortx maps)
  in
    OrdTable.fromSeq result
  end

  fun count (T : countTable)
    ((xLeft, yHi) : point, (xRight, yLo) : point) : int =
  let
      val numx = OrdTable.getRange T (xLeft, xRight)
      val right = case OrdTable.size numx of 0 => 0 
                    | _=> size (getRange (#2 (valOf(last numx))) (yLo, yHi))
      val left = case OrdTable.size numx of 0 => 0 
                    |_=> size (getRange (#2 (valOf(first numx))) (yLo, yHi))
    in
      if (size numx = 0) then 0 else right - left + 1
    end
end
