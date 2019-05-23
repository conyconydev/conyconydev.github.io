---
layout: post
title:  UIImageView && Custom View 만들기
date:  2019-05-18 23:54:25
category: post
tags: [ios]
---

- [[iOS] UIImageView 학습 && Custom View 만들기](#ios-uiimageview-%ED%95%99%EC%8A%B5--custom-view-%EB%A7%8C%EB%93%A4%EA%B8%B0)
    - [UIImageView에 이미지를 추가하기](#uiimageview%EC%97%90-%EC%9D%B4%EB%AF%B8%EC%A7%80%EB%A5%BC-%EC%B6%94%EA%B0%80%ED%95%98%EA%B8%B0)
    - [Custom View 만들기](#custom-view-%EB%A7%8C%EB%93%A4%EA%B8%B0)
      - [addSubView()로 서브뷰를 추가했을때](#addsubview%EB%A1%9C-%EC%84%9C%EB%B8%8C%EB%B7%B0%EB%A5%BC-%EC%B6%94%EA%B0%80%ED%96%88%EC%9D%84%EB%95%8C)
      - [인터페이스 빌더에서 서브뷰를 추가했을 때](#%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4-%EB%B9%8C%EB%8D%94%EC%97%90%EC%84%9C-%EC%84%9C%EB%B8%8C%EB%B7%B0%EB%A5%BC-%EC%B6%94%EA%B0%80%ED%96%88%EC%9D%84-%EB%95%8C)
    - [UIView의 생성자](#uiview%EC%9D%98-%EC%83%9D%EC%84%B1%EC%9E%90)

<br />
# [iOS] UIImageView 학습 && Custom View 만들기

Apple 문서: [UIImageView](https://developer.apple.com/documentation/uikit/uiimageview)



### UIImageView에 이미지를 추가하기

* 첫 번째 방법 : 
  * 1. 프로젝트에 `.png`파일이나 `.jpg`파일 추가
  * 2. Main.storyboard 를 클릭
  * 3. UIImageView를 선택
  * 4. attributes inspector 선택 후 Image: 에서 넣고 싶은 이미지 파일 선택


<img width="400" src="https://github.com/conyconydev/conyconydev.github.io/blob/master/_posts/postImg/imgAdd01.png?raw=true">
<img width="400" src="https://github.com/conyconydev/conyconydev.github.io/blob/master/_posts/postImg/imgAdd02.png?raw=true">
<br />

* 두 번째 방법
  * 코드 설정하는 방법
  * 1. 프로젝트에 `.png`파일이나 `.jpg`파일 추가
( IBOutlet 연결 해줘야 한다.)

<pre><code class="swift">
@IBOutlet weak var banana: UIImageView?
override func viewDidLoad() {
    super.viewDidLoad()
    banana?.image = UIImage(named: "Banana.jpg")
}
</code></pre>


### Custom View 만들기
나의 문제 : 

여러개의 ImageView를 수정하고 싶다. ViewController에  ImageView 수정하는 코드를 작성하였다.



> 이렇게 특정 뷰의 속성을 모두 바꾸는 코드를 꼭 ViewController가 갖고 있어야 할까요? ViewController가 비효율적으로 길어지네요!

서브뷰를 만들어서 상속을 해서 더 구체적인 동작을 하는 뷰 객체를 만드는 방법이 좋겠다.

1. UIImageView를 상속받는 Cocoa Touch Class 만든다.
2. 내가 원하는 속성을 지정 해준다.
3. 추가할 서브뷰들의 타입을 Custom View 타입으로 지정 해준다.

> 예) Custom View를 상속 받은 모든 UIImageView에 둥근 모서리(cornerRadius)속성을 부여하고 싶다! 한번 해보자!

#### addSubView()로 서브뷰를 추가했을때
code로 추가한 view에 속성을 적용하기 위해서는 init(frame:)에 속성을 지정 해줘야한다.
다만, init(frame:)에는 무조건 frame값을 넣어 줘야하기 때문에, 아래 예시코드와 같은 방법으로 convenience init에 임시 frame값을 넣어줘도 된다.
이 방법을 사용하면 원하는 frame값은 상위모듈에서 바꿔 줘야한다.

<pre><code class="swift">
override init(frame: CGRect) { // by code
    super.init(frame: frame)
    self.layer.cornerRadius = 5.0
    self.clipsToBounds = true
}
convenience init() {
    self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
}
</code></pre>

#### 인터페이스 빌더에서 서브뷰를 추가했을 때
인터페이스 빌더에서 custom Class로 지정한 View는 required init?(coder aDecoder:)가 호출된다.
(storyboard에서 ViewController가 가진 View의 타입을 오른쪽 탭 custom class에서 내가 추가한 custom View class 이름 입력하여 연결)

만약에 어디서 호출될지 모르면 awakeFromNib과 두 convenience init에 설정하는 코드를 넣어주면 된다. 는 꼼수아닌 꼼수도 있다.
<pre><code class="swift">
override func awakeFromNib() {
    // config setting code
        super.awakeFromNib()
    }

required init?(coder aDecoder: NSCoder) {
    // config setting code
    fatalError("init(coder:) has not been implemented")
}
</code></pre>

### UIView의 생성자
서브뷰를 추가하는 방법에 따라 (뷰를 생성되는 방법에 따라) 호출되는 UIView의 초기화 함수가 결정되기 때문에, Custom View의 어디에 속성설정 코드를 넣어야 하는지가 중요하다

UIView는 두개의 필수 생성자가 있다. 
**init(coder: NSCoder)**, **init(frame: CGRect)** 이다.
<br />

* **init(coder: NSCoder)** 는 storyboard에서 UIView를 만들 때 호출되는 생성자 이다.
View를 storyboard에서 드래그해서 만들었는데,앱이 실행될때 storyboard가 재구성되면 이 생성자가 호출되면서 UIView가 만들어진다.

* **init(frame: CGRect)** 는 코드로 UIView를 만들 때 호출되는 생성자 이다. 
반드시 CGRect타입으로 프레임을 정해주고, UIView를 생성한다.
<pre><code class="swift">
let rect = CGRect(x: 10, y: 10, width: 100, height: 100)
let myView = UIView(frame: rect)
</code></pre>

