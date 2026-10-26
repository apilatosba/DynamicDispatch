#import,file "../module.jai";
#import "Basic";
#import "Thread";

main :: () {
   Initialize();

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
