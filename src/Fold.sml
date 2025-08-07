fun $ (a, f) = f a
structure Fold :> FOLD =
struct
  type ('x, 'y) fin = 'x -> 'y

  type ('acc, 'x, 'y, 'next) step = 'acc * ('x, 'y) fin -> 'next

  type ('acc, 'x, 'y, 'next) t = ('acc, 'x, 'y, 'next) step -> 'next

  type ('acc1, 'acc2, 'x, 'y, 'next) step0 =
    ('acc1, 'x, 'y, ('acc2, 'x, 'y, 'next) t) step
  type ('acc11, 'acc12, 'acc2, 'x, 'y, 'next) step1 =
    ('acc12, 'x, 'y, 'acc11 -> ('acc2, 'x, 'y, 'next) t) step

  fun fold (a, f) g = g (a, f)

  fun step0 h (a, f) =
    fold (h a, f)

  fun step1 h (a, f) b =
    fold (h (b, a), f)

  fun post (w, g) s =
    w (fn (a, h) => s (a, g o h))

  fun lift0 s (a, f) =
    fold (fold (a, fn x => x) s $, f)
end
