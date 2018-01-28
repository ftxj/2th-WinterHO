structure Mylist = 
struct
	(*中缀操作append操作*)
	infixr 5 @;
	fun ([] @ l) = l
		|((x::xs) @ l) = x:: (xs @ l);
	(*测试是否为空	*)
	fun null [] = true
		| null (_::_) = false;
	(*返回list首元素*)
	fun hd (m::_) = m;
	(*返回list尾元素*)
	fun til (_::ns) =ns;
	(*递归实现求长度*)
	fun nlength [] = 0
		| nlength (m::ns) = 1 + nlength(ns);
	(*迭代版求长度*)
	local
		fun addlen (n,[]) = n
			| addlen (n,m::ns) =addlen(n+1,ns)
	in
		fun length l = addlen(0,l)
	end;
	(*取出前i个元素*)
	fun ntake ([],i) = []
		| ntake(x::l,i) = if i>0 then x::ntake(l,i-1) else [];
	(*迭代取出前i个元素*)
	local
		fun rtake ([],_,l) = l
			| rtake (x::xs,i,l) = if i>0 then rtake(xs,i-1,x::l) else l
	in
		fun take (ll,i) = rtake(rtake(ll,i,[]),length(rtake(ll,i,[])),[])
	end;
	(*取出后i个元素*)
	fun drop (l,i) = if null(l) then [] else if i>0 then drop(til(l),i-1) else l;
	(*取出第i个元素，从0开始*)
	fun nth (x::xs,i) = if i>0 then nth(xs,i-1) else x;
	(*反转此串*)
	local
		fun revAppend ([],l) = l
			| revAppend(x::xs,l) = revAppend(xs,x::l)
	in
		fun rev l = revAppend(l,[])
	end;
	(*将list list 变成list*)
	fun contact [] = []
		| contact (x::xs) = x@contact(xs);
	(*将两个list配对二元组*)
	fun zip (x::xs,y::ys) = (x,y)::zip(xs,ys)
		| zip _ = [];
	(*将配对的二元组解配对*)
	fun unzip [] = [[],[]]
		| unzip ((x,y)::pairs) =
						let
							val [xs,ys] = unzip pairs
						in
							[(x::xs),(y::ys)]
						end;
	fun compare (x1,x2) = if x1>x2 then GREATER else if x1<x2 then LESS else EQUAL;
	fun isSort [] = true
		| isSort [x] = true
		| isSort (x::y::L) = (compare(x,y) <> GREATER) andalso isSort(y::L);

	fun ins (x,[]) = [x]
		| ins (x,y::L) = case compare(x,y) of 
						 GREATER => y::ins (x,L)
						 | _ => (x::y::L);

	fun insertSort [] = []
		| insertSort (x::L) = ins(x,insertSort L);

	fun merge ([],L2) = L2
		| merge (L1,[]) = L1
		| merge (x::L1,y::L2) = case compare(x,y) of
								GREATER => y::merge(x::L1,L2)
								| _ => x::merge(L1,y::L2);
	fun split [] = ([],[])
		| split	[x] = ([x],[])
		| split (x::y::L) = let
								val (A,B) = split L
							in
								(x::A,y::B)
							end;

	fun mergeSort [] = []
		| mergeSort [x] = [x]
		| mergeSort L = let
							val (A,B) = split(L)
						in
							merge(mergeSort A,mergeSort B)
						end	;
end

structure Mytree = 
struct
	datatype tree = Empty | Node of tree * int * tree;
	fun compare (x1,x2) = if x1>x2 then GREATER else if x1<x2 then LESS else EQUAL;
	fun max (x,y) = case compare (x,y) of
					GREATER => x
					| _ => y;	

	fun size Empty = 0
		| size (Node(A,x,B)) = 1 + size A +size B;

	fun depth Empty = 0
		| depth (Node(A,_,B)) = max(depth A,depth B) + 1;

	fun NLRtrav Empty = []
		| NLRtrav (Node(TL,v,TR)) = (v::NLRtrav TL)@NLRtrav TR;
	fun LNRtrav Empty = []
		| LNRtrav (Node(TL,v,TR)) = LNRtrav TL @ v::LNRtrav TR;
	fun LRNtrav Empty = []
		| LRNtrav (Node(TL,v,TR)) = LRNtrav TL @ LRNtrav TR @[v];

	fun isSort' [] = true
	| isSort' [x] = true
	| isSort' (x::y::L) = (compare(x,y) <> GREATER) andalso isSort'(y::L);
	fun isSort T = isSort'(LNRtrav T);
	fun ins (x,Empty) = Node(Empty,x,Empty)
		| ins (x,Node(TL,v,TR)) = case compare (x,v) of
								  GREATER => Node(TL,v,ins(x,TR))
							   	  | _ => Node(ins(x,TL),v,TR);

	fun split(y,Empty) = (Empty,false,Empty)
		| split (y,Node(TL,v,TR)) = case compare (y,v) of
									GREATER => let
													val (ST,result,BT) = split(y,TR)
												in
													(Node(TL,v,ST),result,BT)
												end
									| LESS => let
												 val (ST,reslt,BT) = split(y,TL)
											  in
												  (ST,reslt,Node(BT,v,TR))
											  end	
									| EQUAL => (TL,true,TR);
	fun LeftRotate Empty = Empty
		| LeftRotate (Node(Node(L2,v2,R2),v1,R1)) = Node(L2,v2,Node(R2,v1,R1));

	fun RightRotate Empty = Empty
		| RightRotate (Node(L1,v1,Node(L2,v2,R2))) = Node(Node(L1,v1,L2),v2,R2);

	fun DoubleLeftRotate Empty = Empty
 		| DoubleLeftRotate (Node(L,v,R)) = LeftRotate (Node((RightRotate L),v,R));

 	fun DoubleRightRotate Empty = Empty
 		| DoubleRightRotate (Node(L,v,R)) = RightRotate (Node(L,v,LeftRotate R));

	fun ReBalance Empty = Empty
		| ReBalance (Node(Empty,v,Empty)) = Node(Empty,v,Empty)
		| ReBalance (Node(L,v,R)) = let
										val difference = (depth L) - (depth R) 
									in 
										if difference > 1 then 
											LeftRotate (Node(ReBalance L,v,ReBalance R)) 
										else if difference < ~1 then 
											RightRotate (Node(ReBalance L,v,ReBalance R)) 
										else Node(ReBalance L,v,ReBalance R)
									end;
	fun Min (Node(Empty,v,Empty)) = v
		| Min (Node(L,v,R)) = Min L;

	fun Insert (Empty,x) = Node(Empty,x,Empty)
		| Insert (Node(L,v,R),x) = case compare (x,v) of
								   GREATER => Insert(R,v)
								   | LESS => Insert(L,v)
								   | _=>Node(L,v,R);
	fun Delete (Empty,x) = Empty
		| Delete (Node(L,v,R),x) = case compare (x,v) of
								   GREATER => Delete(R,x)
								   | LESS => Delete(L,x)
								   | EQUAL => Node(Delete(L,Min L),Min L,R);
	fun merge (Empty,T2) = T2
		| merge (T1,Empty) = T1
		| merge (Node(T1L,v1,T1R),T2) = let
											val (ST,result,BT) = split(v1,T2)
										in
											case result of
											true => Node(merge(T1L,ST),v1,ins(v1,merge(T1R,T2)))
											| false => Node(merge(T1L,ST),v1,merge(T1R,T2))
										end;
	fun mergeSort Empty = Empty
		| mergeSort (Node(TL,v,TR)) = ins(v,merge(mergeSort TL,mergeSort TR));
end		

(*解决找零钱问题*)
fun allChangef (coins, coinvals, 0) = [coins]
  | allChangef (coins, [],amount) = []
  | allChangef (coins, (c,0)::coinvals, amount) = allChangef(coins, coinvals, amount)
  | allChangef (coins, (c,n)::coinvals, amount) =
      if amount<0 then []
      else allChangef(c::coins, (c,n-1)::coinvals, amount-c) @ allChangef(coins, coinvals, amount);

fun allChange (coins, coinvals, 0, coinslist) = coins::coinslist
  | allChange (coins, [],  amount, coinslist) = coinslist
  | allChange (coins, c::coinvals, amount, coinslist) =
      if amount<0 then coinslist
      else allChange(c::coins, c::coinvals, amount-c,allChange(coins, coinvals, amount, coinslist));

fun greedychange(coinslist,0) = []
	| greedychange([],money) = []
	| greedychange(x::relist,money) = 
		if money>=x then x::greedychange(x::relist,money-x) else greedychange(relist,money);


val it = Mylist.null [];
val mysubject : string list = ["Math","Chinese"];
Mylist.drop(mysubject,0);
Mylist.take(mysubject,2);
Mylist.nth(mysubject,0);
Mylist.rev(mysubject);
Mylist.zip([4,5,6],[4,5,6]);
Mylist.unzip(Mylist.zip([4,5,6],[4,5,6]));
val romcoins : int list = [1000,500,100,50,10,5,1];
val it = greedychange(romcoins,1984);
val it = allChange([],romcoins,100,[]);

val test : int list = [1,5,8,9,7,5,3,5,6];
Mylist.isSort(Mylist.mergeSort test);
Mylist.isSort(Mylist.insertSort test);

val T= Mytree.Node(Mytree.Node(Mytree.Empty,0,Mytree.Empty),2,Mytree.Node(Mytree.Node(Mytree.Empty,3,Mytree.Empty),4,Mytree.Empty));
val T'= Mytree.Node(Mytree.Node(Mytree.Empty,2,Mytree.Empty),0,Mytree.Node(Mytree.Node(Mytree.Node(Mytree.Empty,5,Mytree.Empty),4,Mytree.Empty),3,Mytree.Empty));
Mytree.LNRtrav T';
Mytree.isSort (Mytree.mergeSort T');
Mytree.ReBalance T';
Mytree.size T;
Mytree.depth T;
Mytree.isSort T;
Mytree.ins (1,T);
Mytree.split (2,T);
Mytree.NLRtrav T;
Mytree.LNRtrav T;
Mytree.LRNtrav T;