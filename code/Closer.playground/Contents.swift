///정렬을 위한 함수 전달
let names: [String] = ["wimes", "eric", "jenny", "kevin"]

func backwards(first: String, second: String) -> Bool{
  print("\(first) \(second) 비교중")
  return first > second
}
//let reversed: [String] = names.sorted(by: backwards)
//print(reversed)
//eric wimes 비교중
//jenny eric 비교중
//jenny wimes 비교중
//kevin eric 비교중
//kevin jenny 비교중
//kevin wimes 비교중
//["wimes", "kevin", "jenny", "eric"]


///sorted(by:)메서드에 클로저 전달
//let reversed: [String] = names.sorted(by: {
//    (first: String, second: String) -> Bool in
//    return first > second
//})
//print(reversed) // ["wimes", "kevin", "jenny", "eric"]


///후행 클로저 표현
//let reversed: [String] = names.sorted(){ (first: String, second: String) -> Bool in
//    return first > second
//}
//
////sorted(by:) 메서드의 소괄호까지 생략 가능합니다.
//let reversed: [String] = names.sorted { (first: String, second: String) -> Bool in
//    return first > second
//}


///클로저의 타입유추
//// 클로저의 매개변수타입과 반환타입을 생략하여 표현할 수 있습니다.
//let reversed: [String] = names.sorted{ (first, second) in
//    return first > second
//}


///단축 인자 이름 사용
let reversed: [String] = names.sorted{
    return $0 > $1
}


///incrementByTwo 상수에 함수 할당
func makeIncrementer(forIncrement amount: Int) -> ( () -> Int) {
  var runningTotal = 0
  func incrementer() -> Int{
    runningTotal += amount
    return runningTotal
  }
  return incrementer
}

let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)

let first: Int = incrementByTwo() // 2
let second: Int = incrementByTwo() // 4
let third: Int = incrementByTwo() // 6

let incrementByTwo2: (() -> Int) = makeIncrementer(forIncrement: 2)
let incrementByTen: (() -> Int) = makeIncrementer(forIncrement: 10)

let first2: Int = incrementByTwo2() // 2
let second2: Int = incrementByTwo2() // 4
let third2: Int = incrementByTwo2() // 6

let ten: Int = incrementByTen() // 10
let twenty: Int = incrementByTen() // 20


///함수를 탈출하는 클로저의 예
//typealias VoidVoidClosure = () -> Void
//let firstClosure: VoidVoidClosure = {
//    print("Closure A")
//}
//let secondClosure: VoidVoidClosure = {
//    print("Closure B")
//}
//
//// first와 second 매개변수 클로저는 함수의 반환값으로 사용될 수 있으므로 탈출 클로저입니다.
//func returnOneClosure(first: @escaping VoidVoidClosure, second: @escaping VoidVoidClosure, shouldRetrunFirstClosure: Bool) -> VoidVoidClosure{
//    // 전달인자로 전달받은 클로저를 함수 외부로 다시 반환하기 때문에 함수를 탈출하는 클로저입니다.
//    return shouldRetrunFirstClosure ? first : second
//}
//
//// 함수에서 반환한 클로저가 함수 외부의 상수에 저장되었습니다.
//let returnedClosure: VoidVoidClosure = returnOneClosure(first: firstClosure, second: secondClosure, shouldRetrunFirstClosure: true)
//
//returnedClosure() // Closure A
//
//var closures: [VoidVoidClosure] = []
//
//// closure 매개변수 클로저는 함수 외부의 변수에 지정될 수 있으므로 탈출 클로저입니다.
//func appendClosure(closure: @escaping VoidVoidClosure){
//    // 전달인자로 전달받은 클로저가 함수 외부의 변수 내부에 저장되므로 함수를 탈출합니다.
//    closures.append(closure)
//}


///클래스 인스턴스 메서드에 사용되는 탈출, 비탈출 클로저
typealias VoidVoidClosure = () -> Void

func functionWithNoescapeClosure(closure: VoidVoidClosure){
    closure()
}

func functionWithEscapingClosure(completionHandler: @escaping VoidVoidClosure) -> VoidVoidClosure {
    return completionHandler
}

class SomeClass{
    var x = 10
    
    func runNoescapeClosure(){
        // 비탈출 클로저에서 self 키워드 사용은 선택사항입니다.
        functionWithNoescapeClosure {
            x = 200
        }
    }
    
    func runEscapingClosure() -> VoidVoidClosure{
        // 탈출 클로저에서는 명시적으로 self를 사용해야 합니다.
        return functionWithEscapingClosure {
            self.x = 100
        }
    }
}

let instance: SomeClass = SomeClass()
instance.runNoescapeClosure()
print(instance.x) // 200

let returnedClosure: VoidVoidClosure = instance.runEscapingClosure()
returnedClosure()
print(instance.x) // 100


///오류가 발생하는 hasElements 함수
//func hasElements(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
//
//    //Error!: Escaping closure captures non-escaping parameter 'predicate'
//    return (array.lazy.filter{
//        predicate($0)
//        }.isEmpty == false)
//}

///withoutActuallyEscaping(_:do:)함수의 활용
let numbers: [Int] = [2, 4, 6, 8]

let evenNumberPredicate = { (number: Int) -> Bool in
    return number % 2 == 0
}

let oddNumberPredicate = { (number: Int) -> Bool in
    return number % 2 == 1
}

func hasElements(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
    
    withoutActuallyEscaping(predicate, do: { escapablePredicate in//
        return (array.lazy.filter{
            escapablePredicate($0)//
        }.isEmpty == false)
    })
}

let hasEvenNumber = hasElements(in: numbers, match: evenNumberPredicate)
let hasOddNumber = hasElements(in: numbers, match: oddNumberPredicate)

print(hasEvenNumber) // true
print(hasOddNumber) // false


///클로저를 이용한 연산 지연
//대기중은 손님들
//var customersInLine: [String] = ["YoangWha", "SangYong", "SungHun", "HaMi"]
//print(customersInLine.count) // 4
//
//// 클로저를 만들어두면 클로저 내부의 코드를 미리 실행(연산)하지 않고 가지고만 있습니다.
//let customerProvider: () -> String = {
//    return customersInLine.removeFirst()
//}
//print(customersInLine.count) // 4 아직 실행 안됨
//
//// 실제로 실행
//print("Now serving \(customerProvider())!") // Now serving YoangWha!
//print(customersInLine.count)


///함수의 전달인자로 전달하는 클로저
var customersInLine: [String] = ["YoangWha", "SangYong", "SungHun", "HaMi"]

func serveCutomer(_ customerProvider: () -> String){
    print("Now serving \(customerProvider())!")
}

serveCutomer({
    customersInLine.removeFirst() // Now serving YoangWha!
})
