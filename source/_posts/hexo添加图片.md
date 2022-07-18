---
title: hexo添加图片
date: 2019-12-01 01:10:14
categories:
- hexo
---

如何为hexo网站添加图片呢？
<!--more-->

```_config.yml```中的```post_asset_folder```设为```true```

每次执行指令```hexo new "new_post"```，都会在```_post```目录下生成对应名称的文件夹，把图片放里面

md文件中的图片只需要图片名+后缀名