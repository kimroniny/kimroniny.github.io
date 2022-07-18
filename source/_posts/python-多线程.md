---
title: python 多线程
date: 2019-12-04 19:05:03
tags:
- python
categories:
- python
- threading
---

关于python中多线程的实现以及一些知识点

<!--more-->

## threading

实现方式

```python
import threading
threads = []
for _ in range(thread_num):
    threads.append(threading.Thread(target=func, args=[arg0, arg1]))
for i in range(thread_num):
    threads[i].start()
for i in range(thread_num):
    threads[i].join() # join的含义就是阻塞在线程i，直到线程i停止，然后阻塞在下一个线程i+1，直到线程i+1停止

# 线程锁
mutex = threading.RLock()
mutex.acquire()
mutex.release()

```

## threadpool

```shell
pip install threadpool
```
```python
import threadpool
pool = threadpool.ThreadPool(thread_num)  # 成立线程池
params = [x*x for x in range(thread_num)]  # 拼接 func 的参数
thread_requests = threadpool.makeRequests(post, params)  #
[pool.putRequest(req) for req in thread_requests] # putRequest就已经启动了线程
pool.wait() # 类似于join进行堵塞
```

## 伪并行

因为GIL（全局解释锁）。

python中的线程在单个CPU上进行，使用GIL解决资源共享的一致性问题。

对于计算密集型多线程程序，也就是说单个线程不会有因本线程问题而阻塞的情况（比如网络延迟），那么该线程本来可以安然无恙、无需等待的去进行，但是其他线程要来争夺资源，所以需要进行线程间的切换，而多线程的交替执行涉及到上下文切换、锁机制处理（获取锁，释放锁等），所以需要耗费更多的时间。

对于网络密集型多线程程序，则无需考虑该问题，因为在等待网络请求的过程中，线程往往会处于阻塞状态，这是可以切换到其他线程进行其他操作，因此节省了时间。

## thread.setDaemon(True)

译名：守护线程

执行下面代码后

```python
thread[i].setDaemon(True)
```

主要体现在线程i与主线程之间的关系，主线程执行完毕后，会直接退出程序，杀死线程i，不会管线程i是否执行完毕

setDaemon的作用和join相反，join是阻塞主线程