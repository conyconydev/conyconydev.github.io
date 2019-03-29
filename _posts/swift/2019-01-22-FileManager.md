---
layout: post
title:  FileManager
date:  2019-01-22 12:45:22
category: post
tags: [swift]
---

# FileManager 를 공부해보자!



**FileManager를 이용해 파일/폴더 만드는 법**

파일 및 디렉토리와 관련된 가장 기본적인 작업 중 일부는 파일 시스템을 생성하고 파일 시스템 중심으로 이동시키는 것입니다. 이 작업은 앱이 작업을 수행하는데 필요한 파일 시스템 구조를 빌드하는 방법입니다 .대부분의 작업에서 NSFileManager클래스는 파일을 만들고 조작하는데 필요한 기능을 제공해야합니다. 



### Creating New Files and Directories Programmatically



파일 및 디렉토리를 만드는 것은, 파일 관리의 기본 부분입니다.

일반적으로 사용자 지정 디렉토리를 만들어, 코드에서 만든 파일을 구성합니다. 예를들어, Application Support디렉토리에 사용자 정의 디렉토리를 만들어, 앱에서 관리하는 개인 데이터 파일을 저장할 수 있습니다. 그리고 파일을 만드는 많은 방법이 있습니다.



### Creating Directories



사용자 정의 디렉토리를 만들려면, NSFileManager의 메소드를 사용합니다. 프로세스는 권한을 가진 곳이면, 어디에서나 디렉토리를 생성할 수 있으며, 항상 현재 홈 디렉토리를 포함하며 다른 파일 시스템 위치도 포함 할 수 있습니다. 경로를 만들고, NSURL또는 NSString객체를 다음 방법중 하나로 전달하여 만들 디렉토리를 지정합니다.



- `**createDirectoryAtURL:withIntermediateDirectories:attributes:error:**` (macOS 10.7 and later only)
- `**createDirectoryAtPath:withIntermediateDirectories:attributes:error:**`



NSFileManager메소드는 단순성 때문에 새 디렉토리를 만드는데 선호되는 방법입니다. 그러나 mkdir함수를 사용하여 직접 디렉토리를 만들 수도 있습니다. 그렇게 할 경우, 중간 디렉토리를 만들고 발생하는 모든 오류를 처리해야합니다. ==> 걍 NSFileManager메소드 써라 아닙니까.





### Creating New Files



파일을 만들려면, 파일 시스템의 파일에 대한 레코드를 만들고 파일에 내용을 채우는 두 파트가 있습니다. 파일을 생성하기 위한 모든 고급 인터페이스는 두 작업을 동시에 수행합니다. 대개 파일을 NSData 또는 NSString객체의 내용으로 채운 다음 파일을 닫습니다. 하위 수준 함수를 사용하여 빈 파일을 만들고, 파일 설명자(file descriptor )를 가져와서 파일로 채울 수 있습니다. 파일을 만드는데 사용할 수 있는 루틴 중 일부는 다음과 같습니다. 

- `**createFileAtPath:contents:attributes:**`(`NSFileManager`)
- `**writeToURL:atomically:**` (`NSData`)
- `**writeToURL:atomically:**` (`NSString`)
- `**writeToURL:atomically:encoding:error:**`(`NSString`)
- `writeToURL:atomically:` (Various collection classes define this method for writing out property lists.)
- `open` function with the `O_CREAT` option creates a new empty file



Note : 생성한 모든 파일은 현재 사용자 및 프로세스와 관련된 모든 권한을 상속합니다.



이까지가 FileManager에 관한 Apple문서였구요. 실습..?만드는 방법..을 보겠습니댜



사용자에 의해 생성되는 모든 Contents는 Documents디렉토리에 저장되도록 권장?강제..?하고 있습니다. 적어도 Apple문서에서는요.

그럼 자 생각해봅시다.

내가 파일을 하나 어디에 저장하고 싶어. 그럼 Documents디렉토리 안에 저장되어야 할거에요.

그럼 중요한건? 네. 이 Document디렉토리가 어딨는지를 일단, 가장 먼저 알아야겠죠. 

네 그렇습니다. 처음 할 거는 Document Directory URL얻기. 



그 전에!!! 파일을 생성하기 가장 쉬운 방법은 FileManager를 사용하는 방법이죠?



```swift
let fileManager = FileManager.default
```



먼저 FileManager인스턴스를 생성해야겠죠?  default는 FileManager의 싱글톤 인스턴스를 만들어준답니다.



```swift
let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
```



저 urls라는 메소드는 요청된 도메인에서 지정된 공통 디렉토리에 대한 URL배열을 리턴해주는 메소드에요.

첫번째 파라미터는 검색 경로 디렉토리에요.  들어간 값을 보니, enum인 것 같죠?

무슨 값들이 있는지는 [여기](https://developer.apple.com/documentation/foundation/filemanager.searchpathdirectory)에 나와있어요.  그리고 두번째는 Domain을 나타내는 파라미터로, 다른 값들은 [여기](https://developer.apple.com/documentation/foundation/filemanager.searchpathdomainmask)에 나와있어요. 



자. 그럼 우리는 지금 Documents디렉토리의 URL을 안거에요.

그럼 내가 뭐..파일을 추가한다고 생각해볼게요. 폴더를 추가할 수도 있겠지만요.

그럼 그 파일의 이름!! 이름있죠. 이름을 정해줘야 합니다.



```swift
let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
let fileURL = documentsURL.appendingPathComponent("make파일")
```



자..이게 무슨뜻일까요. 아까 우리가 가져왔던 DocumentURL에 파라미터로 받은 path component를 추가하고 난!!! 이걸 추가하고 난!!!1그 이후의 URL을 돌려줍니다.

이상태까지만 하면, Files앱에 안나오는데, 뭔가를 써야 나오게 됩니다.



```swift
let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
let fileURL = documentsURL.appendingPathComponent("make 파일")
let myTextString = NSString(string: "HELLO WORLD")

try? myTextString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8.rawValue)
```



이렇게 하면, 뭔가 해당 파일에 HELLO WORLD를 쓴다는 것 같죠? 맞습니다.



확장자 지정

```swift
let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
let fileURL = documentsURL.appendingPathComponent("make 파일.txt")
```



만약에 내가 파일을 "**다운로드**"한다고 쳐봅시다. 

내가 다운로드 할 파일이 텍스트인지..뭔지 어케 알겠어요? 그래서 보통

```swift
let fileURL = documentsURL.appendingPathComponent((nameUrl?.lastPathComponent)!)
```



그 다운받으려는 파일의 URL있죠???? 보통 String이죠? "~~~~어쩌고 저쩌고"일텐데, 이 다운받으려는 URL을(String이지만) => 진짜  URL타입으로 바꿔주세요.

그러면, **lastPathComponent**라는 프로퍼티를 얻을 수 있는데, 딱 보면 알겠듯이 마지막 컴포넌트? 라는 말 같죠? 보통 가장 마지막에 "파일 이름"이 들어가기 때문에 대부분 lastPathComponent를 사용합니다.



위 코드에서 nameUrl이 다운받으려는 URL String을 URL타입으로 바꿔준 거에요.



Alamofire를 사용하면 파일 다운로드가 굉장히 쉬워진답니다. XD

```swift
let fileURL = documentsURL.appendingPathComponent((nameUrl?.lastPathComponent)!)
```

이렇게 얻은 FileURL있죠????이걸 넘겨주기만 하면, 해당 폴더에 다운로드를 해줘요. write이런거 안해도댐 ㅎㅎ

==> 내가 다운받았던 파일을 또 받으면 어케되냐? 알아서 저번꺼 삭제하고 다시 새로운걸로 만들어줌 ㅇㅇ





**● 디렉토리 만드는법**

```swift
let filePath =  documentsURL.appendingPathComponent("cony")
            if !fileManager.fileExists(atPath: filePath.path) {
                do {
                    try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    NSLog("Couldn't create document directory")
                }
            }
```



원리는 파일과 똑같아요. createDirectory 메소드를 사용해서 디렉토리를 만들 위치만 지정해주면 디렉토리가 짠 하고 만들어진답니다. 

이렇게요. 디렉토리 이름이 cony 이유는???

```swift
let filePath =  documentsURL.appendingPathComponent("cony")
```



```swift
let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("cony")
```

