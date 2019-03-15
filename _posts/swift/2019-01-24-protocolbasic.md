---
layout: post
title:  protocol 기초공부
date:  2019-01-24 10:08:33
category: post
tags: [Swift,protocol]
---

# Protocol 기초 정리

*프로토콜Protocol*은 인터페이스입니다. 최소한으로 가져야 할 속성이나 메서드를 정의합니다. 구현은 하지 않습니다. 진짜로 정의만 합니다.

```swift
/// 전송가능한 인터페이스를 정의합니다.
protocol Sendable {
  var from: String? { get }
  var to: String { get }

  func send()
}
```

클래스와 구조체에 프로토콜을 *적용Conform*시킬 수 있습니다. 프로토콜을 적용하면, 프로토콜에서 정의한 속성와 메서드를 모두 구현해야 합니다.

```swift
struct Mail: Sendable {
  var from: String?
  var to: String

  func send() {
    print("Send a mail from \(self.from) to \(self.to)")
  }
}

struct Feedback: Sendable {
  var from: String? {
    return nil // 피드백은 무조건 익명으로 보냅니다.
  }
  var to: String

  func send() {
    print("Send a feedback to \(self.to)")
  }
}
```

프로토콜은 마치 추상클래스처럼 사용될 수 있습니다.

```swift
func sendAnything(_ sendable: Sendable) {
  sendable.send()
}

let mail = Mail(from: "devxoul@gmail.com", to: "jeon@stylesha.re")
sendAnything(mail)

let feedback = Feedback(from: "devxoul@gmail.com")
sendAnything(feedback)
```

`sendAnything()` 함수는 `Sendable` 타입을 파라미터로 받습니다. `Mail`와 `Feedback`은 엄연히 다른 타입이지만, 모두 `Sendable`을 따르고 있으므로 `sendAnything()` 함수에 전달될 수 있습니다. 그리고, `Sendable`에서는 `send()` 함수를 정의하고 있기 때문에 호출이 가능합니다.

프로토콜은 또다른 프로토콜을 따를 수 있습니다.

```swift
protocol Messagable {
  var message: String? { get }
}

protocol Sendable: Messagable {
  // ...
}
```

`Sendable`은 `Messagable`을 기본적으로 따르는 프로토콜입니다. 따라서, `Sendable`을 적용하려면 `var message: String? { get }`을 정의해주어야 합니다.

> **응용하기**: `Sendable`에 `Messagable`을 적용하고, `Mail`과 `Feedback`에 발생하는 컴파일 에러를 고쳐보세요.

### Any와 AnyObject

`Any`는 모든 타입에 대응합니다. `AnyObject`는 모든 객체Object에 대응합니다.

```swift
let anyNumber: Any = 10
let anyString: Any = "Hi"

let anyInstance: AnyObject = Dog()
```

`Any`와 `AnyObject`는 프로토콜입니다. Swift에서 사용 가능한 모든 타입은 `Any`를 따르도록 설계되었고, 모든 클래스들에는 `AnyObject` 프로토콜이 적용되어있습니다.

### 타입 캐스팅 (Type Casting)

`anyNumber`에 `10`을 넣었다고 해서 `anyNumber`가 `Int`는 아닙니다. '`Any` 프로토콜을 따르는 어떤 값'이기 때문이죠.

```swift
anyNumber + 1 // 컴파일 에러!
```

이럴 때에는 `as`를 이용해서 *다운 캐스팅Down Casting*을 해야 합니다. `Any`는 `Int`보다 더 큰 범위이기 때문에, 작은 범위로 줄인다고 하여 '다운 캐스팅'입니다.

`Any`는 `Int` 뿐만 아니라 `String`과 같은 전혀 엉뚱한 타입도 포함되어 있기 때문에 무조건 `Int`로 변환되지 않습니다. 따라서 `as?`를 사용해서 옵셔널을 취해야 합니다.

```swift
let number: Int? = anyNumber as? Int
```

옵셔널이기 때문에, 옵셔널 바인딩 문법도 사용할 수 있습니다. 실제로 이렇게 사용하는 경우가 굉장히 많습니다.

```swift
if let number = anyNumber as? Int {
  print(number + 1)
}
```

### 타입 검사

타입 캐스팅까지는 필요 없고, 만약 어떤 값이 특정한 타입인지를 검사할 때에는 `is`를 사용할 수 있습니다.

```swift
print(anyNumber is Int)    // true
print(anyNumber is Any)    // true
print(anyNumber is String) // false
print(anyString is String) // true
```

### Swift 주요 프로토콜

Swift에는 기본적으로 제공하는 기초적인 프로토콜들이 있습니다. 알아두면 개발할 때 굉장히 유용하게 사용할 수 있습니다.

#### CustomStringConvertible

자기 자신을 표현하는 문자열을 정의합니다. `print()`, `String()` 또는 `"\()"`에서 사용될 때의 값입니다. `CustomStringConvertible`의 정의는 아래와 같이 생겼습니다.

```swift
public protocol CustomStringConvertible {
  /// A textual representation of `self`.
  public var description: String { get }
}
```

실제로 적용해볼까요?

```swift
struct Dog: CustomStringConvertible {
  var name: String
  var description: String {
    return "🐶 \(self.name)"
  }
}

let dog = Dog(name: "찡코")
print(dog) // 🐶 찡코
```

> **응용하기**: `CustomDebugStringConvertible`을 적용해봅시다.

#### ExpressibleBy

우리는 지금까지 `10`은 `Int`, `"Hi"`는 `String`이라고 '당연하게' 인지하고 있었습니다. 하지만, 엄밀히 하자면 `10`은 원래 `Int(10)`으로 선언되어야 하고, `"Hi"`는 `String("Hi")`로 선언되어야 합니다. `Int`와 `String` 모두 생성자를 가지는 구조체이기 때문이죠.

이렇게, 생성자를 사용하지 않고도 생성할 수 있게 만드는 것을 *리터럴Literal*이라고 합니다. 직역하면 '문자 그대로'라는 뜻이에요. 아래 코드는 문자 그대로 `10`, 문자 그대로 `"Hi"`, 문자 그대로 배열이고 딕셔너리입니다.

```swift
let number = 10
let string = "Hi"
let array = ["a", "b", "c"]
let dictionary = [
  "key1": "value1",
  "key2": "value2",
]
```

이 리터럴을 가능하게 해주는 프로토콜이 있답니다. 바로 `ExpressibleByXXXLiteral` 인데요. `Int`는 `ExpressibleByIntegerLiteral`을, `String`은 `ExpressibleByStringLiteral`을, `Array`는 `ExpressibleByArrayLiteral`을, `Dictionary`는 `ExpressibleByDictionaryLiteral` 프로토콜을 따르고 있습니다. 각 프로토콜은 리터럴 값을 받는 생성자를 정의하고 있어요. 놀랍죠?

우리도 만들 수 있어요.

```swift
struct DollarConverter: ExpressibleByIntegerLiteral {
  typealias IntegerLiteralType = Int

  let price = 1_177
  var dollars: Int

  init(integerLiteral value: IntegerLiteralType) {
    self.dollars = value * self.price
  }
}

let converter: DollarConverter = 100
converter.dollars // 117700
```

> **Tip**: `typealias`는 C의 `typedef`와 같습니다. `typealias MyInt = Int`라고 하면, 새로 생성된 `MyInt`는 `Int`와 완전히 동일한 타입입니다. 프로토콜에서도 `typealias`를 정의할 수 있습니다.
>
> **Tip**: `1177`은 가독성을 위해 `1_177`로 쓸 수 있습니다. `12_345`는 `12345`랑 같아요. `1234_5`도 `12345`와 같습니다.

분명히 구조체를 만들었는데, `ExpressibleByIntegerLiteral`을 적용하니까 `= 100`과 같은 문법을 사용할 수 있게 되었습니다.

> **응용하기**: `ExpressibleByArrayLiteral`을 적용하여 아래와 같이 홀수와 짝수를 나눠서 보관하는 `OddEvenFilter` 구조체를 만들어보세요.
>
> 
>
> ```swift
> let oddEvenFilter: OddEvenFilter = [1, 3, 5, 2, 7, 4]
> oddEvenFilter.odds  // [1, 3, 5, 7]
> oddEvenFilter.evens // [2, 4]
> ```