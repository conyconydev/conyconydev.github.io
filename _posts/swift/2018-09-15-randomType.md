---
layout: post
title:  random,type
date:  2018-09-15 23:02:46
category: post
tags: [swift]
---

* 랜덤 함수

```swift
func arc4random() -> UInt32 {
    var val1: Int = Int(arc4random_uniform(10))
    var val2: UInt = arc4random_uniform(10)
}
```



* 타입 정보 얻기 : type(of: val)

```swift
let i = 100
type(of: i) //Int
```



* 타입 비교

```swift
type(of: intVal) == type(of: intval2)
type(of: intVal) == Int.self
```

