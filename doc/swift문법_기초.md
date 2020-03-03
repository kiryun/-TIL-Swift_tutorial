# swift 문법 기초

아래의 글은 
https://www.inflearn.com/course/스위프트-기본-문법#
강의를 듣고 정리한 글입니다.

글이 기니 옆의 바로가기 기능을 사용하세요.

## Any AnyObject nil

Any - swift의 모든 타입을 지칭하는 키워드

AnyObject - 모든 클래스 타입을 지칭하는 프로토콜

nil - 없음을 의미하는 키워드

```swift
var someAny: Any = 100
someAny = "hello"
someAny = 123.12

let someDouble: Double = someAny // error! 
someAny = nil //error! 어떤 data type도 들어올 수 있지만 '없음'은 들어갈 수 없다.
```

## Collection Type

Array - 순서가 있는 리스트 컬렉션

Dictionary - 키와 값의 쌍으로 이루어진 컬렉션

Set - 순서가 없고, 멤버가 유일한 컬렉션

```swift
var integers: Array<Int> = Array<Int>()
integers.append(1)
integers.append(100) 

integers.contains(100) // true
integers.contains(99) // false

integers.remove(at: 0) // 1
integers.removeLast() // 100
integers.removeAll() // []
integers.count // 0

var doubles: Array<Double> = [Double]()
var characers: [Character] = []

//let을 사용하면 변경불가 append, remove 사용시 error 발생
let immutableArray = [1, 2, 3]

var anyDictionary: Dictionary<String, Any> = [String: Any]()
anyDictionary["someKey"] = "value"
anyDictionary["anotherKey"] = 100
anyDictionary["someKey"] = "dictionary"
//["someKey": "dictionary", "anotherKey": 100]

//removeValue, nil을 이용해 dictionary의 값 삭제 가능
anyDictionary.removeValue(forKey: "anotherKey") // 100
anyDictionary["someKey"] = nil
anyDictionary // [:]

let a: [String: String] = ["name": "gihyun"]
let v: String = a["name"] // error, a["name"]의 값이 있는지 없는지에 대한 불확실성 때문에 에러가 발생한다.

var s: Set<Int> = Set<Int>()
s.insert(1)
s.insert(100)
s.insert(99)
s.insert(99)
s.insert(99)

s // {100, 99, 1} Set는 data의 unique를 보장해준다.

//Set는 집합연산에 유용하게 사용된다.
let setA: Set<Int> = [1,2,3,4,5]
let setB: Set<Int> = [3,4,5,6,7]

let union: Set<Int> = setA.union(setB) // {2,4,5,6,7,3,1}
let sortedUnion: [Int] = union.sorted() // {1,2,3,4,5,6,7}


```

## 함수 고급

```swift
func greeting(friend: String, me: String = "gihyun")
{
  print("Hello \(friend)! I'm \(me)")
}

greeting(friend: "hana") // Hello hana! I'm gihyun

//전달인자 레이블
//매개변수의 역할을 좀 더 명확하게 하거나
//함수 사용자의 입장에서 표현하고자 할 때 사용한다.
func greeting(to friend: String, from me: String){
  print("Hello \(friend)! I'm \(me)")
}

//함수를 호출할 때에는 전달인자 레이블을 반드시 사용해야 한다.
greeting(to: "hana", from: "gihyun")

//가변 매개변수
func sayHelloToFriends(me: String, friends: String...) -> String{
  return "Hello \(friends)! I'm \(me)"
}
print(sayHelloToFriends(me: "gihyun", friends: "hana", "eric", "wing"))
//Hello ["hana", "eric", "Wing"]!  I'm gihyun!

print(sayHelloToFriends(me: "gihyun"))
//Hello []! I'm gihyun!

//스위프트는 함수형 프로그래밍 패러다임을 포함하는 다중 패러다임 언어이다.
//스위프트의 함수는 일급객체이므로 변수, 상수 등에 저장이 가능
//매개변수를 통해 전달할 수도 있다.

//반환값은 생략할 수가 없다. 반환값이 없다면 Void 라고 명시해줘야 한다.
var someFunction: (String, String) -> Void = greeting(to:from:)
someFunction("eric", "gihyun") // Hello eric! I'm gihyun

someFunction = greeting(friend:me:)
someFunction("eric", "gihyun") // Hello eric! I'm gihyun

//타입이 다른 함수는 할당할 수 없다.
//someFuction = sayHelloToFriends(me: Friends:) // error!

func runAnother(function: (String, String) -> Void){
  function("jenny", "mike")
}

runAnother(function: greeting(friend:me:))
//Hello jenny! I'm mike

runAnother(function: someFunction)
//Hello jenny! I'm mike





```



## 반복문



```swift
let people = ["gihyun": 10, "eric": 15, "mike": 12]

// for의 iteration부분에 key, value값이 들어가야 한다.
for (name, age) in people{
  print("\(name): \(age)")
}

let integer = [1, 2, 3]

//swift의 do-while문
repeat{
  integer.removeLast()
} while integer.count > 0
```



## 옵셔널

값이 '있을 수도', ''없을 수도'' 있습니다.

**옵셔널의 존재 이유**

* nil의 가능성을 명시적으로 표현
* nil의 가능성을 문서화 하지 않아도 코드만으로 충분히 표현가능
  * 문서/주석 작성 시간을 절약
* 전달받은 값이 옵셔널이 아니라면 nil 체크를 하지 않더라도 안심하고 사용
  * 효율적인 코딩
  * 예외상황을 최소화하는 안전한 코딩

```swift
//개발문서에 nil이 들어갈 수 있다 없다를 적을 필요가 없음
//코드상으로 이미 nil이 들어갈 수 있는 함수와 그렇지 않은 함수로 나눠져 있다.
func someFunction(someOptionalParam: Int?){
  //...
}

func osmeFunction(someParam: Int){
  //...
}

someFunction(someOptionalParam: nil)
someFunction(someParam: nil) // error! Int를 param으로 받는 함수에 nil을 넣으려고 한다.

```

Optional은 enum 과 general을 이용해 만들어졌습니다.

```swift
//Optional의 정체
enum Optional<Wrapped> : ExpressibleByNilLiteral{
  case none //optinal된 값이 있다.
  case some(Wrpeed) //optional된 값이 없다.
}

//위와 아래 모두 같은 문법
let optionalValue: Optional<Int> = nil
let optionalValue: Int? = nil
```

**Optional ? !**

```swift
//!
//암시적 optional 추출
var optioanlValue: Int! = 100

//optional은 열거형이기 때문에 다음과 같이 검사 가능
switch optionalValue{
  case .none:
  print("This Optional variable is nil")
  case .some(let value):
  print("Value is \(value)")
}

//기존 변수처럼 사용가능
optionalValue = optionalValue + 1

//nil할당 가능
optionalValue = nil

//그러나 잘못된 접근으로 인한 런타임 오류가 발생할 수 있다.(ex. optionalValue가 nil 경우)
optionalValue = optionalValue + 1


//?
var optionalValue: Int? = 100

switch optionalValue{
  case .none:
  print("This Optional variable is nil")
  case .some(let value):
  print("Value is \(value)")
}

//nil할당 가능
optionalValue = nil

//그러나 기존 변수처럼 사용 불가 - 옵셔널과 일반값은 다른 타입이므로 연산불가
optionalValue = optionalValue + 1

```



## Optional 추출

**optional 바인딩**

nil 체크 + 안전한 값 추출

![image-20191025004444592](/Users/gihyunkim/Library/Application Support/typora-user-images/image-20191025004444592.png)

안에 값이 있는지 노크를 해봅니다.

```swift
func printName(_ name: String){
  print(name)
}

var myName: String? = nil

printName(myName)// 전달되는 값의 타입이 다르기 때문에 컴파일 오류 발생

```

**if - let**

```swift
func printName(_ name: String){
  print(name)
}

var myName: String! = nil

//if-let 절 안에서만 사용할 수 있는 name 상수 
if let name: String = myName{
  printNAme(name)
}else{
  print("myName == nil")
}

//여러 optional을 동시에 바인딩 가능
var myName: String? = "gihyun"
var yourName: String? = nil

if let name = myName, let friend = yournName{
  print("\(name) and \(friend)")
}
//yourName이 nil이기 때문에 실행이 안됨

yourName = "hana"

if let name = myName, let friend = yournName{
  print("\(name) and \(friend)")
}
//gihyun and hana

```



**optional 강제추출**

![image-20191025005303851](/Users/gihyunkim/Library/Application Support/typora-user-images/image-20191025005303851.png)

optional 바인딩에서 노크해서 정중하게 꺼내오던 방식과는 다르게 **보호막을 깨부셔서** 안의 내용물을 가져옵니다.

```swift
func printName(_ name: String){
  print(name)
}

var myName: String? = "gihyun"

//강제 추출
printName(myName!) // gihyun

myName = nil

print(myName!) // runTime error. 강제추출시 값이 없으므로 

var yourName: String! = nil

//yourName에 !가 붙었기 때문에 여기에는 !가 붙지않아도 된다.
printName(yourName) // nil 값이 전달되기 때문에 런타임 오류발생
```



## 구조체

```swift
struct Sample{
  var mutableProperty: Int = 100
  let immutableProperty: Int = 100
  
  static var typeProperty: Int = 100
  
  func instanceMethod(){
    print("instance method")
  }
  
  static func typeMethod(){
    print("type method")
  }
}

//가변 인스턴스
var mutable: Sample = Sample()

mutable.mutableProperty = 200
mutable.immutableProperty = 200 //error! struct내부에서 let으로 설정한 것은 변경불가

//불변 인스턴스
let immutable: Sample = Sample()
immutable.mutableProperty = 200 //error! let으로 생성된 인스턴스는 그 어떤 property도 변경할 수 없다.
imutable.instanceMethod() // 메서드 호출은 가능


```



## 클래스

```swift
class Sample{
  var mutableProperty: Int = 100
  let immutableProperty: Int = 100
  
  static var typeProperty: Int = 100
  
  func instanceMethod(){
    print("instance method")
  }
  
  //타입 메서드
  //상속받을시 재정의 불가 타입메서드
  static func typeMethod(){
    print("type method - static")
  }
  
  //재정의 가능 타입메서드
  class func classMethod(){
    print("type method - class")
  }
}


var mutableReference: Sample = Sample()

mutableReference.mutableProperty = 200

//let으로 선언된 인스턴스도 class내부의 가변 프로퍼티 변경 가능
let immutableReference: Sample = Sample()

immutableReference.mutableProperty = 200

```



## 열거형

각 case는 그 자체가 고유의 값입니다.(C/C++ 처럼 정수값이 할당되는 것이 아님)

```swift
enum Weekday{
  case mon
  case tue
  case wed
  case thu, fri, sat, sun
}

var day: Weekday = Weekday.mon
var day = Weekday.mon
day = .tue

print(day) // tue


switch day{
  case .mon, .tue, .wed, .thu:
  print("평일")
  case Weekday.fri:
  print("불금파티")
  //error!
  //만약 열거형에 모든 case를 명시해두지 않으면 반드시 default를 명시해줘야 한다.
  //case .sat, .sum:
  //print("신나는 주말")
}

//자동으로 peach는 2로 증가하게 됨
enum Fruit: Int{
  case apple = 0
  case grape = 1
  case peach //2
}

//어떤 타입으로든 가능
enum School: String{
  case elementary = "초등"
  case middle = "중등"
  case high = "고등"
  case univ // 정의를 해주지않으면 그냥 univ임
}

//rawValue가 case에 해당하지 않을 수 있으므로 rawValue를 통해 초기화 한 인스턴스는 옵셔널 타입이다.
let apple: Fruit = Fruit(rawValue: 0) //error!
//Fruit 열거형의 0 값을 넣는다.(apple)
let apple: Fruit? = Fruit(rawValue: 0) // rawValue를 초기화 할 때는 옵셔널타입을 맞춰줘야 한다.

//열거형에 메서드도 추가를 해줄 수 있음
enum Month{
  case dec, jan, feb
  case mar, apr, may
  case jun, jul, aug
  case sep, oct, nov
  
  func printMessage(){
    switch self{
      case .mar, .apr, .may:
      print("봄")
      case .jun, .jul, .aug:
      print("여름")
      case .sep, .oct, .nov:
      print("가을")
      default:
      print("겨울")
    }
  }
}

Month.mar.printMessage() // 봄

```



## 값 타입 & 참조 타입(call by value & call by reference)

**class**

* 전통적인 oop 관점에서의 클래스
* 단일상속
* (인스턴스/타입)메서드
* (인스턴스/타입)프로퍼티
* **참조타입**
* Apple 프레임워크의 대부분의 큰 뼈대는 모두 클래스로 구성

**struct**

* c언어등의 구조체보다 다양한 기능
* 상속불가
* (인스턴스/타입)메서드
* (인스턴스/타입)프로퍼티
* **값 타입**
* swift의 대부분의 큰 뼈대는 모두 구조체로 구성

**enum**

* 다른 언어의 열형과는 많이 다른 존재
* 상속불가
* (인스턴스/타입)메서드
* (인스턴스/타입)프로퍼티
* **값 타입**
* Enumeration
* 유사한 종류의 여러 값을 유의미한 이름으로 한 곳에 모아 정의
  예) 요일, 상태값, 월(Month)등
* **열거형 자체가 하나의 데이터 타입 열거형의 case 하나하나 전부 하나의 유의미한 값으로 취급**

![image-20191028005155553](/Users/gihyunkim/Library/Application Support/typora-user-images/image-20191028005155553.png)

**구조체는 언제 사용하나?(구조체나 클래스나 별반 차이 없어보이는데...?)**

* 연관된 몇몇의 값들을 모아서 하나의 데이터타입으로 표현하고 싶을 때
* 다른 객체 또는 함수 등으로 전달될 때 **참조가 아닌 복사를 원할 때**
* 자신을 상속할 필요가 없거나, 자신이 다른 타입을 **상속받을 필요가 없을 때**
* Apple 프레임워크(iOS/MacOS)에서 프로그래밍을 할 때는 주로 클래스를 많이 사용

```swift
struct ValueType{
  var property = 1
}

class ReferenceType{
  var property = 1
}

let firstStructInstance = ValueType()
var secondStructInstance = firstStructInstance
secondStructInstance.property = 2

//call by value
print(\(firstSturctInstance.property)) //1
print(\(secondStructInstance.property)) //2


let firstClassReference = ReferenceType()
var secondClassReference = firstClassReference
secondClassReference.property = 2

//call by reference
print(\(firstClassReference.property)) //2
print(\(secondClassReference.property)) //2
```

**기본 타입들(Int, Stirng ...)은 어떻게 선언이 되어있는가?**

```swift
//기본타입들이 struct로 선언이 되어있다.
public struct Int
public struct Double
public struct String
public struct Dicionary<Key: Hashable, Value>
public struct Array<Element>
public struct Set<Element: Hashable>
```



## 클로저 기본

코드의 블럭

일급시민(first - citizen)이라서 변수, 상수 등으로 저장, 전달인자로 전달이 가능

함수: 이름이 있는 클로저(함수는 클로저의 일종임)

```swift
//함수를 사용한다면
func sumFunction(a: Int, b: Int) -> Int{
  return a + b
}

var sumResult: Int = sumFunction(a: 1, b: 2)

print(sumResult) // 3

//클로저의 사용
var sum: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in 
	return a + b
}

sumResult = sum(1, 2)
print(sumResult) // 3

//함수는 클로저의 일종이므로
//sum변수에는 당연히 함수도 할당이 가능하다
sum = sumFunction(a:b:)

sumResult = sum(1, 2)
print(sumResult) // 3
```

클로저는 주로 함수의 전달인자로서 사용이 많이 됩니다.
함수에서 함수의 동작이 완료된 후 실행할 코드를 원합니다. 즉, 콜백의 용도로도 많이 쓰임

```swift
let add: (Int, Int) -> In t
add = { (a: Int, b: Int) -> Int in
	return a + b
}

let sub: (Int, Int) -> In t
sub = { (a: Int, b: Int) -> Int in
	return a - b
}

let div: (Int, Int) -> In t
div = { (a: Int, b: Int) -> Int in
	return a / b
}

let mul: (Int, Int) -> In t
mul = { (a: Int, b: Int) -> Int in
	return a * b
}

func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int{
  return method(a, b)
}

var calculated: Int
calculated = calculate(a: 50, b: 10, method: add)

print(calculated) // 50 + 10 = 60

//이런식으로도 가능함
calculated = calculate(a: 50, b: 10, method: { (left: Int, right: Int) -> Int in
	return left * right
})

print(claculated) // 50 * 10 = 500
```



## 클로저 고급

```swift
func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int{
  return method(a, b)
}

var result: Int

//후행 클로저
//클로저가 함수의 마지막 전달인자라면
//마지막 매개변수 이름을 생략한 후
//함수 소괄호 외부에 클로저를 구현할 수 있다.
//즉, 이함수의 마지막 인자는 클로저이다.
result = calculate(a: 10, b: 10){ (left: Int, right: Int) -> Int in
	return left + right
}

//반환타입 생략
//calculate 함수의 method 매개변수는 Int 타입을 반환할 것이라는 사실을 컴파일러도 알기 때문에
//굳이 클로저에서 반환타입을 명시해 주지 않아도 된다.
//대신 in 키워드는 생략할 수 없다.

result = claculate(a: 10, b: 10, method: {(left: Int, right: Int) in
	return left + right
})

print(result) //20

// 후행클로저와 함께 사용 가능
result = calculate(a: 10, b: 10){(left: Int, right: Int) in
	return left + right
}

//단축 인자이름
//클로저의 매개변수 이름이 굳이 불필요하다면 단축 인자이름을 활용할 수 있다.
//단축 인자이름은 클로저의 매개변수의 순서대로 $0, $1, ... 처럼 표현한다.
result = calculate(a:10, b: 10, method: {
  return $0 + $1
})

//당연히 후행 클로저와 함께 사용이 가능
result = calculate(a: 10, b: 10){
  return $0 + $1
}

//암시적 반환 표현
//클로저가 반환하는 값이 있다면
//클로저의 마지막 줄의 결과값은 암시작으로 반환값으로 취급한다.
result = calculate(a: 10, b: 10){
  $0 + $1
}

//축약전 함수
result =  calculate(a: Int, b: Int, method: { (left: Int, right: Int) -> Int in
  return left + right
})

//축약후 함수
result = calculate(a: 10, b: 10){
  $0 + $1
}
```



## 프로퍼티

프로퍼티는 구조체, 클래스, 열거형 내부에 구현할 수 있습니다.

다만 열거형 내부에는 연산 프로퍼티만 구현할 수 있습니다.

연산 프로퍼티는 var로만 선언할 수 있습니다.

저장 프로퍼티와 연산 프로퍼티의 기능은 함수, 메서드, 클로저, 타입 등의 외부에 위치한 **지역/전역** 변수에도 모두 사용이 가능

```swift
struct Student{
  //인스턴스 저장 프로퍼티
  var name: String = ""
  var `class`: String = "Swift"
  var koreanAge: Int = 0
  
  //인스턴스 연산 프로퍼티
  //연산을 수행해주기 위한 프로퍼티
  var weternAge: Int{
    get{
      return koreanAge - 1
    }
    set(inputValue){
      koreanAge = inputValue + 1
    }
  }
  
  //타입 저장 프로퍼티
  //타입과 관련해서 저장하는 프로퍼티
  static var typeDescription: String = "학생"
  
  //읽기전용 인스턴스 연산 프로퍼티
  var selfInstroduction: String{
    get{
      return "저는 \(self.class)반 \(name)입니다."
    }
  }
  
  //읽기전용 타입 연산 프로퍼티
  //읽기전용에서는 get을 생략가능
  static var selfIntroduction: String{
    return "학생타입입니다."
  }
}

//타입 연산 프로퍼티 사용
print(Student.selfIntroduction) //학생타입입니다.

//인스턴스 생성
var gihyun: Student = Student()
gihyun.koreanAge = 10


//인스턴스 저장 프로퍼티 사용
gihyun.name = "gihyun"
print(gihyun.name) //gihyun

//인스턴스 연산 프로퍼티 사용
print(gihyun.selfIntroduction) //저는 swift반 gihyun입니다.

print("제 한국나이는 \(gihyun.koreanAge)살이고, 미국나이는 \(gihyun.westernAge)살 입니다.")
//제 한국나이는 10살이고, 미국나이는 9살 입니다.

//응용
struct Money{
  var currencyRate: Double = 1100
  var dollar: Double = 0
  var won: Double{
    get{
      return dollar * currencyRate
    }
    set{
      dollar = newValue / currencyRate // newValue는 set에 매개변수를 명시하지않으면 암시적으로 생성되는 변수
    }
  }
}

var moneyInMyPocket = Money()
moneyInMyPocket.won = 11000 // won에 값을 넣는 순간 11000은 newValue에 할당되고 dollar가 초기화 된다.
```



## 프로퍼티 감시자

프로퍼티 감시자를 사용하면 프로퍼티 값이 변경될 때 원하는 동작을 수행할 수 있습니다.

프로퍼티 감시자의 기능은 함수, 메서드, 클로저, 타입 등의 외부에 위치한 **지역/전역** 변수에도 모두 사용이 가능

```swift
struct Money{
  //프로퍼티 감시자 사용
  var currencyRate: Double = 1100{
    //currencyRate가 바뀌기 직전에 호출
    willSet(newRate){ //newRate: 바뀔 값이 매개변수로 들어옴
      print("환율이 \(currencyRate)에서 \(newRate)으로 변경될 예정입니다.")
    }
    //currencyRate가 바뀌었을 때 호출
    didSet(oldRate){ //oldRate: 바뀌기 이전의 값이 들어옴
      print("환율이 \(oldRate)에서 \(currencyRate)으로 변경되었습니다.")
    }
  }
  
  
  var dollar: Double = 0{
    //willSet의 암시적 매개변수 이름 newValue
    willSet{
      print("\(dollar)에서 \(newValue)달러로 변경될 예정입니다.")
    }
    //didSet의 암시적 매개변수 이름 oldValue
    didSet{
      print("\(oldValue)에서 \(dollar)달러로 변경되었습니다.")
    }
  }
  
  //연산 프로퍼티
  var won: Double{
    get{
      return dollar * currencyRate
    }
    set{
      dollar = newValue / currencyRate
    }
  }
  /*프로퍼티 감시자와 연산 프로퍼티 기능을 동시에 사용할 수 없다.
  willSet{
  
	}
  */
}


```



## 상속

스위프트의 상속은 클래스, 프로토콜 등에서 가능합니다.

열거형, 구조체는 상속이 불가능합니다.

스위프트는 다중상속을 지원하지 않습니다.

```swift
class Person{
  var name: String = ""
  
  func selfInstroduce(){
    print("저는 \(name)입니다.")
  }
  
  //final 키워드를 사용하여 재정의(오버라이딩)를 방지할 수 있다.
  final func sayHello(){
    print("hello")
  }
  
  //타입 메서드
  //재정의 불가 타입 메서드 - static
  static func typeMEhod(){
    print("type method - static")
  }
  
  //재정의 가능 타입 메서드 - class
  class func classMethod(){
    print("type method - class")
  }
  
  //재정의 가능한 class 멧드라도
  //final 키워드를 사용하면 재정의 할 수 없다
  //메서드 앞의 static과 final class는 똑같은 역할을 한다.
  final class func finalClassMethod(){
    print("type method - final class")
  }
}

class Student: Person{
  //var name: String = ""//error! 저장 프로퍼티는 재정의 불가
  var major: String = ""
  
  override func selfIntroduce(){
    print("저는 \(name)이고, 전공은 \(major)입니다.")
  }
  
  override class classMethod(){
    
  }
  
  //static을 사용한 타입메서드는 재정의 불가
  //override static func typeMethod(){}
  
  //final 키워드를 사용한 메서드, 프로퍼티는 재정의 불가
  //override class func finalClassMethod(){}
}


```



## 인스턴스 생성과 소멸

```swift
//프로퍼티의 초기값이 꼭 필요하지는 않을 때
//옵셔널을 사용
class PersonC{
  var name: String
  var age: Int
  var nickName: String?
  
  convenience init(name: String, age: Int, nickName: String){
    //self.name = name
    //self.age = age
    //위에 두줄 대신 미리 만들어 놓은 init을 호출할 수 도있다. 이때 convenience 키워드가 붙어야 함
    self.init(name: name, age: age)
    self.nickName = nickName
  }
  
  init(name: String, age: Int){
    self.name = name
    self.age = age
  }
}

//암시적 추출 옵셔널은
//인스턴스 사용에 꼭 필요하지만
//초기값을 할당하지 않고자 할 때 사용
class Puppy{
  var name: String
  var owner: PersonC! //꼭 필요하지만 init할 때 전달되기 어려운 값들을 암시적 추출 옵셔널을 사용한다.
  
  init(name: String){
    self.name = name
  }
  
  func goOut(){
    print("\(name)가 주인 \(owner.name)와 산책을 합니다")
  }
}

let happy: Puppy = Puppy(name: "haapy")
//happy.goOut() //error! Puppy.owner를 초기화 시켜주지 않았다. 현재 owner는 nil인 상태임 
happy.owner = jenny
happy.goOut()

//실패가능한 이니셜라이저
//이니셜라이저 매개변수로 전달되는 초기값이 잘못된 경우 인스턴스 생성에 실패할 수 있다.
//인스턴스 생성에 실패하면 nil을 반환한다.
//그래서 실패가능한 이니셜라이저의 반환타입은 옵셔널이다.
class PersonD{
  var name: String
  var age: Int
  var nickName: String?
  
  //실패가능한 init을 만들때는 ?를 붙여준다.
  init?(name: String, age: Int){
    
    //실패하면(조건에 맞지않다면) return nil
    if (0...120).contains(age) == false {
      return nil
    }
    
    if name.characters.count == 0 {
      return nil
    }
    
    self.name = name
    self.age = age
  }
}

//위에서 init의 리턴값이 옵셔널이기 때문에 인스턴스 타입도 옵셔널로 지정해줘야한다.
let john: PersonD? = PersonD(name: "john", age: 23)
let joker: PersonD? = PersonD(name: "joker", age: 123) //age가 123이다.
let batman: PersonD? = PersonD(name: "", age: 23) //name이 ""이다.

print(joker) //nil
print(batman) //nil

//디이니셜라이저
//deinit은 클래스의 인스턴가 메모리에서 해제되는 시점에 호출된다.
//인스턴스가 해제되는 시점에 해야할 일을 구현할 수 있다.

class PersonE{
  var name: String
  var pet: Puppy?
  var child: PersonC
  
  init(name: String, child: PersonC){
    self.name = name
    self.child = child
  }
  
  //deinit(name: String, child: PersonC) //error! deinit은 매개변수를 가질 수 없다.
  deinit{
    if let petName = pet?.name{
      print("\(name)가 \(child.name)에게 \(petName)를 인도합니다")
      self.pet?.owner = child
    }
  }
}

var donald: PersonE? = PersonE(name: "donald", child: jenny)
donald?.pet = happy
donald = nil //donald 인스턴스가 더이상 필요없으므로 메모리에서 해제된다.
//donald가 메모리에서 해제되는 순간 deinit 호출
//donald가 jenny에게 happy를 인도합니다.

```



## 옵셔널 체이닝

옵셔널 체이닝은 옵셔널 요소 내부의 프로퍼티로 또다시 옵셔널이 연속적으로 연결되는 경우 유용하게 사용할 수 있습니다.

구조체나 클래스를 선언해줬을 때 클래스(or 구조체)안에 또다른 클래스 인스턴스가 있고 또 그안에 또다른 인스턴스가 있을 수 있습니다.

이런 인스턴스를 타고 타고 타고 해서 접근해야하는 경우가 있습니다.

이때 프로퍼티 자체가 옵셔널인 경우 nil인지 아닌지 체크를 해야하는 경우가 있습니다.

이경우 옵셔널 체이닝을 사용하면 유용하게 사용할 수 있습니다.

```swift
class Person{
  var name: String
  var job: String?
  var home: Apartment?
  
  init(name: String){
    self.name = name
  }
}

class Apartment{
  var buildingNumber: String
  var roomNumber: String
  var `guard`: Person?
  var owner: Person?
  
  init(dong: String, ho: String){
    buildingNumber = dong
    roomNumbver = ho
  }
}

let gihyun: Person? = Person(name: "gihyun")
let aprt: Apartment? = Apartment(dong: "101", ho: "202")
let superman: Person? = Person(name: "superman")

//옵셔널 체이닝이 실행 후 결과값이 nil일 수 있으므로 결과타입도 옵셔널이다.
//만약 gihyun의 경비원의 직업이 궁금하다면?
//옵셔널 체이닝을 사용하지 않는다면 아래와 같다.
func guardJob(owner: Person?){
  if let owner = owner{
    if let home = owner.home{
      if let `guard`= home.guard{
        if let guardJob = `guard`.job{
          print("우리집 경비원의 직업은 \(guardJob)입니다.")
        }else{
          print("우리집 경비원은 직업이 없습니다.")
        }
      }
    }
  }
}

//옵셔널 체이닝을 사용한다면
func guardJobWithOptionalChaining(owner: Person?){
  if let guardJob = owner?.home?.guard?.job{
    print("우리집 경비원의 직업은 \(guardJob)입니다.")
  }else{
    print("우리집 경비원은 직업이 없습니다.")
  }
}

gihyun?.home?.guard?.job // nil

gihyun?.home = apart

gihyun?.home // Optional(Apartment)
gihyun?.home?.guard // nil

gihyun?.home?.guard = superman

gihyun?.home?.guard // Optional(Person)

gihyun?.home?.guard?.name // superman
gihyun?.home?.guard?.job //nil

gihyun?.home?.guard?.job = "경비원"

//nil 병합 연산자
var guardJob: String

guardJob = gihyun?.home?.guard?.job ?? "슈퍼맨"
//앞에 gihyun?.home?.guard?.job 값이 nil이라면 gihyun?.home?.guard?.job에 "슈퍼맨"을 할당해달라
print(guardJob) //경비원

gihyun?.home?.guard?.job = nil

guardJob = gihyun?.home?.guard?.job ?? "슈퍼맨"
print(guardJob) //슈퍼맨

```



## 타입캐스팅

스위프트의 타입캐스팅은 인스턴스의 타입을 확인하는 용도 
또는 클래스의 인스턴스를 부모 혹은 자식 클래스의 타입으로 사용할 수 있는지 확인하는 용도로 사용합니다.
is, as를 사용

기존의 다른언어서에서의 타입캐스팅을 생각하면

```swift
let someInt: Int = 100
let someDouble: Double = Double(someInt)
```

그러나 이건 Double 인스턴스를 하나더 생성해서 만드는 것이지, 타입캐스팅이 아닙니다.

```swift
//타입 캐스팅을 위한 클래스 정의
class Person{
  var name: String = ""
  func breath(){
    print("숨을 쉽니다.")
  }
}

class Student: Person{
  var school: String = ""
  func goToSchool(){
    print("등교를 합니다")
  }
}

class UniversityStudent: Student{
  var major: String = ""
  func goToMT(){
    print("MT ㄱ")
  }
}

var gihyun: Person = Person()
var hana: Student = Student()
var jason: UniversityStudent = UniversityStudent()

//타입 확인
var result: Bool

result = gihyun is Person //true
result = gihyun is Student //false
result = gihyun is UniversityStudent //false

result = hana is Person //true
result = hana is Student //true
result = hana is UniversityStudent //false

result = jason is Person //true
result = jason is Student //true
result = jason is UniversityStudent //true

switch jason{
  case is Person:
  print("jason은 사람")
  case is Student:
  print("jason은 학생")
  case is UniversityStudent:
  print("jason은 대학생")
  default:
  print("jason은 사람도, 학생도, 대학생도 아니다.")
}//jason은 사람

switch jason{
  case is UniversityStudent:
  print("jason은 대학생")
  case is Student:
  print("jason은 학생")
  case is Person:
  print("jason은 사람")
  default:
  print("jason은 사람도, 학생도, 대학생도 아니다.")
}//jason은 대학생

//업 캐스팅
//as를 사용하여 부모클래스의 인스턴스로 사용할 수 있도록 컴파일러에게 타입정보를 전환해준다.
//Any혹은 AnyObject로도 타입정보를 변환할 수 있다.
//암시적으로 처리되므로 생략해도 무방하다.
var mike: Person = UniversityStudent() as Person
var jenny: Student = Student()
//var jina: UniversityStudent = Person() as UniversityStudent // error!
var jina: Any = Person() // as Any 생략가능

//다운 캐스팅
//as? 또는 as!를 사용하여 
//자식 클래스의 인스턴스로 사용할 수 있도록 
//컴파일러에게 인스턴스의 타입정보를 전환해준다.

//as?(조건부 다운캐스팅)
//옵셔널로 저장됨
var optionalCasted: Student?

optionalCasted = mike as? UniversityStudent // 캐스팅 가능 
optionalCasted = jenny as? UniversityStudent // nil
optionalCasted = jina as? UniversityStudent // nil
optionalCasted = jenny as? Student // nil

//as!(강제 다운캐스팅)
//옵셔널이 아닌 값으로 저장됨
//nil일경우 런타임 에러
optionalCated = mike as! UniversityStudent //캐스팅 가능
//optionalCasted = jenny as! UniversityStudent // error! nil
//optionalCasted = jina as! UniversityStudent // error! nil
//optionalCasted = jenny as! Student // error! nil

//활용

//아래 switch구문은 case로 확인만 할 뿐 실질적인 추출은 하지못함
//추출하려면 (someone as! UniversityStudent).goToMT() 같은 번거로운 짓을 해야함
func doSomethingWithSwitch(someone: Person){
  switch someone{
    case is UniversityStudent:
    (someone as! UniversityStudent).goToMT()
    case is Student:
    (someone as! Student).goToSchool()
    case is Person:
    (someone as! Person).breath()
  }
}

// if-let 구문을 이용해서 아래와 같이 깔끔하게 추출해서 사용 가능
func doSomething(someone: Person){
  if let universityStudent = someone as? UniversityStudent{
    universityStudent.goToMT()
  }else if let student = someone as? Student{
    student.goToSchool()
  }else if let person = someone as? Person{
    person.breath()
  }
}


```



## assert와 guard

애플리케이션이 동작 도중에 생성하는 다양한 결과값(연사값 등)을
동적으로 확인하고 안전하게 처리할 수 있도록
확인하고 빠르게 처리할 수 있습니다.

### assert(Asssertion)

assert: 어떠한 결과를 확인하는데 사용
assert(_:_:file:line:) 함수를 사용
asssert 함수는 디버깅 모드에서만 동작합니다.
배포하는 애플리케이션에서는 제외됩니다.
주로 디버깅 중 조건의 검증을 위하여 사용

```swift
var someInt: Int = 0

assert(someInt == 0, "someInt != 0")

someInt = 1
//assert(someInt == 0) //동작 중지, 검증 실패
//assert(someInt == 0, "someInt != 0") //메세지 출력 후 동작 중지, 검증 실패
//assertion filed: someInt !=0: file guard_assert.swift, line 8


func functionWithAssert(age: Int?){
  assert(age != nil, "age == nil")
  
  assert((age! >= 0) && (age! <= 130), "나이값 입력이 잘못되었습니다.")
  print("당신의 나이는 \(age!)세 입니다.")
}

functionWithAssert(age: 50)
functionWithAssert(age: -1) //동작 중지, 검증 실패
//functionWithAssert(age: nil)//동작 중지, 검증 실패

```



### guard(Early Exit)

guard를 사용하여 잘못된 값의 전달 시
특정 실행구문을 빠르게 종료

디버깅 모드 뿐만 아니라 어떤 조건에서도 동작합니다.

guard의 else 블럭 내부에는
특정 코드블럭을 종료하는 지시어(return, break 등)가
꼭 있어야합니다.

타입캐스팅, 옵셔널과도 자주사용됩니다.
그 외 단순 조건 판단후 빠르게 종료할 때도 용이합니다.

```swift
func functionWithGuard(age: Int?){
  
  // guard let하게 되면 age를 먼저 언래핑(옵셔널 바인딩)하게 된다. 만약 nil이면 뒤에거 안보고 바로 else로
  guard let unwrappedAge = age, 
  unwrappedAge < 130,
  unwrappedAge >= 0 else{ //guard에는 항상 else가 있어야한다.
    print("나이값 입력이 잘못되었습니다.")
    return //guard에는 항상 return또는 break이 있어야 한다.
  }
  // guard let 으로 선언한 unwrappedAge가 계속 살아있음
  print("당신의 나이는 \(unwrappedAge)세 입니다.")
}

//반복문안에서도 사용가능
var count = 1
while true{
  guard count < 3 else{
    break
  }
  print(count)
  count += 1
}
//1
//2

//dictionary에서도 굉장히 많이 쓰인다.
func someFunction(info: [String: Any]){
  //info["name"]의 값을 String으로 캐스팅했을 때 nil이면 return 아니면 name이라는 변수에 할당
  guard let name = info["name"] as? String else{
    return
  }
  
  guard let age = info["age"] as? Int, age >= 0 else{
    return
  }
  
  print("\(name): \(age)")
}

someFuncgtion(info: ["name": "gihyun", "age": "10"]) //2번째 guard에서 막힘
someFuncgtion(info: ["name": "gihyun") //2번째 guard에서 막힘
someFuncgtion(info: ["name": "gihyun", "age": 10]) //gihyun: 10

```



## 프로토콜

프로토콜은 특정 역할을 수행하기 위한
메서드, 프로퍼티, 이니셜라이저 등의 요구사항을 정의합니다.

구조체, 클래스, 열거형은 프로토콜을 채택(adopted)해서
프로토콜의 요구사항을 실제로 구현할 수 있습니다.

어떤 프로토콜의 요구사항을 모두 따르는 타입은
그 '프로토콜을 준수한다(conform)'고 표현합니다.

프로토콜의 요구사항을 충족시키려면 프로토콜이 제시하는 기능을 모두 구현해야 합니다.

**쉽게말하면 프로토콜은 너는 이기능을 꼭 구현해야하만 해 라고 강요하는 것과 같습니다. (java의 interface와 비슷)**

```swift
protocol Talkable{
  //프로퍼티 요구
  //프로퍼티 요구는 항상 var 키워드를 사용한다.
  //get은 읽기만 가능해도 상관 없다는 뜻이며
  //get과 set을 모두 명시하면
  //읽기 쓰기 모두 가능한 프로퍼티여야 한다.
  var topic: Stirng{get set}
  var language: String{get}
  
  //메서드 요구
  func talk()
  
  //이니셜라이저 요구
  init(topic: String, language: String)
}

//프로토콜 채택 및 준수

//Person 구조체는 Talkable프로토콜을 채택했다.
struct Person: Talkable{
  var topic: String
  let language: String // protocol에서 읽기 전용으로 선언해라 해서 let으로 선언해도 무방함
  
  //읽기전용 프로퍼티 요구는 연산 프로퍼티로 대체가 가능하다.
  //var language: String {return "한국어"} //get 따로 안적어줘도 됨 
  
  //물론 읽기, 쓰기 프로퍼티도 연산 프로퍼티로 대체할 수 있다.
  var subject: String = ""
  var topic: String{
    set{
      self.subject = newValue
    }
    get{
      return self.subject
    }
  }
  
  func talk(){
    print("\(topic)에 대해 \(language)로 말한다.")
  }
  
  init(topic: String, language: String){
    self.topic = topic
    self.language = language
  }
}

//프로토콜 상속

//프로토콜은 클래스와 다르게 다중상속이 가능하다

protocol Readable{
  func read()
}

protocol Writeable{
  func write()
}

protocol ReadSpeakable: Readable{
  //func read() //Readable을 상속 받았기 때문에 ReadSpeakable은 자동으로 func read()가 있다.
  func speak()
}

protocol ReadWriteSpeakable: Readable, Writeable{
  //func read()
  //func write()
  func speak()
}

struct SomeType: ReadWriteSpeakable{
  func read(){
    print("Read")
  }
  
  func write(){
    print("Write")
  }
  
  func speak(){
    print("Speak")
  }
}

//클래스 상속과 프로토콜
//클래스에서 상속과 프로토콜 채택을 동시에 하려면
//상속받으려는 클래스 먼저 명시하고
//그 뒤에 채택할 프로토콜 목록을 작성한다.
//순서중요
class SuperClass: Readable{
  func read(){print("read")}
}

class SubClass: SuperClass, Writeable, ReadSpeakable{
  func write(){print("write")}
  func speak(){print("speak")}
}

//프로토콜 준수확인
//인스턴스가 특정 프로토콜을 준수하는지 확인할 수 있다.
//is, as연산자 사용

let sup: SuperClass = SuperClass()
let sub: SubClass = SubClass()

var someAny: Any = sup
someAny is Readable //true
someAny is ReadSpeakable //false

someAny = sub
someAny is Readable //true
someAny is ReadSpeakable//true

if let someReadable: Readable = someAny as? Readable{
  someReadable.read()
} //read

if let someReadSpeakable: ReadSpeakable = someAny as? ReadSpeakable{
  someReadSpeakable.speak()
} //동작하지 않음

someAny = sub

if let someReadSpeakable: ReadSpeakable = someAny as? Readable{
  someReadSpeakable.read()
} //read
```



## 익스텐션

익스텐션은 구조체, 클래스, 열거형, 프로토콜 타입에
새로운 기능을 추가할 수 있는 기능입니다.

기능을 추가하려는 타입의 구현된 소스코드를
알지못하거나 볼 수 없다고 해도,
타입만 알고 있다면 그 타입의 기능을 확장할 수도 있습니다.
**예를 들면  String이라는 타입에 어떠한 기능을 추가할 수도 있습니다.**

익스텐션으로 추가할 수 있는 기능

* 연산 타입 프로퍼티 / 연산 인스턴스 프로퍼티
* 타입 메서드 / 인스턴스메서드
* 이니셜라이저
* 서브스크립트
* 중첩타입
* 특정 프로토콜을 준수할 수 있도록 기능 추가

기존에 존재하는 기능을 재정의할 수는 없습니다.

익스텐션은 기존에 존재하는 타입이
추가적으로 다른 프로토콜을 채택할 수 있도록
확장할 수도 있습니다.

```swift
//익스텐션 구현

//연산 프로퍼티 추가
extension Int{
  var isEven: Bool{
    return self % 2 == 0
  }
  var isOdd: Bool{
    return self % 2 == 1
  }
}

//그냥 숫자를 쓰게 되면 정수타입임(아래의 숫자들은 정수타입이다.)
print(1.isEven) //false
print(2.isOdd) //false

var number: Int = 3
print(number.isEven) // false

//메서드 추가
extension Int{
  func multiply(by n: Int) -> Int{
    return self * n
  }
}
print(3.multiply(by: 2)) //6

//이니셜라이저 추가
extension String{
  init(intTypeNumber: Int){
    self = "\(intTypeNumber)"
  }
  
  init(doubleTypeNumber: Double){
    self = "\(doubleTypeNumber)"
  }
}
let stringFromInt: String = String(intTypeNumber: 100)


```



## 오류처리

Error 프로토콜과 (주로)열거형을 통해서 오류를 표현합니다.

```swift
//자판기 동작 오류의 종류를 표현한 VendingMachineError 열거형
enum VendingMAchineError: Error{
  case invalidInput
  case insufficientFunds(moneyNeeded: Int) //열거형의 연관값
  case outOfStock
}

//함수에서 발생한 오류 던지기
//자판기 동작 도중 발생한 오류던지기
//오류발생의 여지가 있는 메서드는 throws를 사용하여
//오류를 내포하는 함수임을 표시한다.
class VendingMachine{
  let itemPrice: Int = 100
  var itemCount: Int = 5
  var deposited: Int = 0
  
  //돈 받기 메서드
  //함수 파라미터 옆에 throws를 적어서 오류가 발생할 여지가 있다는 것을 알림
  func receiveMoney(_ money: Int) throws{
    //입력한 돈이 0 이하 면 오류를 던진다.
    guard money > 0 else{
      throw VendingMachineError.invalidInput
    }
    
    //오류가 없으면 정상처리
    self.deposited += money
    print("\(money)원 받음")
  }
  
  //물건팔기 메서드
  func vend(numberOfItems numberOfItemsToVend: Int) throws -> String{
    //원하는 아이템의 수량이 잘못 입력되었으면 오류를 던진다.
    guard numberOfItemsToVend > 0 else{
      throw VendingMachineError.invalidInput
    }
    
    //구매하려는 수량보다 미리 넣어둔 돈이 적으면 오류를 던진다.
    guard numberOfItemsToVend * itemPrice <= deposited else{
      let moneyNeeded: Int
      moneyNeeded = numberOfItemsToVend * itemPrice - deposited
      
      throw VendingMachineError.insufficientFunds(moneyNeeded: moneyNeeded)
    }
    
    //구매하려는 수량보다 요구하는 수량이 많으면 오류를 던진다.
    guard itemCount >= numberOfItemsToVend else{
      thorw VendingMachineError.outOfStock
    }
    
    //오류가 없으면 정상처리
    let totalPrice = numberOfItemsToVend * itemPrice
    
    self.deposited -= totalPrice
    self.itemCount -= numberOfItemsToVend
    
    return "\(numberOfItemsToVend)개 제공함"
  }
}

//자판기 인스턴스
let machine: VendingMachine = VendingMachine()

//판매 결과를 전달받을 변수
var result: String?

//오류 처리
//오류발생의 여지가 있는 throws함수(메서드)는
//try를 사용하여 호출해야 한다.
//try, try?, try!


//do-catch
//오류발생의 여지가 있는 throws함수(메서드)는
//do-catch구문을 활용하여
//오류발생에 대비한다.
do{
  try machine.receiveMoney(0)
}catch VendingMachineError.invalidInput{
  print("입력이 잘못되었습니다.")
}catch VendingMachineError.insufficientFunds(let moneyNeeeded){
  print("\(moneyNeeded)원이 부족합니다.")
}catch VendingMachineError.outOfStock{
  print("수량이 부족합니다.")
}//입력이 잘못되었습니다.

do{
  try machine.receiveMoney(300)
}catch /*(let error)*/{ //let error는 써도 되고 안써도 됨 암시적으로 catch구문에 항상 있음
  switch error{//let error를 생략했다면 error가 아닌 어떤 이름을 써도 된다. A를 적어도 되고 B를 적어도되고
    case VendingMachineError.invalidInput:
    print("입력이 잘못되었습니다.")
    case VendingMachineError.insufficientFunds(let moneyNeeeded):
    print("\(moneyNeeded)원이 부족합니다.")
    case VendingMachineError.outOfStock:
    print("수량이 부족합니다.")
    default:
    print("알수없는 오류 \(error)")
  }
}//300원 받음

//귀찮으면 아래처럼 do-catch, do만 써도된다.
do{
  result = try machine.vend(numberOfItems: 4)
}catch{
  print(error)
}//insufficientFunds(100)

do{
  result = try machine.vend(numberOfItems: 4)
}

//try? 와 try!
//try?
//별도의 오처리 결과를 통보받지 않고
//오류가 발생했으면 결과값을 nil로 돌려받을 수 있다
//정상동작 후에는 옵셔널 타입으로 정상 반환값을 돌려 받는다.

result = try? machine.vend(numberOfItems: 2)
result //Optional("2개 제공함")

result = try? machine.vend(numberOfItems: 2)
result //nil

//try!
//오류가 발생하지 않을 것이라는 강력한 확신을 가질 때
//try!를 사용하면 정상동작 후에 바로 결과값을 돌려받는다.
//오류가 발생하면 런타임 오류가 발생하여
//애플리케이션 동작이 중지된다.
//왠만하면 쓰지 않는게...

result = try! machine.vend(numberOfItems: 1)
result //1개 제공함

```



## 고차함수

전달인자로 함수를 전달받거나
함수실행의 결과를 함수로 반환하는 함수

map, filter, reduce

```swift
//map
//컨테이너 내부의 기존 데이터를 변형(transform)하여 새로운 컨테이너 생성

let numbers: [Int] = [0, 1, 2, 3, 4]
var doubledNumbers: [Int]
var strings: [String]

//for구문 사용
doubledNumbers = [Int]()
strings = [String]()

for number in numbers{
  doubledNumbers.append(number * 2)
  strings.append("\(number)")
}

print(doubledNumbers) //[0, 2, 4, 6, 8]
print(strings) //["0", "1", "2", "3", "4"]

//map 메서드 사용
//numbers의 각 요소를 2배하여 새로운 배열 반환(Int형태로 반환)
doubledNumbers = numbers.map({(number: Int) -> Int in
	return number * 2
})

strings = numbers.map({(number: Int) -> String in
	return "\(number)"
})

//더 간단하게 쓸 수 있다.
//매개변수, 반환 타입, 반환 키워드(return) 생략, 후행 클로저
doubledNumbers = numbers.map{$0 * 2}

//filter
//컨테이너 내부의 값을 걸러서 새로운 컨테이너로 추출

//for구문 사용
var filtered: [Int] = [Int]()

for number in numbers{
  if number % 2 == 0{
    filtered.append(number)
  }
}

print(filtered) //[0, 2, 4]

//filter 메서드 사용
//let말고 var사용 가능
let evenNumbers: [Int] = numbers.filter{
  (number: Int) -> Bool in
  return number % 2 == 0
}

//더 간단하게 쓸 수 있다.
let oodNumbers: [Int] = numbers.filter { $0 % 2 != 0 }


//reduce
//컨테이너 내부의 컨테츠를 하나로 통합
let someNumbers: [Int] = [2, 8, 15]

//for구문사용
var result: Int = 0

//someNumbers의 모든 요소를 더한다.
fornumber in someNumbers{
  result += number
}

//reduce 메서드 사용
//초기값이 0이고 someNumbers내부의 모든 값을 더한다.
let sum: Int = someNumbers.reduce(0, {
  (first: Int, second: Int) -> Int in
  
  return first + second
})

//초기값이 0이고 someNumbers내부의 모든 값을 뺀다.
let subtract: Int = someNumbers.reduce(0, {
  (first: Int, second: Int) -> Int in
  
  return first - second
})

//간단하게 표현
let sum = someNumbers.reduce(0){ $0 + $1 }

print(sum) //25

//초기값이 3이고 someNumbers 내부의 모든 값을 더한다.
let sumFromThree = someNumbers.reduce(3){ $0 + $1 }
print(sumFromThree) //28
```



## 더알아보기

추가적으로 알아가야할 문법과 개념들을 모아봤습니다.

* 제네릭(Generics)
* 서브스크립트(Subscript)
* 접근수준(Access Control)
* ARC(Automatic Reference Counting)
* 중첩타입(Nested Types)
* 사용자정의 연산자(Custom Operators)

