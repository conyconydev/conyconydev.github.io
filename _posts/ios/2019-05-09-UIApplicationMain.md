---
layout: post
title:  UIApplicationMain 과 UIApplication 학습
date:  2019-05-09 10:29:26
category: post
tags: [ios]
---

# [iOS] UIApplicationMain 과 UIApplication 학습

Apple 문서 : [UIApplicationMain](https://developer.apple.com/documentation/uikit/1622933-uiapplicationmain?language=objc) 링크 
Apple 문서 : [UIApplication](https://developer.apple.com/documentation/uikit/uiapplication?language=objc) 링크

----

### UIApplication
- UIApplication은 클래스이다.
> "The centralized point of control and coordination for apps running in iOS."
- iOS에서 실행되는 앱의 중앙 집중식 제어 및 조정 지점이다.  

<br />

모든 iOS앱에는 UIApplication인스턴스가 "하나만" (exactly one instance)있다. (또는 매우 드물게 UIApplication의 하위클래스)
앱이 시작되면, 시스템은  UIApplicationMain 함수를 호출한다. 이 함수는 다른 task들 중에서 싱글톤 UIApplication객체를 만든다.
그런 다음, shared클래스 메소드를 호출하여 객체에 접근한다.

```swift
@available(iOS 2.0, *)
open class UIApplication : UIResponder {
    open class var shared: UIApplication { get } 
}
```

그럼 UIApplicationMain 뭘까?
<br />

### UIApplicationMain

UIApplicationMain은 application객체와 application delegate를 만들고, 이벤트 사이클을 설정하는 역할을 가지고 있다.

#### Parameters

\-  **argc** : argv의 개수. 이것은 대게 main에 해당하는 매개변수 이다.

\- **argv** : argument의 변수 목록. 이것은 대게 main에 해당하는 매개변수 이다.

\- **prinsipalClassName** : UIApplication클래스 또는 하위 클래스의 이름이다. nil을 지정하면, UIApplication으로 가정된다.

\- **delegateClassName** : application delegate가 인스턴스화 되는 클래스 이름이다. prinsipalClassName이 UIApplication의 하위클래스를 지정하는 경우, 하위 클래스를 delegate로 지정 할 수 있다. 하위클래스 인스턴스는 앱의 delegate 메세지를 받는다. 앱의 기본 nib파일에서 delegate 객체를 로드하는 경우, nil을 지정한다.

#### Return Value
정수 반환 유형이 지정 되었더라도이 함수는 절대로 반환하지 않는다. 사용자가 홈 버튼을 눌러 iOS 앱을 종료하면 애플리케이션이 백그라운드로 이동한다.

#### Discussion
이 함수는 주요 클래스에서 해당 인스턴스를 생성하거나 주어진 클래스나 어플리케이션 대리자를 통해 대리자의 인스턴스를 생성한다.
또한 메인 이벤트 루프, 어플리케이션 실행 루프, 프로세스 이벤트의 시작점을 설정한다.이 어플리케이션의 info.plist 파일에  NSMainNibFile Key나 값이 유효한 nib 파일 이름이 포함된 로드하려는 특정 nib파일을 지정한다면 이 함수는 nib 파일을 로드한다.

반환 타입이 설정되었더라도 이 함수는 절대 반환하지 않는다. 이 함수의 작동 방식에 대한 자세한 내용 은 iOS 용 [App Programming Guide](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007072)의 " [App App Behavior](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/ExpectedAppBehaviors/ExpectedAppBehaviors.html#//apple_ref/doc/uid/TP40007072-CH3) "를 참조해라 .



application 객체의 주요 역할은, 들어오는 사용자 이벤트의 초기 라우팅을 처리하는 것이다. 제어 객체(UIControl의 인스턴스)가 적절한 target 객체에 전달한 action 메세지를 전달한다. application 객체는 열린 window(UIWindow의 객체)의 목록을 유지관리하며, 이를 통해 앱의 UIView객체를 검색할 수 있다.


UIApplication클래스는 [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate?language=objc)프로토콜을 준수하고, 일부 프로토콜 메소드를 구현해야하는 delegate를 정의한다. application 객체는 delegate에게 중요한 런타임 이벤트(예: 앱 시작, 메모리 부족 경고 및 앱 종료)를 알리고, 적절히 응답 할 기회를 제공한다.

### Subclassing Notes
대부분의 앱은 UIApplication을 서브클래싱 할 필요가 없다. 대신 app delegate를 사용하여 시스템과 앱 간의 상호작용을 관리한다.

앱에 들어오는 이벤트를 시스템이 처리하기 전에 처리해야하는 경우 -매우 드문경우- 사용자 정의 이벤트 또는 디스패칭 메커니즘을 구현 할 수 있다. 
이렇게 하려면 UIApplication을 서브클래스화하고, sendEvent: and/or sendAction메소드를 override 한다.

인터셉트하는 모든 이벤트에대해 이벤트를 처리 한 후, [super sendEvent:event]를 호출하여 시스템에 이벤트를 다시 전달한다. 이벤트를 가로채는 것은 거의 필요하지 않으며, 가능하면 피해야한다.


> 문서를 보다가 궁금해서 질문을 했다. 
> 질문 !! 그럼 @UIApplicationMain는 어디서 왔으며? 어디에 구현이 되어있을까요? 

Objective-C에서는 main.m 에서 UIApplicationMain를 호출했다.

```swift
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
```

Swift에서는 appDelegate.swift에서 AppDelegate클래스 앞에 어노테이션으로 붙여서 호출했다.

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    ...
}
```

> 나의 생각 정리
> 1. UIApplication 싱글톤 객체 생성 : 앱에 하나만 존재하게
> 2. @UIApplicationMain 어노테이션이 있는 class를 찾아 AppDelegate 객체를 생성
> 3. main 이벤트 구문 실행