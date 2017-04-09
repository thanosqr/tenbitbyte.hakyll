---
title: Functional and logic programming differences
short_title: Logic vs Function
status: ready
---

When I was first introduced to logic programming it was hard to pinpoint how exactly it was different compared to functional programming.
After all they're both declarative paradigms, and they usually focus on immutability and recursion - however, logic programming offers a whole new approach to programming.

### It's all about the building blocks
In my view, the major difference between functional and logic programming is in the "building blocks": 
functional programming uses functions while logic programming uses predicates.

Which leads to the question: what's the difference between a function and a predicate?

### A predicate does not have a return value
But wait, you say, I can just use on of the arguments to get the result - e.g.
```
add(X, Y, Result):-
  Result is X + Y
```
Well, for starters, that predicate does not work for all instantiation patterns - it will fail for `add(1, X, 2)` instead of returning `X = 1`.
You can certainly write prolog programs that way, they'll compile, they'll work, but it won't be logic programming 
- just like code can follow the imperative paradigm even if it's written in a functional language.
 
 In order to truly harness the power of a logic language you need to understand the underlying philosophy: that you are writing how something can be true.
 Perhaps it depends on the value of some variables - those can be used as arguments, and, when those are left undefined, 
 the goal will be to find the values that would make the clause true.

Prolog in particular uses a special form of logic clauses, called Horn clauses, that originate in first order logic; hilog uses clauses of higher order logic.

When you write a prolog predicate you are defining a Horn clause: `foo:- bar1, bar2, bar2.` means that `foo` is true if `bar1`, `bar2` and `bar3` are true. 
But not if and only if; you can have multiple clauses for one predicate, e.g.:
```
foo:-
   bar1.
foo:-
  bar2.
```

which means that `foo` is true if `bar1` is true or if `bar2` is true.


### Going back
Another difference between logic and functional programming is backtracking. 
In functional programming, once you enter the body of the function you cannot fail and move to the next definition. For example you can write

```
abs(x)--> 
   if x>0 x else -x
```

but you cannot write:
```
abs(x)-->
   x>0,
   x;
abs(x)-->
   x.
```
On the other hand, in prolog, you could write
```
abs(X,R):-
   X>0,
   R is X.
abs(X,R):-
   R is -X.
```
Then, if you call `abs(-3,R)`, prolog will try the first clause and fail when the execution reaches `-3>0` - but you won't get an error! 
Instead, prolog will try the second clause and return `R = 3`.

Of course, it's not impossible for a functional language to implement something similar (languages such as Curry or Mercury come to mind).
In fact, having guards, e.g.:
```
abs(x) x>0 --> x;
abs(x) x=<0 --> -x.
```
looks quite similar - however, there's a fundamental difference: guards are nothing more than syntactic sugar for flow control; the code is split into two "modes": 
conditions and expressions, while in logic programming there's no such separation.  

### Is logic programming a superset of functional programming?

Some say that logic programming is a superset of functional programming since each function could be expressed as a predicate:

```foo(x,y) --> x+y.```

could be written as

```
foo(X,Y,ReturnValue):-
   ReturnValue is X+Y.
```

But I think that such statements are a bit misleading. Sure, there's a way to map functions to predicates, but, 
after all, everything is equivalent to a Turing machine and compiles to machine code - what a programming paradigm is offering 
is different ways of _thinking_ about the problems and structuring the code. 

 I definitely recommend trying a bit of logic programming: it should be a mind-blogging experience, 
 of a similar scale of going from imperative-style programming to functional programming.