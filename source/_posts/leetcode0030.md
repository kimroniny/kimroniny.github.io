---
title: leetcode0030
date: 2020-08-11 16:38:44
tags: 
- leetcode
categories:
- leetcode
---

leetcode 0030 串联所有单词的子串：滑动窗口

<!--more-->

1. unordered_map<string, int>
   - 判断是否存在某个key，unodr_map.find(key) != unodr_map.end() 
2. auto 类型推导
   - 遍历vector: for (auto x:words) {}
3. vector 
   - 初始化
     - vector<int> f(n, 1);
     - vector<int> f(n);
     - vector<int> f = {1, 2, 3};
     - vector<int> f(v.begin(), v.end());
     - vector<int> f; f = vector<int>(n, 10); // 先声明再初始化
     - vector<int> f; f.resize(10); // 先声明再初始化
     - vector<vector<int>> f(n, vector<int>(n, 10)); // 先声明再初始化
   - 去重
     - #include<set> set<int>s(v.begin(), v.end()); v.assign(s.begin(), s.end());
4. 滑动窗口
   - 如果当前子串在words中不存在，则将窗口 head 和 tail 指向新的位置，继续匹配。
   - 如果当前子串在words中存在（可能已经匹配完一个，也可能没有匹配完，因为子串的出现次数超过了words中存在的数量），则将窗口 head 往后移动一个单词长度，继续匹配。
   - 外部总循环，只需要循环一个单词长度即可，因为只需要以第一个单词长度内的位置作为起始位置，然后后面的循环中会按照上面两步执行

```c++
class Solution {
public:
    vector<int> findSubstring(string s, vector<string>& words) {
        vector<int> result;
        int ls = s.length();
        if (!words.size() || !ls) return result;
        int lw = words[0].length();
        unordered_map<string, int> map, tempmap;
        for (auto &s:words) map[s]++;
        tempmap = map;
        vector<bool> flag(ls, false);
        for (int i = 0; i < lw; i++){  // 这里最开始我写的是 ls，结果总是超时，改成 lw ok。
            if(lw*words.size() > ls-i) break;
            if(flag[i]) continue;
            string word = s.substr(i, lw);
            tempmap = map;
            int count = 0, j = i, k = i;
            while (k+words.size()*lw <= ls && !flag[k]){
                while (tempmap[word]>0) {
                    tempmap[word]--;
                    count++;
                    j+=lw;
                    if (j > ls) break;
                    word = s.substr(j, lw);
                }
                if (count == words.size()) {
                    result.push_back(k);
                    flag[k] = true;
                }
                if (tempmap.find(word) != tempmap.end()){
                    tempmap[s.substr(k, lw)]++;
                    count--;
                    k += lw;
                }else{
                    flag[k] = true;
                    k = j = j+lw;
                    tempmap = map;
                    word = s.substr(k, lw);
                    count = 0;
                }
            }
        }
        return result;
    }
};
```