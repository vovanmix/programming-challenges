def f(arr:List[Int]):List[Int] = arr.zipWithIndex.filter{ case (_, idx) => (idx + 1) % 2 == 0 }.map{ case (v, _) => v }

def f(arr: List[Int]): List[Int] = (arr.zipWithIndex filter (_._2 % 2 == 1)).unzip._1

def f(arr:List[Int]):List[Int] = arr match {
    case odd::Nil => Nil
    case odd::even::Nil => even::Nil
    case odd::even::tail => even::f(tail)        
}

def f(arr:List[Int]) : List[Int] = arr match {
    case Nil => Nil
    case _::Nil => Nil
    case x::(y::xs) => y::f(xs)
}

def f(a: List[Int]) = a.grouped(2).flatMap(_.tail)
