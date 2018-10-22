---
layout: post
title:  ClassInitializer,memory
date:  2018-09-20 23:02:46
category: SwiftIos
tags: [Swift,Class,Initializer,memory]
---


## 클래스 상속과 Failable Initializer

* 상속과 Failable Initializer
* 부모 클래스의 Initializer의 위임
  * 부모 클래스의 Failable Initializer 로 위임 -> Failable Initializer로 작성
* Failable Initializer 재정의
  * Failable Initializer 를 Failable Initializer로 재정의
  * Failable Initializer 를 non - Failable Initializer 로 재정의
* Failable Initializer 가 있는 부모 클래스

```swift
class Parent {
    var value = 0
    init?(value: Int) {
        if value < 0 {
            return nil
        }
    }
    init() {
        
    }
}
```

```swift
class Child1: Parent {
    // Initializer 재정의
    override init(value: Int) {
        // non-Failable Initializer 로 delegation
        super.init()
    }
}
```

```swift
class Child2: Parent {
    override init?(value: Int){
        //Failable Initializer 로 delegation
        super.init(value:value)
    }
}
```



# 메모리 관리



### ARC와 메모리 관리

* 객체 생성과 메모리

  * 객체생성 -> 메모리 차지
  * 메모리 공간의 제약 -> 메모리 관리

* 메모리 관리

  * 필요한 객체 유지
  * 필요 없는 객체 해제

* 객체가 사용중 인가?

  * 사용 중이라는 표시 - 소유하기 (Own)
  * 객체 소유하는 방법 - 강한 참조 (Strong Pointer)

* 객체 소유 관리

* 레퍼런스 카운트 (Reference Count)

  * 강한 참조의 개수
  * 객체 사용 -> 레퍼런스 카운트 늘리기
  * 객체 사용 끝 -> 레퍼런스 카운트 감소
  * 레퍼런스 카운트 0 : 객체 사용 끝

* 레퍼런스 카운트 관리

  * 수동 관리 : 레퍼런스 카운트 증가 / 감소 코드 작성
  * 자동 관리 : 레퍼런스 카운트 증가 / 감소 자동

* ARC

  * Automatic Reference Counting
  * 자동 레퍼런스 카운트 관리
  * 객체의 레퍼런스 카운트 관리 코드 자동 생성 (컴파일)
  * 레퍼런스 타입(클래스) 객체에만 적용
  * 밸류 타입 (구조체, Enum) 객체에는 미적용

* 객체 소유하기 , 소유권 해제

* 객체 생성과 해제 확인

  * 객체 생성 : 객체 소유

  * ```swift
    var ptr: MyClass! = MyClass()
    ```

  * nil 대입 : 소유권 해제

  * ```swift
    ptr = nil
    ```

  * 레퍼런스 카운트 0 : 객체 해제

  * 객체 해제 확인하기 : deinit

* 객체 해제 확인하기

  * 클래스의 deinit 메소드 작성

  * 프로젝트 환경에서 동작

  * ```swift
    class MyClass {
        deinit {
            print("객체가 메모리에서 해제")
        }
    }
    ```

  * 객체 생성과 해제 확인

  * ```swift
    var obj: MyClass! = MyClass()
    obj = nil
    ```

  * 강한 참조

  * ```swift
    var obj: MyClass! = MyClass()
    var anotherPointer = obj
    obj = nil
    ```

* 변수의 스코프와 소유권
* 객체를 소유하는 참조 변수의 종류
  * 지역 변수
  * 프로퍼티
  * 타입 프로퍼티
* 선언 방식에 따라 스코프(Scope)가 다르다.



* 참조 변수 : 지역 변수

  * 함수 내 지역 참조 변수의 스코프 : 함수 범위

  * 함수 종료와 함께 소유권 해제

  * ```swift
    class MyApplication {
        func sayHello() {
            var obj: MyClass!
            obj = MyClass()
            
            print("HelloWorld!")
        }
    }
    ```



* 참조 변수 : 프로퍼티

  * 프로퍼티의 라이프 사이클: 객체 생명 주기

  * ```swift
    class MyApplication {
        var obj: MyClass!
        init() {
            obj = MyClass()
        }
        func hello() {
            obj.howAreTou()
        }
    }
    ```

* 참조 변수 : 타입 프로퍼티

  * 객체의 생존 주기와 무관

  * ```swift
    class MyApplication {
        static var obj: MyClass!
    }
    ```

  * 수동으로 객체 생존 주기 설정

    ```swift
    MyApplication.obj = MyClass()
    MyApplication.obj = nil
    ```

* 콜렉션과 소유권

  * 콜렉션에 객체 저장 : 콜렉션이 객체 소유
  * 콜렉션에서 객체 삭제 : 소유권 해제
  * 콜렉션 객체 해제 : 소유권 해제
  * 메모리 소유권 해제 실습

  ```swift
  var obj: MyClass! = MyClass()
  var array = [obj]
  obj = nil
  ```

  * 배열에서 삭제 - 소유권 해제

  ```swift
  array.remove(at: 0)
  ```


### 강한 순환 참조

* 강한 참조로 순환 참조

  * 두 개 이상의 관계에서도 가능
  * 서로 소유하므로 해제되지 않음 ( 메모리 누수 )
  * 수동으로 해제 되도록 작성 해야 함

  ```swift
  class Car {
      var engine: Engine?
  }
  // 서로 소유
  class Engine {
      var car: Car?
  }
  ```

* 강한 순환 참조 확인

  * 정상 해제 상황

  ```swift
  class ClassA {
      var objB: ClassB! deinit {
          print("A객체 해제")
      }
  }
  class ClassB {
      var objA: ClassA! deinit {
          print("B객체 해제")
      }
  }
  var a: ClassA! = ClassA()
  var b: ClassB! = ClassB()
  
  a = nil
  b = nil
  ```

* 강한 순환 참조 확인

  * 강한 순환 참조 발생

  ```swift
  class ClassA {
      var objB: ClassB! deinit {
          print("A 객체 해제")
      }
  }
  class ClassB {
      var objA: ClassA! deinit {
          print("B 객체 해제")
      }
  }
  var a: ClassA! = ClassA()
  var b: ClassB! = ClassB()
  
  a.objB = b
  b.objA = a
  a = nil; b = nil
  ```

### 약한 참조

* 강한 순환 참조 문제 해결하기
  * 객체를 소유하는 강한 참조만 사용하면 문제가 될 수 있음
  * 객체를 소유하지 않는 약한 참조(Weak reference) 사용
* 약한 참조

  * 객체를 소유하지 않는 포인터 : weak , unowned

* weak

  * 참조하던 객체가 해제되면 자동 nil
  * nil이 되므로 옵셔널
  * 상호 독립적으로 존재하는 객체에 사용

* 권장 사용 예시

  * 사용자와 스마트폰
  * 운전자와 자동차

* 약한 참조 예시

  * 클래스 작성

  ```swift
  class Person {
      weak var phone: Phone!
      deinit { 
      	print("Person 객체 해제")
      }
  }
  class Phone {
      var owner: Person!
      deinit {
          print("Phone 객체 해제")
      }
  }
  ```

  * 사용

  ```swift
  var owner: Person! = Person()
  var iphone: Phone! = Phone()
  iphone.owner = owner
  owner.phone = iphone
  //객체 해제 확인
  owner = nil
  iphone = nil
  ```


* unowned
  * 옵셔널 타입으로 선언 불가 (Initializer)
  * 완전히 종속적인 경우에 사용
  * 참조하던 객체가 해제 되어도 nil 로 변하지 않음 -> Dangling Pointer 위험
  * 단독으로 존재 못하는 종속적인 경우
* 권장 사용 예시
  * 신용카드와 사용자
  * 국가와 수도
* unowned 작성 예시

```swift
// 클래스 작성
class Country {
    var capital: City!
}
class Capital {
    unowned var country: Country
    init(country:Country){
        self.country = country
    }
}
```

```swift
// 사용
var korea: Country! = Country()
var seoul: Capital! = Capital(country:korea)
korea.capital = seoul
//객체 해제 확인
korea = nil
seoul = nil
```



### 구조체 , Enum

```swift
struct MyStruct {
    var value: Int
    
    //Designated Initializer
    init(v: Int) {
        self.value = v
    }
    // convenience Initializer
    init() {
        self.init(v:0)
    }
}
```

* Mutating

* 구조체의 프로퍼티 수정

  * 초기화 메소드에서 설정 가능
  * 구조체 외부에서 설정 가능

* 구조체 프로퍼티 수정 메소드

  * 메소드 선언에 mutating

* 구조체 내부에서 데이터 수정

  * 컴파일 에러 발생

  ```swift
  struct Point {
      var x = 0 
      var y = 0
      func moveTo(x: Int, y: Int){
          self.x = x // err
          self.y = y // err
      }
  }
  ```

  * 메소드에 mutating 선언

  //mutating 을 사용하는 이유는 구조체의 메서드가 구조체 내부에서 데이터 값을 수정할때 사용하는 키워드다.

  // 따라서 다른 구조체 API를 보고 mutating이 있느냐 없느냐에 따라서 , 월래 구조체 내부의 값을 변경하는 API인지 , 아닌지 유추할수 있다.

  ```swift
  struct Point {
      var x = 0
      var y = 0
      mutating func moveTo(x:Int , y: Int){
          self.x = x
          self.y = y
      }
  }
  ```

* Array

  * struct Array
  * 배열 내용 유지 - 새로운 배열 생성 API

  ```swift
  func map<U>(transform:(T)->U)->[U]
  func reverse() -> [T]
  func filter(includeElement:(T) -> Bool)->[T]
  ```

  * 배열 내용 변경 API

  ```swift
  mutating func insert(newElement: T, atIndex i:Int)
  mutating func remove(at index: Int) -> T
  ```



* 정적 메소드와 정적 프로퍼티

  * static 키워드
  * 정적 저장 , 정적 계산 프로퍼티

  ```swift
  struct MyStruct {
      static func staticFunc() {
          print("정적메소드")
      }
      static var static Property: Int!
  }
  MyStruct.staticFunc()
  MyStruct.staticProperty = 10 
  ```


* 클래스와 구조체
  * 구조체와 클래스 모두 있는것
    * 프로퍼티와 메소드
    * 초기화
  * 구조체에는 없고 클래스에 있는 것
    * 상속과 재정의
    * ARC
  * 클래스 : 레퍼런스 타입 , 참조 복사 , 객체 참조 추가
  * 구조체 : 밸류 타입 , 복사

* Enum

```swift
enum Day {
    case am
    case pm
}

var now: Day
now = Day.am

var newDay: Day.am

switch newDay {
    case .am:
    print("am")
    case .pm:
    print("pm")
    default :
    print("xxx")
}
```

* 원소 타입이 있는 Enum

  * 원소의 값 : rawValue
  * rawValue 에서 Enum 생성 (옵셔널)

  ```swift
  var ael = Pet(rawValue:0)
  ```

  * Enum 에서 rawValue 얻기

  ```swift
  ael.rawValue
  ```


