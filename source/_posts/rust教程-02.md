---
title: rust教程-02
date: 2022-10-18 21:44:06
tags:
- rust
categories:
- rust
---

rust 教程 02: 例子

<!--more-->

一个简单的猜数小游戏。

```rust
// 导入包的方式
use rand::Rng; // 为什么导入 rng，但是下面没有用 rng，而是直接用 rand::thread_rng().gen_range();
use std::{cmp::Ordering, io};

fn main() {
    // let x = String::new(); 不加 mut 修饰词，则默认为 immut
    let secret_number = rand::thread_rng().gen_range(1, 101);

    loop {
        println!("please input a number:");

        let mut guess = String::new();
        io::stdin().read_line(&mut guess).expect("input error!");

        // let guess: u32 = guess.trim().parse().expect("pls input an interger...");

        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        match guess.cmp(&secret_number) {
            Ordering::Equal => {
                println!("win!!!");
                break;
            }
            Ordering::Less => {
                println!("less~");
            }
            Ordering::Greater => {
                println!("greater~");
            }
        }
    }
}

```

---

## 参考
1. https://www.youtube.com/watch?v=e3-2uxHhbzs&list=PL3azK8C0kje1DUJbaOqce19j3R_-tIc4_&index=1&t=140s
2. 《rust权威指南(The Rust Programming Language)》