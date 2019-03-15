---
layout: post
title:  UnitConverterPost
date:  2018-10-10 10:59:40
category: post
tags: [Swift , String ]
---



# UnitConverter



## 문제를 풀면서 모르는 부분을 post



### hasSuffix(_:) -> Bool

: 문자열의 마지막이 주어진 문자열과 같은지 여부를 Bool으로 반환

```swift
func cutValue(_ userValue: String , _ unit: String) ->(number : String ,charUnit : String) {
    if userValue.hasSuffix(unit) {
        let unitStr = unit
        let i = unitStr.index(unitStr.startIndex, offsetBy: 0)
        
        let index = userValue.index(of:unitStr[i]) ?? userValue.endIndex
        let number = String(userValue[..<index])
        let charUnit = String(userValue[index...])

        return (number , charUnit)
    } else {
        return ("nil","nil")
    }
}
```





### String 쪼개기 

두개의 차이는 뭘까?  차이는 스페이스를 어떻게 취급하느냐?! 이다.

components 메소드를 사용했을때 , count 가 2가 나오는데

split 메소드를 사용했을때 , 공백을 무시한다.

* **components(separatedBy: " ")       반환 : Array**  

```swift
var stringArr =  "1+2-3*4/5"
var arr =  stringArr.components(separatedBy: ["+","-","*","/"])
print(arr)
```



* **split(separator: " ")** 

map을 사용하지 않으면 이상한 영문값이 찍혀서… map으로 찍었다.

```swift
let userLine = readLine() //ex) 123cm m
let userValue = userLine?.split(separator:" ").map{ String($0) }
print(userValue![0])
print(userValue![1])
```



* **split(separator: " " , maxSplits : Int)**

: maxSplits : 콜렉션을 분활하는 최대 횟수 또는 반환 할 시퀀스 수 (count) 보다 적은 수 . maxsplits은 0보다 크거나 같아야 한다.

기본값은 Int.max  (쉽게는 쪼개는 횟수)

```swift
let userLine = readLine() //ex) 123cm m
let userValue = userLine?.split(separator:" " , maxSplits :1).map{ String($0) }

// 공백을 기준으로 쪼개준다.
// maxSplits 1이라서 한번만 쪼갠다.
// maxSplits 0이면 안쪼갠다.
```



* **indices**

: String을 Character로 분해해준다.

```swift
//사용자의 숫자와단위를 str 변수에 저장해서 반복문을 돌리기 위해 변수에 저장
    let str = userValue[0]
    //앞에서부터 숫자가 몇개인지 판별하기 위해
    var num = 0
    // 숫자랑, 단위 저장할 변수 선언
    var number : String = ""
    var userUnit : String = ""
    
    // 아스키코드 값으로 숫자를 판별할려고 반복문 설치
    for index in str.utf16 {
        if index >= 48 , index <= 57 {
            num += 1
        }
    }
    // 문자 하나씩 접근해서 숫자랑 문자랑 나누려고 사용
    for i in str.indices {
        if num > 0 {
            number.append(str[i])
            num -= 1
        }else {
            userUnit.append(str[i])
        }
    }
```



* **sorted(by: <)**

: 정렬을 하고 싶어서 사용해 보았다.

```swift
func dicSort(_ unit:[String:Double]) {
    let order = unit.sorted(by: <)
    print(order)
}
```



* **terminator**

: print 시 newline 이 안된다.

```swift
for n in 1...5 {
    print(n) //1
    print(n,terminator:" ") //2
}
```

1번의 결과는

1

2

3

4

5

2번의 결과는 

1 2 3 4 5

