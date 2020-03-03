/////옵셔널 변수의 선언 및 nil 할당
//var myName: String? = "wimes"
//print(myName) // Optional("wimes")
//
//myName = nil
//print(myName) // nil


///switch를 통한 옵셔널 값의 확인
func checkOptionalValue(value optionalValue: Any?){
    switch optionalValue {
    case .none:
        print("This Optional variable is nil")
    case .some(let value):
        print("Value is \(value)")
    }
}


/////switch를 통한 옵셔널 값의 확인
//var myName: String? = "wimes"
//checkOptionalValue(value: myName) // Value is wimes
//
//myName = nil
//checkOptionalValue(value: myName) // This Optional variable is nil

let numbers: [Int?] = [2, nil, -4, nil, 100]

for number in numbers{
    switch number {
    case .some(let value) where value < 0:
        print("Negative value!! \(value)")
    case .some(let value) where value > 10:
        print("Large value!! \(value)")
    case .some(let value):
        print("Value \(value)")
    case .none:
        print("nil")
    }
}

//Value 2
//nil
//Negative value!! -4
//nil
//Large value!! 100


///옵셔널 값의 강제추출
//var myName: String? = "wimes"
//
//// 옵셔널이 아닌 변수에는 옵셔널 값이 들어갈 수 없습니다. 추출해서 할당해주어야 합니다.
//var wimes: String = myName!
//
//myName = nil
////wimes = myName! // 런타임 오류!
//
//// if 구문 등 조건문을 이용해서 조금 더 안전하게 처리해볼 수 있습니다.
//if myName != nil{
//    print("My name is \(myName)")
//}else{
//    print("myName is nil")
//}
//// myName is nil


///옵셔널 바인딩을 사용한 옵셔널 값의 추출
//var myName: String? = "wimes"
//
//// 옵셔널 바인딩을 통한 임시 상수 할당
//if let name = myName{
//    print("My name is \(name)")
//}else{
//    print("myName is nil")
//}
//// My name is wimes
//
//// 옵셔널 바인딩을 통한 임시 변수 할당
//if var name = myName{
//    name = "john"
//    print("My name is \(name)")
//}else{
//    print("myName is nil")
//}
//// My name is john
//
//print(myName) // Optional("wimes")


///옵셔널 바인딩을 사용한 여러 개의 옵셔널 값의 추출
var myName: String? = "wimes"
var yourName: String? = nil


if let name = myName, let friend = yourName{
    print("We are friend! \(name) , \(friend)")
}else{
    print("friend에 바인딩 되지 않으므로 실행되 않습니다.")
}
// friend에 바인딩 되지 않으므로 실행되 않습니다.

yourName = "eric"

if let name = myName, let friend = yourName{
    print("We are friend! \(name) , \(friend)")
}else{
    print("friend에 바인딩 되지 않으므로 실행되 않습니다.")
}
// We are friend! wimes , eric


