---
title: restful与传统接口的区别
date: 2020-08-01 21:51:58
tags:
categories:
---

restful与传统api接口的区别

<!--more-->

示例：一个状态数据操作接口

**传统模式：**

api/getstate.aspx - 获取状态信息

api/updatestate.aspx - 更新状态信息

api/deletestate.aspx - 删除该状态的数据

 
**RESTful模式：**

api/state 只需要这一个接口

GET 方式请求 api/state - 获取该状态的数据

POST 方式请求 api/state - 更新该状态的数据

DELETE 方式请求 api/state - 删除该状态的数据