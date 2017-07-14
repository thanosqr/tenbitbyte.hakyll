---
title: "Schedplot: a scalability profiler for Erlang programs"
short_title: Schedplot
status: ready
---

## What's a Schedplot?

Schedplot (SCHEDuler PLOTter) is a profiler for Erlang programs I developed for my thesis during the last year. 
It visualizes the workload of Erlang's schedulers, which can be used to detect bottlenecks and scalability issues in multicore architectures.

In other words, Schedplot aspires to answer a simple question: why a program doesn’t run twice as fast if the number of available processors is doubled?

 
## This sounds familiar to...

[Threadscope (Haskell)](https://wiki.haskell.org/ThreadScope). 
[Threads View (VS)](https://msdn.microsoft.com/en-us/library/dd627193%28v=vs.110%29.aspx). 
[Thread Scheduling Visualizer (Java)](http://docs.oracle.com/javase/realtime/TSV/JavaRTS-TSV.html).
Indeed! But isn't it awesome that Erlang has schedulers instead of threads? Threadplot just doesn't sound right...

 ## Schedplot example
So, without further ado, here's a screenshot:

![](/images/scheplot1.jpeg)

The profiled program spawns 5 processes: each one calculates a Fibonacci number (28, 29, 30, 31, 32). 
The program runs in a VM using 4 schedulers (S1-S4). It is trivial to realize why the program doesn’t have ideal speedup; 
although we have more than 4 processes, their work load is unbalanced and 3 schedulers are inactive while the 4th calculates fib(32)



### How do you know that the last one is fib(32)?
Well, see that red line at the end with the `end32` label?
That's the result of using `schedplot:print/1`, which prints a message on the graph (the message is placed on the scheduler on which the process that called it was running). 
In our case, when a process has finished the calculations it prints `endN` where N is the Fibonacci number it was calculating.


### So what do we actually see in the chart?

![](/images/scheplot2.jpeg)

Well, no, not really lazy. Each pixel is corresponds not to a single moment (1us); 
hence, in 10us a scheduler may be inactive for 5us and active for 5us and will be displayed as 50% active.


### What will happen if in 100us the scheduler is 99% active but the chart height is 10pixel?

It will be 9 pixel. The graph has max height if and only if the scheduler is 100% active; otherwise, the visualization could hide significant gaps.

Symmetrically, the height is zero if and only if the scheduler is 0% active.




## So now what?

Well, if you are still interested you can:
1. Check the [presentation](/files/schedplot-pres.pdf)
2. Get the [code](https://github.com/thanosqr/schedplot)
3. Read the [thesis](http://artemis-new.cslab.ece.ntua.gr:8080/jspui/bitstream/123456789/6427/1/DT2012-0198.pdf#page=7) (Pages 1-6 are in Greek, rest in English)