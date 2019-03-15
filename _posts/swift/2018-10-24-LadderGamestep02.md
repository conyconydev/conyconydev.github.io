---
layout: post
title:  LadderGamestep02
date:  2018-10-24 11:45:06
category: post
tags: [Swift, ]
---



# LadderGame Step02



## 문제를 풀면서 모르는 부분을 post



## 접근 제어(Access Control)

* 지정한 접근 수준을 개별적인 타입(클래스, 구조체, 열거형)에 할당 할 수 있으며, 뿐만 아니라 이들 타입이 속한 속성, 메소드, 이니셜라이저 그리고 서브스크립트도 포함한다. 프로토콜은 전역 상수, 변수 그리고 함수 같은 특정 컨텍스트로 제한될 수 있다.
* public private(set) var numberOfEdits = 0

​       쓰기는 private 읽기는 public

* `mutating` 키워드는 속성을 수정 가능하도록 정의

* 구조체와 열거형을 위한 타입 메소드는 `func` 키워드 앞에 `static` 키워드를 작성함.

* #### Getters and Setters

  Setter에게 Getter 보다 낮은 접근 제한자를 지정하여 쓰기 접근을 제한 할 수 있다.


```swift
struct LadderPlayer {
    private (set) var name: String
    
    init(name: String) {
        self.name = name
    }
}

```

## 확장(Extensions)

확장은 기존 클래스, 구조체 또는 열거형 타입에 새로운 기능을 추가한다. 기존 소스 코드에서 접근하지 못하는 타입들을 확장하는 능력이다(소급 적용 모델링). Swift 확장은 이름을 가지지 않는다.

Swift에서 확장은 다음 기능을 할 수 있다:

- 계산 속성과 계산 정적 속성 추가
- 인스턴스 메소드와 타입 메소드 정의
- 새로운 이니셜라이저 제공
- 서브스크립트 정의
- 새로운 중첩 타입 정의와 사용
- 기존 타입에 프로토콜 적용하기

확장은 타입에 새로운 기능을 추가할 수 있지만 기존 기능을 오버라이드 할 수 없다.

### 확장 문법(Extension Syntax)

`extension` 키워드로 확장을 선언한다.

```swift
extension SomeType {
    // new functionality to add to SomeType goes here
}
```

확장은 하나 이상의 프로토콜을 만들어 기존 타입에 적용시켜 확장한다.

```swift
extension SomeType: SomeProtocol, AnotherProtocol {
    // implementation of protocol requirements goes here
}
```

기존 타입에 새로운 기능을 추가하기 위해 확장을 정의한다면, 새로운 기능은 기존 타입의 인스턴스에서 가능하다. 심지어 확장이 정의되기 전에 만들어진다.

### 계산 속성(Computed Properties)

확장은 기존 타입에 계산 인스턴스 속성과 계산 타입 속성을 추가할 수 있다. 다음은 다섯개의 계산 인스턴스 속성을 Swift에 탑재된 Double 타입에 추가하는 예제이다.

```swift
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
println("One inch is \(oneInch) meters")
// prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
println("Three feet is \(threeFeet) meters")
// prints "Three feet is 0.914399970739201 meters"
```

이들 계 속성은 Double 값이 특정 길이의 단위로 간주됨을 나타낸다. 계산 속성들로 구현되었지만 부동소수점 리터럴 값에 점 문법으로 속성의 이름을 덧붙여 리터럴 값을 거리값으로 변환할 수 있다.

1.0의 Double value는 일 미터로 표현하는 예제로, `m` 계산 속성은 `self`를 반환한다. 1.m 표현은 1.0의 Double 값으로 계산하여 간주된다.

다른 단위들은 미터 측정값으로 표현되기 위한 변환이 필요하다. 1킬로미터는 1,000 미터와 같고, 그래서 `km` 계산 속성은 1_000.00을 값에 곱하여 표현한다. 유사하게 1미터는 3.28024 피트이고 `ft`는 3.28024를 Double 값으로 나누어 피트를 미터로 변경한다.

이들 속성은 읽기 전용 계산 속성으로, `get` 키워드 없이 짧게 표현된다. Double 타입의 반환 값은 산술 계산을 사용하여 Double에 어디에나 적용된다.

```swift
let aMarathon = 42.km + 195.m
println("A marathon is \(aMarathon) meters long")
// prints "A marathon is 42195.0 meters long"
```

확장은 새로운 계산 속성을 추가할 수 있지만, 저장 속성이나 기존 속성에 속성 감시자를 추가할 수 없다.

### 메소드(Methods)

확장은 새로운 인스턴스 메소드와 타입 메소드를 기존 타입에 추가할 수 있다. 다음은 Int 타입에 인스턴스 메소드를 추가하는 예제이다.

```swift
extension Int {
    func repetitions(task: () -> ()) {
        for i in 0..<self {
            task()
        }
    }
}
```

repetitions 메소드는 타입 `() -> ()` 단일 인자를 가지며, 이 함수는 인자와 반환 값을 가지지 않는다.

확장이 정의된 뒤에, 호출할 만큼의 정수에서 repetitions 메소드를 호출할 수 있다.

```swift
3.repetitions({
    println("Hello!")
})
// Hello!
// Hello!
// Hello!
```

클로저 문법으로 더 간결하게 호출하여 사용한다.

```swift
3.repetitions {
    println("Goodbye!")
}
// Goodbye!
// Goodbye!
// Goodbye!
```

### 서브스크립트(Subscripts)

확장은 기존 타입에 새로운 서브스크립트를 추가할 수 있다. 다음은 Swift에 내재된 Int 타입에 정수 서브스크립트를 추가하는 예제이다. 서브스크립트 `[n]`는 n번째 숫자를 반환한다.

```swift
extension Int {
    subscript(var digitIndex: Int) -> Int {
        var decimalBase = 1
            while digitIndex > 0 {
                decimalBase *= 10
                --digitIndex
            }
            return (self / decimalBase) % 10
    }
}
746381295[0]
// returns 5
746381295[1]
// returns 9
746381295[2]
// returns 2
746381295[8]
// returns 7
```

### 중첩 타입(Nested Types)

확장은 기존 클래스, 구조체 그리고 열거형에 새로운 중첩 타입을 추가할 수 있다.

```swift
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
            }
    }
}
```

위 예제는 Int 타입에 새로운 중첩 열거형을 추가하였다. Kind 라는 열거형은 정수 종류를 zero, positive, negative라고 표현한다.

다음은 Int에 계산 인스턴스 속성을 추가하는 예제로 적합한 기호를 반환해준다.

```swift
func printIntegerKinds(numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ")
        case .Zero:
            print("0 ")
        case .Positive:
            print("+ ")
        }
    }
    print("\n")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// prints "+ + - 0 - 0 +"
```

`number.kind`는 `Int.Kind` 타입으로 이미 알려져 있다. `Int.Kind` 모든 멤버 값은 Switch 문에서 축약하여 작성되기 때문에 `Int.Kind.negative` 보단 `.Negative`를 사용한다. 



**flatMap -> compactMap**

------



네. 그렇습니다. Swift 4.1에서 flatMap이 compactMap이라는 이름으로 바뀝니다!!!!

하지만!!!!!!!!!!!!!!!!!!!!! flatMap이 사라지는건 아닙니다. 

부분적으로 정말 딱 그 순간에만 



![img](https://t1.daumcdn.net/cfile/tistory/99CA8A335A9D17ED35)

이미지출처 : https://useyourloaf.com/blog/replacing-flatmap-with-compactmap/



ㅠ(지금 이 상황에서) flatMap은 deprecate됐어.....compactMap을 써줄래.....?라고 나오게 됩니다.

이미...



![img](https://t1.daumcdn.net/cfile/tistory/99289B365A9D183604)



여기엔 (벌써)Deprecated된다고 나옴..

그러나!!!!!!!!

![img](https://t1.daumcdn.net/cfile/tistory/99E789415A9D18A503)



여기는 deprecate내용이 없네요 :)

또 다른 쓰임이 있는데, 그러니까!!!!!!!!!!!!!!!!!!!! 쓰임에 따라서 그걸 compactMap을 써야할지 flatMap을 써야할지 구별해야한다는 것입니다.

Declaration을 봐도 조금 다르죠??



어떤 상황에서 compactMap으로 바뀌는지 조금 더 알아봅시다.

배열(Array)와 같이 **sequence**에 flatMap을 사용하여 nil에 매핑되는 모든것을 필터링하던 그!!! 작업?

```
let possibleNumbers = ["1", "2", "three", "///4///", "5"]

let mapped: [Int?] = possibleNumbers.map { str in Int(str) }
// [1, 2, nil, nil, 5]

let flatMapped: [Int] = possibleNumbers.flatMap { str in Int(str) }
// [1, 2, 5]
```



바로 이러한 상황이죠. 이러한 상황에서의 flatMap은  Swift 4.1에서는 더이상 사용되지 않으며, **compactMap으로 대체됩니다.**

정의를 잠깐보면..



```
func flatMap<U>(_ transform: (Self.Element) throws -> U?) rethrows -> [U]
```



딱 이런케이스에서



```
let names: [String?] = ["Tom", nil, "Peter", nil, "Harry"]let counts = names.compactMap { $0?.count }// [3, 5, 5]
```



이제 compactMap이 사용됩니다. 

하지만, 바로 위와같은 케이스 단 하나에서만 compactMap을 사용해야 하는 것이며, **다른 상황?, 케이스에 대해서는 여전히 flatMap을 사용해야합니다.**





**1. 각 요소요소가 sequence일 때 flat하게 만들어주는 flatMap이 있었죠!**

```
let scores = [[5,2,7], [4,8], [9,1,3]]
let allScores = scores.flatMap { $0 }
// [5, 2, 7, 4, 8, 9, 1, 3]

let passMarks = scores.flatMap { $0.filter { $0 > 5} }
// [7, 8, 9]
```

``

바로 이런 케이스에서요!

이럴땐 여전히 flatMap이 사용되게 됩니다. 





**2. Optional에서의 flatMap사용**

```
func flatMap<U>(_ transform: (Wrapped) throws -> U?) rethrows -> U?
```



```
let input: Int? = Int("8")let passMark: Int? = input.flatMap { $0 > 5 ? $0 : nil}// Optional(8)
```



아주 지극히 개인적인 생각.....이지만.. 솔직히 flatMap하면



```
let names: [Int?] = [1, nil, 3, nil, 5]let valid = names.flatMap { $0 }print(valid)//[1, 3, 5]
```



저는 이런느낌이 조금 더 강하거든요. nil이 있으면 알아서 걸러주고...이런거(위 케이스는 이제 compactMap으로 바뀌겠지만요)



```
let input: Int? = Int("8")let passMark: Int? = input.flatMap { $0 > 5 ? $0 : nil}// Optional(8)
```



근데 flatMap에서 Optional이 나온다는게 저는 처음에 음? flatMap은 값이 있으면 그 값을 뽑아주고 뭐 그런거 아니었어? 라고 해서 조금 헷갈렸어요 :)......

위 케이스에서 Optional(8)이 나온이유는 애초에 여기서의 flatMap의 정의가

```
func flatMap<U>(_ transform: (Wrapped) throws -> U?) rethrows -> U?
```

```
이것이기 때문입니다.
```

```
자. input으로 Int? 즉 Optional값을 받았어요. 그리고 그 input으로 flatMap을 호출하네요. 바로 Optional에서의 
```

```
flatMap을 호출하게 될 것입니다. 
```

```swift
let passMark: Int? = input.flatMap { $0 > 5 ? $0 : nil}
```

여기서 리턴타입이 Int?죠? Optional이죠? 

```
func flatMap<U>(_ transform: (Wrapped) throws -> U?) rethrows -> U?
```



그럼여기서 U? ==  Int?일것이고, 최종적으로 U == Int일거에요. 

그렇다면 최종적으로 Optional에서의 flatMap은 U?를 반환하니까, U는 Int였으니까, Int?를 반환하게 될 거에요. 그래서!!!!!!! 결과가 Optional(8)이 나오게 되었답니다 :)

아무튼...이 Optional의 케이스에서도 여전히 flatMap이 사용되게 될거에요.



[여기](https://useyourloaf.com/blog/replacing-flatmap-with-compactmap/)에서는 이렇게 flatMap이 compactMap으로 바뀐 이유가, map으로도 할 수 있는 작업에서 flatMap을 오용하는 상황을 방지하려고 바뀌는 것 같다고 해요 :)





그러니까 지금 조금 혼란이 오실 수도 있는데!!!!!!!!정리하자면!!!!!!!

Swift에서는 flatMap의 정의가 이렇게 3가지 있었는데!!!!



```
Sequence.flatMap<S>(_: (Element) -> S) -> [S.Element]
    where S : Sequence
Optional.flatMap<U>(_: (Wrapped) -> U?) -> U?
Sequence.flatMap<U>(_: (Element) -> U?) -> [U]
```



여기서 마지막거인 



```
Sequence.flatMap<S>(_: (Element) -> S) -> [S.Element]
    where S : Sequence
Optional.flatMap<U>(_: (Wrapped) -> U?) -> U?
Sequence.flatMap<U>(_: (Element) -> U?) -> [U]
```





이것만 이제 compactMap으로 바뀐다...라는 것만 아시면 됩니다.

자세한 변경사항?..은 [**Apple Swift evolution**](https://github.com/apple/swift-evolution/blob/master/proposals/0187-introduce-filtermap.md)을 참고해주세요 :)

XD



+) 여담이지만



![img](https://t1.daumcdn.net/cfile/tistory/999940475AA4956733)



도큐먼트에서 이런거 있었나요?!!?...저는 어제 처음봤어요..!!!! 뭐가 수정됐고, 뭐가 추가됐고 이런걸 한눈에 볼 수 있더라구요!!!



![img](https://t1.daumcdn.net/cfile/tistory/99D3813F5AA4959829)



Xcode 9.2-9.3 beta 4에서는 BusinessChat이 추가가 되고, 여러개가 바뀌었구나~~라는것을 한눈에 볼 수 있죠



![img](https://t1.daumcdn.net/cfile/tistory/99601E3E5AA495E534)



계속 타고타고 들어가도 이렇게 한눈에 보여줍니다. CoreAnimation이 바뀌었다는데..어떤게 바뀐거지? 하고 들어가면 또 여기서 뭐가 바뀐건지 표시를 해줘요 :)



## guard 구문 

* let player : [LadderPlayer] = players 

  변수선언해서 값을 저장 후 (,) 콤마를 사용해서 뒤의 값을 비교하는걸 사용했다.

```swift
guard let player : [LadderPlayer] = players , height > 0 , player.isEmpty == false else {
            return nil
        }
```





## git  

> Can't automatically merge. Don't worry, you can still create the pull request.

에러가 나서 어떤게 문제인지 잘 몰랐다.

: 브랜치를 마지막부분에서 만든게 아니라 처음부분에서 브랜치를 만들어서 오류가 생겼었다.





## 피드백 받은 부분

- 강제 unwrapping을 하기 보다는 옵셔널 처리를 해보세요.

  > 옵셔널 처리하는 부분을 정리

- 사다리를 표현하는 데이터 구조를 [[Int]] 로 설계 했는데, 사다리가 있고 없고 표현하는데 Int가 적절한가요?

  > 있고 없고를 사용하기엔 Bool 이지! 

- 메소드들 중에서 내부에서만 쓰는 메소드는 private을 지정하세요.

  > 넵!

- 단순히 값을 대체하는 정도가 아니라 함수를 호출하는거라면 3항 연산자보다는 차라리 if문을 쓰세요.

  > 3항 연산자를 사용하는 이유는 : 함수의 덩어리를 최대한 작게 라인수를 작게 만들고 싶었다.
  >
  > 또한 , else 구문을 사용하기 싫어서… 3항 연산자를 사용하였다.
  >
  > 3항 연산자는 보기도 어렵고, 계산하는것도 머리가 아프다.
  >
  > 그래서 함수로 분리를 했습니다. 함수 분리하고 , 함수 안에서 조건 하나만 검사하고 return하고 else를 사용하지 않고 return 을 바로 하는것을 선택하였다.
