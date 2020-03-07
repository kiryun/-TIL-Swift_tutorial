///addThree 함수
func addThree(_ num: Int) -> Int{
    return num + 3
}

addThree(2) // 5
//addThree(Optional(2)) // Error!


///map을 사용하여 옵셔널을 연산할 수 있는 addThree(_:) 함수
Optional(2).map(addThree) // 5

//따로 함수가 없어도 클로저를 사용할 수도 있다.
var value: Int? = 2
value.map({ $0 + 3 }) // Opational(5)
value = nil
value.map({ $0 + 3 }) // nil(== Optional<Int>.none)


///옵셔널의 map 구현
extension Optional{
    func map<T>(f: (Wrapped) -> T) -> T? {
        switch self {
        case .some(let x):
            return f(x)
        case .none:
            return .none
        }
    }
}


///doubleEven(_:)함수와 플랫맵의 사용
func doubleEven(_ num: Int) -> Int? {
    if num.isMultiple(of: 2){ //num이 2의 배수이면
        return num * 2
    }
    return nil
}

Optional(3).flatMap(doubleEven) // nil


///map과 compact의 차이
let optionals: [Int?] = [1, 2, nil, 5]

let mapped: [Int?] = optionals.map({ $0 })
let compactMapped: [Int] = optionals.compactMap({ $0 })
let flatMapped: [Int] = optionals.flatMap({ $0 }) // flatMap과 compactMap은 동작이 같다. 그러나 의미전달의 이유로 **여기서는(sequence인 경우)** compactMap을 사용한다.

print(mapped) // [Optional(1), Optional(2), nil, Optional(5)]
print(compactMapped) // [1, 2, 5]
print(flatMapped) // [1, 2, 5]


///중첩된 컨테인너에서 map과 flatMap(compactMap)의 차이
let multipleContainer = [[1, 2, Optional.none], [3, Optional.none], [4, 5, Optional.none]]

let mappedMultipleContainer = multipleContainer.map({
    $0.map({ $0 })})
let flatmappedMultipleContainer = multipleContainer.flatMap({
    $0.flatMap({ $0 })})


print(mappedMultipleContainer)
// [[Optional(1), Optional(2), nil],
// [Optional(3), nil], [Optional(4), Optional(5), nil]]
print(flatmappedMultipleContainer)
// [1, 2, 3, 4, 5]


///flatmap의 활용
func stringToInteger(_ string: String) -> Int?{
    return Int(string)
}

func integerToString(_ integer: Int) -> String?{
    return "\(integer)"
}

var optioanlString: String? = "2"

let flattenResult = optioanlString.flatMap(stringToInteger)
    .flatMap(integerToString)
    .flatMap(stringToInteger)

print(flattenResult) // Optional(2)
let mappedResult = optioanlString.map(stringToInteger) // 더 이상 체인 연결 불가
print(mappedResult) // Optional(Optional(2))
