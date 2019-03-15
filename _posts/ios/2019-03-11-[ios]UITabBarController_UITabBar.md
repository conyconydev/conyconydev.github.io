---
layout: post
title:  [ios]UITabBarController_UITabBar
date:  2019-03-11 18:13:01
category: post
tags: [ios]
---

# [ios] UITabBarController 와 UITabBar에 대해서 학습

> 포토프레임(사진액자 앱)을 공부하면서 정리



### UITabBarController : 

UITabBarController의 핵심은 **radio-style interface**를 관리한다

**radio-style**이란 우리가 여러가지 선택할 수 있는 보기가 있을때 보기 중 하나만 선택할 수 있는 경우에 사용하는 방식

TabBarController는 UIViewController를 상속받기 때문에 컨트롤러 자체가 내부 뷰 속성에 접근할 수 있는 하나의 뷰를 가지고 있습니다. 따라서 TabBarItem을 품고 있는 TabBar라는 뷰를 품고 있기에 각 탭별로 화면전환이 가능

----

### UITabBar : 

TabBar View에 해당하는 부분이며 UIView로, 사용자에게 탭들을 어떻게 보여주고 탭 클릭 시 어떻게 반응할 건지 (피드백을 어떻게 보여줄지) 알고 있다.
UITabBar는 보통 UITabBarController와 함께 사용하지만 **혼자 쓰일 수도 있으며**, 각 탭을 구분하는 버튼을 포함하고 있습니다. 각각의 버튼은 탭의 종류를 뜻하며 item이라고 합니다. TabBarItem은 TabBar에 최소 1개 이상이다.

특이점은 종류가 6가지가 넘어간다면 처음 4가지만 표시되고 나머지는 the standard More item(보통 `∙∙∙`) 이라는 버튼으로 표시
