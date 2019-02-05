---
layout: post
title:  Property,Initializer
date:  2018-09-19 23:02:46
category: SwiftIos
tags: [Swift,Property,Initializer]
---
## 프로퍼티

* 객체의 데이터
* 저장 / 계산 프로퍼티
* 값을 저장하고 읽는 행위

### 저장 프로퍼티

* 데이터를 저장하는 용도
* 데이터 읽기/ 쓰기 행위
* 객체 생성시 초기화, 초기화 방법 필요

### 계산 프로퍼티

* 데이터 저장 안함
* 프로퍼티 읽기/쓰기 코드 작성



> 사각형 클래스 프로퍼티

```swift
// 저장 프로퍼티 : 가로길이 , 세로길이
// 계산 프로퍼티 : 크기 , 정사각형인가?

class MyClass{
    //init Property
    var intProperty = 0
    // 초기값을 설정하지 않은 옵셔널 프로퍼티
    var floatProperty: Float?
    //에러 - 초기화되지 않는 프로퍼티 : initializer 필요
    //var strProperty: String
}
//저장 프로퍼티 사용
var obj = MyClass()
obj.iniProperty = 10
obj.floatProperty = 3.1

/* 계산 프로퍼티
값 얻어오기 : get ,값을 설정하기 : set
읽기 전용은 만들수 있으나, 쓰기 전용은 없음.

var [프로퍼티 이름] : [타입] {
	get {
		return RETURN_VAL
	}
	set(newValue) {
		newValue += 1
	}
}
*/
class Person {
    let thisYear = 2018
    var birthYear: Int = 0
    
    var age: Int {
        get {
            return thisYear - birthYear
        }
        set {
            birthYear = thisYear - newValue
        }
    }
}

```



### self 포인터

* 객체 자신을 참조하는 포인터
* 프로퍼티 이름과 파라미터 이름이 겹칠때

```swift
class Counter {
    var count = 0
    func setCount(count:Int) {
        self.count = count
    }
}
```



## 타입 메소드

### 인스턴스 메소드

* 객체 생성, 객체에 사용
* 객체의 데이터(프로퍼티)사용 가능



### 타입 메소드

* 객체 생성하지 않고 사용
* 프로퍼티 접근 불가
* static 키워드 

```swift
class MyClass {
    var property = 0
    
    // typeMethod
    static func typeMethod() {
        property = 2 //에러 .타입 메소드에서 프로퍼티 접근 불가
    }
    func intanceMethod() {
        property = 1 //인스턴스 메소드에서 프로퍼티 접근 가능
    }
}

// 인스턴스 메소드 사용
var obj = MyClass()
obj.intanceMethod()
// 타입 메소드 사용
MyClass.typeMethod()
```



### 타입 프로퍼티

* 계산 프로퍼티 , 저장프로퍼티 가능
* 객체 생성하지 않고 사용

```swift
class Rectangle {
    var width: Int = 0
    //계산 타입 프로퍼티
    static var name: String {
        return "사각형"
    }
    //저장 타입 프로퍼티
    static var edge = 4
}
```



### 프로퍼티 변경 감시

* 프로퍼티 변경 전 : willSet
* 프로퍼티 변경 후 : didSet
* initializer 의 초기화 때는 동작 안함



* 음수 길이 감시하기

```swift
class Rectangle {
    var heught: Int = 0 {
        willSet {
            print("변경예정 \(newValue)")
        }
        didSet {
            print("변경 후 이전값은 : \(oldValue)")
        }
    }
}
```



### 프로퍼티 늦은 초기화

* 프로퍼티의 늦은 초기화 :  lazy

```swift
class Person {
    lazy var phone = Phone()
}
let cony = Person()
cony.phone
```



## 초기화 Initializer

* 모든 객체는 사용하기 전에 초기화
* 프로퍼티 초기화
  * 초기값과 함께 선언된 프로퍼티
  * 옵셔널 타입의 프로퍼티
  * 초기값이 없고, 옵셔널 타입이 아닌 프로퍼티!!!

* 옵셔널/ 초기값이 있는 프로퍼티 :  자동초기화
* 옵셔널 타입이 아니고 , 초기값이 없는 프로퍼티 : 수동 초기화



## Designated Initializer

* 객체 초기화를 단독으로 완료 가능
* 모든 초기화가 필요한 프로퍼티 초기화
* 클래스에 반드시 1개 이상 필요

```swift
class MyClass {
    var a: Int
    var b: Int
    
    init(a:Int, b:Int) {
        //초기화가 끝나기 전에 다른 메소드 호출은 에러
        self.a = a 
        self.b = b
    }
}
```



## Conbenience Initializer

* 단독으로 초기화 불가능
* 일부 프로퍼티만 초기화
* 다른 Initializer를 이용해서 초기화
* 중복 코드 방지

### Initializer Delegation

* 다른 init 메소드 호출하기
* 다양한 객체 생성 방법 제공 -> init 메소드 다수
* 초기화 코드의 중복 방지 , 재사용 높이기



```swift
//초기화 위임 이후에 다른 초기화 동작 작성
convenience init(파라미터) {
    // 초기화 위임
    // 초기화 코드
}
```

* Initializer Delegation 방향

Designated <——— Convenience <——— Convenience



```swift
class MyClass {
    var a,b: Int
    init() {
        a = 0
        b = 0
    }
    init(a:Int, b:Int) {
        self.a = a
        self.b = b
    }
    convenience init(b:Int) {
        self.init() // Initializer delegation
        self.b = b
    }
}

//객체 생성
//Designated Initializer로 객체 생성
var obj1 = MyClass()
var obj2 = MyClass(a:1 , b:2)

//Convenience Initializer 객체 생성
var obj3 = MyClass(b:2)
```



### Failable Initializer

* 객체 생성, 초기화 과정 실패
  * 예) 출생년도가 미래인 사람 객체
  * 예) 학번 규칙이 맞지 않는 학생 객체
  * 예) 크기가 음수인 도형 객체

* 초기화 실패의 결과는?
  * nil 반환
* 작성방법

```swift
// Initializer와 동일
// 조건 체크 - 오류 상황에 nil 반환

// init? init!
// 1900년 이전 출생한 사람이 없는 시스템
// Initializer의 파라미터 조건 검사

init?(birthYear: Int) {
    if birthYear <= 1900 {
        return nil
    }else {
        self.birthYear = birthYear
    }
}

//객체 생성 메소드 - 반환 타입이 옵셔널
var obj1 = Person(birthYear:-1990) //nil, Optional
var obj2 = Person(birthYear: 1990)
//if - let 바인딩
if let obj = Person(birthYear: 1990){
    
}
//강제 언래핑
var obj2 = Person(birthYear: -1800)!

//암시적 언래핑 옵셔널로 작성 가능
init!(birthYear: Int){
    
}
//생성된 객체의 타입
let obj: Person! = Person(birthYear: 1999)
```



### 객체 해제

* 해제 메소드 
  * 객체의 메모리 해제
    * 객체가 메모리에서 해제 되면서 호출
    * 이름 deinit
    * 파라미터, 리턴 타입 없음

```swift
class MyClass {
    deinit {
        //객체 해제 시 동작
    }
}

// 객체 생성, 해제 
// deinit
var obj: MyClass! = MyClass()
//객체 해제
obj = nil
print("==end==")
```



## 상속

### 클래스 상속

* 상속으로 새로운(자식) 클래스 정의
* 기존(부모) 클래스 프로퍼티 / 메소드 상속

```swift
class CLASS_NAME: SUPER_CLASS {
    
}
```

### 재정의

* 메소드 재정의(override)
  * 부모 클래스에 정의된 메소드 재정의
  * 같은 이름, 다른 동작

```swift
override func hello() {}
```

```swift
// 메소드 재정의 예) 사각형 넓이 구하기 
class Rectangle {
    var width = 0
    var height = 0
    func size() -> Int {
        return width * height
    }
}

class Square: Rectangle {
    override func size() -> Int {
        return width * width
    }
}
```



* 프로퍼티 재정의
  * 부모 클래스에 정의된 프로퍼티 재정의
    * 저장 프로퍼티 재정의 : willSet / didSet 행위 추가
    * 계산 프로퍼티 재정의 : get / set 행위 재정의
    * override var value: Int

```swift
// get / set 행위 재정의
class Rectangle {
    var width = 0
    var height = 0
    var isSquare: Bool {
        get { return width == height }
    }
}
class Square: Rectangle {
    override var isSquare: Bool {
        get { return true }
    }
}
```

```swift
//didSet , willSet 은 추가
class Square: Rectangle {
    override var width: Int {
        didSet(newValue) {
            //새로 추가되는 행위
        }
    }
}
```

### 주의

* 재정의시 주의 사항
  * override 누락하면 에러
  * 재사용 아닌데 override 사용하면 에러
  * final : override 금지 (클래스, 프로퍼티 , 메소드)



* 포인터 super
  * 부모 클래스 참조
    * super : 부모 클래스를 참조하는 포인터
    * 재정의시 부모 클래스 구현 참조
    * 부모 클래스로 Initializer Delegation



* 재사용과 super , self

```swift
class Parent {
    func description() -> String {
        return "parent class"
    }
}
class Child: Parent {
    override func description() -> String {
        return "Child class"
    }
    
    func printDescription() {
        print("super.description: \(super.description())")
        print("self.description: \(self.description())")
    }
}
```

<<<<<<< HEAD


```
부모 클래스    Designated <-- Convenience <-- Convenience
				^				<
				| 				|
자식 클래스	  Designated <--  Designated <-- Convenience
```

=======
부모 클래스    Designated <-- Convenience <-- Convenience
​		^		<
​		| 		|
자식 클래스	  Designated <--  Designated <-- Convenience




* Initializer 상속

  * 자식 클래스에 Designated Initializer 없는 경우
    * 별도의 초기화가 필요한 프로퍼티가 없음
    * 부모 클래스의 Designated, Convenience ;Initializer 상속

  ```swift
  // class 정의 , 상속
  //Designated Initializer 작성하지 않는 경우
  class Parent {
      var a: Int
      init(a: Int) {
          self.a = a
      }
      convenience init() {
          self.init(a: 0)
      }
  }
  class Child: Parent{}
  // 객체 생성
  var childObj1 = child(a:10)
  var childobj2 = child()
  ```



  * 자식 클래스에서 모든 Designated Initializer를 재정의
    * convenience Initializer 상속

  ```swift
  //자식 클래스의 Designated Initializer
  init(파라미터) {
      //자식 클래스의 프로퍼티 초기화
      // 부모 클래스의 Designated Initializer 위임
      // 나머지 초기화 동작
  }
  //class 정의 상속
  class Parent {
      var a: Int
      init(a: Int) {self.a = 0}
  }
  class Child: Parent {
      var b: Int
      init(a: Int, b: Int) {
          self.b = b
          super.init(a: a)
      }
  }
  //객체 생성
  var obj = Child(a:10, b:20)
  var obj2 = child(a:10) // x
  
  
  // 자식 클래스 convenience Initializer
  convenience Init(파라미터) {
      //같은 클래스 Initializer Delegation
      // 초기화 코드
  }
  ```

  * 자식 클래스에서 Designated Initializer를 작성하면 - Initializer 상속 안함.
  * Initializer Delegation
    * Initializer Delegation 시 Initializer 상속하는가 ?
    * 부모 클래스의 Delegation Initializer 를 상속하는 경우
    * 부모 클래스의  Delegation Initializer 를 상속하지 않는 경우
  * 자식 클래스의 convenience Initializer 작성

  ```swift
  //Initializer 상속 안함
  class Child: Perent {
      var b: Int
      init(a:Int, b:Int) {
          self.b = b
          super.init(a:a)
      }
      convenience init(b: Int) {
          self.init(a: 10, b: b)
          // 나머지 초기화 동작
      }
  }
  
  //객체 생성
  var obj = Child(a:10 , b: 20)
  var obj2 = child(b:30)
  ```

  ```swift
  //부모 클래스의 Designated Initializer 상속하는 경우
  
  class Parent {
      var a: Int
      init(a: Int) {
          self.a = a
      }
  }
  class Child: Parent {
      var b = 0 
      convenience init(b: Int) {
          self.init(a:0)
          self.b = b
      }
  }
  ```

  ```swift
  //Initializer 재정의
  
  class Parent {
      var a: Int
      init(a: Int){
          self.a = a
      }
  }
  class Child: Parent {
      var b = 0
      override init(a: Int) {
          self.b = 0
          super.init(a:a)
      }
  }
  ```

  * 자식 클래스에서 모든 Designated Initializer 재정의
  * convenience Initializer 상속


* 모든 Designated Initializer 재정의

```swift
class Parent {
    var a: Int
    init(a: Int) {
        self.a = a
    }
    convenience init() {
        self.init(a: 10)
    }
}
class Child: Parent {
    var b: Int
    //Designated Initializer 재정의
    override init(a:Int){
        b = 10
        super.init(a:a)
    }
}
// convenience Initializer로 객체 생성(상속)
var child = Child()
```



* 2단계 초기화

  * 1단계 : 자식 클래스에서 부모 클래스로 위임 - 1차 준비
  * 2단계 : 추가 초기화 동작 (부모 클래스의 내용 커스터 마이징)

  ```swift
  class Parent {
      var a: Int
      init() {
          a = 0
      }
  }
  class Child: Parent {
      var b: Int
      init(a:Int, b:Int) {
          self.b = b
          super.init()
          
          self.a = a
      }
  }
  ```



* Required Initializer

```swift
//Required Initializer 작성 예
required init() {
    
}
```



* Required Initializer 작성
  * 작성 안하면 컴파일 에러
  * required 키워드 사용
  * override 키워드 생략
  * convenience 키워드는 유지



* Required Initializer 

```swift
// Parent Class
class Parent {
	var a: Int; var b: Int 
    required init(a : Int, b : Int) {
		self.a = a
		self.b = b 
    }
//<<<<<<< HEAD
	required convenience init() { 
        self.init(a : 0)
//=======
	required convenience init() { 			
		self.init(a : 0)
//>>>>>>> 39a956005004ab74cf62db96f89c416dbb68bd47
	}	 
}
```

```swift
// Child Class
class Child : Parent {
	var c : Int
	required init(a : Int, b : Int) {
		self.c = 0
		super.init(a: a, b : b) 
    }
//<<<<<<< HEAD
	required convenience init() { 		
        self.init(a : 0, b : 0)
//=======
	required convenience init() { 			
		self.init(a : 0, b : 0)
//>>>>>>> 39a956005004ab74cf62db96f89c416dbb68bd47
	} 
}
```

