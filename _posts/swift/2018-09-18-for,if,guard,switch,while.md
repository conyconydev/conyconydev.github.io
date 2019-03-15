---
layout: post
title:  for,if,guard,switch,while
date:  2018-09-18 23:02:46
category: post
tags: [Swift,for,if,while,guard,switch]

---

### 반복문

```swift
for i in 0..<10 {
    print("for \(i)")
}

for item in [1,2,3,4,5] {
    print("set array : \(item)")
}

for (kor,eng) in dic1 {
    print("dic: key \(kor) val \(end)")
}

for ch in str.characters {
    print("string char : \(ch)")
}

while i < 10 {
    i+=1
}

repeat {
    j+=1
    if j>10 {break}
}while true
```



### 조건문

- 바인딩

```swift
// 유효한 값 판단 : nil 여부
if let val = someFunc() {
    print("\(val)")
}
// 다중 바인딩
if let val1 = someFunc(), let var2 = anotherFunc() {
    print("val1, val2 유효 값")
}
```

- 버전 검사

```swift
// available(FLATFORM VERSION)
if #available(IOS 10 , macOS 10.12, *) {
    //ios 10 이상 , macOS 10.12 이상
}else {
    //ios 10, macOS 10.12 이전 버전용 코드
}
```

- guard

```swift
guard[조건]else {
    //exit 명령
}
```



- switch

```swift
//case 1,2,3 : // 1혹은 2 혹은 3
//case 4..<6 : // 4와 5라면 실행
//case let(x,y) where x>0 : 
//where 조건을 두어 x가 영보다 크면 실행
switch num {
    case 1:
    print("1")
    case 2:
    print("2")
    fallthrough  // 2번 하고 break 하지말고, 3번까지 해라.
    case 3:
    print("3")
    default:
    print("etc")
}
```



