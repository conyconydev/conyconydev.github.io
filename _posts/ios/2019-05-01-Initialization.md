---
layout: post
title:  Initialization
date:  2019-05-01 14:36:15
category: post
tags: [ios]
---

# [ios] 초기화 정리

swift의 객체는 사용하기 전에 반드시 모든 저장 프로퍼티에 대한 초기화가 필요하다.
오늘 정리 할 내용은 Initialization 를 통해 초기화를 하는것에 대해 정리 한다.

```swift
class AddressBook {
    var name: String
    var number: Int?
}
```

이렇게 작성한다면 Error 발생
> Class 'AddressBook' has no initializers
Stored property 'name' without initial value prevents synthesized initializers

따라서 init() 를 생성해서  초기화를 해준다.
> 여러가지 방법이 있지만, 매개변수를 입력 받아서 초기화 하는 방식을 선택
> 여기서 number는 Optional 이라서 초기화를 안해줘도 된다.
> Optional를 모르겠다면 : https://developer.apple.com/documentation/swift/optional


```swift 
class AddressBook {
    var name: String
    var number: Int?
    
    init(name: String) {
        self.name = name
    }
}
let conyAddressBook = AddressBook(name: "cony")
print(conyAddressBook.name)
```

### 클래스 상속과 초기화(Class Inheritance and Initialization)

슈퍼클래스로부터 상속받은 모든 저장 속성은 초기화할 때 초기 값을 할당받아야 함.

Swift는 클래스 타입에 모든 저장 속성에 초기 값을 받도록 도와주는 두가지 이니셜라이저를 정의함. 이를 지정 이니셜라이저(designated initializers)와 편의 이니셜라이저(convenience initializers)라고 함.

### 지정 이니셜라이저와 편의 이니셜라이저(Designated Initializers and Convenience Initializers)

클래스의 주 이니셜라이저는 지정 이니셜라이저로, 클래스의 모든 속성을 완전히 초기화한다. 적합한 슈퍼클래스 이니셜라이저를 호출하여 초기화 과정을 부모클래스로 연쇄하도록 한다.

모든 클래스는 하나 이상의 지정 이니셜라이저를 가진다. 지정 이니셜라이저는 깔때기를 통해 초기화 과정의 연쇄를 슈퍼클래스로 진행시킨다.

#### 나의 생각 정리
>지정 이니셜 라이저(Designated Initializer) 클래스에 반드시 1개 이상 필요
초기화가 필요한 모든 프로퍼티를 단독으로 초기화 가능한 Initializer


편의 이니셜라이저는 호출하는 지정 이니셜라이저 인자에 기본 값으로 설정할 수 있다. 또한 특정 쓰임새나 입력 값 타입을 위한 클래스의 인스턴스를 생성하기 위해 편의 이니셜라이저를 정의할 수 있다.

만약 클래스에 편의 이니셜라이저를 쓸 필요가 없다면 사용하지 않아도 된다. 일반적인 이니셜라이저 패턴을 단축할 때 만든 편의 이니셜라이저는 시간을 단축시키거나 클래스의 이니셜라이저 의도를 명확하게 만들 수 있다.

#### 나의 생각 정리
>편의 이니셜 라이저(Convenience Initializer) 단독으로 모든 프로퍼티를 초기화 할수 없다.
일부 프로퍼티만 처리한 뒤 다른 Initializer 를 이용해서 전체 초기화를 수행,
중복되는 초기화 코드 방지를 위해 사용

```swift
class AddressBook {
    var name: String
    var number: Int
    
    init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
    
    convenience init(number: Int) {
        self.init(name: "cony", number: number)
    }
}
//let conyConvenience = AddressBook(number: Int)
//let conyInit = AddressBook(name: String, number: Int)
```
AddressBook 클래스는 name과 number 프로퍼티에 대해 초기화가 필요하다. 
number 값만 입력 받고 다른 메소드의 도움을 받아서 처리하는 방식이 convenience Initializer 이다. 
convenience는 반드시 자기 자신의 초기화 메서드를 호출하도록 되어 있는데 , super.init() super Class의 초기화 함수를 호출하면 에러가 발생한다.


super / sub class 관계 일때 
만약 포유류 클래스의 super.init 먼저 호출 될 경우 printDescription 메서드에서 leg 변수는 초기화 되지 않은 상태에서 불려지게 된다.

```swift
class Animal {
    var breath: Bool
    var eating: Bool
    
    init(breath: Bool , eating: Bool) {
        self.breath = breath
        self.eating = eating
        printDescription()
    }
    func printDescription() {
        print("breath: \(self.breath) , eating: \(self.eating)")
    }
}
class Mammal: Animal {
    var leg: Int
    
    init(leg: Int) {
        self.leg = leg
        super.init(breath: true, eating: true)
    }
    
    override func printDescription() {
        super.printDescription()
        print("leg : \(self.leg) ")
    }
}
let lion = Mammal(leg: 4)
```

- super class 프로퍼티 값에 바로 특정 값을 넣고 싶어도 우선 super class의 초기화 메서드를 호출하여 초기화한 후에만 값을 대입할 수 있다.



### 필수 이니셜라이저(Required Initializers)

`required` 수식어를 클래스 이니셜라이저 앞에 정의하여 해당 클래스의 모든 클래스는 이니셜라이저를 구현해야 한다고 표시한다.

```swift
class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}
```

`required` 수식어를 필수 이니셜라이저의 구현 앞에 붙이면 후에 서브클래스 연쇄를 필수적으로 적용된다. 따라서 굳이 `override` 수식어를 오버라이드하는 지정 이니셜라이저에 붙일 필요가 없다.

```swift
class SomeSubclass: SomeClass {
    required init() {
        // subclass implementation of the required initializer goes here
    }
}
```

상속받은 이니셜라이저가 요구 사항을 충족할 수 있다면 필수 이니셜라이저를 명시적으로 구현하여 가지고 있지 않아도 된다.

#### 나의 생각 정리
Required Initializer : 상속 받은 클래스에서 반드시 작성해주어야 한다.
override 키워드는 생략된다. (단, convenience 인 경우 이 키워드 생략하지 않음)
