---
layout: post
title:  ViewController 상태변화 정리
date:  2019-03-13 22:53:32
category: post
tags: [ios]
---

# [iOS] ViewController 상태변화

> 포토프레임(사진액자 앱)을 공부하면서 정리



### ViewController 상태변화 : 



![image](https://docs-assets.developer.apple.com/published/f06f30fa63/UIViewController_Class_Reference_2x_ddcaa00c-87d8-4c85-961e-ccfb9fa4aac2.png)

> https://developer.apple.com/documentation/uikit/uiviewcontroller

- func loadView() : ViewController가 관리하는 view를 생성할 때 호출되는 매서드

- func viewDidLoad() : ViewController 가 관리하는 view가 메모리에 로드 된 직후에 호출되는 매서드 , view가 생성되고 처음 한번 세팅해 주어야 하는 값들을 넣기에 적절
- func viewWillAppear(animated: Bool) : view가 화면에 보여지기 직전에 호출되는 매서드 , animated는 뷰가 애니메이션을 동반하며 보여지게 되는지 시스템에서 전달해주는 bool 값.
- func viewDidLayoutSubviews() : view의 하위뷰들의 레이아웃이 결정된 후 호출되는 매서드 , 주로 view의 하위뷰들이 오토레이아웃을 통해 사이즈 조정이 끝나고 호출
- func viewDidAppear(animated: Bool) : view가 화면에 보여진 직후에 호출되는 매서드.
- func ViewWillDisappear(animated: Bool) : view가 화면에서 사라지기 직전에 호출되는 매서드.
- func viewDidDisappear(animated: Bool) : View가 화면에서 사라진 직후에 호출되는 매서드.

----

- UIViewController는 관리하는 view를 꼭 가져야한다.
- UIViewController가 관리하는 view의 상태는 UIViewController의 인스턴스 매서드를 통해 전달된다.
- 호출될 매서드를 알고 있다면 적절한 타이밍에 원하는 것들을 세팅해 줄수 있다. 예) 화면이 보이기 전에 사진을 셋팅, 화면이 나타난 후에 특정 애니메이션 재생 등
- 시스템에서 뷰의 상태 변화에 따라서 각각의 매서드를 호출한다.
- 뷰 상태 변화 매서드는 프로그래머가 직접 호출하지 말아야 한다.
- 기존 UIViewController에 작성되어 있는 매서드이므로 오버라이드 하여 구현할 때에는 override 라는 키워드를 사용하여 오버라이드 된 매서드임을 표시해 주어야 한다.
- 오버라이드 하는 매서드이므로 꼭 해당 메서드 내에서 super.[매서드 이름] 을 통해 기존 매서드를 꼭 호출해 주어야 한다.


