/// for-in 구문과 맵 메서드의 사용 비교
//let numbers: [Int] = [0,1,2,3,4]
//
//var doubledNumbers: [Int] = [Int]()
//var strings: [String] = [String]()
//
////for
//for number in numbers{
//    doubledNumbers.append(number * 2)
//    strings.append("\(number)")
//}
//
//print(doubledNumbers) // [0, 2, 4, 6, 8]
//print(strings) // ["0", "1", "2", "3", "4"]
//
////map
//doubledNumbers = numbers.map({ (number: Int) -> Int in
//    return number * 2
//})
//strings = numbers.map({ (number: Int) -> String in
//    return "\(number)"
//})
//
//print(doubledNumbers) // [0, 2, 4, 6, 8]
//print(strings) // ["0", "1", "2", "3", "4"]
//
////또한 클로저 표현의 간략화도 가능
//doubledNumbers = numbers.map({return $0 * 2})
//print(doubledNumbers) // [0, 2, 4, 6, 8]
//
//doubledNumbers = numbers.map({$0 * 2})
//print(doubledNumbers) // [0, 2, 4, 6, 8]
//
//doubledNumbers = numbers.map{$0 * 2}
//print(doubledNumbers) // [0, 2, 4, 6, 8]


///filter 메서드의 사용
//let numbers: [Int] = [0,1,2,3,4,5]
//
////let evenNumbers: [Int] = numbers.filter { (number: Int) -> Bool in
////    return number % 2 == 0
////}
////print(evenNumbers) // [0, 2, 4]
////
////let oldNumbers: [Int] = numbers.filter{ $0 % 2 == 1}
////print(oldNumbers) // [1, 3, 5]
//
/////map과 fileter의 연계 사용
//let mappedNumbers: [Int] = numbers.map{$0 + 3}
//
//let evenNumbers: [Int] = mappedNumbers.filter { (number: Int) -> Bool in
//    return number % 2 == 0
//}
//print(evenNumbers) // [4, 6, 8]
//
//// mappedNumbers를 굳이 여러번 사용할 필요가 없다면 아래처럼도 가능
//let oddNumbers: [Int] = numbers.map{$0 + 3}.filter{$0 % 2 == 1}
//print(oddNumbers) // [3, 5, 7]


///reduce의 사용
let numbers: [Int] = [1,2,3]

// 첫번째 형태인 reduce(_:_:)메서드의 사용

// 초기값이 0이고 배열의 모든 값을 더한다.
var sum: Int = numbers.reduce(0, { (result: Int, next: Int) -> Int in
    print("\(result) + \(next)")
//    0 + 1
//    1 + 2
//    3 + 3
    return result + next
})

print(sum) //6

// 두번째 형태인 reduce(into:_:)메서드의 사용
// 초기값이 0이고 정수 배열의 모든 값을 더한다.
// 첫번째 리듀스 형태와 달리 클로저의 값을 반호나하지 않고 내부에서 직접 이전 값을 변경한다는 점이 다르다.
sum = numbers.reduce(into: 0, { (result: inout Int, next: Int) in
    print("\(result) + \(next)")
//    0 + 1
//    1 + 2
//    3 + 3
    result += next
})
print(sum) //6
