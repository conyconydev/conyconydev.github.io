---
layout: post
title:  IBAction 과 IBOutlet 정리
date:  2019-03-12 22:53:32
category: post
tags: [ios]
---

# [iOS] IBAction 과 IBOutlet 정리

> 포토프레임(사진액자 앱)을 공부하면서 정리



### IBAction : 

- 조작과 메서드를 연결, 사용자가 부품을 조작했을 때 실행할 일을 지정
- View에서 Event가 발생되었을 때 호출되는 함수

### IBOutlet :

-  연결통로라는 의미, 인터페이스빌더에서 프로그램과의 연결통로
- Controller 함수에서 Button 등 View의 Control에 접근하기 위한 변수



### 버튼에 IBAction을 추가할 때 이벤트(Event) 종류에는 어떤 것들이 있을까?

----

Did End On Exit		: 편집 후 포커스 없어짐

Editing changed 		: 편집

Editing Did Begin 	 : 편집할 때

Editing Did End 		: 편집 종료할 때

Touch Cancel 		: 터치 취소할 때

Touch Down 			: 터치 다운시

Touch Down Repeat    : 여러번 터치 다운시

Touch Drag Enter		: 드래그하여 객체에 들어갔을 때

Touch Drag Exit		: 드래그하여 객체 벗어날 때

Touch Drag Inside	: 객체를 터치하고 드래그 할때

Touch Drag Outside	: 객체를 터치하고 드래그 하여 객체 밖으로 나올때

Touch Up Inside		: 컨트롤에서 터치 업 할때

Touch Up Outside	: 통제가 안되는 영역에서 터치 업할때

Value Changed		: 값이 변경될 때



### 버튼이 여러일 때 하나의 액션에 추가할 수 있을까?

- 가능 : 하나의 액션을 만들고 추가적으로 버튼을 해당 액션에 드래그해서 중복 설정이 가능합니다.

#### 참고

- [UIControl.Event - UIControl | Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uicontrol/event)