#import,file "../module.jai";
#import "Basic";
#import "Thread";

// polling with IsWorkDone, and WaitForWork with a timeout
main :: () {
   Initialize();

   work := DispatchFunction(Slow, 200);

   frames := 0;
   while !IsWorkDone(work) {
      frames += 1;
      sleep_milliseconds(10);
   }
   print("Slow finished after ~% frames\n", frames);

   work = DispatchFunction(Slow, 200);
   done := WaitForWork(work, 50);
   print("after 50ms timeout done: %\n", done);
   assert(!done);

   done = WaitForWork(work);
   print("after waiting forever done: %\n", done);
   assert(done);
   assert(IsWorkDone(work));
}

Slow :: (milliseconds: s32) {
   sleep_milliseconds(milliseconds);
}
