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

- [下载与安装](#下载与安装)
  - [windows](#windows)
  - [linux](#linux)
  - [解决必须使用root登录mysql的问题](#解决必须使用root登录mysql的问题)
- [基本操作](#基本操作)
  - [登录](#登录)
  - [更改密码](#更改密码)
  - [查询基本信息](#查询基本信息)
  - [增删改查](#增删改查)
    - [select](#select)
    - [insert](#insert)
    - [update](#update)
    - [delete](#delete)
  - [复制表](#复制表)
  - [修改表结构](#修改表结构)
  - [创建](#创建)
    - [数据库](#数据库)
    - [表](#表)
  - [执行sql文件](#执行sql文件)
  - [数据备份](#数据备份)
- [基本知识](#基本知识)
  - [各种引号](#各种引号)
  - [datetime](#datetime)
  - [数据类型](#数据类型)
    - [数值](#数值)
    - [日期](#日期)
    - [字符串](#字符串)

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

## 解决必须使用root登录mysql的问题
```shell
​ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
flush privileges;
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
# 在windows里面上述命令总报错，遂使用下面这个
SET PASSWORD = '123';
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

## 复制表

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

## 修改表结构

```sql
-- 增加字段
alter table perple add name varchar(200) default null comment '名称';
-- 修改字段
alter table perple change oldname newname varchar(20) not null default '0';
-- 删除字段
alter table perple drop name;
```

## 创建

### 数据库

```sql
CREATE DATABASE IF NOT EXISTS test default character set utf8 COLLATE utf8_general_ci;
```

### 表

```sql
DROP TABLE IF EXISTS `test`;
CREATE TABLE IF NOT EXISTS `test` (
  `id` bigint(20) NOT NULL,
  `type` int(4) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

## 执行sql文件

```sql
source absolute_path
\. absolute_path
```

## 数据备份

```bash
# 导出数据库中所有的表结构和数据
mysqldump -u root -p dbname > dump.txt
mysqldump -u root -p dbname tablename > dump.txt
# 只导出表结构
mysqldump --opt -d dbname -uroot -p > xxx.sql
mysqldump --opt -d dbname tablename -uroot -p > xxx.sql
# 只导出数据
mysqldump -t dbname -uroot -p > xxx.sql
mysqldump -t dbname tablename -uroot -p > xxx.sql
```

# 基本知识

## 各种引号

- 严格上，sql没有双引号，只有单引号和反引号，但是某些数据库对sql进行了一定的扩展，所以也支持双引号
- 单引号，用来表示字符串
- 反引号，用来表示表名或者列名，防止与关键字冲突

## datetime

插入的时候一般按照`2020-5-9 16:02:22`这种格式。

系统也会自动识别数据格式:
- 20191221010203
- 2019/12/21/1/21/3

## 数据类型

- 数字类型
  - 整数: tinyint、smallint、mediumint、int、bigint
  - 浮点数: float、double、real、decimal
- 日期和时间: date、time、datetime、timestamp、year
- 字符串类型
  - 字符串: char、varchar
  - 文本: tinytext、text、mediumtext、longtext
- 二进制(可用来存储图片、音乐等): tinyblob、blob、mediumblob、longblob

### 数值

***整型***

| type | Storage | Minumun Value | Maximum Value|
| :------------- | :------------- | :------------- | :------------- |
||(Bytes)|(Signed/Unsigned)|(Signed/Unsigned)|
|TINYINT|1|-128|127|
|||0|255|
|SMALLINT|2|-32768|32767|
|||0|65535|
|MEDIUMINT|3|-8388608|8388607|
|||0|16777215|
|INT|4|-2147483648|2147483647|
|||0|4294967295|
|BIGINT|8|-9223372036854775808|9223372036854775807|
|||0|18446744073709551615|

***浮点型***

| 属性 | 存储空间 | 精度 | 精确性 | 说明 |
| ---- | ----  | ---- | ---- | ---- |
|FLOAT(M, D)|4 bytes|单精度|非精确| 单精度浮点型，m总个数，d小数位 |
|DOUBLE(M, D)|8 bytes|双精度|比Float精度高| 双精度浮点型，m总个数，d小数位 |

- FLOAT容易造成精度丢失

***定点数DECIMAL***

- 高精度的数据类型，常用来存储交易相关的数据
- DECIMAL(M,N).M代表总精度，N代表小数点右侧的位数（标度）
- 1 < M < 254, 0 < N < 60;
- 存储空间变长

### 日期

| 类型 | 字节 | 例 | 精确性 |
| ---- | ----  | ---- | ---- |
| DATE | 三字节 | 2015-05-01 | 精确到年月日 |
| TIME | 三字节 | 11:12:00 | 精确到时分秒 |
| DATETIME | 八字节 | 2015-05-01 11::12:00 | 精确到年月日时分秒 |
| TIMESTAMP |  | 2015-05-01 11::12:00 | 精确到年月日时分秒 |

- MySQL在`5.6.4`版本之后，`TIMESTAMP`和`DATETIME`支持到微秒。
- `TIMESTAMP`会根据系统时区进行转换，`DATETIME`则不会
- 存储范围的区别  
    - `TIMESTAMP`存储范围：1970-01-01 00::00:01 to 2038-01-19 03:14:07
    - `DATETIME`的存储范围：1000-01-01 00:00:00 to 9999-12-31 23:59:59
- 一般使用`TIMESTAMP`国际化
- 如存时间戳使用数字类型`BIGINT`

### 字符串

| 类型 | 单位 | 最大 | 特性 |
| ---- | ----  | ---- | ---- |
| CHAR | 字符 | 最大为255字符 | 存储定长，容易造成空间的浪费 |
| VARCHAR | 字符 | 可以超过255个字符 | 存储变长，节省存储空间 |
| TEXT | 字节 | 总大小为65535字节，约为64KB | - |

- TEXT在MySQL内部大多存储格式为溢出页，效率不如CHAR
- Mysql默认为utf-8，那么在英文模式下1个字符=1个字节，在中文模式下1个字符=3个字节。