---
title: rust教程-06
date: 2022-11-01 20:27:44
tags:
- rust
categories:
- rust
---

rust 教程 06: 枚举

<!--more-->

## 枚举

```rust
#[derive(Debug)]
enum Message {
    Quit, // 可以不指定类型
    Move { x: i32, y: i32}, // 可以是一个结构体
    Write (String), // 可以是一个 String
    ChangeColor (i32, i32, i32), // 可以是一个 tuple
}

impl Message { // 为枚举类型添加方法
    fn call(&self) {
        println!("{:#?}", self);
    }
}
fn main() {
    let q = Message::Quit;
    let m = Message::Move { x: 19, y: 29 };
    let w = Message::Write(String::from("asdasd"));
    let c = Message::ChangeColor(12, 12, 12);
    q.call();
    m.call();
    w.call();
    c.call();
}
```

## Option 类型

rust 中没有 null

在其他语言中，一个变量可以处于两种状态：空值（null）、非空

但是当你尝试使用非 null 值那样使用 null 值的时候，就会引起某种错误

rust 中类似 null 的枚举：Option<T>，定义为:
```rust
enum Option<T> {
    Some(T),
    None,
}
```

基本的使用方法：

```rust
fn main() {
    let some_num = Some(5);
    let some_str = Some("asdasd");
    let some_none:Option<i32> = None; // 必须显示的指定类型
}
```

在 rust 中，Option<T> 和 T 是不同的类型，不可以直接相操作

## match

模式匹配，类似于 switch

```rust
#[derive(Debug)]
enum UsState {
    Washington,
    NewYork,
}
enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter(UsState),
}

fn match_coin(coin: &Coin) -> i8{
    match coin { // 必须列出所有可能的值，如果不想列出，必须用 _ 代替
        Coin::Penny => { // 使用 => 
            10
        },
        Coin::Nickel => {
            20
        },
        Coin::Dime => 5, // 也可以不跟 {}
        Coin::Quarter(state) => { // 匹配某种类型的枚举值
            println!("{:#?}", state);
            100
        }
    }
}

fn main() {
    let coin = Coin::Penny;
    let coin2 = Coin::Quarter(UsState::NewYork);
    match_coin(&coin);
    match_coin(&coin2);
}
```

用于 Option<T> 的匹配时

```rust
fn main() {
    let five = Some(5);
    let six = None;
    println!("{:#?}", inc(five));
    println!("{:#?}", inc(six));
}

fn inc(value: Option<i32>) -> Option<i32> {
    match value {
        Some(i)=> {
            Some(i+1)
        },
        None => { // 必须要穷举所有的可能性
            None
        }
    }
}
```

## if let

`if let` 用于匹配一种情况

```rust
fn main() {
    let three = Some(3);
    if let Some(3) = three { // 注意这里用的是一个等号
        println!("{}", 3);
    } else { // 也可以使用 else 来指定其他情况的处理逻辑
        println!("others");
    }
}
```