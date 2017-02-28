For a given list with  integers, return a new list removing the elements at odd positions. 


# Best solutions
## Scala
```scala
def f(a: List[Int]) = a.grouped(2).flatMap(_.tail)
```
