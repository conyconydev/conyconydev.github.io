---
layout: post
title:  Collection Types
date:  2018-09-17 23:02:46
category: SwiftIos
tags: [Swift,Collection Types]
---

### Tuple

```swift
var one = (1,"one","일")

one.2 = "하나"

var two = (num: 2, eng: "two",kor: "둘")
two.num //2
two.kor //둘
```

* 비교

```swift
//순서대로 비교 (앞쪽 숫자비교 하고, 같다면 그다음꺼 비교)
(1,"1")==(1,"1") //true
(1,"one")<(2,"two") //true
```



### Array

```swift
//생성
var intArray = [1,2,3,4,5]
let strArray = ["a","b","c"]
let floatArray = Array<Float>([1.1,2.2,3.3])
```

```swift
//빈배열 생성
var emptyArray = [Int]()
```

 ```swift
//원소 갯수와 공백 확인
intArray.count
emptyArray.isEmpty
//접근, 첨자표기
let element = intArray[0]
 ```

```swift
//추가
var intArray: [Int] = [1,2,3]
intArray.append(5) //1,2,3,5
intArray.insert(4,at:3) // 1,2,3,4,5
intArray += [6,7] //1,2,3,4,5,6,7
```

```swift
//삭제
intArray.remove(at:3) //index 3번째꺼 삭제
```



### Dictionary

* 키 - 값 방식으로 다수의 값 다루기
* 딕셔너리 내 키는 유일
* 키 : 해시값을 제공할 수 있는 Hashable

```swift
// Dictionary<Key,Value> , [key:value] 

//예 key:String , val:Int
var dic = ["one" : 1 , "two" : 2]
var dic1 = Dictionary<String,Int> = ["one" : 1 , "two" : 2]
// 빈 딕셔너리 객체 생성
var emptyDic = [Int:Int]()
```

```swift
//갯수 : count 프로퍼티
dic.count
//삭제 : removeValue(forKey:)
dic.removeValue(forKey:"one")

```

```swift
//다중 구조
var twoDimensionArray: [[String]] = [["a","b"],["c","d","e"],["f"]]
var DimensionArray[1][1]

//딕셔너리와 배열
let evenNums = [2,4,6]
let oddNums = [1,3,5,7]
let dic : [String:[Int]] = ["even":evenNums , "odd":oddNums]
dic["odd"]![1]
```



### Set

```swift
// 배열에서 생성
var beverage: Set<String> = ["Coke","Juice","Milk"]
// 공백의 set 객체 생성
var letters = Set<Character>() //공백의 set 생성
// 갯수 : count
beverage.count
// 비어있는것
beverage.isEmpty // false
// 원소 포함 확인
beverage.contains("Coke")
// 추가
beverage.insert("Soda")
// 삭제
beverage.remove("milk")
// 연산
/* 
교집합: insersection
합집합: union
대칭차집합: symmetricDifference
차집합: subtracting
*/
var set1: Set<Int> = [1,2,3]
var set2: Set<Int> = [2,3,4]
//교집합
let set3: set1.intersection(set2)
set3 // 2,3
//합집합
let set4: set1.union(set2)
set4 //2,3,1,4
```





