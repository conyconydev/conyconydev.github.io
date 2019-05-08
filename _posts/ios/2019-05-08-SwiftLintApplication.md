---
layout: post
title:  SwiftLintApplication
date:  2019-05-08 10:57:30
category: post
tags: [ios]
---

# [iOS] SwiftLint Xcode 나의 프로젝트에 적용하기

- [[iOS] SwiftLint Xcode 나의 프로젝트에 적용하기](#ios-swiftlint-xcode-%EB%82%98%EC%9D%98-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8%EC%97%90-%EC%A0%81%EC%9A%A9%ED%95%98%EA%B8%B0)
  - [내 프로젝트에 SwiftLint를 적용해보자](#%EB%82%B4-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8%EC%97%90-swiftlint%EB%A5%BC-%EC%A0%81%EC%9A%A9%ED%95%B4%EB%B3%B4%EC%9E%90)


SwiftLint사용법은 [swiftLint 한글 사용법](https://github.com/realm/SwiftLint/blob/master/README_KR.md)
이곳에 아주 자세하게 적혀있다. 

그렇지만 내가 겪은 실수와 이후 내가 다시 보기 위해서 정리를 한다. 
**CocoaPods 설치하고 Xcode 나의 프로젝트에 적용하기** 를 적용한 뒤 따라 해야 적용이 된다.


## 내 프로젝트에 SwiftLint를 적용해보자

1. 적용하고 싶은 프로젝트를 가져온다.
> 나는 swift-vendingmachine에 적용하였다. 예제를 보고 싶다면
> [나의 자판기 예제](https://github.com/conyconydev/swift-vendingmachine) 를 참고하면 된다.

2. Podfile에 pod 'SwiftLint' 추가한 뒤 pod install
3. Target > build phase > + > new run script phase
${PODS_ROOT}/SwiftLint/swiftlint
Run script에 위 코드를 추가해주시고, 빌드하면 된다.

![swiftLint](https://github.com/conyconydev/conyconydev.github.io/blob/master/_posts/postImg/SwiftLint.png?raw=true)

