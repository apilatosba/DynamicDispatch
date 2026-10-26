#import,file "../module.jai";
#import "Basic";
#import "Thread";
#import "Atomics";

// every work blocks until ALL works have started.
// with a fixed size thread pool smaller than WORK_COUNT this would deadlock,
// here a new thread is created for each work that cant find an idle thread so it finishes.
WORK_COUNT :: 64;

main :: () {
   Initialize();

   works: [WORK_COUNT] WorkHandle;

   started: s32;
   for 0..WORK_COUNT - 1 {
      works[it] = DispatchFunction(WaitForEveryone, *started);
   }

   for works WaitForWork(it);

   print("all % works completed\n", WORK_COUNT);
}

WaitForEveryone :: (started: *s32) {
   atomic_add(started, 1);
   while atomic_read(started) < WORK_COUNT {
      sleep_milliseconds(1);
   }
}
