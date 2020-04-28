---
title: mysql常用指令和知识
date: 2020-04-23 15:18:38
tags:
- database
- mysql
categories:
- database
- mysql
---

关于mysql的基本操作，平时自己用的比较多的，以后方便用。

<!--more-->


- [下载与安装](#%e4%b8%8b%e8%bd%bd%e4%b8%8e%e5%ae%89%e8%a3%85)
  - [windows](#windows)
  - [linux](#linux)
- [基本操作](#%e5%9f%ba%e6%9c%ac%e6%93%8d%e4%bd%9c)
  - [登录](#%e7%99%bb%e5%bd%95)
  - [更改密码](#%e6%9b%b4%e6%94%b9%e5%af%86%e7%a0%81)
  - [查询基本信息](#%e6%9f%a5%e8%af%a2%e5%9f%ba%e6%9c%ac%e4%bf%a1%e6%81%af)
  - [增删改查](#%e5%a2%9e%e5%88%a0%e6%94%b9%e6%9f%a5)
    - [select](#select)
    - [insert](#insert)
    - [update](#update)
    - [delete](#delete)
- [基本知识](#%e5%9f%ba%e6%9c%ac%e7%9f%a5%e8%af%86)
  - [各种引号](#%e5%90%84%e7%a7%8d%e5%bc%95%e5%8f%b7)

# 下载与安装

## windows

- 官网下载 community server 的压缩包即可，其他组件不用下载
- 解压之后，添加 bin 文件夹到环境变量中
- 将mysql写入windows服务，`mysqld install`
- 启动服务，`net start mysql`

有的时候在启动的过程中，会出现 `本地计算机上的mysql服务启动后停止，某些服务在未由其他服务或程序使用时将自动停止`。此时只需要：
- 删除掉安装目录下 `data` 目录
- 执行 `mysqld --remove mysql`
- 初始化mysqld --initialize-insecure --user=mysql
- 启动服务，`net start mysql`

在windows中，删除某个service的方法：在管理员cmd下，执行 `sc delete mysql`，service的名称可以在 `services.msc` 中右击服务点击属性查看。

## linux

```bash
sudo apt update
sudo apt install mysql-server
sudo mysql_secure_installation
sudo mysql -uroot -p # 注意这里必须使用 sudo
service mysql status
```

# 基本操作

## 登录

```bash
mysql -h12.228.12.12 -P3306 -uroot -p'adadfafaf'  -Dtest_db -A --default-character-set=utf8
# 简化版
mysql -uroot -p
```

## 更改密码

```bash
# 使用 mysqladmin
mysqladmin -uroot -p password 123456
# 登录之后修改
set password for root@localhost = password('123'); 
# update编辑user表
use mysql;
update user set password=password('123') where user='root' and host='localhost'; 
flush privileges; 
```

忘记密码的时候可以这样：

- 关闭正在运行的MySQL服务。 
- 打开DOS窗口，转到mysql\bin目录。 
- 输入mysqld --skip-grant-tables 回车。--skip-grant-tables 的意思是启动MySQL服务的时候跳过权限表认证。 
- 再开一个DOS窗口（因为刚才那个DOS窗口已经不能动了），转到mysql\bin目录。 
- 输入mysql回车，如果成功，将出现MySQL提示符 >。 
- 连接权限数据库： use mysql; 。 
- 改密码：update user set password=password("123") where user="root";（别忘了最后加分号） 。 
- 刷新权限（必须步骤）：flush privileges;　。 
- 退出 quit。 
- 注销系统，再进入，使用用户名root和刚才设置的新密码123登录

## 查询基本信息

```sql
-- 查询数据库
show databases;
-- 查询数据库的所有表名
SHOW TABLES [FROM db_name];
select table_name from information_schema.tables where table_schema='your_db_name';
-- 查询表的所有列名
SHOW COLUMNS FROM tbl_name [FROM db_name];
select COLUMN_NAME from information_schema.COLUMNS where table_name = 'your_table_name' and table_schema = 'your_db_name';
-- 查询数据表结构
SHOW CREATE TABLES tbl_name;
```

## 增删改查

### select

```sql
select a, b, c from table where id > 1;
```

### insert

```sql
INSERT INTO table_name (column1, column2, column3 ) VALUES (value1, value2, value3, ...);
```

### update

```sql
# 多个字段更新，用逗号分隔
UPDATE table_name SET column1 = value1, column2 = value2 WHERE condition;
```

### delete

```sql
DELETE FROM table_name WHERE condition;
```

### 复制表

```sql
-- 复制表结构和数据
CREATE TABLE 新表 SELECT * FROM 旧表;
-- 仅复制表结构
CREATE TABLE 新表 SELECT * FROM 旧表 WHERE 1=2;
CREATE TABLE 新表  LIKE 旧表;
-- 复制旧表数据到新表
INSERT INTO 新表(字段1,字段2,.......) SELECT 字段1,字段2,...... FROM 旧表;
-- 如果两个表的结构一致，则可以
INSERT INTO 新表 SELECT * FROM 旧表;
-- 复制旧表内容到新表
SELECT * INTO 新表 FROM 旧表;
-- 旧表结构复制到新表
SELECT * INTO 表2 FROM 表1 WHERE 1=2;
```

### 修改表结构

```sql
-- 增加字段
alter table perple add name varchar(200) default null comment '名称';
-- 修改字段
alter table perple change oldname newname varchar(20) not null default '0';
-- 删除字段
alter table perple drop name;
```

# 基本知识

## 各种引号

- 严格上，sql没有双引号，只有单引号和反引号，但是某些数据库对sql进行了一定的扩展，所以也支持双引号
- 单引号，用来表示字符串
- 反引号，用来表示表名或者列名，防止与关键字冲突