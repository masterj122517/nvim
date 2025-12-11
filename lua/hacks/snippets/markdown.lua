local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  s(
    'blog',
    fmt(
      [[
---
title: {}
date: {}
tags: [{}]
---

{}
]],
      {
        i(1, ''),
        i(2, os.date '%y-%m-%d'),
        i(3, '标签1, 标签2'),
        i(0),
      }
    )
  ),

  s(
    'rec',
    fmt(
      [[
Date: {}

Start Feelings: {}

Things to do: {}

While Doing feelings: {}

After feelings: {}

Review: {}
]],
      {
        i(1, os.date '%y-%m-%d'),
        i(2, ''),
        i(3, ''),
        i(4, ''),
        i(5, ''),
        i(6, ''),
      }
    )
  ),

  s(
    'learning',
    fmt(
      [[
## 1. 我为什么要学它？
- 解决什么问题？
- 最核心的本质是什么？

---

## 2. 当前小目标是什么？
- 我希望做到什么？
- 完成后的可见成果是什么？

---

## 3. 先做一个 Toy Project
- 项目内容：
- 卡住的点 / 我不理解的地方（只记录，不解决）：

---

## 4. 用问题驱动学习（What / Why / How）
问题：
- What：
- Why：
- How：

（重复添加多个问题）

---

- 大目标：
- 小目标列表：
  - 
  - 
  - 
- 下一步行动（只写一个）：
]],
      {}
    )
  ),
  s(
    'reinforcement',
    fmt(
      [[
## 1. 最终能力（学完后我能做什么？）
（只写可执行的能力，不写抽象概念）
- 

---

## 2. 实现背后的理论（核心思想 / 本质）
（最小理论集：必须知道什么才能做出来？）
- 
- 

---

## 3. 实现框架（Architecture / Pipeline）
（一步步怎么做？必要的模块有哪些？）
- 
- 
- 

---

## 4. 构造框架时遇到的问题
（阻塞点、理解不清的地方、接口冲突、边界）
- 
- 
- 

---

## 5. 思考细节（Edge cases / tricky part / 注意事项）
（最容易踩坑的细节、隐藏假设、边界条件）
- 
- 
- 

---

## 6. 向自己解释所有东西（Self-explain）
（像给 15 岁的自己解释一样——用自己的语言）
- 这东西是什么？
- 为什么这样设计？
- 如果不用它，会怎样？
- 换一种实现会怎样？
- 哪里的 trade-off 最大？

---

## 7. 实现（Implementation Log）
### 实现过程记录
- 步骤 1：  
- 步骤 2：  
- 步骤 3：  

### 难点 & 解决方法
- 难点：
- 解法：
- 原因：

---

## 8. 复盘（Review）
（强化、抽象、总结、提炼 mental model）
- 我真正学到什么？
- 哪些地方最卡？
- 我最终是怎样突破的？
- 哪些抽象是可以复用到下一次学习中的？
- 下一步可以做什么？
]],
      {}
    )
  ),

  s(
    'working',
    fmt(
      [[
## 1. 设立目标
（本次工作要完成什么？一句话纲领）
- 

### 预期成果
- 

---

## 2. 建立框架（Outline / Architecture）
（整体结构、模块、流程图、接口、关键抽象）
- 
- 
- 

---

## 3. 框架构建过程中的问题 & 关键细节
（设计阶段遇到的坑、限制、冲突、注意事项）
- Issue：
- Detail：
- Risk：

---

## 4. 解决框架问题（Decision Log）
（怎么解决的？为什么这么做？为什么不用其他方案？）
- 问题：
- 决策：
- 理由（Trade-offs）：

---

## 5. 实现（Implementation Log）
### 过程记录
（按照时间或步骤记录实现过程）
- 
- 
- 

### 难点 & 解决方案
- 难点：
- 解法：

### 关键细节（避免未来踩坑）
- 
]],
      {}
    )
  ),
}
