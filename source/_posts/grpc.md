---
title: grpc
date: 2019-12-05 16:47:35
tags: 
- python 
- grpc
categories:
- python
- grpc
---

关于google grpc的一些基础知识和操作流程

<!--more-->

### 必要的 packages

```bash
pip install grpcio
pip install grpcio-tools
```

### 将 protobuf 生成为 python 代码

```bash
python -m grpc_tools.protoc     -I../../protos      --python_out=.     --grpc_python_out=.     ../../protos/route_guide.proto
// protoc.py [OPTION] PROTO_FILES
// -IPATH: --proto_path=PATH, Specify the directory in which to search for imports.
// --python_out: Generate Python source file
// --grpc_python_out: Generate Python source file
```
