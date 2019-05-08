---
layout: post
title:  CocoaPodsUseXcode
date:  2019-05-07 10:23:37
category: post
tags: [ios]
---

# [iOS] CocoaPods 설치하고 Xcode 나의 프로젝트에 적용하기

- [[iOS] CocoaPods 설치하고 Xcode 나의 프로젝트에 적용하기](#ios-cocoapods-%EC%84%A4%EC%B9%98%ED%95%98%EA%B3%A0-xcode-%EB%82%98%EC%9D%98-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8%EC%97%90-%EC%A0%81%EC%9A%A9%ED%95%98%EA%B8%B0)
    - [CocoaPod가 뭘까?](#cocoapod%EA%B0%80-%EB%AD%98%EA%B9%8C)
    - [CocoaPod 사용법 정리](#cocoapod-%EC%82%AC%EC%9A%A9%EB%B2%95-%EC%A0%95%EB%A6%AC)
      - [첫번째 CocoaPod 설치](#%EC%B2%AB%EB%B2%88%EC%A7%B8-cocoapod-%EC%84%A4%EC%B9%98)
      - [두번째 적용하고 싶은 프로젝트 가서 CocoaPod init](#%EB%91%90%EB%B2%88%EC%A7%B8-%EC%A0%81%EC%9A%A9%ED%95%98%EA%B3%A0-%EC%8B%B6%EC%9D%80-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EA%B0%80%EC%84%9C-cocoapod-init)
      - [세번째 Podfile을 활용해 라이브러리 다운로드 받는 방법](#%EC%84%B8%EB%B2%88%EC%A7%B8-podfile%EC%9D%84-%ED%99%9C%EC%9A%A9%ED%95%B4-%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC-%EB%8B%A4%EC%9A%B4%EB%A1%9C%EB%93%9C-%EB%B0%9B%EB%8A%94-%EB%B0%A9%EB%B2%95)
      - [네번째 pod install](#%EB%84%A4%EB%B2%88%EC%A7%B8-pod-install)
    - [삭제](#%EC%82%AD%EC%A0%9C)

### CocoaPod가 뭘까?
CocoaPod는 무엇입니까?" 뭘까? 궁금해서 검색을 했다면!!!!
-> CocoaPods 웹 사이트에서 답을 찾는 것이 가장 좋다.

CocoaPods는 Swift 및 Objective-C 코코아 프로젝트의 종속성 관리자이다. 30,000 개가 넘는 라이브러리를 보유하고 있으며 많은 앱에서 사용되고 있다. CocoaPod는 프로젝트를 우아하게 확장하는데 도움을 준다.

코코아팟은 Ruby로 제작 되어 있다.

### CocoaPod 사용법 정리
CocoaPod사용법에 대해 정리해보려고 한다.

#### 첫번째 CocoaPod 설치
첫번째로 해야 할 일은 CocoaPod 설치 한다.

터미널을 열고 아래의 명령어를 입력 해준다.
> $sudo gem install cocoapods

이제 코코아팟(라이브러리들)을 자유롭게 사용할 수 있다. 

#### 두번째 적용하고 싶은 프로젝트 가서 CocoaPod init
터미널을 이용하여 코코아팟 라이브러리를 적용하고 싶은 프로젝트 경로로 들어간다.
프로젝트 경로로 간 상태에서 아래의 명령어를 입력 해준다.
> pod init

프로젝트 폴더에 가보면, Podfile 생성되어 있다.

#### 세번째 Podfile을 활용해 라이브러리 다운로드 받는 방법
Podfile 을 수정해서 라이브러리를 다운로드 받을 수 있다.
* vi 를 활용해서 수정을 해보겠다.
> vi Podfile

내가 원하는 라이브러리를 pod '라이브러리 이름'을 적어준다.
> pod 'SwiftLint'

swift Lint 라이브러리를 다운 받아 보겠다.

```
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'VendingMachine' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
    pod 'SwiftLint'
  # Pods for VendingMachine

  target 'VendingMachineUnitTest' do
    inherit! :search_paths
    # Pods for testing
  end

end
```

pod 라이브러리이름 뒤에 ~>가 붙은 숫자 코드는 버전이다.

 > pod 'Alamofire', '~> 5.0.0-beta.5'

내가 사용하는 SwiftLint 라이브러리는 안써줘도 되는것 같다.
> 참고 : <https://github.com/realm/SwiftLint/blob/master/README_KR.md>


만약에 내가 쓰고싶은 라이브러리가 있다면, 먼저 코코아팟 사이트에 가셔서 검색을 하고, 해당 라이브러리 글에 들어가면, 어떻게 사용하는지 나온다.
> 참고 : <https://cocoapods.org/>

#### 네번째 pod install
이제 Podfile을 저장하고, 다시 터미널 창으로 돌아 온 다음, 아래의 명령어를 입력 해준다.
> pod install


```
Analyzing dependencies
Downloading dependencies
Installing SwiftLint (0.27.0)
Generating Pods project
Integrating client project

[!] Please close any current Xcode sessions and use `VendingMachine.xcworkspace` for this project from now on.
Sending stats
Pod installation complete! There is 1 dependency from the Podfile and 1 total pod installed.

[!] Automatically assigning platform `osx` with version `10.14` on target `VendingMachine` because no platform was specified. Please specify a platform for this target in your Podfile. See `https://guides.cocoapods.org/syntax/podfile.html#platform`.
```
성공적으로 설치했다는 글이 나온다.


```
[!] Please close any current Xcode sessions and use `*.xcworkspace` for this project from now on.
```

현재 Xcode세션을 종료하고,이제부터 *.xcworkspace를 사용하라는 뜻이다.

VendingMachine.xcworkspace가 생겼다. 

VendingMachine.xcworkspace로 열어야만 설치한 라이브러리를 사용할 수 있다.

VendingMachine.xcworkspace에서 설치한 라이브러리를 import 해줘야 한다.
그렇지만 지금 사용한 프로젝트는 import를 하지 않아도 된다. 

### 삭제
프로젝트 폴더안에 있는 Podfile을 연다.
설치 할때 작성한 pod '라이브러리 이름' 부분을 지운다.
> pod install

명령어를 실행시키면 삭제 됬다고 나온다.