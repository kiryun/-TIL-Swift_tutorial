///구조체 정의와 인스턴스 생성 및 사용
struct BasicInformation{
  var name: String
  var age: Int
}

// 프로퍼티 이름(name, age)으로 자동 생성된 이니셜라이저를 사용하여 구조체를 생성합니다.
var wimesInfo: BasicInformation = BasicInformation(name: "wimes", age: 26)
wimesInfo.age = 100
wimesInfo.name = "JJ"

// 프로퍼티 이름(name, age)으로 자동 생성된 이니셜라이저를 사용하여 구조체를 생성합니다.
let jjInfo: BasicInformation = BasicInformation(name: "JJ", age: 99)
//jjInfo.age = 100 // 변경 불가
//jjInfo.name = "KK" // 변경 불가


///클래스 정의와 인스턴스 생성 및 사용
class Person{
//    var err: Float // 초기화 해주지 않으면 에러 출력
    var height: Float = 0.0
    var weight: Float = 0.0
}

var wimes: Person = Person()
wimes.height = 123.4
wimes.weight = 123.4

let jenny: Person = Person()
jenny.height = 123.4
jenny.height = 11.1
jenny.weight = 123.4
jenny.weight = 11.1


///인스턴스 생성 및 소멸
class Person_{
    var height: Float = 0.0
    var weight: Float = 0.0
    
    deinit {
        print("인스턴스 소멸")
    }
}

var w: Person_? = Person_()
w = nil // 인스턴스 소멸
