---
title: python生成器与迭代器
date: 2020-08-01 23:07:07
tags:
categories:
---

区分python中生成器与迭代器

<!--more-->

可迭代对象(Iterable)不是迭代器(Iterator)。

生成器(generator)。

可用于for循环的数据类型: 
1. for, list, str, dict等
2. generator

统称为 Iterable（可迭代的对象），实现了__iter__()函数

迭代器既实现了__iter__()，有实现了__next__()的对象被称作迭代器

把Iterable对象变成Iterator，可以使用iter([1, 2, 3])函数

yield的典例:

```python
"""
实现斐波那契数。
若想获得generator函数的返回值，必须抛异常，用e.value获取返回值
"""
def fib(max):
    n,a,b =0,0,1
    while n < max:
        yield b
        a,b =b,a+b
        n = n+1
    return 'done'
g = fib(6)
while True:
    try:
        x = next(g)
        print('generator: ',x)
    except StopIteration as e:
        print("生成器返回值：",e.value)
        break
```

```python
"""
生产者消费者模式。
只有调用next()函数的时候，才执行generator函数
"""
import time
def consumer(name):
    print("%s 准备学习啦!" %name)
    while True:
       lesson = yield
 
       print("开始[%s]了,[%s]老师来讲课了!" %(lesson,name))
 
 
def producer(name):
    c = consumer('A')
    c2 = consumer('B')
    c.__next__()
    c2.__next__()
    print("同学们开始上课 了!")
    for i in range(10):
        time.sleep(1)
        print("到了两个同学!")
        c.send(i)
        c2.send(i)
```