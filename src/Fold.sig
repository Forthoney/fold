signature FOLD =
sig
  (* The fnishing function to be applied at the end of the fold *)
  type ('x, 'y) fin = 'x -> 'y

  (* Each step in the fold is a function that takes an accululator and the finishing function,
     producing 'next, a type that is completely left open to be filled in by type inference *)
  type ('acc, 'x, 'y, 'next) step = 'acc * ('x, 'y) fin -> 'next
  (* The type of a folder that consumes a single step *)
  type ('acc, 'x, 'y, 'next) t = ('acc, 'x, 'y, 'next) step -> 'next
  type ('acc1, 'acc2, 'x, 'y, 'next) step0 =
    ('acc1, 'x, 'y, ('acc2, 'x, 'y, 'next) t) step
  type ('acc11, 'acc12, 'acc2, 'x, 'y, 'next) step1 =
    ('acc12, 'x, 'y, 'acc11 -> ('acc2, 'x, 'y, 'next) t) step

  (* Create a folder from an initial value and a finishing function *)
  val fold: 'acc * ('x, 'y) fin -> ('acc, 'x, 'y, 'next) t
  val step0: ('acc1 -> 'acc2) -> ('acc1, 'acc2, 'x, 'y, 'next) step0
  val step1: ('acc11 * 'acc12 -> 'acc2)
             -> ('acc11, 'acc12, 'acc2, 'x, 'y, 'next) step1
  val lift0: ('a1, 'a2, 'a2, 'a2, 'a2) step0 -> ('a1, 'a2, 'b, 'c, 'd) step0
  val post: ('acc, 'x, 'y1, 'next) t * ('y1 -> 'y2) -> ('acc, 'x, 'y2, 'next) t
end
