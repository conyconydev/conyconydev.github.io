---
layout: post
title:  for,Optional
date:  2018-09-18 23:02:46
category: SwiftIos
tags: [Swift,반복문,for,while,Optional]
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

* 바인딩

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

* 버전 검사

```swift
// available(FLATFORM VERSION)
if #available(IOS 10 , macOS 10.12, *) {
    //ios 10 이상 , macOS 10.12 이상
}else {
    //ios 10, macOS 10.12 이전 버전용 코드
}
```

* guard

```swift
guard[조건]else {
    //exit 명령
}
```



* switch

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



## 옵셔널 : Optional

```swift
//생성시 값을 넣지 않으면 nil
var optionalVal: Optional<Int>
var optionalVal1: Int?
//nil 대입 가능
var optionalVal2: Int? = 3
optionalVal2 = nil
```

```swift
//콜렉션과 옵셔널
//array
var array1: [String]?
var array2: [String?]
//dic
var dic1: [String:Int]?
var dic2: [String:Int?]
```

### 옵셔널 사용

* 객체나 데이터를 이용한 함수 , 프로퍼티 , 첨자 접근 등
* 유효한 객체나 유효한 값에서 정상 동작
* nil 에는 - 비정상 동작
* 옵셔널 타입의 객체는 nil 일수도 있다.
* 그래서 옵셔널 타입 객체는 다른 사용 방법
* nil 인 경우와 nil이 아닌 경우 고려

```swift
//에러
var optionalStr: String? = "abc"

//optionalType 직접 사용은 불가!
optionalStr.lowercased()
```



* 옵셔널 타입 : nil 이거나 혹은 유효한 값
* 언래핑 : 옵셔널 타입의 변수에서 유효한 값 얻어오기
* 옵셔널 바인딩
* 옵셔널 체인
* 강제 언래핑



* nil 검사하기

```swift
var optionalStr: String?
if optionalStr != nil {
    print("nil no!!")
}else {
    print("nil yes")
}
```

* 옵셔널 바인딩

```swift
//if 를 이용한 옵셔널 바인딩
if let realStr = optionalStr {
    print("str val \(realStr)")
}else {
    print("string nil")
}

// guard 바인딩 된 상수의 범위 (scope)
func bindingWithWhere() {
    guard let val = nilAvailable, val > 0 else {
        return ;
    }
    print("val > 0 : \(val)" )
}
//다중 바인딩, 함수 호출(옵셔널 타입 반환)
if let val1 = someFunc(), let val2 = anotherFunc() {
    //code....
}
//옵셔널 바인딩 체인
if let val1 = nilAvailableStr, let var2 = Int(val1) {
    //code...
}
//옵셔널 바인딩과 조건 비교
if let val = someFunc(), condition == true {
    //code...
}
```

### 강제 언래핑 (Forced Unwrapping)

* 사용사례 : 객체 생성, 메소드 호출, 프로퍼티 접근, 옵셔널 체인



