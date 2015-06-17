# Barrrier

Barrier
=====================
1. 所做的工作跟同步操作任务类似

应用场景
--------------------------
当我们用GCD的时候，做网络资源下载，多个线程访问同一资源，这就是资源抢夺了。
NSMutableArray是线程不安全的。如果同一个时间点。多个线程向数组里面添加，有可能会出现Crash

这里解决这个问题就需要一个特殊的函数dispatch_barrier_async函数
这个往数组的里面的添加操作，是在同一个线程里面做的。下载操作是多线程实现的；

总结的来说：下载异步，添加同步
最常见的场景：从网络下载大量的数据，IO,

注意事项
--------------------------
队列的要用自定义的队列，不能用全局队列，否则不能起到阻塞的效果

