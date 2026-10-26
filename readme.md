## DynamicDispatch

Like ApilaDispatch, but the thread count is dynamic. `DispatchFunction` hands the work to an idle thread if
there is one, otherwise it creates a new thread. A dispatched function never sits in a queue.
Threads are reused. Call `TruncateThreads` to destroy the idle ones after a spike.

```jai
#import,file "../module.jai";
#import "Basic";
#import "Thread";

main :: () {
   InitializeThreads();

   sum: int;
   multiply: int;
   sumWork      := DispatchFunction(Sum, 34, 35, *sum);
   multiplyWork := DispatchFunction(Multiply, 3, 23, *multiply);

   WaitForWork(sumWork);
   WaitForWork(multiplyWork);

   print("sum:       %\n", sum);
   print("multiply:  %\n", multiply);
}

Sum :: (a: int, b: int, result: *int) {
   result.* = a + b;
}

Multiply :: (a: int, b: int, result: *int) {
   result.* = a * b;
}
```
