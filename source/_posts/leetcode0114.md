---
title: leetcode0114
date: 2020-08-02 21:35:24
tags:
- ACM
- leetcode
categories:
- ACM
- leetcode
---

leetcode 0114 心得

<!--more-->

自己的做法：先调换顺序，再把右子树搞成链，并获取链尾指针，然后把左子树添加到链尾，再返回新的链尾

```c++
class Solution {
public:
    void flatten(TreeNode* root);
private:
    TreeNode* deal(TreeNode* root);
};

void Solution::flatten(TreeNode* root){
    this->deal(root);
}

TreeNode* Solution::deal(TreeNode* root){
    if (!root) return NULL;
    // swap left and right
    if (root->left){  // 如果左边没有子树，那就不需要调整；只有有左子树的时候，才需要和右子树上交换，然后把右子树调整到它的下面去，从而保证顺序顺序
        TreeNode *temp = root->right;
        root->right = root->left;
        root->left = temp;
    }
    TreeNode *righttail = this->deal(root->right);  // 先处理右子树，搞成一条链，并返回链的末尾，然后把左子树连接到末尾。
    if (!righttail) return root; // 最终找到的末尾是NULL，所以要返回NULL的父节点。
    righttail->right = root->left;
    root->left = NULL; // 把左子树连接到右子树链的末尾之后，左子树要置空。
    TreeNode *lefttail = this->deal(righttail->right); //把左子树也搞成一条链。
    if (!lefttail) return righttail; // 最终找到的末尾是NULL，所以要返回NULL的父节点
    return lefttail; // 返回tail节点
}
```

在题解里面看到了更简洁的做法。

```c++
class Solution {
public:
    void flatten(TreeNode* root) {
        if(!root || (!root->left && !root->right)) return; // 到达叶子节点
        flatten(root->left);
        flatten(root->right);
        TreeNode *right = root->right; // 先保存原右子树
        root->right = root->left;  // 把原左子树移到右边
        root->left = nullptr; // 把现左子树置空
        TreeNode *cur = root;
        while(cur->right) cur = cur->right; // 找到现右子树的末尾
        cur->right = right;  // 因为左右子树在递归的过程中，都已经成为链，所以只需要简单的添加到现右子树末尾即可。
    }
};
```

比较了一下两种解法，我的是属于先调换顺序（其实调换顺序这里可以直接把左子树放到右边，右子树放到temp存着，而不用放到），把右子树搞成链，然后把左子树添加到右子树末尾，再把左子树搞成链；而题解里的做法是先把左右子树都搞成链，然后调换顺序，找到右子树的末尾，把左子树拼接上去。

从题解里面又深入理解了递归的意义：每一部分的递归都是求解子问题，然后对于当前的问题，考虑如何把已经求解成功的子问题拼接在一起，考虑如何处理叶子节点（也就是边界）。