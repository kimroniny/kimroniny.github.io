---
title: rust教程-01
date: 2022-10-17 12:56:39
tags:
- rust
categories:
- rust
---

rust教程 - 01 - 基础

<!--more-->

## 基础知识

rust 擅长的领域：
- 高性能 web service
- WebAssembly
- 命令行工具
- 网络编程
- 嵌入式设备
- 系统编程

rust 的优点：
- 性能（媲美 c/c++）
- 安全性（内存）
- 无所畏惧的并发

## 安装

官网：https://www.rust-lang.org/

```bash
rustup update # 更新
rustup self uninstall # 卸载
rustc --version # 版本
```

开发工具：`vscode`

插件：`rust`

## 基本程序

后缀名：`.rs`

文件命名规范：`hello_world.rs`

编译：`rustc main.rs`，产生可执行文件

编译需要服务器安装 `gcc`

rust 是 ahead-of-time 编译的语言，可以先编译，然后把可执行文件交给别人运行（无需安装 rust）。

## cargo

cargo 是 rust 的构建系统和包管理工具，即：构建代码、下载依赖的库、构建这些库...

安装 rust 的时候会安装 cargo。`cargo --version`

包 packages 在 cargo 中叫做 `crate`

cargo 生成的 main.rs 放在 src/ 目录下, cargo.toml 在项目顶层下，源代码都在 src/ 目录下，顶层目录可以放 readme、许可信息、配置文件、说明文档等与程序源码无关的文件

```bash
cargo --version

# 创建项目 hello_cargo
# 包括文件:
# # cargo.toml 配置文件
# # src/ 源代码
# # .gitignore 
cargo new hello_cargo

# 编译，创建可执行文件
# target/build/hello_cargo.exe
# cargo.lock文件，负责追踪项目依赖的精确版本
cargo build

# 编译 + 执行
# 如果已经编译过且代码未修改，则直接执行
cargo run

# 检查代码是否可以通过编译，不产生可执行文件
# 可以连续反复使用
cargo check

# 为发布构建
# 编译时会进行优化，代码运行的更快，但是编译时间会更长
# target/release
cargo build --release
```

cargo 更换国内源，在 `~/.cargo/config` 文件中填写下面内容，网络上提供了很多国内源，但是好像只有中科大的能用。
```config
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
# 指定镜像
replace-with = 'ustc'

# 中国科学技术大学
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
```

---

## 参考
1. https://www.youtube.com/watch?v=e3-2uxHhbzs&list=PL3azK8C0kje1DUJbaOqce19j3R_-tIc4_&index=1&t=140s
2. 《rust权威指南(The Rust Programming Language)》