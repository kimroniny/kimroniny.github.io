---
title: rust教程-07
date: 2022-11-13 16:31:00
tags:
- rust
categories:
- rust
---

rust 教程 07: 包

<!--more-->

## package 和 crate

crate 的类型：
- binary
- library

crate root：
- 源代码文件
- rust 编译器从这里开始，组成 crate 的根 module

package：
- 包含 1 个 crate.toxl，他描述了如何构建这些 crates
- 只能包含 0-1 个 library crate
- 可以包含任意数量的 binary crate
- 但必须至少包含一个 crate（library 或者 binary）

cargo 的惯例：
- src/main.rs：binary crate
  - bianry crate 的 crate root
  - crate 名与 package 名相同
- src/lib.rs：library crate
  - package 包含一个 library code
  - library crate 的 crate root
  - crate 名与 package 名相同
- crago 把 crate root 文件交给 rustc 来构建 library 或者 binary
- 一个 package 可以同时包含 src/main.rs 和 src/lib.rs
- 一个 package 可以有多个 binary crate

## Module

Module：
- 在一个 crate 内，将代码进行分组
- 增加可读性
- 控制项目的私有性：public、private

建立 module：
- mod 关键字
- 可嵌套
- 可以包含其他项的定义
  
## path 路径

为了在 rust 的模块中找到某个条目，需要使用路径，两种形式：
- 绝对路径：从 crate root 开始，使用 crate 名或者字面值 crate 
- 相对路径：从当前模块开始，使用 self、super 或者当前模块的标识符
- 路径至少由一个标识符组成，标识符之间使用 ::

## 私有性

- 模块不仅可以组织代码，还可以定义私有边界
- 如果想把函数或者 struct 等设为私有，可以将其放到某个模块中
- rust 中所有的条目（函数、方法、struct、enum、模块、常量）等默认都是私有的
- 父级模块无法访问子模块中的私有条目
- 子模块可以使用所有祖先模块中的条目

```rust
mod front_of_house {
    // 声明为公共的
    pub mod hosting {
        fn add_to_waitlist() {}
    }
}

pub fn eat_at_restaurant() {
    // 绝对路径
    crate::front_of_house::hosting::add_to_waitlist();

    // 相对路径
    front_of_house::hosting::add_to_waitlist();
}
```
## super 关键字

访问父级模块或者方法

## pub struct
- struct 是公共的
- struct 的字段默认是私有的
- 想把哪个字段设置为公有的，就在其前面设置为 pub

## pub enum：
- enum 是公共的
- 所有元素也是公共的，不需要单独设置为 pub

## use 关键字 

- 对于函数，引入到父级，即上一级即可；
- 对于 struct、enum，引入到同一级；
- 也就是对于同名条目，引入到父级即可
- 使用 use 导入到作用域内后，该名称在该作用域内是私有的
  - 使用 pub use 重导出，外部代码就可以引入到他们的作用域

```rust
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}

// 使用绝对路径引入 hosting
// 使用 as 搞个别名
use crate::front_of_house::hosting as hosting1;

// 使用相对路径引入 hosting
// 针对函数，一般是引入到上一级，避免引入多个相同名字的函数
use front_of_house::hosting as hosting2;

pub fn eat_at_restaurant() {
    // 绝对路径
    crate::front_of_house::hosting::add_to_waitlist();

    // 相对路径
    front_of_house::hosting::add_to_waitlist();

    hosting::add_to_waitlist();
}
```

## 使用外部包 package

- cargo.toml 添加依赖的包 package
- use 将特定条目引入到作用域
- std 包不需要放入到 c

cargo.toml 中

使用嵌套路径来引入相同 package 下的多个条目
```rust
use std:: {
    cmd::Ordering,
    io
};
use std::io{
    self, // 引入自己
    write
};
```

## 将模块内容移动到其他文件

模块定义时，如果模块后边是 ";"，而不是代码块：
- rust 会从与模块同名的文件中加载内容
- 模块树的结构不会变化

```bash
src/
├── front_of_house
│   └── hosting.rs
├── front_of_house.rs
├── lib.rs
└── main.rs
```

```rust
// src/front_of_house.rs
pub mod hosting; // 依旧要声明为 pub，公有类型

// src/front_of_house/hosting.rs
pub fn add_to_waitlist() {}
```