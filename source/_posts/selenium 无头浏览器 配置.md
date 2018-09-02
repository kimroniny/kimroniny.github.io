---
title: selenium 无头浏览器 配置
date: 2018-09-02 23:31:41
tags: selenium
categories: selenum
---

python 中selenium设置无头浏览器配置options

<!--more-->

> phantomjs 在新版本selenium中已经warning不支持了

```python
from selenium import webdriver 

options = webdriver.FirefoxOptions()
options.add_argument("--headless")
webdriver.Firefox(options=options)
```
