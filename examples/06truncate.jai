#import,file "../module.jai";
#import "Basic";
#import "Thread";

// a spike creates a lot of threads, TruncateThreads gets rid of the idle ones.
main :: () {
   Initialize();

   SPIKE :: 50;
   works: [SPIKE] WorkHandle;

   for 0..SPIKE - 1 {
      works[it] = DispatchFunction(Slow, 50);
   }
   for works WaitForWork(it);

   // one long running work keeps its thread, the other 49 are idle and get destroyed
   long := DispatchFunction(Slow, 300);
   TruncateThreads();
   assert(!IsWorkDone(long));

   WaitForWork(long);

   // works fine after a truncate
   WaitForWork(DispatchFunction(Slow, 10));
   TruncateThreads();

   print("Done!\n");
}

Slow :: (milliseconds: s32) {
   sleep_milliseconds(milliseconds);
}
