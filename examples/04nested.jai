#import,file "../module.jai";
#import "Basic";
#import "Thread";
#import "Atomics";

// DispatchFunction and WaitForWork can be called from inside a dispatched function.
main :: () {
   Initialize();

   done: s32;
   WaitForWork(DispatchFunction(Spawner, 10000, *done));

   print("done: %\n", done);
   assert(done == 10000);
}

Spawner :: (count: int, done: *s32) {
   works: [..] WorkHandle;
   for 0..count - 1 {
      array_add(*works, DispatchFunction(Child, done));
   }

   for works WaitForWork(it);
   array_free(works);
}

Child :: (done: *s32) {
   atomic_add(done, 1);
}
