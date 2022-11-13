---
title: rust教程-08
date: 2022-11-13 18:04:45
tags:
- rust
categories:
- rust
---

rust 教程 07: vector, string, hashmap

<!--more-->

## Vector

### vector 的基本使用

```rust
fn main() {
    // 必须要指明类型，或者通过 push，能够让编译器知道 v 的类型
    // 离开作用域的时候，v 就被删除了
    let v: Vec<i32> = Vec::new();

    // 不用显示指明类型
    let v2 = vec![1,2,3];

    // 因为 push 了一个 i32 类型的数据，所以不需要显示地指明类型
    let mut v3 = Vec::new();
    v3.push(1);

    // -------

    // 两种读取 vector 元素的方法
    // 1. 通过索引
    let x = &v2[1];

    // 2. 通过 get 方法
    match v2.get(1) {
        Some(x) => {
            println!("x is: {}", x);
        },
        None => {
            println!("x is None");
        }
    }

    // -------

    // 不能在同一作用域内同时拥有可变和不可变引用
    let mut v4 = Vec::new();
    let first = &v4[1]; // 不可变借用
    v4.push(10); // 可变借用，和上面的不可变借用发生冲突，
    println!("first is {}", first);
    // 因为 push 的过程如果 vector 内存不够，则导致 vector 重新分配内润地址，所以此时不可变借用就失效了，因此编译器不允许这种情况出现

    // -------

    // for 循环

    let mut v5 = vec![1,2,3,4,5];

    for i in &mut v5 {
        *i += 10; // 修改 v5 的值
    }

    for i in &v5 { // 循环打印
        println!("i is {}", i);
    }

    println!("Hello, world!");
}
```

### vector 的例子

使用 enum 改变 vector 元素的类型

```rust
enum SheetCell {
    Int(i32),
    Float(f64),
    Text(String),
}
fn main() {
    let row = vec![
        SheetCell::Int(1),
        SheetCell::Float(10.0),
        SheetCell::Text(String::from("asdasd")),
    ];
}
```

## String

rust 的核心语言层面，只有一个字符串类型，即字符串切片 str 或者 &str，对存储在其他地方、UTF-8编码的字符串的引用

```rust
fn main() {
    // -------

    // 创建字符串类型的几种方法
    let s = String::from("asdasd");
    let s1 = "adadad".to_string();
    let data = "dasdad";
    let s2 = data.to_string();

    // -------
    
    // 更新 string
    let mut s3 = String::from("asdada");
    s3.push_str("asdadasd");
    let s4 = String::from("sdasd");
    s3.push_str(&s4); // 不会改变 s4 的所有权
    s3.push('1'); // 附加一个字符

    // 取得了 s3 的所有权，s3会失效
    // &s4 被强制转换为字符串切片 &str，解引用强制类型转换
    let s5 = s3+&s4; 

    // 可以直接用 format 来构建新字符串，这样不会改变所有权
    let s5 = format!("{}-{}-{}", s1, s2, s5);

    // -------

    // 访问字符串元素
    // String 不支持索引形式访问元素
    // String 是对 vec<u8> 的包装
    // 由于 String 是一种 utF-8 编码，所以索引的位置指代的不一定就是字符的位置，有可能是某个字节
    for w in s5.chars() { // 获得标量值
        println!("{}", w);
    }
    for w in s5.bytes() { // 获得字节
        println!("{}", w);
    }

    // 字符串切片
    let s6 = &s5[0..4]; // 必须沿着字符的边界进行切割（比如一个字符占两个字节)，否则就会 panic

}
```

## HashMap<K, V>

以键值对的形式存储数据，一个键对应一个值

```rust
use std::collections::HashMap;

fn main() {

    // -----------

    // hashmap 是同构的，即 k 必须是同一类型，v 必须是同一类型
    let mut scores = HashMap::new();
    scores.insert(String::from("asdads"), 10);

    // 通过 collect 来创建 hashmap

    let teams = vec![
        String::from("asdad"),
        String::from("agdfgd"),
    ];
    let initial_scores = vec![1,2,3,4];
    let scores: HashMap<_,_> = // 用下划线是因为编译器可以根据 vector 中的元素推导出 k v 的类型
        teams.iter().zip(initial_scores.iter()).collect();

    // 所有权问题
    let s1 = String::from("asdasd");
    let s2 = String::from("asdasd");

    let mut map = HashMap::new();
    map.insert(&s1, &s2); // 传递引用不会改变所有权
    // map.insert(s1, s2); // 会改变 s1 和 s2 的所有权

    // 通过 get 取得 hashmap 的值
    match map.get(&String::from("asdas")) {
        Some(x) => {
            println!("{}", x);
        },
        None => {
            println!("None");
        }
    }

    // 通过 for 循环遍历 hashmap 的值
    for (k,v) in &map {
        println!("{}, {}", k, v);
    }

    // 更新 hashmap
    // 每个 k 同时只能对应一个 v
    // 更新 hashmap 中的数据
    // 1. k 已经存在，对应一个 v
    // - 替换现有的 v
    // - 保留现有的 v，忽略新的 v
    // - 合并现有的 v 和新的 v
    // 2. k 不存在
    // - 添加一对 (k, v)
    let mut scores = HashMap::new();
    scores.insert(String::from("asdsd"), 10);
    scores.insert(String::from("asdsd"), 12); // asdsd 的值已经改为 12，无论值是否存在，都在被设置为 12 

    // 对于 entry 而言
    // 如果 k 存在，则返回对应的 v 的一个可变引用
    // 如果 k 不存在，则将新的值插入进去，然后返回该值的可变引用
    scores.entry(String::from("asdsd")).or_insert(49); // 如果不存在则插入并返回新值的引用，如果存在则返回已有的值的引用
    let e = scores.entry(String::from("asdsd"));
    e.or_insert(666);
    
    // 基于现有的值 v 来更新
    let text = "asdasd adfs asdsd asda";
    let mut map = HashMap::new();
    for word in text.split_whitespace() {
        let count: &mut i32 = map.entry(word).or_insert(0);
        *count += 1; // 注意 count 是一个可变引用
    }
}
```

