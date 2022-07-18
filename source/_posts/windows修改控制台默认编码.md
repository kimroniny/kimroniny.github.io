---
title: windows修改控制台默认编码
date: 2020-04-18 23:31:34
tags:
- windows
categories:
- windows
---

修改windows控制台cmd的默认编码方式

<!--more-->

命令行输入 `chcp`， 显示当前的控制台编码

输入 `chcp 65001` 会转到新的代码页，编码方式是 `UTF-8`

永久修改方式，修改注册表

```bash
[HKEY_CURRENT_USER\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe]
"CodePage"=dword:0000fde9
```

`fde9` 是 `65001` 的16进制