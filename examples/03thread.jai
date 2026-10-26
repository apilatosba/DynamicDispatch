#import,file "../module.jai";
#import "Basic";
#import "Thread";

// if your function takes *Thread as its first parameter and you dont provide it,
// the library fills it in for you.
main :: () {
   Initialize();

   WORK_COUNT :: 100;
   works: [WORK_COUNT] WorkHandle;

   for 0..WORK_COUNT - 1 {
      works[it] = DispatchFunction(PrintThreadIndex, it);
   }

   for works WaitForWork(it);

   print("\n\nDone!\n");
}

PrintThreadIndex :: (thread: *Thread, workIndex: int) {
   assert(thread.index == context.thread_index);

   messageFormat := #string HERE
--------------------------------------
work:                  %
thread.index:          %
context.thread_index:  %
HERE
;
   print(messageFormat, workIndex, thread.index, context.thread_index);
}
