---
layout: post
title:  ladderGamestep1
date:  2018-10-12 15:26:12
category: SwiftIos
tags: [Swift,Array]
---



# LadderGame Step01



## 문제를 풀면서 모르는 부분을 post

### 배열 기초 정리

```swift
// 비어있는 배열
var empty1: [Int] = []
var empty2: [Int]()
var empty3: Array<Int> = []
// 데이터가 있는 배열
var a: Array<Int> = [1,2,3,4]
var b: [Int] = [1,2,3,4]
var c = [1,2,3,4]
var d = Array<Int>(1...4)
// 크기가 정해진 배열
//repeating : 넣을 초기값 , count : 배열의 크기
var sizeFixedStorage = [Int](repeating: 0 , count: 3

// 배열 값 추가
// 한개씩
a.append(5)
// 여러개
a.append(contentsOf: stride(from:5,through:10,by:1)) //5,6,7,8,9,10

// 지정한 위치에 값 추가
a.insert(11 , at: 10)

// 배열 값 수정
// 한개씩
a[1] = [0]
// 여러개
a[2...4] = [0,0,0]

// 배열 값 제거
// 지정한 위치의 값 제거
a.remove(at:10)

// 전부 제거 
a.removeAll()

// 마지막값 제거
a.removeLast() // 만약에 값이 안에 없으면 에러가 난다.
a.popLast() // 에러 안남 . 빈 배열에 대해서 nil 반환

// 배열 오름차순 , 내림차순 정렬
var arr = [40,10,20,80,100]
arr.sort()
arr.reverse()

// 원본 데이터를 건들지 않고 오름차순으로 정렬해서 배열로 반환
arr.sorted()

// 원본 데이터를 건들지 않고 내림차순
var arr = [40,10,20,80,100]
print(arr.sorted(by: >)) //[100,80,40,20,10]
print(arr)//[40,10,20,80,100]
```



### 이차원 배열

```swift
var sizeFixedStorage = [[Int]] = Array(repeating: Array(repeating: 1,count:5 ), count: 3)
// 위의 코드를 줄일수도 있다.
var sizeFizedStorage1 = [[Int]](repeating: Array(repeating: 1,count: 5 ), count: 3)

```

* 내 코드….에서 적용할때 어려웠던점은....

```swift
// 이차원 배열을 출력하고 싶었다.
func printLadder(_ ladderTwoArray : [[Int]]) {
	for index in ladderTwoArray {
        print("",terminator:"|")
        rowPrint(index) // 이부분!!!!!!!!!!!!!!!!!!!!
        print("")
	}
}
```

* 내가 원하는 그림은 .....

```swift
//    이차원 배열 접근하기
//    1. print(ladderTwoArray) 
//    2. print(ladderTwoArray.count)
//    3. print(ladderTwoArray[0][0])
//    4. print(ladderTwoArray[0][1])
//    5. print(ladderTwoArray[0][2])

//	  6. rowPrint(ladderTwoArray[index][])

```

1. 이차원 배열이 잘 찍히는걸 확인함
2. 갯수도 잘 나오네
3. 인덱스 접근도 가능하네



6. 그럼 배열을 row을 넘기고 싶었다.

```swift
rowPrint(ladderTwoArray[index][])
// Use of unresolved identifier 'ladderTwoArray'; did you mean 'ladderTwoLine'?
rowPrint(ladderTwoArray[index])

// 뭘까? 어떻게 접근을 해야할까?
print(type(of: index)) // 를 해보았다.
//두둥....[Int] 응??????????
```

상상을 하지 못한 결과가 나왔다.

c언어로 접근 할때는 

```c

int main(void) {
	int index = 0;
	int arr[10][10] = { {1,2,3} , {4,5,6} };
	for (index = 0 ;  index<10 ; index++)
	{
		printf("%d " , arr[index][0]);
	}
	return 0;
}

```











## 피드백 받은 부분

* ! 강제 옵셔널 처리를 하기 보다는 값을 지정해주는 방식으로 사용하기. 그렇지 않으면 항상 ! 가 있는 코드에서는 프로그램이 멈출 수 있다.
* 함수 이름이나 변수 이름은 swift API 디자인 가이드 문서 참고
* 함수를 중첩해서 사용하기 보다는 풀어서 사용하기