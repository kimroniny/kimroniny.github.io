---
title: python 单元测试
date: 2020-04-09 17:26:53
tags: 
- python
- unittest
categories:
- python
- unittest
---

关于python单元测试的常用内容

<!--more-->

## 基本单元测试

使用python自带的unittest进行单元测试, 非常方便。

1. 首先创建测试类, 继承 `unittest.TestCase`。
2. 编写测试用例, 一般命名为 `test+函数名`
3. `setUp()` 方法是在运行测试用例开始之前执行, `tearDown()` 则是在运行测试用例结束之后执行
4. 使用断言, unittest有丰富的断言方法。

```python
import unittest

class TestCase(unittest.TestCase):
    def setUp(self):
        super(TestCase, self).setUp()
    def tearDown(self):
        super(TestCase, self).tearDown()
    def testFunc(self):
        self.assertTrue(True)

if __name__ == '__main__':
    unittest.main()
```

## tornado 单元测试

tornado服务测试采用内置的测试类 `AsyncHTTPTestCase`, 不需要单独在后台开启服务, 只需要实现 `get_app()` 方法, 就可以达到**在测试过程中自动开启服务，测试结束后自动关闭服务**的效果。

示例如下：
1. 创建tornado服务类 `class MapCheck(tornado.web.RequestHandler)`
2. 创建测试类 `class TestClass(AsyncHTTPTestCase)`
- 继承tornado内置单元测试类 `AsyncHTTPTestCase`
- 实现 `get_app()`方法
- 创建测试用例 `test_server()`
    - 使用requests模块构造请求体 `body`
    - 使用 `AsyncHTTPTestCase` 类的 `fetch()` 方法请求接口

```python
# -*-encoding=utf-8-*-
# filename: test_tornado

import unittest, sys
import requests
import tornado.web
from tornado.testing import *
from . import test_tornado as entry

### tornado服务
class MapCheck(tornado.web.RequestHandler):
   def post(self):
      self.write("success")

def make_app(args):
   return tornado.web.Application([
      (r"/map_check", MapCheck, dict(args=args)),
   ])

def getArg():
   return {}


### 测试类
class TestClass(AsyncHTTPTestCase): # 使用tornado内置测试类

   def setUp(self):
      super(TestServer, self).setUp() # 必须有这句
    
   def tearDown(self):
      super(TestServer, self).tearDown() 

   def get_app(self): # 必须实现的方法, 调用make_app()函数
      self.args = entry.getArg()
      return entry.make_app(self.args)

   def test_server(self):
      files = []
      data = {}
      # 构造请求体
      a = requests.Request(url="http://localhost/test", files=files, data=data)
      prepare = a.prepare()
      content_type = prepare.headers.get('Content-Type')
      body = prepare.body
      # 使用fetch()调用tornado接口，传入请求body, 返回response
      headers = {"Content-Type": content_type,}
      response = self.fetch('/map_check', method="POST", body=body, headers=headers)
      self.assertEqual(response.code, 200)

if __name__ == '__main__':
   unittest.main()
```

## grpc 单元测试

grpc服务的单元测试, 使用到 `setUp()` 以及 `tearDown()` 两个方法。

- 在 `setUp()` 中启动grpc服务
- 在 `tearDown()` 中结束grpc服务
- 在测试用例中直接按照grpc客户端访问服务端写法来写即可

```python
# -*- coding: utf8 -*-
import unittest

import grpc_http_server as entry

from proto import audio_pb2, audio_pb2_grpc
from concurrent import futures
import grpc

port = 10051

class AudioClassificationTest(unittest.TestCase):
    def setUp(self):
        options = [('grpc.max_send_message_length', 1000 * 1024 * 1024 * 2),
                   ('grpc.max_receive_message_length', 1000 * 1024 * 1024 * 2)]
        self.server = grpc.server(futures.ThreadPoolExecutor(max_workers=args.max_workers), options=options)
        audio_pb2_grpc.add_GreeterServicer_to_server(entry.Greeter(), self.server)
        self.server.add_insecure_port('[::]:%d' % port)
        self.server.start()

    def tearDown(self):
        self.server.stop(0)

    def test_video_check(self):
        with grpc.insecure_channel('localhost:%d' % port) as channel:
            stub = audio_pb2_grpc.GreeterStub(channel)
            req = audio_pb2.VideoRequest()
            rep = stub.audio_classify(req)

if __name__ == "__main__":
    unittest.main()
```

## Coverage 代码覆盖率单元测试
coverage 用来检测测试代码对被测代码的覆盖率如何。

有两种组织方式:
- 写在 `main` 主体中。

> 在这种方式中, 不能通过 `unittest.main()` 的方式执行测试, 需要通过 `runner` 来执行测试用例, 这一点可以通过 `main` 主体中的代码看到。

- 写在测试用例中。

> 在这种方式中, `main`主体中的执行方式随意, coverage的启动与结束需要包裹在测试用例之中, 这一点可以在 `test_server()`方法中的注释部分看到。

最后生成报告有多种方式(xml, json, html), 通过指定 `omit` 参数, 可以排除不需要的测试覆盖路径(比如某些系统函数)

```python
# -*-encoding=utf-8-*-
import unittest, sys
import coverage

class TestCase(unittest.TestCase):

   def test_server(self):
      """
      如果不在main函数里面写cov，也可以直接在测试用例里面写
      """
      # cov = coverage.Coverage()
      # cov.start()
      self.assertTrue(True)
      # cov.stop()
      # cov.save()
      # cov.report()

if __name__ == '__main__':
   runner = unittest.TextTestRunner()
   suite = unittest.TestLoader().loadTestsFromTestCase(TestCase)

   # 如果不在main函数里面写cov，也可以直接在测试用例里面写，见 test_server()
   # 启动 cov
   cov = coverage.Coverage()
   cov.start()

   # 运行测试用例
   runner.run(suite)

   # 关闭 cov
   cov.stop()
   cov.save()
   cov.xml_report(
      outfile="coverage.xml",
      omit=["./map_check/china_map_pb2*", "./modulecall/*", "/usr/local/ons_agent/names/nameapi.py"]
   )
```

## Mock 单元测试

用来指定某些函数的返回值, 当调用该函数的时候, 直接返回该指定值。

在下面的简单示例中, `beishu()`的返回值是10, 但是在测试用例中通过 `mock.Mock(return_value=5)` 指定它的返回值为5, 再继续进行测试。

```python
# -*-encoding=utf-8-*-
# filename: test_mock
import unittest, sys, mock
from . import test_mock as client

def beishu():
    return 10

def test_add(a, b):
    return beishu() * (a+b)

class TestMathFunc(unittest.TestCase):

    def testAdd(self):
        beishu = mock.Mock(return_value=5)
        client.beishu = beishu
        self.assertEqual(test_add(2, 3), 25)


if __name__ == '__main__':
    unittest.main()
```

## 单元测试, 生成测试报告

可以使用包 `HtmlTestRunner` 来生成html类型的单元测试报告。

使用 `pip` 进行安装, `pip install html-testRunner` 

```python
# -*-encoding=utf-8-*-
import unittest, HtmlTestRunner

def add(a, b):
    return a+b

class TestCase(unittest.TestCase):
    def testAdd(self):
        self.assertEqual(add(1, 2), 3)

if __name__ == '__main__':
    runner = HtmlTestRunner.HTMLTestRunner(
        report_title='TestCase Test',
        report_name='TestCase',
        output='reports/'
    )
    itersuite = unittest.TestLoader().loadTestsFromTestCase(TestCase)
    runner.run(itersuite)
```





