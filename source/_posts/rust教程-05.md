---
title: rust教程-05
date: 2022-10-25 23:12:51
tags:
- rust
categories:
- rust
---

rust 教程 05: struct

<!--more-->

## struct 基础内容

```rust

struct User {
    username: String,
    email: String,
    active: bool, // 最后一个字段也要有逗号
}

fn build_user(username: String, email: String, active: bool) -> User { // 函数返回结构体
    User {
        username, // 可以使用简写的方式初始化，只要变量名和字段名相同即可
        email,
        active
    }
}

fn main() {
    // 声明了可变的user，此时 user 的所有变量都是可变的
    let mut user = User {
        active: true,
        email: String::from("kimroniny@gmail.com"),
        username: String::from("kimroniny") // 可以调整赋值顺序，但是不可以不给某个字段赋值
    };
    user.active = false; // 修改字段的值；

    let mut user2 = User {
        email: String::from("cuncun@gmail.com"),
        ..user
    }; // 使用已有的 user 为新的 user2 赋值
    println!("Hello, world!");
}
```

## tuple struct

类似于 tuple 的 struct，整体有个名字，但是字段没有名字，只有类型

```rust
fn main() {
    struct Color(i32,i32,i32);
    struct Point(i32,i32,i32);
    let color = Color(0,0,0); // 初始化方式和 struct 不一样，用 ()
    let origin = Point(0,0,0);
}
```

## struct 的一个例子

```rust
#[derive(Debug)]
struct Rectangle {
    width: u32,
    length: u32,
}

fn main() {
    let rect = Rectangle {
        width: 1,
        length: 2,
    };
    println!("area: {}", area(&rect));
    println!("{:?}", rect); 
    /*
    Rectangle { width: 1, length: 2 }
    */
    println!("{:#?}", rect);
    /* 
    Rectangle {
        width: 1,
        length: 2,
    }
    */
}

fn area(rect: &Rectangle) -> u32 {
    rect.width * rect.length
}
```

## struct 的方法

```rust
#[derive(Debug)]
struct Rectangle {
    width: u32,
    length: u32,
}

impl Rectangle { // 使用 impl 实现 struct 的方法
    fn area(&self) -> u32 { 
        self.width * self.length
    }

    // 关联函数，第一个参数不是 self
    // 多用于实例化
    fn square(size: u32) -> Rectangle {
        Rectangle { width: size, length: size }
    }
}

impl Rectangle {
    // 可以放置多个 impl 块
    // 相当于综合在一起
    fn area2(&self) -> u32 {  
        self.width * self.length
    }
}

fn main() {
    let rect = Rectangle {
        width: 1,
        length: 2,
    };
    println!("area: {}", rect.area()); // 直接调用
    let rect2 = Rectangle::square(10);  // 使用双冒号来调用关联函数
}
```

---

## 参考
1. https://www.youtube.com/watch?v=e3-2uxHhbzs&list=PL3azK8C0kje1DUJbaOqce19j3R_-tIc4_&index=1&t=140s
2. 《rust权威指南(The Rust Programming Language)》