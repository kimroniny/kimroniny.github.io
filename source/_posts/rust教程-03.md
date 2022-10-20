---
title: rust教程-03
date: 2022-10-20 19:28:22
tags:
categories:
---

rust 教程 03 基本内容

<!--more-->

## 变量、常量、隐藏

### 变量

```rust
let x = 5; // 不可变变量
let mul x = 3; // 可变变量，通过 mut 修饰符
```

### 常量

常量 constant，绑定值以后也是不可变的，但是与不可变变量有很多区别
1. 不可以使用 mut 修饰符，常量永远不可变
2. 声明常量使用 const，且必须标注类型
3. 可以在任何作用域内声明，包括全局作用域
4. 只可以绑定到常量表达式，无法绑定到函数的调用结果或者运行时才能计算出的值
命名规范：使用全大写字母，用下划线分开单词

```rust
const MAX_POINTS: u32 = 100;
```

### 隐藏

```rust
let y = 1;
// y = y + 1; // error: 不可变变量
let y = y + 1; // ok: 隐藏了上一个 y
let y = "hello"; // ok: 可以改变 y 的类型
```

## 强类型语言

rust 是静态编译语言，在编译时必须直到所有变量的类型，即：

- 基于使用的值，编译器可以推断出它的具体类型
- 如果类型比较多，必须添加类型标注，否则编译报错

```rust
// 变量 x 必须指明类型 u32，因为 parse() 的结果产生的类型可能有很多，比如 i32，i64，u64 等等
let x: u32 = "43".parse().expect("pls input a number"); 
```

## 标量类型

一个标量类型代表一个单个的值

四个标量类型：整数、浮点、布尔、字符

### 整数类型

- 十进制：97_88 可以加下划线
- 十六进制：0xff 可以加下划线
- 八进制：0o99 可以加下划线
- 二进制：0b01_0101 可以加下划线
- 字节（u8）：b'A'

整数溢出：
- debug模式下，会 panic
- release 模式下，会发生“环绕”操作，不会 panic

### 浮点类型

- f32，32位，单精度
- f64，64位，双精度，默认类型，精度更高，和 f32 的速度在现代 CPU 上差不多

### 布尔类型

bool
- true
- false

### 字符类型

char

单引号

占用 4 个字节

Unicode 标量值，可以表示比 ASCII 多得多的字符内容
- U+0000 到 U+D7FF
- U+E000 到 U+10FFFF

## 复合类型

复合类型：可以将多个值放在一个类型里

两种基础的复合类型：元组（Tuple）、数组

### Tuple

可以将多个类型的值放在一个类型里，每个位置对应一个类型

长度固定，一旦声明无法改变

```rust
let tup:(i32, f64, u8) = (400, 4.6, 1); 
let (x, y, z) = tup;
println!("{}, {}, {}", tup.0, tup.1, tup.2); // 通过 .index 的方式来取值
```

### 数组

如果想要保存数据在栈而不是堆上，或者保证有固定数量的元素，就可以使用数组

数组没有 vector 灵活，vector 由标准库提供

优先使用 vector

访问越界的话，在编译期间不会报错，但是在运行时会 panic，rust 不允许访问越界地址的内存

```rust
let a = [1, 2, 3, 4];
let a: [i32: 5] = [1,2,3,4,5]; // [类型：长度]
let a = [3; 5]; // 等同于 let a = [3,3,3,3,3]，即 a = [初始值；长度]
```

## 函数

针对函数和变量名，使用 snake case 命名规范，所有字母小写

```rust
fn main() {
    add(34,5); // argument
}

// parameter, 必须声明每个参数的类型
fn add(x: i32, y: i32) -> i32{  // 只有返回值的类型，不可以为返回值命名
    x + y // 最后一个表达式即为返回值，也可以使用 return 提前返回
    // x + y; // 不可以加分号，如果加了分号，就是语句，语句的返回值是空的 tuple，即 () 
}
```

## 控制流: 条件表达式

```rust
fn main() {
    let x = 3;

    if x % 10 == 0 {

    } else if x % 3 == 0 {

    } else if x % 7 == 0 {

    }

    let y = if x % 10 == 0 { 5 } else { 6 }; // 返回值类型必须是统一的，即编译期间能够确定类型
}
```

## 控制流: 循环

```rust
fn main() {

    // loop 循环
    loop {
        println!("loop...");
    }

    // loop 循环返回一个结果
    let mut counter = 0;
    let result = loop {
        counter += 1;
        if counter == 10 {
            break counter; // 通过 break 返回当前 loop 的值
        }
    }

    // while 循环
    while counter != 100 {
        counter += 1;
    }

    // for 循环
    let a = [1,2,3,4,5];
    for element in a.iter() {
        println!("element is {}", element);
    }

    // for range
    for element in (1..4).rev() { // (1..4) 只有 1,2,3 不包括 4，rev 就是反转一下
        println!("element is {}", element);
    }

}
```
