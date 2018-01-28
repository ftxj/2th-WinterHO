structure Tests =
struct

  (* Do not remove the following line! *)
  val corpus = TextIO.inputAll (TextIO.openIn "corpus.txt")

  val testsChoose : (((string * int) list) * real) list  = [
    ([("test", 10)], 0.5),
    ([("test", 2), ("awesome", 2)], 0.5),
    ([("yay", 1), ("woah", 2), ("oh", 3), ("yup", 4)], 0.47),
    ([("xin", 2), ("jie", 5)], 0.0),
    ([("xin", 2), ("jie", 5)], 1.0),
    ([("yay", 1), ("woah", 2), ("oh", 3), ("yup", 4),("yay2", 1), ("woah2", 2), ("oh2", 3), ("yup2", 4)], 0.5),
    ([("a", 4500), ("b", 4724), ("c", 7831), ("d", 5198), ("e", 3244), ("f", 3446), ("g", 2626),
      ("h", 2954), ("i", 3357), ("j",  711), ("k",  577), ("l", 2392), ("m", 4196), ("n", 1698), 
      ("o", 2104), ("p", 6559), ("q",  412), ("r", 5143), ("s", 9599), ("t", 4160), ("u", 2561), 
      ("v", 1206), ("w", 2205), ("x",   19), ("y",  248), ("z",  137)], 0.5143)
  ]

  (* You must add test kgrams for the corpus in corpus.txt as part of task 5.5
   * You may edit corpus.txt -- it will be handed in.
   *
   * You may also add other tests, which use other corpi (corpuses?), but those
   * corpuses will not be submitted. *)
  val testsKGramStats : ((string * int) * (string list)) list = [
    ((corpus, 5),
        ["",
        "direction",
         "time",
         "direction of time",
         "would write",
         "What Eddington says about",
         "What Eddington says about 'the direction of time' and the law of entropy comes to this: time would change its direction if men should start walking backwards one day. Of course you can call it that if you like, but then you should be clear in your mind that you have said no more than that people have changed the direction they walk in.What Arthur Eddington says about the infinite monkey theorem and the direction of time comes to this: if an army of monkeys would write on typewriters, they would write, provided the motion of time, all the books in the British Museum.But consider that people start to walk in reverse. That is, time *does* change its direction one day. Then one must again consider the infinite monkey theorem and the direction of time. As if time would change its direction, then the world may be rendered nonsensical, just as men should start walking backwards.So the question is this:Provided the motion of time, in particular in reverse, would an army of monkeys on typewriters write all the books in the British Museum?"
        ])
  ]


end
