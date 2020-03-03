///매개변수 이름과 전달인자 레이블
//// from과 to라는 전달인자 레이블이 있으며
//// myName과 name이라는 매개변수 이름이 있는 sayHello 함수
//func sayHello(from myName: String, to name: String) -> String{
//  return "Hello \(name)! I'm \(myName)"
//}
//
//print(sayHello(from: "wimes", to: "Jenny")) // Hello Jenny! I'm wimes


///매개변수 기본값
//times 매개변수가 기본값 3을 갖는다.
func sayHello(_ name: String, times: Int = 3) -> String{
  var result: String = ""
  
  for _ in 0..<times{
    result+="Hello \(name)!" + " "
  }
  
  return result
}

//times 매개변수의 전달 값을 넘겨주지 않아 기본값 3을 반영해서 세 번 호출
print(sayHello("Hana")) // Hello Hana! Hello Hana! Hello Hana!

//times 매개변수의 전달값을 2로 넘겨주었기 때문에 전달 값을 반영해서 두 번 호출
print(sayHello("Hana", times: 2)) // Hello Hana! Hello Hana!


///가변매개변수를 가지는 함수의 정의와 사용
func sayHelloToFriends(me: String, friends names: String ...) -> String{
    var result: String = ""
    
    for friend in names{
        result += "Hello \(friend)!" + " "
    }
    
    result += "I'm "+me+"!"
    return result
}

print(sayHelloToFriends(me: "wimes", friends: "Johansson", "Jay", "Wiz"))
// Hello Johansson! Hello Jay! Hello Wiz! I'm wimes!

print(sayHelloToFriends(me: "wimes"))
// I'm wimes!


///inout 매개변수의 활용
var numbers: [Int] = [1, 2, 3]

func nonReferenceParameter(_ arr: [Int]){
    var copiedArr: [Int] = arr
    copiedArr[1] = 1
}

func referenceParameter(_ arr: inout [Int]){
    arr[1] = 1
}

nonReferenceParameter(numbers)
print(numbers[1]) // 2

referenceParameter(&numbers)
print(numbers[1]) // 1


///함수 타입의 사용
typealias CalculateTowInts = (Int, Int) -> Int

func addTwoInts(_ a: Int, _ b: Int) -> Int{
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunction: CalculateTowInts = addTwoInts
// var mathFunction: (Int, Int) -> Int = addTwoInts와 동일한 표현 입니다.

print(mathFunction(2,5)) // 2 + 5 = 7

mathFunction = multiplyTwoInts
print(mathFunction(2, 5)) // 2 * 5 = 10


///전달인자로 함수를 전달받는 함수
func printMathResult(_ mathFunction: CalculateTowInts, _ a: Int, _ b: Int){
    print("Result: \(mathFunction(a, b))")
}

printMathResult(addTwoInts, 3, 5) // 8


///특정 조건에 따라 적절한 함수를 반환해주는 함수
func chooseMathFunction(_ toAdd: Bool) -> CalculateTowInts {
    return toAdd ? addTwoInts : multiplyTwoInts
}

printMathResult(chooseMathFunction(true), 3, 5)


/////원점으로 이동하기 위한 함수
//typealias MoveFunc = (Int) -> Int
//
//func goRight(_ currentPosition: Int) -> Int {
//    return currentPosition + 1
//}
//
//func goLeft(_ currentPosition: Int) -> Int{
//    return currentPosition - 1
//}
//
//func functionForMove(_ shouldGoLeft: Bool) -> MoveFunc{
//    return shouldGoLeft ? goLeft : goRight
//}
//
//var position: Int = 3 // 현 위치
//
//// 현위치가 0보다 크므로 전달되는 인자 값은 true가 됩니다.
//// 그러므로 goLeft(_:)함수가 할당될 것입니다.
//let moveToZero: MoveFunc = functionForMove(position > 0)
//print("원점으로 갑니다.")
//
//// 원점에 도착하면 반복문이 종료됩니다.
//while position != 0 {
//    print("\(position)...")
//    position = moveToZero(position) // goLeft(postion) => currentPostion - 1
//}
//print("원점 도착")
//// 3...
//// 2...
//// 1...
//// 원점 도착


///중첩함수의 사용
typealias MoveFunc = (Int) -> Int

func functionForMove(_ shouldGoLeft: Bool) -> MoveFunc{
    func goRight(_ currentPosition: Int) -> Int {
        return currentPosition + 1
    }

    func goLeft(_ currentPosition: Int) -> Int{
        return currentPosition - 1
    }
    
    return shouldGoLeft ? goLeft : goRight
}

var position: Int = -4 // 현 위치

// 현위치가 0보다 크므로 전달되는 인자 값은 false가 됩니다.
// 그러므로 goRight(_:)함수가 할당될 것입니다.
let moveToZero: MoveFunc = functionForMove(position > 0)
print("원점으로 갑니다.")

// 원점에 도착하면 반복문이 종료됩니다.
while position != 0 {
    print("\(position)...")
    position = moveToZero(position) // goRight(postion) => currentPostion + 1
}
print("원점 도착")
// -4...
// -3...
// -2...
// -1...
// 원점 도착


/////비반환 함수의 정의와 사용
//func crashAndBurn() -> Never {
//    fatalError("Something very, very bad happend")
//}
//
////crashAndBurn()
//
//func someFunction(isAllIsWell: Bool){
//    guard isAllIsWell else {
//        print("마을에 도둑이 들었습니다!")
//        crashAndBurn()
//    }
//    print("isAllIsWell")
//}
//
//someFunction(isAllIsWell: true) // All is well
//someFunction(isAllIsWell: false) // 마을에 도둑이 들었습니다.
//// 프로세스 종료 후 오류 보고
